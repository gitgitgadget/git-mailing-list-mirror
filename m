Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0333B488223
	for <git@vger.kernel.org>; Fri,  2 Oct 2026 11:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790940315; cv=none; b=d95p42TY+HJM6IzBiT1eavzosfeNWmR82d7pONlOiehlB1agGlsBrf3b1NxSDW7furCxuqioBhFXOkAmq5K3G/9Nkp237ovIz/PParI19QpOyxQ3KF/VXaK/Uj1ND30l4fA8oxk27fqDi0WFKynzBxLhdWaOpfNPNw2z7yP4MJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790940315; c=relaxed/simple;
	bh=HzXb7EIe/NUAeHtSayPxHqlwxyanCaIgTa5Mev6DXjA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tLRZT++eLt7WUd7T7eXTUBLr1yCY1WyOq2XrKQNXDCUD9MMJu8MqnWqlD1H8ACAY8d2oMbCbF+cW2tCMBOB66RwcevBy0y79SHOvwazph50u+h81h+NDdp0aSkG5igvOM5OzpNAtm7xQCYqP7TmgwUYFPPg9+ghx3Vmil5CN3vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=oJBCKKra; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=uqb3a0La; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="oJBCKKra";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uqb3a0La"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 1422E14000F6
	for <git@vger.kernel.org>; Fri,  2 Oct 2026 07:25:13 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Fri, 02 Oct 2026 07:25:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1790940313; x=1791026713; bh=zK33gArVyq
	7uT2T8iSqbTaDMOm8ihRDNF0o1fLbT24Y=; b=oJBCKKraYEXI6hJJVdeY6Mt43S
	CLoUdLVP8zCw/RuPnUaDizZfK/XCOIhEWjEqX2xlvG1he9kLzlg/YnOqeFmHloPY
	y70QbzVKhI/WjwKHjDFXMO1uHbAdddezIWvDZWBl4r/zfqWqIgy11gLCBTd/FLL5
	iJ0srXhvB0Wh0yFFJf+gFGaNzNlT3aFogAUlbdWLvVLOYHT4UkIT30sbApNIYE5H
	PXXbQkGsM83CYBT9RdV11gVErtj+Z3WI5fnDtal9eLpN6ie3k0GyAUmrNKkANbuZ
	Ep6bf+9O8Zfmcbbihiul4SeHCbUtZp4pRAtB0ijPuBFu+H2VtzUoJLTkToSA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790940313; x=1791026713; bh=zK33gArVyq7uT2T8iSqbTaDMOm8ihRDNF0o
	1fLbT24Y=; b=uqb3a0LahhwSSpxmBghJlxvJsswxe7oIfUde8QEQKkWlp+8ABe+
	MQyqYx/S7IJC7NAJdRbfrayvblXoIIUQgp1T3HsoPOC0Xj8LII0g5f5HwO25f9Gm
	yrLkxX1Vyd53hf6AuRWp2/CfLItv2fqVpmhkpu0PT4ywCLdd8iFTVBR6suExmLYY
	PPMWqC99YN69xzymYkPCCsC3rXu3YwBOkOL1BncZWIoCGxdbAY2MALDHZDFWrpwf
	mGTC6U0cX9ulZYcMJNNkm1i++pm9Ua+fNiicEvUCCKotgJsXBHx6uYgJqDt7XBFx
	sSTIUrEBSPXNcHrp9Lv8gp+6axSdnBFcAIw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1790940313; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:no60rwDPKByFW0dSgP7zUopcJr4YA6HA3tZzvFd+HY+ujeE
	J025CTqMfiETrEM11zbfoKuANVgNMGK1abcZDL1RrAmbfRTVYUhJTFt1jigQTgBi
	9dMyu3bdFMxRkDSFNAa5PH+vHq3WKpGDbRs5YgbARz75msDlMtcYpiNuokgmNAq7
	uZhTF2MrQxlyRd54hEWy5WXWFFjjR7nmpn1+rliaIyyRD240FYIkpUKznvuYQTwd
	rwlPTANN2WzR9CQYyKoZbEDkgf+kiVxCaQS+4yfaYwzU1E2RSHsJYVhrl2B/vsFH
	eDBIzj4htOuM5N3bhhuJjmKL06uXSUxYFoCu/xw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:dxSn/faxbWBZYPFgqROyw9nbVvTHih6OHO8UJLDmBto=:HzXb7EIe/NUAeHtSayPxHqlwxyanCaIgTa5Mev6DXjA=;
X-ME-Sender: <xms:mJS_amIcVOtyDyoheR0OQ3fnqXGZv9XXYoRLiI3EfVNcGnRf3N0qHw>
    <xme:mJS_akLBO8MrJMtLTygNaXANq6MQgao6pLqp8PdmhLZz6gtTEiZAjBEZ8hGdZ6M78
    aIo7ZTS0sgl2qZPKFHPJJ7dK6acE6JpwihV0yhchaXZ5-R6kQRXPnc>
X-ME-Received: <xmr:mJS_akWLM2l35zZkrMVN1lX86mPtf9YVaY0tea8HLZ8HJWluHn5Bjg>
X-ME-Proxy-Cause: dmFkZTEcDBOo22Ivu09X1A8CmHZyXVjegjfmTOXOPbpiY4eSnrdb3F2ePsvLhSlqdnShIN
    vwYhnmdncR95J0vMief42kbGsrCKLEqxrMNrGNaajtHfqG3iuo64KYrCCRYxA39COgU8fE
    larcRhZHwFB0mzJY76VriwIlgUQ15ApLUZKGdPfx3nD5KFf+XkKhzDlrvsVAzKB3bRiznD
    QpBIhMlSXpH1EQv31TuUUsAPrxViOByOa8RpxSY4qyeUkIJdeaeKT7NUyjOzFBWh7KH3tf
    sU796E+ibCe3udQtpgXvmVTGoOVv0GUg8xQnpn2QJSDiK818w+91qUn5Wm8Df5wLhZ/aiJ
    Pgtzoh1jCva2SAucTTXsh++ZXhiyX41bdPBHIJ8q3LT88aW0SfrmcokKACFimGWQx9FBpo
    pPqib1G9HVv5nlKLiWm8PBfOaKzF0pHuRDnDeCDPKyqmYMntlpgM6PFs4UguETsgYLfRZf
    elnv6HcHC/3v9IKti+91Gd3ZRHRwhlYm2fWnf6vfcEEDfxT9Zwa9FOJM65sAdXdkysaXR8
    Vc5eUtkCkrBsB/xNnoQImAsFzxrVVBZVRLs6PUJ71mkdmEtDCKpYbKQV0C3JbX35PDFlDb
    C0CYhAnw3Gd8+0BRSxrqLATPNp/Z7HkqkfTxeHknzEl01kMoTAq+JoEBdEOQ
X-ME-Proxy: <xmx:mJS_amiTiHtPZvDs-u7RGWP0wLdEmsGj6o6syTJ166WdvQP___d_XA>
    <xmx:mJS_av-wPEs9GqbzXo78aI4RGK_-wsnB2Cy3SrwlZ_lU1bA_DdOyog>
    <xmx:mJS_agBiiHoBVxunIs2w-8b3L4SxljFFmPv3RWsBlEw45ftyhsvz3A>
    <xmx:mJS_asJssud6KEr4pAUA5KBSyB7u5g9y9hdH9_2zrv_nls-7KQwaKg>
    <xmx:mZS_an6NfinKUjnHVrApm1zQspWuJC_Gz1YKfajuoNFvFIsa5jfu0tiG>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 2 Oct 2026 07:25:12 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 602401b8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 2 Oct 2026 11:25:11 +0000 (UTC)
Date: Fri, 2 Oct 2026 13:25:07 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Khan Zimov <kaliugov@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] doc: fix typo in user manual
Message-ID: <ar-Uk3BJyKTdQB4N@pks.im>
References: <20261001181412.846-1-kaliugov@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261001181412.846-1-kaliugov@gmail.com>

On Thu, Oct 01, 2026 at 10:14:12PM +0400, Khan Zimov wrote:
> The sentence following the git tag command continues the
> preceding sentence, so "You" should be lowercase.
> 
> Signed-off-by: Khan Zimov <kaliugov@gmail.com>
> ---
>  Documentation/user-manual.adoc | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/user-manual.adoc b/Documentation/user-manual.adoc
> index 5ec65cebe2..1652ab3e86 100644
> --- a/Documentation/user-manual.adoc
> +++ b/Documentation/user-manual.adoc
> @@ -632,7 +632,7 @@ running
>  $ git tag stable-1 1b2e1d63ff
>  -------------------------------------------------
>  
> -You can use `stable-1` to refer to the commit 1b2e1d63ff.
> +you can use `stable-1` to refer to the commit 1b2e1d63ff.
>  
>  This creates a "lightweight" tag.  If you would also like to include a
>  comment with the tag, and possibly sign it cryptographically, then you

This looks a bit funny as a standalone diff, but as you point out in the
commit message this is indeed a continuation of a sentence. So yes, the
fix does make sense.

Thanks!

Patrick
