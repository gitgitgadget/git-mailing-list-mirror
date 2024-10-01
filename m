Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B2211A3BB9
	for <git@vger.kernel.org>; Tue,  1 Oct 2024 03:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727754049; cv=none; b=kfUps90xa6ScXFwFJyD4JdxiKe3Ct1BhPebeUKwd5b27MDmlDGDm543c+uxPbc3erPxrM+rh4ajvs2rEoQyQcCBOuI2bbKEM7eubg9xdk948eBoyLICsuOkI4aJ4sYo40ce1USx6KOAAlzR1ihDAnAVV8XvvnQF+Xv/C+I0mx48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727754049; c=relaxed/simple;
	bh=r7JyXQj6BLnWHSyaX8ltoe1xNvB1wf3sh64BaVfLqMU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YhLbOf4RyVylbGY63ScDah2SRcmgecFYxsz10zv+/RMxXddeU6czhoDdyveB0vScQg5jolWVfztH5HXN3pTROJE8sa2eiEG1pRXCdABxqiGUhb2fgxLezpTF9CkvGWWBYd0iZapfy4hyPLiMbwPfakIfdic6ujjExxwDqR0l+rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f8UDfD93; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f8UDfD93"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-7cd8803fe0aso3511653a12.0
        for <git@vger.kernel.org>; Mon, 30 Sep 2024 20:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727754048; x=1728358848; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nu5xjtxj8YqI2DBHQWuOUeutr3b5BcOOa9KLCJIdxKs=;
        b=f8UDfD93S9Y5UUfU/3qvbRluRdUKpoJVKVqalABO1m00QxYTfkqCQulYUZCWPWgnTV
         QChWEnyX+jGI/nRMxtdY21toWfk/Aswi4E8hUPL0e3/FvICwskVOsC5w3rxEebXz1Cmp
         oriY38hAbWgYLsCLq6oDEEVMmTeozWOQLyJAKpsE9ToLHhB4/pXQi+qxY5gEJ1cEAjWn
         G0evKsS6Owu7aks2LXpk3AKAUfrdniwp8Q8zsmSeQB9waavP0Q8THvyoou4ZA++bXBVi
         xBdCgaoHhZdoeX4vb/oUf7fS1B1hqy75o3RTF9xY/gmc8ieiKBqX6gqv7+SQGTW9c5Yr
         EH1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727754048; x=1728358848;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nu5xjtxj8YqI2DBHQWuOUeutr3b5BcOOa9KLCJIdxKs=;
        b=S/Tnb1+RhDU4DBtXb4DPinZsAB5eE9YVBTjIP3IVxiWvdo//bqrsOW/3oQIQLL47Kv
         CMAZS2nPH+mFMg/wp7cFE9MkIME3sactJdwBRKUItJM3Vq7Z7J5bYu0xw8u+sGG4LX5p
         kA/J5V215I+N4ln89aALnIm6ySAuHU6YbuY8vEPkE4G1Pkp2IZHM/nNnT2FAw06TWvtA
         DIa8tGbNi1DJrToZrg6cchGJ41zK0ecvO9MxrGcFuFAjLInDJvBUyjl2WbxmhZfTBWOf
         El02y6psMHgCF55A3SfjVgY5eiIDzhHtrzXD0D3jRj//jPw6Rk3HbiK6y6CXgZAc34QE
         Vkww==
X-Gm-Message-State: AOJu0YwSGjTojDDUGNnjGsUABl2NUKdXyFH8D8OXcEh9Z3AyqHcBwhEF
	lXLEJ0iQYA9KN5Us0qmQWh8sYW0GlaYnVbUMsOOUVtvq8/Cq7kGh19wfFQ==
X-Google-Smtp-Source: AGHT+IFI2tQTT3oaildNhczUn5pRJMEYpoeqJ+7XdSEBs6dFzvw7ATE8AZaPbAWiBlfaPcVXrL5gaw==
X-Received: by 2002:a05:6a20:c797:b0:1d2:bbfc:769e with SMTP id adf61e73a8af0-1d4fa78fce7mr18349311637.38.1727754047665;
        Mon, 30 Sep 2024 20:40:47 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71b26515e56sm6998206b3a.136.2024.09.30.20.40.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 20:40:47 -0700 (PDT)
Date: Tue, 1 Oct 2024 11:40:48 +0800
From: shejialuo <shejialuo@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>,
	Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v5 0/9] add ref content check for files backend
Message-ID: <ZvtvQBdnDWzVgtYk@ArchLinux>
References: <ZuRzCyjQFilGhj8j@ArchLinux>
 <Zvj-DgHqtC30KjJe@ArchLinux>
 <xmqqikud6kc0.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqikud6kc0.fsf@gitster.g>

On Mon, Sep 30, 2024 at 11:57:19AM -0700, Junio C Hamano wrote:
> shejialuo <shejialuo@gmail.com> writes:
> 
> > Because I do not sync the upstream for a long time. For this series, I
> > sync the latest upstream and generate the patch, it is based on
> >
> >   3857aae53f (Git 2.47-rc0, 2024-09-25)
> 
> Does this help to reduce conflicts when merging the topic to say
> 'next' or 'seen'?  If so, such a rebase and noting it in the cover
> letter message, like you just did, is very much appreciated.
> 
> If not, please don't ;-).
> 

Actually, I am sure that there is no conflicts after squashing the
following two patches.

  <xmqqle0gzdyh.fsf_-_@gitster.g>
  <xmqqbk1cz69c.fsf@gitster.g>

The reason why I just sync the upstream is that the build system (such
as warning about unused parameters) and CIs are all changed.

I will remember this.

Thanks,
Jialuo
