Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C4001805B
	for <git@vger.kernel.org>; Tue, 18 Feb 2025 06:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739861206; cv=none; b=trDJWG7dKQe03swtGbRsA3jgg+f3rdcsg43MzRhrYv1vY1nHYnQfF30zON9oyd1DfL1kOOGOooiTTvaBf8qGjrmY3O2AHbgxI1jabeK5pQaZo3ifRK/Y/BBhgZLsev9EbMpbtlbiJQ5V3YHWa4ca+amQrZXGyhtykUg40Xav0JY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739861206; c=relaxed/simple;
	bh=NBw8dM4AsHAyQKTepCAOVHLalnG8Wk9znHD3CMKOPxg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TDLcFRuWAFUXkTIJM4QGmsUqKrpVaiDUpdtECy4lcEXImCkN4hmOUvuT/tKn2zPPu9Nd/QIjQNNTKjFhLw7fkoXZCA47Veyh/iBIT4pIYD+dAaaKAT3HQtK0B5eV43/9/HQ/+aBptm2pYXoUb2FfXhaAO3JM5uUgbsMNYtO9Jic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=s6XrCmbf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=l0Dw+fI1; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="s6XrCmbf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="l0Dw+fI1"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id 71A6713809A0;
	Tue, 18 Feb 2025 01:46:42 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Tue, 18 Feb 2025 01:46:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1739861202;
	 x=1739947602; bh=fjg54fZK09d3bv+n/nm9ulS8InW7XQAywCAECE5twvE=; b=
	s6XrCmbfFjqoGD1HwkqMTDHzS8X2vW4u1KXFuuqh+zXBB0RJTKAbEMJf+lD8xmcL
	VYu4dJbEAQDDVvG5aoP3f51XRHJleGHlNk76GUsibSp51QEgjx5gyHOZ1Qa6xsCR
	Tq0Jq06OuhAcql1Sjf99usGrNWnmB5f+420SyYo+PKDVb9jFeKY6aPrk1uA3gPT8
	77za7za3pJvBy7+/6BmIOEIEzk/fWQ3IAZLd9imun1H6yEiOiEmV1qNzttWmxcGt
	9vcCa4r5mEI6+zSs8WDyyuatAFefV+YRrDws3FUShG0SjQ9vX/DxUv+mmDCHjVkM
	G7AHwRKAqFWvhsVE7NUcaA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1739861202; x=
	1739947602; bh=fjg54fZK09d3bv+n/nm9ulS8InW7XQAywCAECE5twvE=; b=l
	0Dw+fI1xRsT/1Csxg+JQRdn0cy1Q6ptGJtIbQodgEPsDrQsH1ZaEkuGUBxeIjLCD
	V12uFcNiWLDeguMdPAWmP2BgJSKRlvNK2F5/yyy8+iGGL4usK9DAFeL8f3DGTtYK
	2yGPeWiIS3FV8hIU5PdcAt/C8oub75nL1Lj38T7PeUCTTVKl8GJFoA+66GRhmJYO
	ocDd5ggvHzn/CQGqkMSsg4SHeblzIvQb+ke5N+embcpti0NogiuLm2Xd+R7SwIrg
	WJmARsefQjbWkQ5rYnIgNPN7x/lyAL9Sc6lnN4onfVCDStptWIYENRHZq1xv2yTq
	PL+b7780b5Z38hjyooCPw==
X-ME-Sender: <xms:0Sy0Z9GaTMbLt0-09zDm9oowsQuWNDWE9lYKFXJHjgkMuymgUO_H_w>
    <xme:0Sy0ZyXNV4Cs9c6_dKa4Wd07s0GJNhWojcez-x_OB-3qFo_RkyMCDCuDQlHAlrouA
    aUI5inpYIvyUG_QUQ>
X-ME-Received: <xmr:0Sy0Z_LuLbPomM23T9gQAAbz2rcKOSJEsDuvKse8gpAt8XPeiJ5WCAby3kFKd8LTDbtcu9rMrIf-7VoORBSpJiK0YLTmsgmy4TD0F5CQi3rj8Rap>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeitdeiudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtugfgjgesthekredttddt
    jeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepvdefjeeitdetleehieetkeevfedtfedvheekvdev
    teffvdevveejjeelgeetvdfgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepmhgtvghplhestggvphhlrdgvuhdprhgtphhtth
    hopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:0Sy0ZzGVN_c-sXNtGhzHv67ahnUXeIK_NMwagWbgL2nzWbP7otBZ2g>
    <xmx:0Sy0ZzVQJHYDY4OpxmCqOPGfuxv8AzFBLyiRnkS-Sjo9FrjBh8Conw>
    <xmx:0Sy0Z-NgSFVQa-VdraTlfbwyk_cTGE6up3qt-ydpHE8NQzqWvYo8lg>
    <xmx:0Sy0Zy3EvvSEzQz1B34pY3ssmIwSnE-Q2iZG20Rc0SMOiuNIlqSgQg>
    <xmx:0iy0ZwhP8wf4-bsv65DnWfwqZ5X_PYM9MtIgE0FFnHjL3TmExrgWQiDU>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 18 Feb 2025 01:46:41 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id af28d3e1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 18 Feb 2025 06:46:37 +0000 (UTC)
Date: Tue, 18 Feb 2025 07:46:36 +0100
From: Patrick Steinhardt <ps@pks.im>
To: =?utf-8?B?TWF0xJtq?= Cepl <mcepl@cepl.eu>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] doc: fix typo
Message-ID: <Z7QszEnV4EzQMJ9R@pks.im>
References: <20250217130902.2706880-1-mcepl@cepl.eu>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250217130902.2706880-1-mcepl@cepl.eu>

On Mon, Feb 17, 2025 at 02:08:50PM +0100, Matěj Cepl wrote:
> I don’t think there is an option --signed-off-cc (without -by)
> for git send-email.

A couple comments regarding the commit subject and body:

  - The subject should point out _where_ you're fixing a typo.

  - The message should be assertive and use imperative moot, as if
    instructing the documentation to change.

I'd recommend to have a look at commit messages that relate to your file
by doing `git log --follow Documentation/git-send-email.adoc` to get a
bit of an idea of how this could look like.

> Signed-off-by: Matěj Cepl <mcepl@cepl.eu>
> ---
>  Documentation/git-send-email.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

You should probably rebase your commit on the latest `master` as the
file has since been renamed to "git-send-email.adoc".

> diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
> index bc3ef45acb..d762058907 100644
> --- a/Documentation/git-send-email.txt
> +++ b/Documentation/git-send-email.txt
> @@ -389,7 +389,7 @@ Automating
>  +
>  Default is the value of `sendemail.suppressCc` configuration value; if
>  that is unspecified, default to 'self' if --suppress-from is
> -specified, as well as 'body' if --no-signed-off-cc is specified.
> +specified, as well as 'body' if --no-signed-off-by-cc is specified.

The change itself looks obviously correct to me, thanks!

Patrick
