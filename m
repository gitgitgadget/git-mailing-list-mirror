Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73F121993B0
	for <git@vger.kernel.org>; Thu, 25 Jul 2024 12:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721909796; cv=none; b=iVWOOASYpvlPN5x0UZFfcN2FOPNw0FM4PJ2iGW81SBJypnPt81wPlNZr2sdQ/9pwRsTIVpIZZQCEypTdwxeoZWiDL3ISXEgknfARy/+KtIc4eT7zZfWGGSAMyPEs5FnkO7jtTdwp+UNDxFR5CWh44AMsE8gLeINP1yusNGNJleI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721909796; c=relaxed/simple;
	bh=W0Gt0NQSpG+X4yY1WQ7JgUK36HcAPkhBRwA8x3Ye2os=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EGEYqwtuEvAVNJMIiFNT6a0yM/ejnWi4WaaXnlS3SIYuveQmj670AKHjV2Hmx2cLzUtGn8h4B6gg/53cYjU1nO0OFlImLmMpnKfKoIkbIB48PN1aMRQdxiH1OhLTLV1ojNbK4tEe+93vyeLMevVHXIGw3dwshKRPyBc0jswJfJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YgKqTxMX; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YgKqTxMX"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4266b1f1b21so6489415e9.1
        for <git@vger.kernel.org>; Thu, 25 Jul 2024 05:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721909793; x=1722514593; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RNFhGrtR8+vFq6a9qFqZCJy++uPwsZdfraecqIt7TWU=;
        b=YgKqTxMXvFmLIgtQSq92cdyWFP2nAOrfXf2ypOl+UDQ3EG710kg3NSd4gLucmIP/FW
         FqWrdKz59H28k7LiraYrRHezhnuKHMINt80YEyJYZSzIrTneocfJiUu0PM3DNkyeN/Jx
         HNxNPjg6Au6dg98cjH2jJw+LrQXIS676PQCsMc7UVNcLTkL9CO5opAWvBtL9NTCtB1KH
         mtx1Klrd6Qx/hfRJdcal9oujG+8Pw10emegOvDkxiOQq79M+k4yhPLCwWnyFlZ0RwJPR
         PgIO9oZaOo2YHfhBuIFuzbvgzzEm1Oaf17X+PME7G0E+qbBJJh4Xt7b6rXHU3dPx9vhr
         U2pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721909793; x=1722514593;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RNFhGrtR8+vFq6a9qFqZCJy++uPwsZdfraecqIt7TWU=;
        b=i//QW+OntO4e6WYkRgFAofQBtwjOhYxVM0YPoNObAZD1Y8ijiL2baadDpKk7XJMJKZ
         6oU2qG7BvlDsqDDYzF6MY5OP9gDmygpV+5Lkvbo1ft/HYPgUbCj5NjxPI5TnT7MbnUg2
         pDswat3TCAizZ0RTyQwmDwNx5sZLYnuRCfLp2sJsgvfVrCJ0C3DjFD8Psl5HCIky79QS
         psJ9/kpL4bJZGR1xgUu+Xf1RSLxT4/HEtcrMyXnFNkjJHB2g9H8j4rfBb+ytO/+aYqCi
         kZzhahC2DV6/04X/3XVHvhaDUOiuXgq0N5jHz5IVBf/OlG6OixZ/CeSQWI+NGgc7MPu3
         xeDQ==
X-Gm-Message-State: AOJu0YwOEX+1xrSM1KuQOXsYDt1XqM+z3ayXww3qZCS0YrEXkQ2lG/e5
	qiQTVoAJ0h9/w3yY/qVYHd3AIPbVeNu2OElPMYbakwep8kj05wiWxRMLrA==
X-Google-Smtp-Source: AGHT+IHRJRoZ6CUOaYVYVDDlucP5nQYPJVztz++IQMKt5Qg8OugwlFYU/GCL+gL3d5gChc0LSXrAtw==
X-Received: by 2002:a7b:c31a:0:b0:426:6089:e503 with SMTP id 5b1f17b1804b1-42806b8f93bmr11180145e9.16.1721909792363;
        Thu, 25 Jul 2024 05:16:32 -0700 (PDT)
Received: from gmail.com (155.red-88-14-47.dynamicip.rima-tde.net. [88.14.47.155])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42808473208sm16802035e9.42.2024.07.25.05.16.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jul 2024 05:16:31 -0700 (PDT)
Message-ID: <88286ad9-eab7-4461-a407-898737faa6a1@gmail.com>
Date: Thu, 25 Jul 2024 14:16:31 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] add-p P fixups
To: phillip.wood@dunelm.org.uk
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
References: <7c9ec43d-f52f-49b7-b1f3-fe3c85554006@gmail.com>
 <62af789f-ca19-4f11-9339-a97400f7e70c@gmail.com>
 <2333cb14-f020-451c-ad14-3f30edd152ec@gmail.com>
 <5735bee3-0532-4894-b717-12a0bdcb9e84@gmail.com>
 <a25c37e2-fcfd-4a4c-890b-a85039ccef12@gmail.com>
 <97902c27-63c9-4537-8ebe-853ef0cb1d3b@gmail.com>
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
Content-Language: en-US
In-Reply-To: <97902c27-63c9-4537-8ebe-853ef0cb1d3b@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Thu, Jul 25, 2024 at 10:45:04AM +0100, Phillip Wood wrote:
> Hi Rubén
> 
> On 24/07/2024 17:12, Rubén Justo wrote:
> > On Wed, Jul 24, 2024 at 04:21:53PM +0100, phillip.wood123@gmail.com wrote:
> > 
> > That was my initial thought [*1*] when the problem with "dash
> > 0.5.10.2-6" appeared.
> > 
> > Junio proposed [*2*] documenting the changes to address it as a separate
> > patch, and I think it makes sense and it is valuable to capture the
> > situation this way in the history.
> 
> We normally avoid merging commits that are known to break our ci.

Fair point.  I'll reroll and let Junio decide, or ignore ;).

> We can add
> a comment about the dash problem to the commit message when this fixup is
> squashed. Also the problem is now documented in
> Documentation/CodingGuidelines which is more likely to be read by other
> contributors.
> 
> > Regarding the bisectability, I don't understand what stops from being
> > bisectable.  Except in a scenario with a shell like "dash 0.5.10.2-6"
> > there won't be any problem.
> 
> But we know that shell is in use in a popular Linux distribution so it is a
> problem for those users.

It's not an excuse; I just wanted to point out that Ubuntu 20.04 was
updated with a version of "dash" that doesn't have the issue we're
seeing in our CI for quite some time now.  The version I mentioned in
message [1/2] of this thread: dash 0.5.12-9.  

> 
> Best Wishes
> 
> Phillip
> 
> > And in one with it, which should be
> > uncommon, the situation is well explained.
> > 
> > So, I dunno.
> > 
> >     1.- 2b57479c-29c8-4a6e-b7b0-1309395cfbd9@gmail.com
> > 
> >     2.- xmqq7cdd9l0m.fsf@gitster.g

Thank you for trying to make Git and its history better.
