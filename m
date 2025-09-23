Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83DB3F9C1
	for <git@vger.kernel.org>; Tue, 23 Sep 2025 15:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758642859; cv=none; b=LYPIEPV4Qdo9RnNmswKiLGsY6l6abeRlbSKoeDEds9AweFPEkBtvcuMYeb+CVts+q0/4hC0Qa4cEuMMO+0zlbk+0pceiTcjx4VhSD+jgrJf+dv0KqZj877hBawCjr/aBMI3MTSrSmxqNUzHXQ3gJa4+x+fWmYbsRVzTU/G+/o5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758642859; c=relaxed/simple;
	bh=trE8QTr7UXFDSEkB1GoqKNUNlEjRVJLetPNaodn/EOk=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=s3dytuWupHZvTG/dy/fk+FRP6lKrhsCnTRjeeygdP1vfJrWpT+59HTa9b0+kePz4cH+FoFOxqccl3n3v9AcKC3v6nJA1XCWY+K1z3ATae9i/xQCkLUvS3mkF13qaZ/+0aQYkbplC9Qa8kj/0Khef2k6hscqk3CL/0+QDLAKlEnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=XgJLQJ32; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Bfz82K74; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="XgJLQJ32";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Bfz82K74"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id A0564EC0109;
	Tue, 23 Sep 2025 11:54:14 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Tue, 23 Sep 2025 11:54:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1758642854;
	 x=1758729254; bh=TiWdPJlv6VZy4BDEogPGoP9pkCw3neMQxvX0xhlvk5M=; b=
	XgJLQJ32L0slH+LQZ48+x/RLaUdcpMIyrXF5P7eqK5/KBgwcbp0sfZh55oB7+dhQ
	q9x4m4OACYtzhbxPa20RY6OS0P8yE/WKOQfHwUCtst22v4xnrwx6J1pgMbEcCKa8
	k06eEzfmVpCBvhmE/KohTIFvqgLm3GX+/mCA0Dcrk+2AaUinc1DRfonmNNP+1OLZ
	Uj86W71C1Xqvx43Ap9Ty0668x7EN80NNMk8zMaUgoDwh8ui7vBo5hOPivM5dbrnT
	ewF/e3KqsfeEh0Dr4exKtmoCF/Xm3TLHqfSG76SREm8O+CjroUvy7K77iW+Oa6m3
	UAjB6Qt9eV96bOA4B0P+Vw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1758642854; x=
	1758729254; bh=TiWdPJlv6VZy4BDEogPGoP9pkCw3neMQxvX0xhlvk5M=; b=B
	fz82K74qBTj+1ajhRmaF1rpcT59rCyeFcuRsbdUL7ssXob7hsJv8YL6wcsorAPl7
	e17jwx6eSr6aYLdE3GcVTkoNP3EOyGLAMpEXlg+6cVQaYTBYHodjvPNLZKRP6QM/
	TUXxrfS/HGv3wcDdbn4rCh/PTpsxcLTnPlbHqYx/NLtYLF8Wkfk0+YBn0sVA5UkE
	cZNt4jh/C/RdM8gZ5mOFQuxarq3/2DFoo3b2Kj5WiCPe6pmQ0FinmFSinXHCTKu+
	nShKZ+MiCeEf/u+bth1aHlGRCwiCmySYj1H54BweEmluSIHSTRA+aWUVGgV4nRnr
	x8Vyrok937/5WxQXOziWQ==
X-ME-Sender: <xms:psLSaK1EAE3RJ7nheCHyg9-99eEOL0qrK2iAfoIxcuJvFnsqpWezLwc>
    <xme:psLSaH5_2zfPPJtRpcEmuHOXG8LYuWJKO-1JxKKk210TtFHEFFh8Qc8EEFz-suu_K
    5klhZmSeZndMKtxwBweCsR148mBsexQJqb2C4YLqRSfu_3uLNjliA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeiuddugecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhepofggfffhvfevkfgjfhfutgfgsehtqhertd
    ertdejnecuhfhrohhmpedfmfhrihhsthhofhhfvghrucfjrghughhssggrkhhkfdcuoehk
    rhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomheqnecugg
    ftrfgrthhtvghrnheptdeigfegjeegjefhheeuvdegjeekleeguddukeeljeektdevjefg
    iefgfeekudfgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhm
    pdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehkrh
    hishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprhgtphht
    thhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvg
    hrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:psLSaNxvhelG5qIXCQ1ZXUn0saF4EniDgz3qP0Ws-L4FwCvljKG17A>
    <xmx:psLSaFDM6h-uiKV3KvnE8u9Es_xqC9V4eNHTtpOu387NOyJk7obVSQ>
    <xmx:psLSaKZZqq7-lUq9biQmatEB7K8V-iXdY1IVF8St4idkDsvng7MqtA>
    <xmx:psLSaNjQrA4KVf02AACh0wkhey8De8KauXv1W1wZv_Os5uw7ERkeLw>
    <xmx:psLSaGLw6w1otfmhU_SecI8ZXzcRbqSz99K6xeniOG9Apvaw8qNS2jls>
Feedback-ID: i83a1424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 6D8271EA006B; Tue, 23 Sep 2025 11:54:14 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AV1qRGHblxFk
Date: Tue, 23 Sep 2025 17:53:54 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Junio C Hamano" <gitster@pobox.com>,
 "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Cc: git@vger.kernel.org
Message-Id: <ba9b7fb2-c990-44fb-a506-0800d02854a9@app.fastmail.com>
In-Reply-To: <xmqqikharvyl.fsf@gitster.g>
References: <cover.1758574974.git.code@khaugsbakk.name>
 <bb065767336.1758574974.git.code@khaugsbakk.name>
 <xmqqikharvyl.fsf@gitster.g>
Subject: Re: [PATCH 1/2] revision: add rdiff_other_arg to rev_info
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 22, 2025, at 23:58, Junio C Hamano wrote:
> kristofferhaugsbakk@fastmail.com writes:
>
>> git-format-patch(1) is supposed to treat Git notes the same between
>> notes output beneath the commit message and the notes output for the
>> range-diff.
>
> Is this an opinion, or are there things that existing pieces of code
> already do to achieve such a behaviour already?

What I mean is that

    Notes (...)

Beneath the commit message and

    ### Notes (...) ###

In the range-diff should be from the same namespaces. It shouldn=E2=80=99=
t be,
for example:

    Notes (presentation):

Beneath the commit message while the range-diff has:

    ### Notes (testing) ###
    ...
    ### Notes (scratchpad) ###

That=E2=80=99s the point of passing `--notes` to range-diff.

Am I missing something in the explanation?  The commit message might
need a rewrite.

>> diff --git a/revision.h b/revision.h
>> index 21e288c5baa..26c18a0934b 100644
>> --- a/revision.h
>> +++ b/revision.h
>> @@ -334,6 +334,7 @@ struct rev_info {
>>  	/* range-diff */
>>  	const char *rdiff1;
>>  	const char *rdiff2;
>> +	struct strvec rdiff_other_arg;
>>  	int creation_factor;
>>  	const char *rdiff_title;
>
> When embedding a struct A in a struct B, we should always make sure
> that initialization macro/function for struct B is updated so that
> the initialization for struct A is done correctly for the new member.
>
> We do have REV_INFO_INIT for "struct rev_info"
>
>         #define REV_INFO_INIT { \
>                 .abbrev =3D DEFAULT_ABBREV, \
>                 .simplify_history =3D 1, \
>                 .pruning.flags.recursive =3D 1, \
>                 ...
>                 .expand_tabs_in_log_default =3D 8, \
>         }
>
> that does not allow any existing callers to leave it uninitialized
> or get away by zero-initializing, so all the users must be using it
> or the system before your patch is already buggy.
>
> And we do have STRVEC_INIT that we must use in that initializer.
>
>         extern const char *empty_strvec[];
>
>         struct strvec {
>                 const char **v;
>                 size_t nr;
>                 size_t alloc;
>         };
>
>         #define STRVEC_INIT { \
>                 .v =3D empty_strvec, \
>         }
>
> So this step forgets to update revision.h to teach STRVEC_INIT on
> the new rdiff_other_arg member.

Thanks for the explanation.  I=E2=80=99ve added `.rdiff_other_arg =3D ST=
RVEC_INIT
\` to `REV_INFO_INIT`.

> Back when it was a random one-shot variable in range-diff, it might
> not have mattered all that much, but now we have it as a proper
> member of the struct, can we give it a name better than 'other_arg"?

I=E2=80=99ve had that thought too.  But then I forgot what a better name
would be.

Could it be as simple as `log_arg` or `log_args`?

(This could be added as a preliminary patch)

`builtin/range-diff.c` uses `range_diff_options.other_arg` to pass
`--notes` but also (and quite recently[1]) to pass `--merges`.

    /* If `--diff-merges` was specified, imply `--merges` */

=E2=80=A0 1: f8043236 (range-diff: optionally include merge commits' dif=
fs in
    the analysis, 2024-12-16)

> Or is it the case that truly any random crap can be slurped into the
> array and thrown back at "git log" without range-diff machinery
> understanding what it is doing at all (which I would not be
> surprised, as some parts of our code base is written in somewhat a
> sloppy way)?

Well anything you throw into it will ultimately end up in the git-log(1)
child process in `range-diff.c:73`.[2]  But this doesn=E2=80=99t seem li=
ke a
problem given that all the arguments are =E2=80=9Cprogrammed=E2=80=9D as=
 constant
strings?

=E2=80=A0 2: on ca2559c1 (The tenth batch, 2025-09-18)
