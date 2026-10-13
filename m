Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D590C17C203
	for <git@vger.kernel.org>; Tue, 13 Oct 2026 00:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791850097; cv=none; b=PQpnYa/i/S1OdhcWyhCp9n/IgMs2lSeIuXfyT7oqXleIWtvm8+STes32u1pOUoMGUJ5VGAxZZAjbLJmcq01NpIDntl14vXkvw/gRPAuH/10XylHTEWK0eKFzLHz+T8bcSscYphZwNgVrMYfoMCXWO0G5GGI78nj5Em8gP43IHQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791850097; c=relaxed/simple;
	bh=Gx+2N3pX64SMFMd7oj94l6KXrJIx/aXZ1Kmo3CIoKYU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XP1XOsNr8kfMu13nDhB0JqjX/Z0RhJzacA/lk6LfXw04DMqQ1bIsJpdLiywiakh4/9UhsitDfyIlTg5zZfsmBhfXnl2+7wnL9/28zicCwUqrqJJlv4WKQy3JT3mp9YT0SQVa5OUgvStMLOfKGaduu4agFGxIh4LSEYV3JZx3OLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=p7f4Bu0Z; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WZ5CapoC; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="p7f4Bu0Z";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WZ5CapoC"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 02D9C7A012B
	for <git@vger.kernel.org>; Mon, 12 Oct 2026 20:08:13 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Mon, 12 Oct 2026 20:08:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1791850093; x=1791936493; bh=tUhHOc4y2e
	JzlkVd+D5hNX5X3PATXRhUwzJVhrKTvoE=; b=p7f4Bu0ZQxHeh9TtTkkFD5ULcV
	ARZKR+4CuF8du4JwO9XTGf5ZewsTRXXjJ+SiC45tvhZm9siEA9VBk2enZkOfqThs
	32BSqoxH7h+c0c2yuAd/jSyjyIRRspN8c3BzLj+kk36lEU6kwzXMbInpUkcYfCBr
	PZW1PDU+ikIrHf27InasLakAgykYW4xjK4vrkGfMharbI3tpAvm4281ULOYYqAU4
	DSVFqAYwCrF+2MMoGJ6k2Ia2Sgka/LHtXWQIxLFic/V0e8KhWeTyjKihFutPcFco
	ZUI7rUYPm/1mag46n8Mt6LZ7uX9sytqxm9FSnoNJySh1lU2zUAx9sw3sUteQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1791850093; x=1791936493; bh=tUhHOc4y2eJzlkVd+D5hNX5X3PATXRhUwzJ
	VhrKTvoE=; b=WZ5CapoCAQ2+Xc3QEybeWOUqXg8/ge5xdz2uugMsU+w9t6rQMcQ
	pUL4chJVnVeeFp+xFvuf9TFV+f3y5TWfOu1QuaCI0tbR1DeNvAtfjy/pGcmm56zH
	TUsA99mYhfK+pr6bmkAFN+sgrG0cneGV0M2LeOrjKylTy1UeBVu4RwwHv6tntj91
	U6qD/8QS4b69wpexIHGSmGRvRnxSvyTUzo/qX5cHi/tnzCGuGE1Ja6WzlgkeJbfL
	cdG9/MFTyYQT/ImG15dPWbThNBR3Sy9CPHCTbuTNFgGLUwhNvFIvtVxvkmsWGzI1
	Vew9TQCDcSYLapuIAPXkU7BojaISzxlITjA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791850093; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:gG2kkOz+3Y5GCSBlBMC+Z31QTj3FdZi49sG4hO/PnZ79Z79
	hNrk8jnngcFEsSkXATWDU5lI8GWofdYM+Yyf1aH+JCs8/wIsoz0voEo/hr/AvyPx
	E62jJfbGGDNEg3eljzo0dkRaDrD3Q5fog+iyY5rIwFOrIsLIwJR0B4+1peUpWVhE
	PsR7SWL1c30dPp/e0Myj1k8J1upk3oyzEZUsUJv4on6L03RpJmpvfvW8sYy//Dq6
	Y/yGT8kw62pPmxhB4Dprq/MW2I79naP5qpJiEDNY60EiIarFtJaNIC8Q1vwmFatk
	NptIMrZRolaIEbh7Vr2jn3lMHyye/GRtk02Fypg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:37CGZj0igBKuyhC+PbJSldPJNeEmvRhoOwt9BI27ksA=:Gx+2N3pX64SMFMd7oj94l6KXrJIx/aXZ1Kmo3CIoKYU=;
X-ME-Sender: <xms:bXbNamfU5fOqiTH4QL_v-JfihUTjVgwKaJZyUSKh0c2dX0xxJ_RTiw>
    <xme:bXbNanHg0JFcj-m3OLJe6TojYRco0uihJst35276lWFdPxO08tvbY9WXu7hYCuBKe
    Sv_o1Y29X0Fi9VTH6SDe1uK15xcvi1LPlNyySqGCWNW1KaDGRqmooDy>
X-ME-Received: <xmr:bXbNav2o00il0bq2vIMAeceCJxtsUSn1lt6z6O4s3RNYLLDDe8PMvuR2j-clKeOObrhlTF389xmOjA7p4KPUrZCpBfLpv2Nx7szx>
X-ME-Proxy-Cause: dmFkZTECUlcoS0LvJLD0m9cBg27nxvphk/PBO+1Ln/WBFzqvDiyC48Nx/fhVCvbqQO3k6y
    Zk1IVGTeKDn2U36DZEu9FdrnTSg3fmiOGhjZVCz2FagdMSXxeeLoT2WCT+lLRpXP8gAv5Q
    TrGHHriNt9DhMfjvoOV0KU9uB6JTyt75VAJJsdt4rWHr2kkwaNf/Td+lJzW8+CoTBWLPwD
    7yjJ1vd9pp++dgi3TU7/uyr/gu9sDT+zb6aWnHBxRRgAk8pa9XLQT08BovgwxVy1uGRw28
    n15qQ98mPpghwWM4wZdXrDxyrtai68hVy5Wj+OKgDhljH3KhMQpCin6Hj83ZvPlU6nZnnT
    esjWd1Bg5I0w5pETI4UFFuVxUo8XEkU5SQqCe6haxgRc9SLGHjWTBuwLkdZwj2nqmVnFMJ
    u3Wa+sF3H4LgEqkcBfc55RjMSswAylb1LSpSIJHEsWG8Zxa4cS/EXhK8nat4pY9gdUcfDx
    VSaq6lCQ3lqLN0RlRCjnJZtelCaQVPzVP7uvd+uxH6Fan9mGOopj43NuM56WqH+QDL0/eO
    +A746EK/TVP3mmzGbdWs2tq2vXaQkDHKVlKrsFxxTCpuD5bOkgW1pz1qhtjLAqBNuOEJP8
    0wfjCuPYNm5pA0dvU5KFh/rC6qNbuuHbqop2duXeFX+Eh+5CnaAW/WUar1oQ
X-ME-Proxy: <xmx:bXbNavlrz-Ct_kQQV7tzHRKV6BBMTOFe_Dxzec98lm3jtZESloDkkA>
    <xmx:bXbNav9r9L_Rn8Xy3xDJUoZV8giMjI3PXL_InRhRJxfpbLuRhzec9Q>
    <xmx:bXbNakpvKQkAs0u9G0hSg6AnhOz-oxWvJWzZcwGXuZqXcWSCY_GdtQ>
    <xmx:bXbNaokmEjvv7EeZ1yD6mRDuKZXIORVu104W5efXnRh1SBkPYiW10Q>
    <xmx:bXbNat9ndftmiDGyhvlhCqDty6iUSqs6xIX9vMCrQk3yQUaQ2XzCgC27>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 12 Oct 2026 20:08:13 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Marc Becker via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Aniket Gupta <aniketgupta3001@gmail.com>,  Marc
 Becker <becm@gmx.de>
Subject: Re: [PATCH v2] fast-import: fix lookup for new commits and tags
In-Reply-To: <pull.2252.v2.git.1791845420568.gitgitgadget@gmail.com> (Marc
	Becker via GitGitGadget's message of "Mon, 12 Oct 2026 22:50:20
	+0000")
References: <pull.2252.git.1791653078449.gitgitgadget@gmail.com>
	<pull.2252.v2.git.1791845420568.gitgitgadget@gmail.com>
Date: Mon, 12 Oct 2026 17:08:11 -0700
Message-ID: <xmqq1p9u4g44.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Marc Becker via GitGitGadget" <gitgitgadget@gmail.com> writes:

The patch text seems to make sense, but ...

> From: Marc Becker <becm@gmx.de>
>
> Queries for commits created during the same 'git fast-import' session
> result in a crash:

Should it say "sometimes results in a crash"?  It is not like that
no queries for commits can ever be made before the session gets
closed, right?

>     < reset refs/heads/newbranch
>     < from <new-commit-oid>
>     > fatal: not a valid commit: <new-commit-oid>
>
> Getting file content for commit has no issue (working implementation):

... what do you mean by "(working implementation)" here?  Do you
mean that without your patch applied, neither commits nor blobs can
be read, and with the patch applied we get a "working
implementation" and blobs can be read?  Or do you mean that objects
other than commits do not have such a problem?

>     < ls <new-commit-oid> file-in-new-commit.txt
>     > {file content}

Or do you mean the current code does not allow reading commits but
everything else it does allow reading?  If so, such a description
should be followed by why commit alone is so special, or put it
differently, why blobs can be accessed just fine.  Otherwise, saying
that getting file content would work fine only confuses readers
without adding much value to them.

> During import, new objects may not (yet) be reachable via the ODB layer.

This "may not (yet)" is very believable; I would be very surprised
if we were holding any and all object data we were fed in core
without flushing to the ODB, but depending on the timing of your
query, necessary objects may or may not have been flushed.  Is that
what you meant by "may not (yet)" here?  If so, that confirms my
"sometimes results in a crash" above, right?

Here is what my assistant produced trying to guess what the commit
wanted to say.  I do not know how close it is to what you wanted to
say, but if the change were explained like this, it may have been
easier to understand.  At least, failures for commit vs success with blobs
you hinted at is explained sufficiently.

Of course, my assistant may be totally off the mark and the following may
not explain what you wanted to do at all.  I dunno.

    fast-import: allow 'from' to reference new commits and tags by oid

    During a 'git fast-import' session, newly created objects are written
    to an in-progress packfile and recorded in fast-import's internal
    object table.  Until a 'checkpoint' command or the end of the session
    finalizes and indexes that packfile, these objects are not visible to
    the repository's object database via odb_read_object_peeled().

    Commands such as 'ls' (via parse_treeish_dataref() and dereference())
    and 'cat-blob' already account for this when given a hex object name:
    they look up the object in fast-import's internal object table with
    find_object() first and read it from the in-progress packfile with
    gfi_unpack_entry() when its '.pack_id' is not MAX_PACK_ID.

    By contrast, when 'from <committish>' (in a 'commit' or 'reset'
    command) is given a hex object name instead of a mark or branch name,
    parse_objectish() parses the hex string into 'b->oid' and calls
    parse_from_existing(), which unconditionally looks up the object via
    odb_read_object_peeled().  If the object is a commit or tag created in
    the current pack cycle, odb_read_object_peeled() returns NULL and
    fast-import dies with "fatal: not a valid commit: <oid>".

    Teach parse_from_existing() to look up 'b->oid' with find_object()
    first, peel any tag objects in the object table using dereference(),
    and unpack the target commit with gfi_unpack_entry() if it resides in
    the in-progress packfile, before falling back to
    odb_read_object_peeled() for objects in the repository's object
    database.

> diff --git a/builtin/fast-import.c b/builtin/fast-import.c
> index fbd919982c..574a03c484 100644
> --- a/builtin/fast-import.c
> +++ b/builtin/fast-import.c
> @@ -292,6 +292,9 @@ static void fast_import_state_init(struct fast_import_state *state,
>  	state->option = option;
>  }
>  
> +static struct object_entry *dereference(struct object_entry *oe,
> +					struct object_id *oid);
> +
>  static void parse_argv(struct fast_import_state *state);
>  static void parse_get_mark(struct fast_import_state *state, const char *p);
>  static void parse_cat_blob(struct fast_import_state *state, const char *p);
> @@ -2658,12 +2661,20 @@ static void parse_from_existing(struct branch *b)
>  		oidclr(&b->branch_tree.versions[1].oid, the_repository->hash_algo);
>  	} else {
>  		unsigned long size;
> -		size_t size_st = 0;
>  		char *buf;
> +		struct object_entry *e = find_object(&b->oid);
>  
> -		buf = odb_read_object_peeled(the_repository->objects, &b->oid,
> -					     OBJ_COMMIT, &size_st, &b->oid);
> -		size = cast_size_t_to_ulong(size_st);
> +		while (e && e->type == OBJ_TAG)
> +			e = dereference(e, &b->oid);

This would mean we would peel down a tag that points at a tree or a
blob to tree or blob.  And that object is not a commit, so we would
continue going down the other "read from odb_read_object_peeled()"
code path.  That is the same behaviour as the original (in happy
case, when the objects are flushed to the odb layer).

> +		if (e && e->type == OBJ_COMMIT && e->pack_id != MAX_PACK_ID) {
> +			buf = gfi_unpack_entry(e, &size);
> +		} else {
> +			size_t size_st = 0;
> +			buf = odb_read_object_peeled(the_repository->objects, &b->oid,
> +						     OBJ_COMMIT, &size_st, &b->oid);
> +			size = cast_size_t_to_ulong(size_st);

And the code inside this "else" clause is the same as the original.

> +		}

So the change itself makes sense.  It is that it is not clear if the
"makes sense" I just said matches what you described in your proposed log
message.

>  		parse_from_commit(b, buf, size);
>  		free(buf);
>  	}
