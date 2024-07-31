Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E11038F83
	for <git@vger.kernel.org>; Wed, 31 Jul 2024 18:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722450443; cv=none; b=gFq/TphXflUxe21l4lI3gcc0+ZHNIZ7lAy9YVa1ZUq6Z1IyqgyDUZ9zDpqgWwkJr6912JDY/tnu+dPp1pDCqV0f3wUxSMWRhZ5oqD4uuBsJIK+I206BAehRbSkfVIpEOW6onAznlAKCrHt/AxAxQ+8eXHxNZFnojm/yOQk9ptPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722450443; c=relaxed/simple;
	bh=obQ2BcNZorEdijDbNFSR1bCChITT5z/HD4FfEnSkCWI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lN1bzoREwMSkU1W88kj0XQpPi0WXwOEQ1Iav2CQu/5DuWhmi7uysosWo4f6pg4pP9JgOFUYweN7mDLFa7s1v+LUO0K91RnBRv0BXexP9OuFjPSHGLF8xeAZbKds1pFXfqLAkoWRIF1bOZSJHH82JcJGLYHetsObFAz4bUig4RwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oAeAuOjm; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oAeAuOjm"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1fc611a0f8cso43534505ad.2
        for <git@vger.kernel.org>; Wed, 31 Jul 2024 11:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722450441; x=1723055241; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=obQ2BcNZorEdijDbNFSR1bCChITT5z/HD4FfEnSkCWI=;
        b=oAeAuOjm80CJ67ieChg+2mzTpIXCDXLa8SC2J9uYvqdkgDMLw5TKvh7bCoXQlhRfWz
         38SMMQXQDC5zTTHWcpUBeJeYzsUsTSC3+C0IJxXDfrfWSJuX+r96LI/U70ibaB6Pcg2j
         pQvnLmuYPxbvxS9w461luxlMmXeIPRRD/CU/Kwuz03lDTyv/t/m+DiwsaTOvTmesfQg3
         csw5UdtiXzIPIapMh8Doij9pyL3+O5keV/2MQLOXpYIl0yFAz8MMGaQ+v2Htn59823ti
         YKnjcqpW9WrCGqszbo3o9jVzEAwaMXt5azW1odjkrBauLVOqw71rHxUq6WB/gnEWpm+d
         vpuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722450441; x=1723055241;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=obQ2BcNZorEdijDbNFSR1bCChITT5z/HD4FfEnSkCWI=;
        b=lPSGtUpfd9osIeNwP/67Am/SvEMNptdfQOkng9YGK1uiazwQgDNsWeWzC1KDNbsOj0
         71oHtJFEIDkLxapPtkpSlMV4O6w47vzSshaa7B3T1t/m1f7DlgAakLzycO77/B/vk0pc
         JryHDrymL+g2u6BlzUoUpN5ccjlYFRmm++y92JeyrwQ1udJytWNuoQlf4m9tiA/NiJxB
         bhKFot6i0wkQ9A2pJBqx0yGlfHgs+1IrcgAyJZ85PbJFI/C7x9FYPXcQm/JyQwg09wFu
         xpOZL+SnXc3W3/4nNJzAwnw4RDS1+pnyr919pcMIVDDmvCe4coxAjOZM0Kz2HJMgNeh5
         vyvA==
X-Gm-Message-State: AOJu0YzI+dKS+B0wSXzq9M3nurSopdjUWPdn+1VIbtuebYww4S42mi0o
	4zyvyuunpAaRiKPLMWRtCvsjAhVgzPFYHIUWF0jq4VCu7hPWEHSrBPadVxguZg==
X-Google-Smtp-Source: AGHT+IFsvLdfUp+IXP65kKPSpbE/av7t34SgoibfVAiY3pMfolfG4S0xkh3Oeq5zrr36HpMsLQh4pg==
X-Received: by 2002:a17:902:e802:b0:1fd:aac9:a72e with SMTP id d9443c01a7336-1ff4d20dfccmr2151095ad.43.1722450441118;
        Wed, 31 Jul 2024 11:27:21 -0700 (PDT)
Received: from google.com ([2620:15c:2d3:204:ec46:755c:60f:a94d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7ee8177sm123134355ad.124.2024.07.31.11.27.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 11:27:20 -0700 (PDT)
Date: Wed, 31 Jul 2024 11:27:13 -0700
From: Josh Steadmon <steadmon@google.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>, 
	Junio C Hamano <gitster@pobox.com>, Kyle Lippincott <spectral@google.com>, 
	Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [RFC PATCH 1/3] t: import the clar unit testing framework
Message-ID: <463oz7j4btei57brq42zlnsydguu74n2n22rhdq7iwjk4y2bei@6r32nghurrmr>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>, 
	Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org, =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>, 
	Junio C Hamano <gitster@pobox.com>, Kyle Lippincott <spectral@google.com>, 
	Phillip Wood <phillip.wood@dunelm.org.uk>
References: <cover.1722415748.git.ps@pks.im>
 <b3db953e88ece99b441993c9248223cc0ecc6be8.1722415748.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b3db953e88ece99b441993c9248223cc0ecc6be8.1722415748.git.ps@pks.im>

On 2024.07.31 11:04, Patrick Steinhardt wrote:
> Import the clar unit testing framework at commit faa8419 (Merge pull
> request #93 from clar-test/ethomson/fixtures, 2023-12-14). The framework
> will be wired up in subsequent commits.

Rather than forking our own copy of clar, could we just add it as a
submodule instead?
