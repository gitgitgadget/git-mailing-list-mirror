Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFE985A0F8
	for <git@vger.kernel.org>; Wed, 15 May 2024 10:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715767505; cv=none; b=TLhLGg+PMzDJDKAmVv2EIwu17HPqgZEsnoiXE4QDPeFwLko5iA+hNLpciAcyR+WEHE0BMC6swGU8JfNhyFCLdXGeKX4DUROrII1Rx6PWfExDx/1aJgDwE4slPZqhlZQhiCsq80/WH3Js620MVFnIBu32PMb0GCY488zjJ9iI2yM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715767505; c=relaxed/simple;
	bh=bfmAtPfnWuOxdUU/RAGlvhb3F3t+3MOjmnzwukLUuRY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jAZ7BePFLEomIm76k08/5vV5jYVN+pAFlWnYvsnEgMCB5LMZp6a3DVJXlPGXqcY8vXbx1XyxO0W/vnBx6wnZO1XJTI+N8116xvFSJM5fz8bUcAoCA3WL2CgyuzWyQ6ALxUZc6aUbohkVzlVdhkFZ2KnXG+NxRp182CUzAwpAxd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EnpZKj2k; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EnpZKj2k"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1ed41eb3382so48162485ad.0
        for <git@vger.kernel.org>; Wed, 15 May 2024 03:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715767503; x=1716372303; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CbYorGS4w2UxdrE84bcv89t1UQTu2l8DGgwTA4FFaxg=;
        b=EnpZKj2kZ/7FVtNyjQAiwL/In5tJ9nNh6wu0aeR0ZMtQsRBlQSPvqWwnLFBwFKLhVf
         7pQoYRbDCplH6Y7iihv2DVC7PWsxLiJSVLcL91Cquk3HNF0oFVHeOref+2R6oTfHFPuv
         fs5B7F4+KdHI2ALK5dZgas75pCjXWxcjNu1QNwaHzRftr+e2adG7q2XQl5NmJdNWss/D
         uE3qZYoKY6HwHDwmd1bBoXr+vnLvkDNxa6bgrWXV8CmcVvIX5CwJIXXyt48WslUOqvGl
         olSQ42skhHi9RawS0qAeQdJhDHiLVuZq8k5N90GK03qSCMXnhJHqWLP45IUv+RStyIzV
         /tuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715767503; x=1716372303;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CbYorGS4w2UxdrE84bcv89t1UQTu2l8DGgwTA4FFaxg=;
        b=hI6MC9iZI3K6yeI+QoVl1cir1SBu0k1iyvKm88CdeyrqcO+l06v2OZ0aXrXbXBX7Q9
         VJu08+UdMQDjZcStHzgmh3Vo10xnwsGiBqfeDVzawzXzcPjwUgmCe/n8YbEboMi2O1iD
         zkWQouvjp+C4O26hEaOOLhSkdbpI2cjqJeDK/ZR4SKluueAkwblq1ikFlYOusi+dDTDt
         b76i2N5fz+ExVVYUT/liFFSG2ltLPNKajsG+6yVbYfybtpUlW+xqw6qfC3no0as7iDZe
         EO7pOvkyOp0VVNZzh9wQbBPvHgyn8Kf4tzV/O/pAvB5NXVp4og/uxk4V5ZRaZbEfyhRx
         C3WA==
X-Forwarded-Encrypted: i=1; AJvYcCUUCVF5zwZUkZwHZFttTKgUqCcpE2Ap11XSW0/bVTVeHdsSHO81Y259djdObHvELLJw5jC0fiE40av5/m+qBco37mIv
X-Gm-Message-State: AOJu0YyEIoGEFtkzU2OmrthBl+jaxQLFZytfjMgO2zTzhUVAK7eOKW4u
	IVB07tTKLRf2/sqehJQ4xKL5TBK9pP48/cIHn2FtgRV6CHNIV0Wh
X-Google-Smtp-Source: AGHT+IE8bRQNgTzbpzfPwoqX8uEje6/guDNy5nTr5BUHTcxkV8T5zuV7JPhs2uxJq6nW6sYwLPJfMQ==
X-Received: by 2002:a17:902:7b82:b0:1dd:e114:121c with SMTP id d9443c01a7336-1ef4404c175mr192283725ad.56.1715767503164;
        Wed, 15 May 2024 03:05:03 -0700 (PDT)
Received: from localhost ([2604:5040:11:69e::e973])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0b9d1a57sm114237275ad.11.2024.05.15.03.05.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 May 2024 03:05:02 -0700 (PDT)
Date: Wed, 15 May 2024 18:04:59 +0800
From: shejialuo <shejialuo@gmail.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: Ghanshyam Thakkar <shyamthakkar001@gmail.com>,
	Chandra Pratap <chandrapratap3519@gmail.com>, git@vger.kernel.org,
	Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [GSoC] Welcoming our 2024 contributors and thanking our
 applicants
Message-ID: <ZkSIywwX20fJo-91@ArchLinux>
References: <406aa31f-4ea0-496c-aeb6-443be86385c0@gmail.com>
 <CAP8UFD0u01mrjRfqrmv=ztv0-ek9yUebZNm-GmQyacLiynFxJg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP8UFD0u01mrjRfqrmv=ztv0-ek9yUebZNm-GmQyacLiynFxJg@mail.gmail.com>

Hi Everyone:

On Wed, May 15, 2024 at 11:19:34AM +0200, Christian Couder wrote:
> Hi Chandra, Ghanshyam and Jialuo,
> 
> On Wed, May 8, 2024 at 6:01 AM Kaartic Sivaraam
> <kaartic.sivaraam@gmail.com> wrote:
> 
> > As you may be aware, the results for GSoC 2024 have been officially
> > announced[1]. We have 3 contributors contributing to Git this year[2].
> 
> Please let us know if you would like a call or some other kind of
> meeting with only your mentors or with the wider Git community. It
> could be on a regular schedule (like every few weeks) or not. It could
> be a special Slack channel with us and perhaps others who would ask us
> to be invited in it. We could also use this thread or other emails
> threads either with or without the mailing list in Cc to discuss
> things if you prefer.
> 

I've had meetings with my mentors Patrick and Karthik this week. We've
set up bi-weekly video meetings for syncing. I think it's good to create
a Slack channel where we could help each other for some general problems
thus improving the productivity and also establishing a good
relationship.

> We are suggesting this because the GSoC docs
> (https://developers.google.com/open-source/gsoc/help/oa-tips) have the
> following:
> 
> "Have a virtual introductory meeting with all of the accepted GSoC
> contributors and mentors in May to help welcome everyone and help them
> feel more like part of the community. This is something GSoC
> contributors appreciate and ask for every year in their feedback, more
> orgs should try this."
> 
> and in an email to mentors and org admins we were also told to "Set up
> an introduction/welcome meeting with all of your GSoC contributors and
> mentors (and other community members when possible)".
> 

I think it's nice to have a virtual introductory meeting with all of the
accepted GSoC contributors and mentors thus we could know each other
more.

> Also please be aware that if we setup something, you might help each
> other on that channel, but you should not really work together on the
> same things as https://google.github.io/gsocguides/mentor/selecting-a-student
> for example says:
> 
> "Don’t select multiple people for the same project idea: If two GSoC
> contributors are working on the exact same project then they are
> competing with each other. Likewise, don’t make one person’s project
> dependent on another person’s project, that essentially makes it a
> team project which is not allowed or in the best interest of the GSoC
> contributors."
> 
> Also feel free to reply to this privately to your mentors if you prefer.
> 
> Best!

Thanks
