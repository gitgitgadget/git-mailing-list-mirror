Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 716AD25E449
	for <git@vger.kernel.org>; Wed,  7 May 2025 12:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746619806; cv=none; b=SFZ1Aw+6r3jKQ3Z+p6vcmeoAo2wfF4f/kZZgC6kYcg27MnrNB6WNLf9RL+zxwCP7uRGjRqpYhNve8V16FxLh5rAC41d57cwSwHhwG9KPq7qOzMo17/2j0w1y24XNv4lv6EIxElLXdTib45ZSC89gStrgV0AYDlj5OK/TLye6GvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746619806; c=relaxed/simple;
	bh=k5YoCbFqw8VEh+yj/PqUnUydkMIbaaAsPwowuavBE0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dYuBN/4fV0RoS++WKkE27gt40Jy7uzvHatOH6avNKvCGtMwKrT1hf+WxE2Vip3fhjLZM1FH3DYv4GOj4efxA2yHYaP59el/ZgKF6BK1viPpd0uF3fSBsn3stQDbOBPnai9tmT9QpySjaOdRjgKhzAC/TwENn9btzHIaNekW7X8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZJW6W/rG; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZJW6W/rG"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-224341bbc1dso88072205ad.3
        for <git@vger.kernel.org>; Wed, 07 May 2025 05:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746619805; x=1747224605; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qU0q9gKbvh5XhBvuYGR7H6phEv0v1PWxORPpqEDSQxw=;
        b=ZJW6W/rGjqGN8nqklR+fRmnycj1RM/DO81FtW7YG2z4CbSed3XstFxFv+c029STWWn
         Pw1Vopd4IRiz0S7+V4dflSUG847mH/yQMegPwjyc+Qknx7n1PkWwh6430nmJ/m2P5CLr
         nGBoouGq5R0GReJyb6hwO+oWG3C9WUaccGZqXyo4Ygd7IroembhJnz2BKkFArV0NFI8n
         Jc6UT6hCEkQfnJ4rI0i+C3TSrLWwTvYcl2hM6wV+xhtK4w3FlD9m4S8K+HcxNghBRSC8
         iJgmYjMusMRwqWAm5nCF7UnAnK167QcqIpYrqibzMi7G/KVHEHBQPBW9umbME9ENLBc2
         fnxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746619805; x=1747224605;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qU0q9gKbvh5XhBvuYGR7H6phEv0v1PWxORPpqEDSQxw=;
        b=uTOQ/9FH+WsL88WzNWxlsRjlpUFBQ/It2c2+NRo/XT/yoWzTcsD7/Fq9+R5/gEJS+I
         kFI2qa0sXKTHGuabmOSTCDXKy/i9nzr6u1eRncpxHShn3lVxy6Xgft07Pc/R62j/2lIx
         yhN3DqZ5Xkq86Vyl/a752F9sn7yuiZKNF63hR4euvXtLESMnoLaW8gPUO8ezuM6v+58p
         desEElO1jUJL0U28mJVsB78dn0yYFUEweixmxIE4WRNIfP+ZLz7Vj6MTOe9T6rroHI42
         3ayM1yi5HKVNn64z8nK7Dgf1AKszuEA79LD6y+y36ZjD+pXq2Vd0Pldf1dtX0jJdkziA
         nUZA==
X-Gm-Message-State: AOJu0YyPwsGcgJXI/YCeZLXiOOSqXcyVF90j17TYdML98DEZATq8hYRV
	d+rSkF96vNWwAzLw8UY8fDw08y2EfhX57mKiN9eLIlAWzNZUBmA7gR5g3m0YmaU=
X-Gm-Gg: ASbGnct3esQDn3Yi+EVrFVaswiN7aSD4HfhBy4PP655m2j2RCNdMP8V+pgz5edCOjJR
	smLNM4ASwzOx1NQQW5/e5x3nmn+H9TSMt5+1yOyNPSMR1jM/vmKwCV8e6Wm+yt/M+xTd9i06XbY
	2o1NOhtmSfqVGjWFkclfK4Vx+dNtiV+vTZK5jDHD9q0MM60jqWr2T6RHAEtMLm0+Utzozwj3OQ5
	NXt/b9pW7LMlJbJ5l7XVHkAYfUh0GteyS+0LHZ1asG5B7xRmYXXnCW+ZLTYIbIRJpHSIyarBRUL
	ZLeu5EjlychoWY8T17DDXgFAL+dKt9d2iSSV
X-Google-Smtp-Source: AGHT+IEKkTryeroxZnq1KvuOwlzPymxoAR3tcxQV0YyAGQL/GssiydSNKARIPqx4fGFLJmw14x75TA==
X-Received: by 2002:a17:90b:3b8f:b0:2f9:bcd8:da33 with SMTP id 98e67ed59e1d1-30aac1bf94amr4381744a91.21.1746619804614;
        Wed, 07 May 2025 05:10:04 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-30aaec19d86sm1797182a91.40.2025.05.07.05.10.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 May 2025 05:10:03 -0700 (PDT)
Date: Wed, 7 May 2025 20:10:28 +0800
From: shejialuo <shejialuo@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH 1/4] packed-backend: skip checking consistency of empty
 packed-refs file
Message-ID: <aBtNtHni7uT70_Nu@ArchLinux>
References: <aBo7OiCKHTyT4DzH@ArchLinux>
 <aBo7nBOl18WWYIsA@ArchLinux>
 <xmqqzffpima4.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqzffpima4.fsf@gitster.g>

On Tue, May 06, 2025 at 12:14:59PM -0700, Junio C Hamano wrote:
> shejialuo <shejialuo@gmail.com> writes:
> 
> > In "load_contents", when the "packed-refs" is empty, we will just return
> > the snapshot. However, we would report an error to the user when
> > checking the consistency of the empty "packed-refs".
> 
> Neither the commit title nor the above paragraph hints that this is
> talking about "fsck" part of the packed-refs subsystem.  That leaves
> the readers confused when they read "with the runtime behavior"
> below.
> 

That's right. My message is vague.

> > We should align with the runtime behavior. As what "load_contents" does,
> > let's check whether the file size is zero and if so, we will skip
> > checking the consistency and simply return.
> 
> How about
> 
> 	During fsck, an empty "packed-refs" file gives an error;
> 	this is unwarranted.  We should instead just return an empty
> 	"snapshot" and let the caller happily declare success, just
> 	like the code paths that implement the runtime use of the
> 	file do.
> 
> or something?
> 
> As to the title
> 
> 	packed-backend: fsck should allow an empty packed-refs file
> 
> is shorter and clearer, I would think.
> 

Thanks, I will improve this in the next version.

> The code change is trivially correct, I think.  Nicely found.
