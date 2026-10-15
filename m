Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D827223DEA
	for <git@vger.kernel.org>; Thu, 15 Oct 2026 17:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792085233; cv=none; b=ZnoUqCVlRg1Rs72IwxK0yUKA3JD2SGFkGkeqCITtn1lh6WnG5Lf5MFeu3VW7XYQn4FoNfQIy5sDsqBa05qPnqL+LbKpKukZ9z7zRfngMT7NMeD6ZOdtaJZriNW9CrwG2YnxQu50PXW+Hp/1N1cdX2Yk+egwXjDJ6YNutFaGx6XE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792085233; c=relaxed/simple;
	bh=tMVp2Do1L+ZMUu8opDt1S/YUYbmXCaEBt3fXdoro9WA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XcCLAQllg5OzZzCXpVlMRRpTF9O37R1DaEXFzl5+6YO9YASa14gQWdlBS+Qm1wJh42EuDDtA8ytjM5DJcV4vwjCZGW2PImJgD26VRT0pCaIOGEnlmDD2YSuRJvCrq8VaTdeMgIYa5Af+yaO0fx+F9nWZQVCAeRkhbo/TVvJNRYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aXkf7zQd; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aXkf7zQd"
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-48e94879f02so1799056fac.0
        for <git@vger.kernel.org>; Thu, 15 Oct 2026 10:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792085225; x=1792690025; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xkA8I9LMatE/KdnJ8LjJ06ONvF7vsmqP0jl09JcRL9U=;
        b=aXkf7zQd0TPmRSNrDmO+QYBpvq4wbcsMVjxn8KYvZ1uGeJ9A/YSNOLyzZCgf/7Dxq5
         xmISB1VmL7AMNC+Z2v1EO4zzX+3hZs6bcpv7TkDL72x9OIGamReqRK+fBdd0Xrm5h4l7
         +2vB1RnD8tuATHAYSxtf7swhREEb2DOqu+cHCJvdcJKkKTztJvVlQ+XDBCwj8Se+UfKg
         GWVRXQ0VL6MrvUqFuSaJKubb1GA93x+x/57Ty8WCadwvu5I/Px5IM9t+oxdo9X4ffNxC
         kt12deIcGnnXRdNA2arIjK05XG24NEjAWD+xeUS0NR4Ye54utIdpx8Gl+JqldGmIKZSK
         EVGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792085225; x=1792690025;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xkA8I9LMatE/KdnJ8LjJ06ONvF7vsmqP0jl09JcRL9U=;
        b=hCnI++KGru9peBClSMgndZGyiw7Vi1meDz6DVMprsuiA4dVW4UDd1IleFHexnXcOm3
         rs6Kxw2WVOq3dlyUB7fFfM/FBnIE7A3s5opwElZe1378UBZosZzITn+vTRUMzImYPyvP
         AMz9QFEzIkNL3De8IJbCCI/DJJXBOvhTCx3FmwLe+RkHLMLXWWEYdn9fIE+/YTb6wKAi
         sbmBOlIC65RTJ3XGv/tWk4BEaliGKK3ceUYFVap1FNwKvAfHs+scNqPnvDG0X2LUsGJD
         HE0TU/5QWsRKW6LzChJqzbBVN+ZdeTlF0aBZlaly0dvk1QCfcKPuCdL0WiG2aEY2zqCC
         5p7Q==
X-Gm-Message-State: AFq9FYLVEXkagTXyzp0EtF7XoWadpg1NowZfAEcJC1OxMFnZG9CDUvHV
	HJxkVAPVf+PNOzkqACnGYA5n1PQGNvH3YR5bB9LljXMlDEcVbtf20sjV
X-Gm-Gg: AYBFou2H/mYJwOfh4vVzmY25pStR5Utk6+f1/upJClse2RPQy1zNuWz6v/V/pebtRtT
	KEj09P5EcoRX2P9Yaj88VUG1Z9UoddM5d8PI4itgUlIXrWhAyyYTan4V2gDMGzXVFCI/uHm61KO
	ABypiT81AOFffC6M5M7OKm0TC64aRjgmD+52rV/CynjI0i8TXG3+hUo3CpfhU7tEe+1U0QAP0+E
	bTIrA/bhP5A9OLEkzrTkeDUrorO9cUBZxbsbDNQDp7pVwejwYXhA9Oar7l81hs+toYDT9GtiOZu
	WW8V+uKiVv3TY4o/yfB7u0953R+tDJd/a91K52EW65CFoAiSFlIWL7ETUz0kpsUiJq1l5LJF0Gb
	vbPoMr+xH+B+BlN7SspaSV3VvrxeCWfp2gsxGDTuonoSeQo9wGjcjGApyAEfMhDq6xfe4hKCExB
	1aK6SEAM9p/yuH8AxAlCMy7NvIVXFkk4N3ANRHPJ4k0q5BLpPok/wBTbMHLiMzpZ3cIejKSKy7z
	bnWWOUgGdG8PNWMdol5dz3j
X-Received: by 2002:a05:6871:b21:b0:48f:e0f6:c46a with SMTP id 586e51a60fabf-4a2a8a64998mr18198588fac.56.1792085224585;
        Thu, 15 Oct 2026 10:27:04 -0700 (PDT)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4a6dfcb1714sm4674103fac.16.2026.10.15.10.27.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 10:27:04 -0700 (PDT)
Date: Thu, 15 Oct 2026 12:27:00 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
	Wolfgang Kritzinger <wkritzinger@atlassian.com>, Tyrie Vella <tyrielv@gmail.com>
Subject: Re: [PATCH v3 0/6] odb/files: cleanups and improvements for
 alternates
Message-ID: <atEMt5wgfblCiv5a@denethor>
References: <20261013-pks-odb-files-alternates-cleanups-v1-0-b7030ff2b26f@pks.im>
 <20261015-pks-odb-files-alternates-cleanups-v3-0-bfc62fd780eb@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261015-pks-odb-files-alternates-cleanups-v3-0-bfc62fd780eb@pks.im>

On 26/10/15 07:27AM, Patrick Steinhardt wrote:
> Changes in v3:
>   - Add a regression test, supplied by Tyrie.
>   - Link to v2: https://patch.msgid.link/20261014-pks-odb-files-alternates-cleanups-v2-0-fed9b2caa3be@pks.im

Thanks. This version of the series looks ready to me.

-Justin
