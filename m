Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E85E1ABEA7
	for <git@vger.kernel.org>; Mon, 14 Oct 2024 20:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728936816; cv=none; b=Yte+OpvzeFgLbw4pYbVjk9XTn/4/SRVOaW07bAHBP5gDsY912ROS3BjGe02D75x2bsBXgCKYmZ5uxgAv1iIU/QoNvoGfGDl7/rPizt6UrBSeJraX/CZT6yG0cltDl48XQVZVruTV2PCdSj/V9o2euJaRwwAVwpJlqKwzm3UA9f0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728936816; c=relaxed/simple;
	bh=PP0IcyPt9Ib/hS6Ic81IsEVg21VFmOg98bIiIa6EJiY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MVCLKjy53993VuFjtfxNKddhFtpj0LagNnjPdB1DpMYmWYpugh/6atGapLkqdKQ28HG6QLp+jq+lxF9MCZ6McMFQ4HESsZmcWNXnq8agk2JUf3Oms+Zt51k5goI9F3s/JotuQ1FSC9DtdE1Dh4jsHdVxh/XnM8oEO+/AIFVHrBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CweCr3RF; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CweCr3RF"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-20ca03687fdso345115ad.0
        for <git@vger.kernel.org>; Mon, 14 Oct 2024 13:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728936814; x=1729541614; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g3g6m+SEBXmhzzGQJs8byyCt1hRt9E656U1LT6KYKCc=;
        b=CweCr3RFFLn3pN05M767lruxO8Lv8XnYfS8lp7kwlimAWKA8rTR0+pvAKryfiDiawk
         JFDOYlFqh7RIsnGgjv32+x+YDGX8lY9PZoUZP9dJF5ZZ15uMrEn7jV62QOz00opuGfSI
         PMmiT+oh4sdimL2T+QmxO26iQb187bXgXALZkto3rwePDq1yDu57/E1mG8I0Kfq6mEm2
         zJJUyqOIazUGyhKu2CW7LtknxtHDLAykBRqxiZpFTw/DSDPWbi5shhvv0Pe0Z/jBtg0w
         0gbFGs+ziA7WsLdr6x3mYANprhzcdUMgEy2kg49UvSml8eD+0ke+BcZZNBu8MFPqtmHZ
         ClDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728936814; x=1729541614;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g3g6m+SEBXmhzzGQJs8byyCt1hRt9E656U1LT6KYKCc=;
        b=dR8nWifsXjfvjApXcEaAjfc5WwvmaslMnAN5Zr4RQChyJEphae9ZWMSq2di+F2RwkJ
         +mH0IGNlpbc9I8GSYvhojeMtlGY/VkRuxBJxtyJjTYkqvZqc0Wj+ja5+TbrRumsP0MSY
         sOgXt+bTYNMs4ODLjTVQlF+xliv2l4NTxfNb3jfe/K1s/I2b7MvGPsGNtMQaA3pEy/qx
         7GGQihjd7/aVKeVH2udE66XGaeoXZP/Pj4CPMB3G+S89gYEuH3PSUixXIZCMZHnAcfpF
         xZQo/MBE1CXgqpn37umok/8cLZICksNA4cv/OluxvBadSuvrpZxzNz2CSYIWacagvFyZ
         jpRw==
X-Gm-Message-State: AOJu0YwmCXXn+UeQzZD+lwG5nJUuoll5pihBI1id5P81sUFBmlGxadxI
	L7uoHRlrUmg0EsnS6JM/vRs2eWPDsaq6jFdyQIB2j1XcsfcBxHdNoXJhtyOY6g==
X-Google-Smtp-Source: AGHT+IG0F7vnKGsRIN1dDGECrFvrjlp1faQq1toAqzWGoTx9orhRWhQ/hrpdG1VgFVT2hXrpG4M06g==
X-Received: by 2002:a17:903:2442:b0:206:9e8f:7cb with SMTP id d9443c01a7336-20cbce2266emr4360415ad.2.1728936813583;
        Mon, 14 Oct 2024 13:13:33 -0700 (PDT)
Received: from google.com ([2620:15c:2d3:204:2a9b:d27f:d626:2e54])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e2d5df1128sm9536184a91.16.2024.10.14.13.13.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 13:13:32 -0700 (PDT)
Date: Mon, 14 Oct 2024 13:13:26 -0700
From: Josh Steadmon <steadmon@google.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, calvinwan@google.com, spectral@google.com, 
	emilyshaffer@google.com, emrass@google.com, mh@glandium.org, sandals@crustytoothpaste.net, 
	ps@pks.im, sunshine@sunshineco.com, phillip.wood123@gmail.com, 
	allred.sean@gmail.com
Subject: Re: [PATCH v4 5/5] Makefile: add option to build and test libgit-rs
 and libgit-rs-sys
Message-ID: <jpzziq6a2sepvrrpltahlgvx3kibestargeettnty3q7dk6njn@vizhrfj72g7a>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>, 
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org, calvinwan@google.com, spectral@google.com, 
	emilyshaffer@google.com, emrass@google.com, mh@glandium.org, sandals@crustytoothpaste.net, 
	ps@pks.im, sunshine@sunshineco.com, phillip.wood123@gmail.com, 
	allred.sean@gmail.com
References: <cover.1723054623.git.steadmon@google.com>
 <cover.1728429158.git.steadmon@google.com>
 <2ed503216f8e14d7b516c488caf3c76ffcb15697.1728429158.git.steadmon@google.com>
 <xmqq7caixhz0.fsf@gitster.g>
 <yynolodpcv43doqcab4bin7z7gembixqfhvqdzpcoeipnyjwl4@ek3gr4l2ycrr>
 <xmqq7cagok3j.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq7cagok3j.fsf@gitster.g>

On 2024.10.09 17:52, Junio C Hamano wrote:
> Josh Steadmon <steadmon@google.com> writes:
> 
> > Hmm, I think this may be an unfortunate interaction between Git's `make
> > all`, followed by libgit-sys's `build.rs` calling make again (with
> > different CFLAGS, specifically '-fvisibility=hidden') to build
> > libgitpub.a. So then the second `make all` has to rebuild everything due
> > to changing the CFLAGS back, and then libgit-sys has to rebuild
> > libgitpub.a once again.
> 
> Ah, OK, if we need to compile in two different ways, then it is a
> matter of giving a dedicated *.o build directory to each, and until
> that happens, the object files for Git proper and libgit-sys would
> try to stomp on each other.
> 
> I thought Patrick's build procedure update has out-of-tree build as
> one of its goals, in which case we may be able to piggy-back on the
> effort once it starts to stabilize.
> 
> Thanks.

Actually, including '-fvisibility=hidden' by default doesn't break the
main build, so I think we can just add this to BASIC_CFLAGS if
INCLUDE_LIBGIT_RS is set. I'll do that (and add documentation as
requested) and restore this patch in V5.
