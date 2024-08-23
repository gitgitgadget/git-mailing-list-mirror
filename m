Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA7A71E89C
	for <git@vger.kernel.org>; Fri, 23 Aug 2024 11:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724412557; cv=none; b=jKErHYdoIzl4USqfpJm7gAPazjBVJr4QnzpI6nk657/QsOXYRvSikCoDmWetIWr1ZfHqo9TkmyPvFK1Mct4CaSgAXYzK0EK0Y0VoM9D47YiVM8i59aLLaABZlS469/UnumL8Q3ryEB+5abtp/0kYY3o5QjlcVIBPeghuhQd48wU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724412557; c=relaxed/simple;
	bh=s9zb3iqLI+J9W3GCr085qhhOW8VM4XJVAYbFEhygWz0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bEtWc/nziUDawx1Xef4cWZZ43bkoTUZjGvVSZQnEehpzPnoHVs0umVzJxSFtcVLguMkm6iuqR/o9W4J+1r5DwmuoHWIOK/gkQj8BJfyAKlu5Vwu6bHUaVJZndvouEJSzjv6x+qK3Hnxa4rKuodPZIpswGA9bivWYg8tsCnBYDyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CjKDSVYA; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CjKDSVYA"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2020ac89cabso17568175ad.1
        for <git@vger.kernel.org>; Fri, 23 Aug 2024 04:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724412555; x=1725017355; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fOvZYbaYjpcRfhBuo50pprsK8+gCeaNzJ5rFD1jK/Q0=;
        b=CjKDSVYA9FrIlURMNK9OwpSDUz2HE6qYHUmj1goeCoenw36tmuwRMlANISNXQNqxpr
         aWxcvVl43rqVd4WFiFYg8viM+lLsVnZkBXvsdbgzxTbuOUQtpMQpRGXgRvqakiOnFqVP
         CiGIyOEPbDddO2hZQ6jEk9GMgRc1QYCa+J7PS6RtgFkBCqxpM6+cTev5hP3XiYYTG9sb
         t0s92ama8S69Mwrz9QZUVtXyFS2NbAmqRCJ8AVb/KX0BLnFyQtjivbNGWo7sOgAY71Zf
         cIg+Jf3M6M6GG3Ls7X8az8FvRP2UKywfGxl/N2CdY5SQgQqtrsO/xoN50+XwXuHFJJNk
         x0sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724412555; x=1725017355;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fOvZYbaYjpcRfhBuo50pprsK8+gCeaNzJ5rFD1jK/Q0=;
        b=QFPliUYeS5Iby4KYMR8NHoedsmqpK9a/ngn++LIhUtZIGKasF5hcDYq72BubIJQulX
         nHDN2gzImDiNMq8BQ/qVV8EPELX7dnNb2sNnLlqT2dtkqRUBTc/WZ87oAuMmQ6ZAudQn
         Gij7+Kms6AgT6QuDKx4zIlo+fJuaK6pctGpDy7u22DefiluzNFOlSVVqGKfmiprv4voL
         TPGmOhLgb1KxjWa7raIhO/Yht/mEyW+UwxsdBtWMDsV07oZ/Meti/8mvQCA5Pwt24pBT
         w8T08+Cnvjihum39qIPvYCpFEzHK0sxR/vnCTV9dpRValgQ72bzepafIs9JqFBScfw+W
         rs8Q==
X-Forwarded-Encrypted: i=1; AJvYcCXiCbm302BuD+/6GQwhcn1/kM+Kr4SploX4eDSypUI2lQ8ECchXj3eSm9iCP43M7NSLh/M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyleBZdubNDonogkPsDS7V2PK5z5DziBOaPFGJDYetbjqmygbIt
	VRWeQ0QBlfF8Z/TZiJ0guS40rbx3nZ1Civ0t2AClhnlfVnHkbTqk
X-Google-Smtp-Source: AGHT+IHjiMkb6F9WyJHsOTG0P1hZey1VmB28okdqgPwPqh+bVB4BXqf0uWdtzpnNIJMYkvExJfEsDQ==
X-Received: by 2002:a17:90a:ce11:b0:2c9:7d09:1e7b with SMTP id 98e67ed59e1d1-2d646cecbf1mr1897203a91.27.1724412554729;
        Fri, 23 Aug 2024 04:29:14 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d5ebbb0b27sm6081293a91.45.2024.08.23.04.29.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 04:29:14 -0700 (PDT)
Date: Fri, 23 Aug 2024 19:30:00 +0800
From: shejialuo <shejialuo@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v1 2/4] ref: add regular ref content check for files
 backend
Message-ID: <ZshyuH55IP_a55z0@ArchLinux>
References: <ZsIMc6cJ-kzMzW_8@ArchLinux>
 <ZsIM2DRDbJsvNjAM@ArchLinux>
 <xmqqed6j9m24.fsf@gitster.g>
 <Zsb64NTyqc_oHNFO@tanuki>
 <xmqq1q2gtu19.fsf@gitster.g>
 <xmqqwmk8sfaz.fsf@gitster.g>
 <Zsg4ZLHFD4nzISc6@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zsg4ZLHFD4nzISc6@tanuki>

On Fri, Aug 23, 2024 at 09:21:14AM +0200, Patrick Steinhardt wrote:
> On Thu, Aug 22, 2024 at 09:17:08AM -0700, Junio C Hamano wrote:
> > Junio C Hamano <gitster@pobox.com> writes:
> > 
> > > Patrick Steinhardt <ps@pks.im> writes:
> > >
> > >> So any reference that contains additional data is not a proper ref and
> > >> thus should be warned about from my point of view. No Git tooling should
> > >> write them, so if something does it's a red flag to me.
> > >
> > > If you find such a file in $GIT_DIR/refs/ hierarchy, because our
> > > consumer side has been looser than necessary forever, and we never
> > > have written such a file ourselves, it is a sign that a third-party
> > > tool wrote it, and that the third-party tool used our reader
> > > implementation as the specification.  That is why I am hesitant to
> > > retroactively tighten the rules like this patch does.
> > 
> > I forgot to add my recommended course of action, without which a
> > review is worth much less X-<.
> > 
> > I am OK if we tightened the rules retroactively, as long as it
> > starts as a probing check (i.e. "info: we found an unusual thing
> > in the wild. Please report this to us so that we can ask you for
> > more details like how such a ref that would violate a rule that was
> > retroactively tightened got there", not "error: malformed ref").
> 
> Okay, that makes sense. The fsck infrastructure does have info message
> types, so this should certainly be doable. I'd argue that we might want
> to make this an `FSCK_WARN`, but I'm also fine with iteratively bumping
> up the severity from INFO to WARN to ERROR when we don't observe any
> complaints about this tightening.
> 

From the perspective of the implementation, there is no difference
between the info and warn. But I have a doubt here. Do we really
distinguish the info and warn in code?

Let's see the "fsck_vreport" (although this is a new function, but I
never change the implementation) function:

  static int fsck_vreport(...)
  {
      enum fsck_msg_type msg_type = fsck_msg_type(msg_id, options);

      if (msg_type == FSCK_FATAL)
          msg_type = FSCK_ERROR;
      if (msg_type == FSCK_INFO)
          msg_type = FSCK_WARN;

      ...
  }

We eventually convert the "FSCK_INFO" to "FSCK_WARN". Confusing.
