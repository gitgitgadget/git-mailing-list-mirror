Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DBE01D2785
	for <git@vger.kernel.org>; Mon,  7 Oct 2024 12:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728303543; cv=none; b=og3KbrxXhcxvV75uRvfDyPfNJhmp5xR7emaCvstwvUHmVZ+A8JdYjlJTUg20EnAm/9a8wkAMwQgjJ1mXmAlCzAVGCLA3q/M0rLsddObBJbEUyCyKUey4Ikn0ZyiFCealWO9tG6URdIl0W6xCc6jbbkMUTQQnd4Ox2wZ/DqbZ4AM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728303543; c=relaxed/simple;
	bh=7EF2EW2U5BXMOKFV49S0TolXil39NgSN5Mf0ZmB+Rp4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uUbcMzDEBKVYGb8TdnPH7wNeYOw9WX2OvRwQa+VC7jLk/FZOS3+0nxuHbdwnHZakfvGLhZQTlMcr4IpdKo1Y22oK6UbqchmChoh8HU/7fe5fDfg9myMhW0s+/82SKR+xKPozC5EZ0id3sUSjhFNbKx6kPkKAVtgT95bHMluQYrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SX3ZEbm8; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SX3ZEbm8"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-20b0b2528d8so49486275ad.2
        for <git@vger.kernel.org>; Mon, 07 Oct 2024 05:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728303541; x=1728908341; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=r5Fyrs33N/2+FRzjZorDuhanvAFkzjlCQnZ/b6oqFy0=;
        b=SX3ZEbm82FF8JQ3Iy+Ub/4yS9u0LtzUrTChNDLAZrJa8Z7VGJCq/kSCZGokwojAOBL
         Jv150q0237sgddyM6ClM9vW8Ri9OZ4C2MowHZzjNF4wdBVNa10bkzu+b+7vxk4H8oyUv
         LTPo19rNHsP4AJTNysj8L1pHDx+gnn6S0UPERpjNGWgYPb2pVcEDwu9A2JmRSz38LJZ1
         2XYI2x5ZoEDiHIDOdpLk22MJRcDjYP941wOEkBxYU9NhVNtyVJAtZhc30Ydo9/SF6ZyR
         yomRrhu/uJwc1Ip9y7Lmq3BdTLyE0wEe8Ip2borAjlLvXGkbuNAjf0f0eGEHBWVwtCa8
         +dnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728303541; x=1728908341;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r5Fyrs33N/2+FRzjZorDuhanvAFkzjlCQnZ/b6oqFy0=;
        b=NXZPennb2U8OSyougbbEfESo/Gkcwre2LI/bp+epRo/8aTV8zUkLpoewz10Xh9gNZB
         1x5QvB803b0fcDBlAEvLzYg+jKg+xLKjLOjt/7AJRioIJlUHzHPGlkBKKQZ1b4FWnypo
         YNd3dk83wJg1ix62mdMw80KjCDeYgQ3z4ko8AEyuyJvsc9jGt043NixInN2FVGBF6eYe
         m/w7KEFcFINQkWy8YIKuEob/ZMbSVf4cV3Kp3ihL2lOOjlU2qLTv/50wBmvXUcPB2OnU
         7ltBUhshKmPlHJLiirsMQDuQBKzB2ZBrF7lmRfS4WLGG8eeTZmBGHruYqJ6ZIDT/F/Ck
         K0QA==
X-Gm-Message-State: AOJu0Ywbpt+W/xoT4crtzmFGBdsyg2/BWIqG5iRVUf/lCtsMJhMXdj8a
	4yHPLw0IajagwNRyMPOny3MtMQl1hb+xzuxb9/UMg3ylsn+5MKfy
X-Google-Smtp-Source: AGHT+IHMKcvK1rsaHvRJftFb25/2QB+dq49OIxuDYgcWUl0OnH59DUybhw2F774I+kjthYIo/Ov7bA==
X-Received: by 2002:a17:902:eccd:b0:20b:6f1b:c5a5 with SMTP id d9443c01a7336-20bfdf6ae8emr171259195ad.10.1728303541554;
        Mon, 07 Oct 2024 05:19:01 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c138afe40sm38442715ad.39.2024.10.07.05.19.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 05:19:01 -0700 (PDT)
Date: Mon, 7 Oct 2024 20:19:08 +0800
From: shejialuo <shejialuo@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 4/9] ref: add more strict checks for regular refs
Message-ID: <ZwPRvENH0TA5YX6J@ArchLinux>
References: <Zvj-DgHqtC30KjJe@ArchLinux>
 <Zvj-sBX-0AFsuFDC@ArchLinux>
 <ZwOGnQSqmwALK-9z@pks.im>
 <ZwOfYGi21oa302sS@ArchLinux>
 <ZwOo9dQSr8Xu-PBb@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZwOo9dQSr8Xu-PBb@pks.im>

On Mon, Oct 07, 2024 at 11:25:17AM +0200, Patrick Steinhardt wrote:

[snip]

> > 
> > Actually, in the previous versions, I have mapped one message id to one
> > error case. But, in the v4, Junio asked a question
> > 
> >   Not limited to this patch, but isn't fsck_report_ref() misdesigned,
> >   or is it just they are used poorly in these patches?  In these two
> >   callsites, the message string parameter does not give any more
> >   information than what the FSCK_MSG_* enum gives.
> > 
> >   That is what I meant by "misdesigned"---if one message enum always
> >   corresponds to one human-readable message, there is not much point
> >   in forcing callers to supply both, is there?
> > 
> > In my opinion, we should have only one case here for trailing garbage
> > and not end with a newline. When writing the code, I chose the name
> > "unofficialFormattedRef" for the following reason:
> > 
> >   1. If we use two message ids here, for every message id, we need write
> >   to info the user "please report this to git mailing list".
> > 
> >   2. If we decide to make this as an error. We could just classify them
> >   into "badRefContent" message category.
> > 
> >   3. The semantic is correct here, they are truly curious formatted
> >   refs, and eventually we will give the info to the user what is
> >   curious.
> > 
> > So, I think we should not always map one message to one error case.
> 
> From my point of view the error codes should be the single source of
> truth, as this is what a user can use to disable specific checks. So if
> one code maps to multiple messages they have the problem that they can
> only disable all of those messages.
> 

Thanks for your remind here. I totally forgot this. I have changed my
mind now, we should use one to one mapping here. As you said, if we do
not, we will give the user the bad experience.

> I don't disagree with what Junio is saying. It is somewhat duplicate
> that the user has to pass both a code and a message in the current
> form-- it should be sufficient for them to pass the code, and the
> message can then e.g. be extracted from a central array that maps codes
> to messages.
> 
> But you can also make the reverse argument: messages can be dynamic, so
> that the caller may include additional details around why specfically
> the check failed. The code and message would still be 1:1, but we may
> include additional details like that to guide the user.
> 

Yes, I will refactor the "fsck_report" to allow the user pass the "NULL"
message if the fsck message id is clear enough to indicate the error
case.

So, more things to do here.

> Patrick

Thanks,
Jialuo
