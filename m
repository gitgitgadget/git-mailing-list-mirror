Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58FD53C10BE
	for <git@vger.kernel.org>; Sun,  4 Oct 2026 17:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791135077; cv=none; b=PQkCuw8+FLgATe/b++DGlcXupgQCWvB+ZFqfpRlvffNKvehU1fDbHHxP0Gvy/8r90jqEdnijldck5ONx9uyHCiFL/vTPF8G/TpTfTRBYjVJsXfSetDEuNLhSyzi2Ndh2b3Elba04Xyjscq0fUqsHl5Q1+0xacbs1frkiIY/qhXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791135077; c=relaxed/simple;
	bh=d2syl8Ztm0ERLDt1H23VO6gtCTnBFAeHqwGwMzJJsrs=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=P/cRbUa70uQ57o+nwVvjegTjP6PhBm6foUJdqSmoPZwIurXDKHcejprL+Zz6bSZaZrc/b7A35Ls2o4PYtxTPQfzUf0BNutgjxw9Ih0lZzNBi8F1h9JaYXHXyStDJXvk+TQt0iVXoZhM1wq2R/SfrpcufpiqwwdmXqakkhyLSaDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=fnvgVCta; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kJkIKZ+c; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="fnvgVCta";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kJkIKZ+c"
Received: from ams-compute-01.internal (ams-compute-01.internal [10.64.2.61])
	by mailfhigh.phl.internal (Postfix) with ESMTP id CD7E414000DD
	for <git@vger.kernel.org>; Sun,  4 Oct 2026 13:31:13 -0400 (EDT)
Received: from ams-imap-15 ([10.64.2.35])
  by ams-compute-01.internal (MEProxy); Sun, 04 Oct 2026 13:31:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1791135072;
	 x=1791221472; bh=HAAAe5MpZ/0JU4Yblc94OQ+IleZ1C8bMqnghE553+io=; b=
	fnvgVCtapqQZNBk+snbvQDPldUiVOkVF4rawDyoh/JZElLfXp6xp6MSBoF6c0JL/
	GZXXb42Z2hNB0yzd1ScDqwviXssxtYurmmRm7EA0GeMxgHEVjAjWaHh2P8RwljsY
	NFaYFA8mRBDB92rT6UyT5SGQd4A6N84bedyaMiXd0Vmxxq0o6Qy9OMix+Rk7YLFF
	+qdkqEB0tZrLv4Ov5bq6joUZ50Bfdflr37/3G6vX1/kHSk9PNpRc6HnYlO1A7F70
	LzGSFGerlGdfqaZH9fT/mbzuch/KHotiGX3/H588dXhlaeQoxc94GFzASwulzBzi
	YVX3HkdbQzlPbkpCaJ4nhw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1791135072; x=
	1791221472; bh=HAAAe5MpZ/0JU4Yblc94OQ+IleZ1C8bMqnghE553+io=; b=k
	JkIKZ+cs3+oWMnVu87jvnQqGUiW5JGlsyV1xNcjB/15Rvjq2qXfi9PZPtRIcWHUd
	G4vfOZCrIVsbUFPmjAEqGohh82EtkhnsJC3ScFK+dFtHCRG24os/Q+dzbgu6hXSj
	FzS6UuqDof7y/PBv4vFv/xLMXo3jWDAvtEi3lIznelIEBLIacs48ZVXG664oCzMq
	Xr0/jePyeFf/U+3s7l7yJCqVhINHaGSkMfncmkuKuhlLpVX6Hw3VvkzSpPWQhPVa
	hGFlfB8FkMgImd1jOmzN5k53sM5/4/Md+4/T1GkJ5gYGZzDGuH5Y0vDp63emc2sT
	lRCkBPAu0r0Av6J2jubyA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=sign d=fastmail.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791135072; d=fastmail.com;
	mf=PGtyaXN0b2ZmZXJoYXVnc2Jha2tAZmFzdG1haWwuY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:A8+iCGJcn8j7WpzCX0elvJUBQimyC7trXAlyeHvFm2kvoqZ
	9LHTQVqyhzjYuxhakSQeBSx6BPPt7Y4dbP3AHV6pBSBOZGsY+QMWUgzUMiwilQqH
	eQAONqOeVgenlohGOScuK1SHm5Wy6FUKfy/29ErbJl++qYtDxzx/HvaaQ5wu7MsU
	MnJVAOwEaM/KjuPXfdoPjLFBKqijYzFndU+V5N+deNsGgXnp5juuSrFZxCOG9Hey
	0irn9u4sl11Dn07Yv5QuGyX5zc4aygWSzzUcZH4eQ3mZNPH+o1aqhxYJoZFzjTS1
	nrZjC5agvele0VSfp/nRdy+YVw3G9d2U8JFn6qw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:WrXJa1WMdUbLwy1O+dhrXTrDn4t6rhVHbCpxhCv+D0s=:d2syl8Ztm0ERLDt1H23VO6gtCTnBFAeHqwGwMzJJsrs=;
X-ME-Sender: <xms:X43CakbSFh-FvYo8TgihxzMfzJua3QMAGGQ2538aSdpEYCmf3ZN261s>
    <xme:X43CaqM_uSWn8egLCB2Uo9DwIR01hwVGdIjwVtXIzUdDie-qvjPQWohUN0yAOsl4i
    cwFFZ_6Zr5hgmsUKf1w01dKBQX7GfPjkq5eYBDUd8Tb5ZxSnpA8fq0>
X-ME-Proxy-Cause: dmFkZTGEoFK88AtPIz+HsDAY05soEkwLgSdBr3IVT9y40eMPCwp8NvU2PkL0Et+sAwROhk
    RsH9ewBU70G3lAkIq1tVYycNRMkwz3lRS0YOFTq4E5v4Suwf0gFWgxHQk7qH5Uq0geLN5d
    Ob72RFIPPfq99ZYgXNNEUM0A/R0fH/DIhdysaD9xJbdAM7TJcIVO8l8KiQRvjBfMxbQKsV
    fywBovg6i97bwiBKgMrq4+XWTfuaVyvM9aERyeQemCk38z4zV4/nmB1dWP/cED5KCzWmvc
    /stGlGqd5p+HkmtULmugJd4eGsh59Ktd8GlgZzFyfuuuShsnsv6/+fnN7ubq5EMfsLboTY
    r+0SaEQhxgjE7/Gm4CWcc4cUHd4hWcmMJKkLoz9QAnhDya0y1DEljTtXmDKFi+v3klF61r
    Ccx6f97F6IudtOFxJklj/8HoopIRqyD1tkW/58+wKc3aVwdz2m14f65qp540BR8PAgwAz1
    UlegW2kgVmUj62SHO+kgkQXvPot93VUPUnk+bkP+8EC5s7PGTCcGpRftT7AKrvhU1eDkGA
    rPX6f++gdEWtp4I98EXZZeifW8C4RlXrphr0XrfukpsTRGB61hrwTGL4iLOLcKul5gVIel
    HrhNHXFy/dYs2JH0hc+bKNqKpz/Xb9XDFCEw1xKC4BAcqeP3LqoWRyQWBcuw
X-ME-Proxy: <xmx:X43Cau3OHPGniefpDm_a0pKZQlorEcJb_mV3-yxL2R5sO5isjbK-ag>
    <xmx:X43Cao2Mc7wZXLtGGUqfOvp4LPvlfDQgP3Ni-sbhPd_zkan8AUhfag>
    <xmx:X43Cap8B10_-7qnzr6TgJKHBT2glynoL-oqUwWna4Aqx0tXtxkDO0A>
    <xmx:X43Cat0LJpW3sY2QmWEpSMU-F4Mi2n10yqynIWMZHFiXJgx6A6kw9Q>
    <xmx:YI3CauRwLYeTHTwI4nYE8N0SdOpVkvAmVyrNW-I1i8s1ytDkeMxGUKmk>
Feedback-ID: i83a1424c:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id F2ED022C0092; Sun,  4 Oct 2026 13:31:10 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Aaez0ouLjM7B
Date: Sun, 04 Oct 2026 19:30:50 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Junio C Hamano" <gitster@pobox.com>
Cc: git@vger.kernel.org, "D. Ben Knoble" <ben.knoble@gmail.com>
Message-Id: <8df975c9-0f90-4ec5-8003-7f4757067fe2@app.fastmail.com>
In-Reply-To: <xmqqqzi5touh.fsf@gitster.g>
References: <CV_format-patch_learn_--range-diff-notes.c57@msgid.xyz>
 <V4_CV_format-patch_learn_--range-diff-notes.d5c@m5gid.xyz>
 <V4_format-patch_learn_--range-diff-notes.d5e@m5gid.xyz>
 <xmqqqzi5touh.fsf@gitster.g>
Subject: Re: [PATCH v4 2/2] format-patch: learn --[no-]range-diff-notes
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 4, 2026, at 18:25, Junio C Hamano wrote:
> kristofferhaugsbakk@fastmail.com writes:
>>[snip]
>> ***
>> Note that using `--creation-factor` without `--range-diff` will cause
>> the command to die. But this is not the case for `--[no-]range-diff-
>> notes`; we would have to check `rdiff_notes.override`, which is a sti=
cky
>> value (cannot be turned off). The reason is that it is potentially
>> inconvenient to error out since it would not let you turn off
>> `--range-diff` in, say, some alias that uses `--no-range-diff-
>> notes`. Granted, it is difficult for me to come up with a concrete use
>> case since `--range-diff` requires a value, specifically a value which
>> is probably not that reusable (revision range), and yet you have
>> something like an alias set up with it. But why spend code closing
>> that door? There is no usability upside to erroring out.
>
> In short, do you mean something like this?
>
>   Unlike `--creation-factor`, `--[no-]range-diff-notes` does not
>   error out when used without `--range-diff`.  This flexibility
>   accommodates workflows where users might configure default options
>   in aliases or wrapper scripts, allowing `--range-diff` to be
>   toggled independently.

That=E2=80=99s a better way to describe it. I think I will use it pretty=
 much
verbatim.

Now in hindsight, with your version on display in front of me, I don=E2=80=
=99t
know why I couldn=E2=80=99t make that paragraph more straighforward. Som=
etimes I
go on a narrative journey because I think it is clearer (but never
shorter), but here I didn=E2=80=99t want to do that at all. I just wante=
d to lay
out the motivation. Stumped.

>
> I suspect that erroring out when only creation-factor is given,
> perhaps via an alias, was a design mistake.  A user who wants to use
> a setting customized for their workflow must resort to an alias
> because there is no configuration variable to control its default.
> In that light, the same argument for --[no-]range-diff-notes applies
> here.  On the other hand, perhaps if we had a configuration variable
> to control which notes are compared in range-diff and shown in the
> output, we would not have to worry about these things.  I do not
> know.

Yeah it can prevent some workflows while not really helping prevent any
errors, I think.

I think I can make this next version right now. I have tried to give
more time to each version (like the last one, intentionally waiting more
than a day) in order to give other people time to react to them. However
at this point most of the changes in this series are so stable that I
don=E2=80=99t think there are any points to interject to for some hypote=
thetical
person that already had two days or so to speak up.

>[snip]
