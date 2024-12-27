Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67BE13F9C5
	for <git@vger.kernel.org>; Fri, 27 Dec 2024 13:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735307877; cv=none; b=RTyGd89UC8QvjZJEZLYFHaRM6/uhCkaaZoTAvpRdaob0TxpB0rIVCxKpwcrm390eRWiqB7FGTk+ZzG9KLdk+dJIzyZ4eiwWJj40n6Tnv5UWxHtRd5Om2F/ZnEa1wZ2teefMK8mh0sZIPb90bKdfH727XX0vYZaXZaTxlXQvr5O4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735307877; c=relaxed/simple;
	bh=42SkQvWJawy4D8al+wNbvqiXQtJEIBhS0q/3XtVxkvU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QNN3IRorxOIM8zbSr/+ZfINcut43y+iGxJiBLJ2RNuJ9U8Qlpkkg13jHyTXxnq3R3k51K8AQ4L955u6lgew+kSrOx/jgAw1ArE95mvze8b7fqb1Z5JsslBQ29xnPkRUqTUjlni1qBToB5sZdEYT8Z5fQj1/5tSavcwHMPGImUp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=luOc9q32; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="luOc9q32"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2f4448bf96fso6916973a91.0
        for <git@vger.kernel.org>; Fri, 27 Dec 2024 05:57:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735307875; x=1735912675; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ow+d/fCnNb8m4tdGUR6laUUkWOwh1KMMSQCTSQI8Sgw=;
        b=luOc9q32jzyIWbwTRaHgdUHrPkpWafoSj0wJ429Kr7g85C4Jk5Pi8yO3pazkTIQlh7
         pD9+XgMhiCDGUrX5STZEFQzY5nOikJnrgZmnGgv+NKKkGqz6nSnxY69PYveqT4QsZCN0
         nNuKnNRByySZP+OINYNGhvS+J4CYbxajaMmWcJqIGspKZmSWi0bz9zv+ealnaia4QX5V
         cchPM8Qqg7i7Uwn43Bu58ggCBIA/tSCCeJa5KoeM7ZSwS09bq63gGnUQq68wrAjjDKs0
         LwYPEXRC3r0+2HLq9fPDSuQFJcXMnSpvm3DhirCRuuIiUNEsIvYsUS9yVtNqJyRfEJlp
         irnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735307875; x=1735912675;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ow+d/fCnNb8m4tdGUR6laUUkWOwh1KMMSQCTSQI8Sgw=;
        b=f/lGOoON+v6DlNuNeJ0pZoi00vu2T+ZFH+j1SwbnaoM3A2rmxwKp9m7ic3M/8NEn6p
         N9wWt+meMmvLDzmz774JBb59jTifgneQ6GQ09Xl5bP+r0YA5iQaAshV633D8gvcb50qK
         ovpbptsn48DnUaZDZ9M4iNfcwm2cwJggWxzWPOJQnF9aeQzMf0d9rbR/FusxzkHGvyPX
         +4kfPo2BU3DAOQBK6eqbxGYOWp+ELrcDRTlTqy8DSFGnfXaGRlBWCDTnK0etwZu3zeLV
         vRqSoUE9v/rK33AzFrVAhIH9RZQunBC88sVdRYGcr3G+1Ann57yHa8rJfcIIYP2/6p+8
         SO1g==
X-Gm-Message-State: AOJu0Yyc6CaOOb2MR+LxiPbW0HpjbVkbGekuzyzOFeTf9++kpsvcYan/
	5+B04FKvqhZW2dd06RPbcCfSri3UmM/eWODZQFqUYsBm7h05MGCFytt3Yw==
X-Gm-Gg: ASbGncsoLn74iycMO4R3MdjQUYbn+hz5VKhhVmchcar6qs0sW9OA8E91tn3HBFaYlxc
	iMP0KuofCaJ/aYdj3rYk9LpD3kYiLjGnHbe7/MCDS5CU71HqwxKGloGe9YaHVMEJQVc/C2PnCmG
	aoMMsFIF5USjynaK8MdmcElITecxO6ykc3Pa1561vQ27GUfmDi8ODu9AMlNf+wg1qFDe7Kgl4RK
	yMXNg1Y+meP3YaL88gXiNoV50xttz6N9gkjjkqvbavrKRt8DW6v
X-Google-Smtp-Source: AGHT+IGDoQpVIOS8hdBJPq7nokVJRY5nS4Ougp4j4wGiaCI86faae4Gt1xCqr8p3OVsH2F0Duz0vwA==
X-Received: by 2002:a17:90a:d004:b0:2ea:5dea:eb0a with SMTP id 98e67ed59e1d1-2f452dea366mr38845817a91.4.1735307874830;
        Fri, 27 Dec 2024 05:57:54 -0800 (PST)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f2ed52cf9esm19440429a91.8.2024.12.27.05.57.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Dec 2024 05:57:54 -0800 (PST)
Date: Fri, 27 Dec 2024 21:58:45 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/1] ref: add object check for regular ref
Message-ID: <Z26ylU3umgLiwuZT@ArchLinux>
References: <Z26uXy31q83dyxvD@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z26uXy31q83dyxvD@ArchLinux>

On Fri, Dec 27, 2024 at 09:40:47PM +0800, shejialuo wrote:
> Hi All:
> 
> When I implement the code for packed ref content checks, I somehow
> notice that I ignore checks for the object. In the first glance, I think
> I could make this patch in the first of my packed ref content check
> series. However, this is not a good idea which may cause the reviewers
> more overhead.
> 
> And this patch aims at checking whether the object exists and whether
> the type of the object is correct.
> 
> Thanks,
> Jialuo
> 
> shejialuo (1):
>   ref: add object check for regular ref
> 
>  refs/files-backend.c     | 50 ++++++++++++++++++++++++++++--------
>  t/t0602-reffiles-fsck.sh | 55 ++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 95 insertions(+), 10 deletions(-)
> 
> -- 
> 2.47.1
> 

Forget to tell Junio, this patch is based on the latest master branch.
I don't use the "sj/refs-content-check" due to there are some conflicts
when using "is_promisor_object" in the latest master branch.
