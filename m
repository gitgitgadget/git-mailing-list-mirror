Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D4E214A4D4
	for <git@vger.kernel.org>; Wed, 28 Aug 2024 22:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724883558; cv=none; b=mlzcdAz/dhRujBvk6A7lIeR2pgI4+S85AdvymDt5DOZx+PG1yNCoZE8xDYZ/oyWQcGoU/9MyrOmffXlwbaMLNAgIUEBgiZi2jEt3OfDmQbKqnm7vIoB/61iPdY1VtpUqBqnh9/oXikAsokuPLEP6dqX6RG116ix++mNYvGF6F0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724883558; c=relaxed/simple;
	bh=SJ+p/jAdDESkMD8gKaEVUJ+jr+j8sP67ZafOC5wKap4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ApOaJ2IXdC9rWKiCi0c478D0k/N9JQ6Og4CBK2nDETO6S3aJUbEy898ZazX1xS5RnwOvhcUZ7sNrUtO+5YRWWDQz4Gw1S26zjZBG24p++TjK7LzhMF8R09BotFNW1DAzdsG9TrqMvfgxFD0xtXrPPFIeQN2KQVYVZD5v1mEV/Sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dQ0SoZ0r; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dQ0SoZ0r"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-20260346ca1so72855ad.0
        for <git@vger.kernel.org>; Wed, 28 Aug 2024 15:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724883556; x=1725488356; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dY5ym/fnr0dmqJ3T+XyQXb5YdeSJrsIqr8P4T8WyBLI=;
        b=dQ0SoZ0rKMXK33uFW6zT6Jnn1gR0n0AZLsbIZ9Eib2Yyudg5J6Xll3KtB5HnOsyV5P
         eHZVmQsECOwP+QLAOu4y56wjaNXCiKhjopWIHQ6q+zNgzCAaPMb8BK45spdiHSRh0sd2
         rbrAeoa0mtHdhskcP46g+Go3EW0Co5X2dDLCIgTx6z7LXTjXVP9dBbfdpkDFEKmSO4u9
         XWrXsypUvEsCUc+bNbSG+DUorRiPCmkSeXLW/BT0Lkimyv91itpxA7xwlsPLMU8AsKcC
         Mk9OyHebVSb80zUZOXY6lYQOx41jQ5i/DaAkw7a23j772dvUdrnAXcq6izr9xsJe7F7N
         PBUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724883556; x=1725488356;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dY5ym/fnr0dmqJ3T+XyQXb5YdeSJrsIqr8P4T8WyBLI=;
        b=SuOBN0aZQ/s0a6MSppr24iBTAMSQg3MuXBFMmyp8MBWYCxU6fu+yYESrLBhQspNSZ+
         YLlInofs++g6RzGFbAp1natC6ADPKGHb8x41i7356v02W3Tw1zSWRSdvo5JdZcujeuLd
         U/TlYfjySuZRSQJCw1azGfia9ukIeYfwfbCAZtLC6x5sC90KVGcliq5ZrBfOAisgXl3C
         ogxnYSzO1fBGqET8zieJwjEXL6ennJSAWoMDWAjnxmn4d8r3oXfvhWoh2PLvMNeRXZa7
         DEbo5bQy+bX4q2riB6FzJWMJI9kfg8cBkYyEangcYUb/A9vql62iygMEvR2DlOs7eMvg
         hW3A==
X-Forwarded-Encrypted: i=1; AJvYcCXQClSjdBfVdhuR4RJj4CMZ4+aaw9pkCyxeZdTizOH3HZOdQKemknZYrwIgc5JzGSuYHzA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjNdvp8mZAptUjBmKqprLVHDmOkJA+L//R9Mm8iqbg/80sfzCT
	JQVKEVpAqSC+k8EpWIUDNNu3f45DnmO2GzQhlb6LXytIzeY9JXnnprWAndzIOb7TqCjELR2ef0E
	elQ==
X-Google-Smtp-Source: AGHT+IHsgb06UxlpsGK1E2mlnxzW18WeuQL0BlvcvsdOwGe0ihDZP3OTJPk4CgeMMyfnrp9VkrQIxg==
X-Received: by 2002:a17:902:e74e:b0:200:ac2c:6794 with SMTP id d9443c01a7336-2050d163951mr1084415ad.12.1724883555761;
        Wed, 28 Aug 2024 15:19:15 -0700 (PDT)
Received: from google.com ([2620:15c:2d3:204:70f6:9fb5:f5d4:421a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2038557f093sm103269125ad.63.2024.08.28.15.19.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 15:19:15 -0700 (PDT)
Date: Wed, 28 Aug 2024 15:19:10 -0700
From: Josh Steadmon <steadmon@google.com>
To: Calvin Wan <calvinwan@google.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Subject: Re: [PATCH 15/22] negotiator/skipping: fix leaking commit entries
Message-ID: <fazvh3gejzofti6ii4x2fkoh66hni6lcc6axc7w4tspte4lioy@hgnvhue2pm26>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>, 
	Calvin Wan <calvinwan@google.com>, Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
References: <920db3a2912c609d4ac1fca2fc6b137513c8eceb.1724656120.git.ps@pks.im>
 <20240828202902.4156688-1-calvinwan@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240828202902.4156688-1-calvinwan@google.com>

On 2024.08.28 20:29, Calvin Wan wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> > When releasing the skipping negotiator we free its priority queue, but
> > not the contained entries. Fix this to plug a memory leak.
> > 
> > Signed-off-by: Patrick Steinhardt <ps@pks.im>
> > ---
> >  negotiator/skipping.c                | 7 +++++--
> >  t/t5552-skipping-fetch-negotiator.sh | 2 ++
> >  2 files changed, 7 insertions(+), 2 deletions(-)
> > 
> > diff --git a/negotiator/skipping.c b/negotiator/skipping.c
> > index f65d47858b4..b738fe4faef 100644
> > --- a/negotiator/skipping.c
> > +++ b/negotiator/skipping.c
> > @@ -247,8 +247,11 @@ static int ack(struct fetch_negotiator *n, struct commit *c)
> >  
> >  static void release(struct fetch_negotiator *n)
> >  {
> > -	clear_prio_queue(&((struct data *)n->data)->rev_list);
> > -	FREE_AND_NULL(n->data);
> > +	struct data *data = n->data;
> > +	for (int i = 0; i < data->rev_list.nr; i++)
> > +		free(data->rev_list.array[i].data);
> > +	clear_prio_queue(&data->rev_list);
> > +	FREE_AND_NULL(data);
> >  }
> >  
> 
> It seems unintuitive that clear_prio_queue() doesn't also free the data
> underneath and that a caller would have to know to free that as well to
> avoid leaking memory. Would it make more sense to add this change to
> clear_prio_queue() instead? Patch 14 has that pattern already.

I'm assuming the reasoning is that clear_prio_queue() can't know if its
items need more complicated cleanup of their own, so if the caller
(potentially) needs to clean up items individually anyway, the caller
can also free them at the same time?

> Thanks again for the cleanups -- I'm tempted to take a stab at some of
> the other memory leaks you mentioned during our biweekly hackathon. All
> of the other patches look reasonable to me.

The series also looks good to me, thanks!

Reviewed-by: Josh Steadmon <steadmon@google.com>
