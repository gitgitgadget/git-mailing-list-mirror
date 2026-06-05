Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 606DD168BD
	for <git@vger.kernel.org>; Fri,  5 Jun 2026 05:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780635936; cv=none; b=MKEwE7pNKvmdckORIRM8Gw+d0ToTTuFqRhE3sBUGAXr2P6KYSKjp06GE3QWu1QRW79tOTnpPht88WIiMtkNh7EA/iY3V/N/Qld+jMrUDmvDJ8ILbdMJyzQaOovk+NmdZFKNlwNlGYa/7tuKmlr+vJaLhHc121N6T6NIxD3JTK8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780635936; c=relaxed/simple;
	bh=UzL4GU54zZLFcYl2/YLT72RIRWp8sbohyculaNdY3Ns=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jET5M2pJav4wUlOkwgZl/9zsOWIaQBPRIhYKZZg/7cbZLjHpiwm+BSNgtTN6lpgqxWWOcl84E0cz/8R4CV46or30kZAJAPcQT4TcYUPVKeTowV/qEK5CD46ZT/bm8iAbvflvrM27RERXK61FVpX9iwLof55xoxsszy4761wq+zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=emailplus.org; spf=pass smtp.mailfrom=emailplus.org; dkim=pass (2048-bit key) header.d=emailplus.org header.i=@emailplus.org header.b=h4mqrYXW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Yt5XizDp; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=emailplus.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=emailplus.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=emailplus.org header.i=@emailplus.org header.b="h4mqrYXW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Yt5XizDp"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 85E8AEC011C;
	Fri,  5 Jun 2026 01:05:34 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Fri, 05 Jun 2026 01:05:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emailplus.org;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1780635934; x=
	1780722334; bh=gzvzgYrza5MkATygtTVEtVZwvYfUzgVBif4hzN02PnU=; b=h
	4mqrYXWNMTUEU1rFnbLKTG+ztW1JQplu5VP9p4YbJ9tdV6/aG8oxrbo+r/OtCD9l
	BKn+0uWpUhNBJh15nOytH5lHJiX6emh8ILo7Pl3n7VyuO3YxqGE8ei4G3HAJgHmD
	UjeblQbSIFoVL/iHBUdINIFMg1QmKc5DHIG4pYqkemh9++AN0+c81y9llXkj+BCr
	nRqzZHk4BStAGkVpi/zxh2SGo0aryRF7vfYVbBQQPR21+hbK3i4Rtf6ItIzIc+lI
	kmGWtKG2z201LS7EpZUJ8ILCJaxKByeCcu3tMfFmm11yJ0tvA+cJkYhTWRrX1vTG
	YnpZwyoTxV0E/jEAG/nIw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1780635934; x=1780722334; bh=gzvzgYrza5MkATygtTVEtVZwvYfUzgVBif4
	hzN02PnU=; b=Yt5XizDpF3gWpZ0RoreEUSsCacoMSgfO4tJn9IEHTveH3h5puIY
	Ra/2XDFwjBOrS60XxU+4sZm4lFECePKZmqi08voWUR723PbziZzB9/g+9Oa4WIQG
	odr2w6nT7ZzGNIhgON42EVzliLkRNjlnoD1HM01/sffkMGVPr2RCj/BLgXI9eQ91
	h/yJTV0mVdPM4OaVNXcIOrO7MOiyig/BcuW2aCwPvbPr1vn+A5TOfgNM6idx65DX
	AOmXs7etLqHBdyNfzknrKhqR/a5ejc9HG7F9UsJCCHzwnt23pTNoqq1L5kC5uBFp
	ucRVLjZUN1N8ExBJKGSkJnXDmAT/zmBSwcA==
X-ME-Sender: <xms:HlkiaqHhbzAjIcYnPa8E0BH0E-1RKFLKEkVvYRMXEBke6B6_Ln9X3Q>
    <xme:Hlkiaiyvl3RnVDUv6_RXnL43809BG4k4t976ACD_DYYy33epwQZcqZY85ll6zcPxp
    jn0YZcWfgonlU21FS7NaLOauvLT5rr8hmmcrMeALqikZYUObuAQlg>
X-ME-Received: <xmr:HlkiahgmBcWUrVLGqK7BVtpXGkH4KfwtpUNU4QG957anWLSFx0OE5ho>
X-ME-Proxy-Cause: dmFkZTGBJJd0jAY6YFs+DrqlkSm0LEvOrCvFJUht2HeeESUrIo/iIeeRkFILRYOuci99aL
    21Ec3XM44FQCazeBENxyeltYjrd++i8ZgIKsLoj2ASo0tod8WN4RkCUVMaPA3a1+UwJiHF
    kw1JTQvZuG3nDh9ajSy9QMg9qVQR2St9rzrFnbMkjdS2ngZzZhZxxaUHy4PFJLWPs7oMnv
    kVoZkNMLr11cS2Q08CTWPU/N+DCAneeC6kIe0gBCd5a26k75yZsp0UvxHEzdLV9o8fmQR2
    B8iPTLOv8LeA9rtEHZwZ2q8RngX9b55KMa5ZhATX4mdAjJHjl8EdQL9ZxckE1/hWXjfss0
    wXpqjdHb/dx5Wjke96mvtsoA+GH9o3qerL1nuHlRHhH38iFZ+/D6Qfir/CE80DMs4+9svd
    FBeHYcfKqgoDOEkfyDjERDt+mx6uqsKRq5AaBn+zAark0QfxGkH7d1qMMGr2nswYpeuXn+
    doFK+xyQVcYoodz5dyCEW3Nt57J9vEqXhUcgQBWkZbGg4YW0RMJizkrB97xN5uGY7fftpO
    7MQ3rXbrCpPWY1KFJ2VQ4eRPvyOdkbgctLAS0PHaCOTRS51GfDJ5i043AgrXBwfQs1ety3
    /ZB8MM8o5ooRDFIZf+69Mba3m7X/aO5FbnTYc4qHUzDbEMvGwrPG+K0jbgVQ
X-ME-Proxy: <xmx:HlkiatxLVVojkvpepySSreNNM0crk940ADH5XRsHc-xHr7SZWpIGug>
    <xmx:HlkiakJwqjlw8-GOZmKnXoEPb1qwQOtUaD5m2Mjp2uloOsn57GIrfg>
    <xmx:HlkiakSZ1nFfXYeNXOlsUIHnzvZF9FfQBkyTUnXL_vT3q2FH6NyOEg>
    <xmx:HlkiaspjlfbJMoqNYRG80T9fQlQKm_-FKAbEhmfQ_apGH-anad-gjw>
    <xmx:Hlkiaoc7KrMCmTkMRbHittPBk-bNwyE-uB6NMMSglceMqJG_UaLDx6Q3>
Feedback-ID: ic1e8415a:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 5 Jun 2026 01:05:32 -0400 (EDT)
From: Benson Muite <benson_muite@emailplus.org>
To: Simon Richter <Simon.Richter@hogyros.de>, Junio C Hamano
 <gitster@pobox.com>
Cc: git@vger.kernel.org 
Subject: Re: Mirror repositories for submodules
In-Reply-To: <d64e7f31-4e00-478c-ab31-b671242865fb@hogyros.de>
References: <875x42vlgv.fsf@emailplus.org> <xmqqcxy7qfgk.fsf@gitster.g>
 <d64e7f31-4e00-478c-ab31-b671242865fb@hogyros.de>
Date: Fri, 05 Jun 2026 08:05:30 +0300
Message-ID: <87h5nhr2zp.fsf@emailplus.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Simon Richter <Simon.Richter@hogyros.de> writes:

> Hi,
>
> On 6/4/26 10:09 AM, Junio C Hamano wrote:
>
>> So, no, I do not think a contribution to add mirror repositories as
>> alternate submodule sources should be considered for inclusion, as
>> it artificially limits usefulness of the feature.  A feature to add
>> mirror repositories as alternate sources might be worth considering,
>> though.
>
> This is relevant to the Debian use case: we run a git server that 
> archives git trees for Debian packages, and ideally the objects on this 
> server should be identical to what you get from upstream projects.
>
> This is a big problem for archiving projects that use submodules, 
> because we cannot alter the reference URLs.
>
> Cloning from our server will, depending on what upstream uses, either a 
> relative URL (which will go to our server, but we have little control 
> over what the name part of the repository base URL is going to be), or 
> an absolute URL that instructs clients to pull from another place, which 
> conflicts with our goal to have a self-contained archive.
>
> The idea posited earlier, to have a "repository identity" that remains 
> the same across forks and clones, is somewhat appealing, but the best 
> idea I can come up with is generating some kind of repository UUID, and 
> adding a symlink -- not a great design because it pollutes outside the repo:
>
>      $ mkdir myproject
>      $ cd myproject
>      $ git init
>      $ ls -l ..
>      lrwxrwxrwx 1 simon simon   9 Jun  4 14:05 
> 12345678-9abc-def0-1234-56789abcdef0.git -> myproject
>      drwxrwxr-x 2 simon simon  40 Jun  4 14:04 myproject
>
> On the other hand, this can be used to construct a stable relative 
> submodule URL.
>
> Making the symlinks optional would require keeping a list of local 
> clones and their UUIDs, and resolving them.
>
> I don't like that design, but as I said it's the best idea I have for now.
>

For submodules, the metadata consists of the url of the repository to
clone from.  One could have a list of absolute URLs.  The default would
be to assume that the URLs are tried in order, and if a URL times out,
the next one would be tried.  One may want to change the default
ordering as a user setting, or do a ping test to get obtain content from
the closest repository.

As an example, for linphone-desktop, the first part of the .gitmodules
file contains:

[submodule "linphone-sdk"]
path = external/linphone-sdk
         url = https://gitlab.linphone.org/BC/public/linphone-sdk.git
[submodule "external/google/gn"]

This could be updated to

[submodule "linphone-sdk"]
path = external/linphone-sdk
         url = https://gitlab.linphone.org/BC/public/linphone-sdk.git
         url = https://github.com/BelledonneCommunications/linphone-sdk.git
[submodule "external/google/gn"]

> I also fully expect that Debian's servers will be used by a lot of 
> people outside the project as soon as it becomes a convenient fallback, 
> in the same way people are pulling .orig.tar.gz archives from Debian 
> mirrors, so we need to make it easy to set up a mirror, to allow this to 
> scale.
>
>     Simon
