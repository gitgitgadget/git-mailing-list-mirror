Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2BAE2AD03
	for <git@vger.kernel.org>; Sun, 11 Oct 2026 16:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791735743; cv=none; b=dMUUEL10wXrMPwpwGydep63ODJ95auSdCbHpwE2RDPmG1h3gyZhtsuJhjyVKsVJC2V5J0LDto12slpskq1px3N4sg1krRNRs+cRUTfpZ4PxZb4C8+BKhAwXJbGbCREmh1oO6VCX0EbCQcZe8z4xyxMyfFEj4tTo9M25X2ee9aSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791735743; c=relaxed/simple;
	bh=DAFSkuQd+MhrH8d7LHVCEYmlI68Jeh2TAQcdbV43q14=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=R8fatSWGp77qmzZnZ+ETxys7vdwfwqISqdHBm+/aoZLbTuj62LjqoF+doRPyyCL4Jhuuuiy8VVfyYc8pHzhkFlQB82x1I0T2juwz78bk4PinWd5p5s8wTiZ5SADStMkm3nWoPEkz7VMZg+Pf0qF7cNhqK3lJZWeGWQEVhPST9io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=I/GmSy/s; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=i4i4T1Z0; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="I/GmSy/s";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="i4i4T1Z0"
Received: from ams-compute-01.internal (ams-compute-01.internal [10.64.2.61])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 6D0381400047
	for <git@vger.kernel.org>; Sun, 11 Oct 2026 12:22:20 -0400 (EDT)
Received: from ams-imap-15 ([10.64.2.35])
  by ams-compute-01.internal (MEProxy); Sun, 11 Oct 2026 12:22:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1791735738;
	 x=1791822138; bh=go6juI06R+q5lrjWIbyH46cNYKWqJRxMqHxTko/BCiw=; b=
	I/GmSy/sqmRY2cwSvqS5NGaT9Wm3i8xYBRrws/wkUGzaEb61gNZgRQX1hHykwH1d
	HcEqsoASSJE4CJKA6rsNlWCQo92PNhViOr1nM1Y7Gx614LAVjbFcSzh8sqg72Q6m
	POKO1tFg5Ro4elzcIkfH+NaOnv//i9opj9dZQTB1tyuyWWAQyHEcYWQHqqO24KXn
	XdGy3bo6m4i3NThlJEcq59FRwEP2jOy47sN5H5ezh47pz+5znA/nOsvBvijL84lw
	jaIUZMLLnwyd4k3d4sim90osL5smyJfYtb4RVp/WkH3tr+Dzr4sCRmOoojFZI5BS
	pO/WeI8DdaMwTBeIAg4+DA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1791735738; x=1791822138; bh=g
	o6juI06R+q5lrjWIbyH46cNYKWqJRxMqHxTko/BCiw=; b=i4i4T1Z09A45Z85/g
	J80b4ZyH4ofxYLmZV9clsyakst3OYfXg541C28CtamRsnDrHMvrSVsIyNJuifkOO
	9pW5wJO1Hk/sDgxajywbxCkIL+2koPvfZPxbtkdmF3oUPeSqe3gGstCPcFAcd7JC
	xtLfvAzi5ZpwhcN7RwM/RAAfhbgp0bICtvvl7OeY1Q7f0UdQRcLUlJQS4qHWmZ7V
	oCdK1HyKvtpAlGz7c/DHjxmgRo8GYi9aDwEIGih9eoD0K86bteh5h0g7//7Rjih1
	VPDN4fxX4p72WlmpsbvMgY4tXc0/2SblVA/KSjTE1iGk6gXzVGkkrUdypQYQod5a
	HYaog==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=fastmail.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791735738; d=fastmail.com;
	mf=PGtyaXN0b2ZmZXJoYXVnc2Jha2tAZmFzdG1haWwuY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:c0TLy53clu+2jy6842Mnx59rntHbnLLwVfYzdxZqpl7JJ+V
	/PMpLeOiJgtL34/a2mlEZqcAOhDsvCOv2vzDz7fBw428LPLeqb/RnJo+T1rhqcwU
	EuipzMMF8lF0u/0Pbe6AMvnaDa0YZzgXQrO/V1oqDM+M6J9L40u7QM+mjzRNaQH9
	kzIJx6T/kn8Facz/KiK+Si/B5imLnxGEd8ykD0GyKeNDQNEyPic+lwTRm+lMDQqG
	CVaYwBdUwjPsDpVXW4uanvaKzEspiePZhB5Xn/cNNEMr5oQ3Rcpdn6YUfowc4T1u
	mJGc9P/eu7o2h8+nu3C6ruoZrVAoEvLc5ShxzZg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=11;
	hn=content-transfer-encoding,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:UFd6Wz7AIdN+oGBUX2BYqR8is0EJdgLpmvH3bREu3QU=:DAFSkuQd+MhrH8d7LHVCEYmlI68Jeh2TAQcdbV43q14=;
X-ME-Sender: <xms:uLfLaivn9meUea_DOcbaY1w9MyVTeSKnphJ7fAurMWYhfWUQ9e_PbAA>
    <xme:uLfLaiTjA1mQK0HnJlEVfwelY4Ma7HB1HAr-BfLeI6XpP1xnzyrLdicZeB7AAsqrF
    qhhrwAhr7jBK4MLwEBCzZPVPK5VxUayRHU7TbFAaoSuBOLbXuDm8nE>
X-ME-Proxy-Cause: dmFkZTExoD2k/0PeQz7AvHt8hs771xJfvyrF88BlW1uAazxoTZuZLqnNzlJxv2BEilgE31
    u7D4xBhMUZIGzzQO0Oj3MZk5WSedsB6TsJ3mkVt7p9WAsf2/oWD8EW8GPI/3z20lijdVO2
    Q/Sxjh49T7jkiTYYGF44FcA811rX8elYxcaZa5slGCWqK6SCrmakSE5+NIWqpN/3qa45c5
    eLwN+jpSaRDILZI6UNQWDrpKtghzb8R+p90QcUSTXjrG6FazEOPLfVpe817zOoss/prdpq
    7brctCB98YVBhv0jZMoKZ9XMRG3YNnuSV4ujE7GEcTxkR6o25UdhVqV/tLmFDWYKsIhJnk
    WrJXWdjNEXoJcADvR2WSzA54H3aMVxdbvysomXe0qClr1KXzrEaz4Xm9uuvj+3qUscI6nk
    l7W3rsqrog2xdnMJ2noeDEVoS6fy8az/Qt/lqYOOJhnciridksjOheQXkIwHmYblvSNr7N
    9nrgudO6pBgr7LYKR85lGqWG0bgJm+bsJqkOrf9IOv2EKyDbjGANouGy6ankSlZI9zwb5W
    vttH/+l/ojTFoNs03aEwu27PtWHFTHDKYRnm0TaUmacq508jltZ2H8QIMq4lI9Er4/1tM3
    zSsSA5JY+xXQp+sVmZeooN53Q8YNQwcK43ijO3suhBUc0vPnncnl0Lnpg0Cw
X-ME-Proxy: <xmx:ubfLaqVJ59Dt4micldBcKdNyyMm-LzXLFTPSjH_sxre_Q2d8vodEgg>
    <xmx:ubfLakan4JEkWWTfNyzDp20JxjgUgLQeYA8sz8emwws2TQhJ8KgOUg>
    <xmx:ubfLao1SuYiBsY_XFmQE_ZdmCGGzEeH6i5OPnunuYZdDrKLLrRn-Jg>
    <xmx:ubfLaughpWWE_CxXUIYvmCKlonVdrCFlBU6cBw8HldfmyfFZ2OaTwg>
    <xmx:urfLajpNc0hpBuJ2C_-0vM2In93mdfIWkH3udiWdX8ClUsjkFN5gJiSR>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id EF84B22C0093; Sun, 11 Oct 2026 12:22:15 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AxSHzAbYhR7-
Date: Sun, 11 Oct 2026 18:21:55 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Jon Simons" <jon@jonsimons.org>, git@vger.kernel.org,
 "Junio C Hamano" <gitster@pobox.com>, "Patrick Steinhardt" <ps@pks.im>
Message-Id: <b0d0ba54-8a46-4c1a-8d64-8b2ac07b051f@app.fastmail.com>
In-Reply-To: <20261011153206.72386-1-jon@jonsimons.org>
References: <20261011153206.72386-1-jon@jonsimons.org>
Subject: Re: [PATCH] SubmittingPatches: avoid add-failing-test-then-fix anti-pattern
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 11, 2026, at 17:32, Jon Simons wrote:
> Document the preference to avoid the 'add a failing test and fix it in=
 a
> subsequent commit' anti-pattern.  Although such a sequence is fine for
> local development, reviewers instead prefer a single commit that
> introduces the test together with its code change.

I have skimmed this document and indeed there does not seem to be an
existing mention of this point. And this is a useful point to mention.

I think the commit message should link to a few examples of this being
stated. Like one of the ones you seemed to have found in your previous
message.

>
> The goal of this addition is to capture the preference in writing, with
> hopes of optimizing future review flows by reducing back-and-forths to
> the list.

Sure, that=E2=80=99s always the case for additions to this file. ;)

>
> Signed-off-by: Jon Simons <jon@jonsimons.org>
> ---
>  Documentation/SubmittingPatches | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/Documentation/SubmittingPatches
> b/Documentation/SubmittingPatches
> index c60855f706..27b53d2b31 100644
> --- a/Documentation/SubmittingPatches
> +++ b/Documentation/SubmittingPatches
> @@ -271,6 +271,16 @@ fixed by accident to avoid regression.  Also, try
> merging your work to
>  that are still in flight may have unexpected interactions with what
>  you are trying to do in your topic.
>
> +When fixing a bug, you may find it useful to first write a test using
> +`test_expect_failure` to confirm that the test exposes the bug.
> +However, unless there is a strong reason not to, submit the test as
> +`test_expect_success` in the same commit as your code change that
> +fixes the bug.  A separate commit that only changes `test_expect_fail=
ure`
> +to `test_expect_success` can leave the behavior being tested out of t=
he
> +diff context, making the fix harder to review.  Reviewers who want to
> +verify that your test reproduces the bug can temporarily undo the code
> +changes while keeping the test.

This is well-written.

Tis comes under `[[tests]]`, so it is appropriately placed. It also
comes after `[[separate-commits]]`, and it sort of functions as a
counterweight to making *too many* separate commits.

> +
>  Pushing to a fork of https://github.com/git/git will use their CI
>  integration to test your changes on Linux, Mac and Windows. See the
>  <<GHCI,GitHub CI>> section for details.
> --
> 2.55.0
