Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C0C784D34
	for <git@vger.kernel.org>; Thu, 30 Jan 2025 18:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738263517; cv=none; b=fPKW3iqPQLWzyC1boUwI/piEYANV3k2n+RA1CBi8DGiMwLLxmfYv6GfzWTVM7/0DUqBBN1aoTQ2zWEfNtxNwiqVpGKRqRsrJ7B5TLIv/IioQtxVfUSVf2+uPMiTEdf7PBUifP5ICMoWW8gtW2XCnUwyksgopM27TFbLHvikHGsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738263517; c=relaxed/simple;
	bh=qtqe63DIj7SsE4D5xstjLyjNt+g+yHLEi+8ZRpXikZ8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Hvd9yS9ubu/aMAw26SLgOo/72yJqGtAA2kOOeGYKvq0uYItRcqzRMNFINtLWzpZ1TLAKKFqLOyUFuEKM9aQs2huRaWGwheG5z5vSvuIP+6z8MUfCOHMC4zRTiHcAygB8SjEB/G5LPtwjA5ySvB4ACSBP14eIFX3JdCIuarhf6KI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=TxCwsqS1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Xhq3sIzV; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="TxCwsqS1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Xhq3sIzV"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 20BFF138011A;
	Thu, 30 Jan 2025 13:58:34 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-11.internal (MEProxy); Thu, 30 Jan 2025 13:58:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1738263514; x=1738349914; bh=PrFP60loIF
	9B+dlFP298mROvQJITox0j/2gBngWQe5Y=; b=TxCwsqS1KtJyVNTIWVbLbp7TdN
	ko+wVbgEA8VYcFCQSlWX8lI8J3sHaCsnp7F7R84e/5cCD+MTUHkxbgxCTANygs+p
	wQIAfgaUlb2y2fOLa7SYE80Kr+QiaMoEPOEEYnjPR+M7yb/DlKLScmExNPWfk6DR
	9WmiYbzY3hwMnKDlGW77sUxEm04ty1UIryneeeoDPmM2EvxLOUrY2ZPQOmjxkomw
	thktFljEVHVFoWXi9EOInq3mB8MWSrU9BDPcMAkuTlgxDe+13350hp7quRH1j6x7
	d0/Avz7g+4QBpfr4Fx8Jumdr4+0vx5ARxUZv097oEhRTFJCOZE53ujDEGZ/g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738263514; x=1738349914; bh=PrFP60loIF9B+dlFP298mROvQJITox0j/2g
	BngWQe5Y=; b=Xhq3sIzVvJBfUPYyalyVjGHGqh5z0Do5/j7XBzvBgXnYoe9hvVn
	cU8l1ilBINVWtwwDliYdRx+nWsGNLen3j9LVGe7TyxIoOPmMoo19fVwRiYYrZ9Q9
	M27tdsHd/P5elISxlnkpU7bqO3b/IEL8ZuH1R+/7f0s2p9w/IgCrrnyqZ+cP8q83
	8C/PP3skSbJPNzHikezIBwmQa+2IeTwvWR2eioqFH13h+8IjOEL56+P+O/DJGBtu
	Hz2qw1QWiYAAcc5Sq7qylcd5ltEq9zjpkSi5Zq8UlwFh0s0wEQ7kebaOii9QOf8l
	zxj5SdEbheyIP42WbeNsaCzQKUQ8ElvOwlQ==
X-ME-Sender: <xms:2cubZ4RgKRXXDphQEp_LujdPZbPlTa-_cxBvzom2RcwGvqKJh8I1QA>
    <xme:2cubZ1zM-ugui9At5ptHS-rXymWA4C73m_KD6ufQbyFVQLMrymjr_A7DCcMQwDILw
    DJNi6Pf6kDUoeqfpQ>
X-ME-Received: <xmr:2cubZ10DlKod4i8PdHaQUGROvDGlEp_ezgfTjnzC8sOMzwyXE7j_NHTMuKCMIqRe4hsoPVSwzgpr5LUwKHJZZCCdzGecOBjlFwt8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeiiedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepshhhvghjihgrlhhuoh
    esghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehkrghrthhhihhkrd
    dukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhhhrghgghgvrhesrghluhhmrdhm
    ihhtrdgvughupdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:2cubZ8BoqqCSa-9nE7K-sRcsEw3vD8_6-J99Q23l5hTt4Sn93mNr7A>
    <xmx:2cubZxje7s_9Sx9f4lt8rONpfHuKZsXK94wkSiJTQfO1vzeCL9C-tg>
    <xmx:2cubZ4q8RDPFeIX83DD-ArsnpLrtKWxyCb-Qp_2N_28c4ojBjdoiRA>
    <xmx:2cubZ0jUfYNcDJL72PAQRLNDRVEVBo8Espm4Ln3wloihWy5BgCuR5Q>
    <xmx:2subZ8Xuf5npSgGC1TjpBk8_d1JSbIPuLTmiKKR6tEkJrakB35A2JxyE>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Jan 2025 13:58:33 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: shejialuo <shejialuo@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Karthik Nayak
 <karthik.188@gmail.com>,  Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v2 4/8] packed-backend: add "packed-refs" header
 consistency check
In-Reply-To: <Z5r7BuEJvjwQ9f4G@ArchLinux> (shejialuo@gmail.com's message of
	"Thu, 30 Jan 2025 12:07:34 +0800")
References: <Z5r6ZnLH3Ee8IQnN@ArchLinux> <Z5r7BuEJvjwQ9f4G@ArchLinux>
Date: Thu, 30 Jan 2025 10:58:32 -0800
Message-ID: <xmqq1pwkdt7r.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

shejialuo <shejialuo@gmail.com> writes:

> In "packed-backend.c::create_snapshot", if there is a header (the line
> which starts with '#'), we will check whether the line starts with "#
> pack-refs with:". As we are going to implement the header consistency
> check, we should port this check into "packed_fsck".
>
> However, the above check is not enough, this is because "git pack-refs"
> will always write "PACKED_REFS_HEADER" which is a constant string to the
> "packed-refs" file. So, we should check the following things for the
> header.

I haven't done history digging in this area for a while, but we
should make sure we are not flagging a file that was written in
ancient version of Git whose repository is still supported.

> 1. If the header does not exist, we may report an error to the user
>    because it should exist, but we do allow no header in "packed-refs"
>    file. So, create a new fsck message "packedRefMissingHeader(INFO)" to
>    warn the user and also keep compatibility.

Are we sure "it should exist"?  I think the header did not exist
before "Git v1.5.0".  I didn't check with other reimplementations of
Git (like jgit or libgit2), but as long as our reading side of the
runtime allows a packed-refs file without the header without
complaint, I do not think it is a good idea to treat it as a
report-worthy event from "git fsck".

> 2. If the header content does not start with "# packed-ref with:", we
>    should report an error just like what "create_snapshot" does. So,
>    create a new fsck message "badPackedRefHeader(ERROR)" for this.

This I can agree with.  If the first line begins with "#" but not
with that string (with a trailing SP), that is a sign that it may
not even be a valid packed-refs file, which is a report-worthy
event.

> 3. If the header content is not the same as the constant string
>    "PACKED_REFS_HEADER", ideally, we should report an error to the user.

NO.  THAT IS NOT IDEAL AT ALL.

The header was written like this:

        /* perhaps other traits later as well */
        fprintf(cbdata.refs_file, "# pack-refs with: peeled \n");

in the older versions of Git before it was made into a separate
preprocessor macro and lost the comment (the above excerpt is from
"git show v1.5.0:builtin-pack-refs.c").

Notice "other traits later" in the comment?

The thing is _designed_ to be extensible.  In fact, these days we
support a few more traits

        static const char PACKED_REFS_HEADER[] =
                "# pack-refs with: peeled fully-peeled sorted \n";

(an excerpt from the current refs/packed-backend.c).

Reporting an error when you see something written by an older
version of Git is far from ideal.

>    However, we allow other contents as long as the header content starts
>    with "# packed-ref with:". To keep compatibility, create a new fsck
>    message "unknownPackedRefHeader(INFO)" to warn about this. We may
>    tighten this rule in the future.

Whatever we do, what we do with an unknown trait should be in line
with what the runtime does.  If the runtime failed (we do not, but
this is to illustrate the principle [*]) on a packed-refs file
without "sorted" trait, noticing that "sorted" is not there and
flagging as an error is a good thing to do.  But if the runtime
gracefully degrades and sorts the list of refs read from such a
packed-refs file before continuing, then a packed-refs file that
lack "sorted" trait is not a report-worthy event.

I do not offhand recall if we introduced the concept of mandatory vs
optional traits in the packed-refs part of the system (like we have
in the index extension subsystem, where a version of Git that
encounters an unknown *and* mandatory index extension must refuse to
touch the repository), but if there is a mandatory trait declared in
the header that our version of Git does not understand, it is a
report-worthy event that must be flagged with "git refs verify".

> +static int packed_fsck_ref_header(struct fsck_options *o, const char *start, const char *eol)
> +{
> +	const char *err_fmt = NULL;
> +	int fsck_msg_id = -1;
> +
> +	if (!starts_with(start, "# pack-refs with:")) {
> +		err_fmt = "'%.*s' does not start with '# pack-refs with:'";
> +		fsck_msg_id = FSCK_MSG_BAD_PACKED_REF_HEADER;
> +	} else if (strncmp(start, PACKED_REFS_HEADER, strlen(PACKED_REFS_HEADER))) {
> +		err_fmt = "'%.*s' is an unknown packed-refs header";
> +		fsck_msg_id = FSCK_MSG_UNKNOWN_PACKED_REF_HEADER;
> +	}

As I outlined above, this is totally unacceptable.  

Inspecting the header is good, but if this code claims to be a
checker, it should do at least what the runtime does, i.e. parse the
header to tell what traits the packed-file declares, not just
assuming that it is a fixed string.  And error on unknown trait(s)
if they are mandatory (if such a concept is implemented in the
runtime reading side).  Informing on an unknown and optional
trait(s) I can live with, but personally I wouldn't recommend it.

In other words, report loudly if it is an error, but otherwise stay
silent if we know we tolerate it well. 

> +static int packed_fsck_ref_content(struct fsck_options *o,
> +				   const char *start, const char *eof)
> +{
> +	struct strbuf packed_entry = STRBUF_INIT;
> +	int line_number = 1;

We limit ourselves with about 1 billion refs in the packed-refs
file, which may be plenty, but I do not quite understand the use of
this variable.  There is no loop inside this so ...

> +	const char *eol;
> +	int ret = 0;
> +
> +	strbuf_addf(&packed_entry, "packed-refs line %d", line_number);

... this is always line #1, and then

> +	ret |= packed_fsck_ref_next_line(o, &packed_entry, start, eof, &eol);
> +	if (*start == '#') {
> +		ret |= packed_fsck_ref_header(o, start, eol);
> +
> +		start = eol + 1;
> +		line_number++;

... it may be incremented, but upon returning from the funcition, it
is lost.

Perhaps you wanted to make it a function-scope static, but then you
are allowed to read one single packed-refs file during the life of
your process before you exit, which I am not sure is what you want?

> +	} else {
> +		struct fsck_ref_report report = { 0 };
> +		report.path = "packed-refs";
> +
> +		ret |= fsck_report_ref(o, &report,
> +				       FSCK_MSG_PACKED_REF_MISSING_HEADER,
> +				       "missing header line");
> +	}
> +
> +	strbuf_release(&packed_entry);
> +	return ret;
> +}

I'll stop here for now.

Thanks.

