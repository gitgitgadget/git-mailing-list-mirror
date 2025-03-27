Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25134DDCD
	for <git@vger.kernel.org>; Thu, 27 Mar 2025 01:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743039102; cv=none; b=I7uH4SMssOkUGuiO83I9yaRH5PSehEx4rbM6HDkBFf0nJaZ8J0jiPLSXtxFkRxhz/laFcOfIwmCSr9iChl9YKVqWk3H6DjANJZf+ZfCbiQ/v3XI6hG39kIxRnsbnumTdsHWq9PgxM892bE72BADWDxY2boAuOBg/v545U9xSQVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743039102; c=relaxed/simple;
	bh=CzF3PVZyvjrZ1uIRGQOL6Y0MpSgsH0S+bVML0xhFqhg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=csaUJQiTjcVoHjNXKA6XEkAtfwGKhTeYo9rxc7XKIRz9VLbRJwed5nYr+ThQ80gUo5ZFn+6M5Wr26TQVQndpGc+7O8gE+2/EVMEHrawFlZ8qZXXuZBxxP2qMulqKEUSQpWVj9m5/Gg4xZ1JJCRaq2oLX/Dt4ur5LnHBKIEJLbUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O2Vn9U9H; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O2Vn9U9H"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5499bd3084aso423451e87.0
        for <git@vger.kernel.org>; Wed, 26 Mar 2025 18:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743039099; x=1743643899; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hRsTnvsRjE0A2GhvDvpcg4HA1xL7U0HVNu7ljomE+48=;
        b=O2Vn9U9HsmsBHxocgwnivVSvQwkXKdMIQP7f5Um+r4n9OuklMj1egAoqhF6CebiXjR
         QcEtnS8EcPgmrg+F6Cm6VIiRbNwuWfxGApJtUbBUQW5XNsNFPkvA3GxneyVGquErznJC
         qI38LXW/SgAmAGjbacJu9QnzwkVeUNVDbnM9yriNvDcD2TIZYLqdZAJKcVWGsk8QriP7
         Rr10Aa21CHzIPQ0LtQY1u+jfhB9fYmaMYZO1E5HohVxF4JyFb078DdTSpBSh4GFHEwRE
         CDrq3Wt24/aaoZR/zUJtMTKzXFWLgtrykrkaVwR/yaiaBhOgmU7NcRaaq86c8Uxrd101
         OJ7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743039099; x=1743643899;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hRsTnvsRjE0A2GhvDvpcg4HA1xL7U0HVNu7ljomE+48=;
        b=IIznxD2pwIZW5gEpoAUjOWAqOgZpWlZLncFcFBDlcyCZCuJN499PL8qpWlgZqX4IEw
         GdX6Q58qHR/mOjbc+1a8+kOAZwz7/14xFPTDPukFss7rwP8jr97Zy2W/D/efhRs4bJYi
         jdyn87RKAtVqsZXnjr2re8c+K5NYOU75lt1Pshkpguwq7Cx+/vPTDKSSQYNI9FSprkH1
         0j3rwCgMRwNwOJkiekZFTl5sMOmtrTXV3c3c58hJLatOzZggrMUTWlqdyIwXxUYlz/YW
         gWN2IUjo6pgKIRowutDqUir5vX6XEiSpaglVjCxo8f9XMTlLqZiMHm22hatE7EIRAIDe
         5LvA==
X-Forwarded-Encrypted: i=1; AJvYcCU+nl7nXcU8eGsg+8Db49Hk9qdhXQBm/k/wLCS/kOhVyPxdAiXHvzAZNHFDynieO2u5Y4U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1ugDY710VkDtzFV/DHgdYqPofG47LMaOGjfCkjSdQ366xzxVb
	uQ05HtPULpdQNOpZTGWsD248FfHa4omlZizJifW1ZBFebafQZsT7DesjJZbi0ZWcwUE2tASsSGt
	mcD73zF2HVEqOEmR3B4JxDPVEbM4=
X-Gm-Gg: ASbGnctmtl4bHI44enNv3lOzDvNq8g6T4ImN61EJCQT8kC5YBtnB9/r5MHHFIdvxWx8
	dQSHEVVWyOfIMUr/J6qyXMQAwZkVqGPzwwT0vL7fRQkfqKiEUWrELpZvbajwfgikOtOPUojBAwi
	0+u/mujmfO14e8lIbZ0GdncvXuqiY=
X-Google-Smtp-Source: AGHT+IEbfG9bH05Wa9Ih3DG+6nhQZ5q2D9l0aGvjeQ0sqms86Fl4Thfrz9CXHt93wo8btOPECYEk6SqXWCqZopiXk4g=
X-Received: by 2002:a05:6512:4024:b0:54a:f66b:e938 with SMTP id
 2adb3069b0e04-54b012649b0mr647660e87.45.1743039099015; Wed, 26 Mar 2025
 18:31:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1889.git.1742889711.gitgitgadget@gmail.com>
 <pull.1889.v2.git.1742945534.gitgitgadget@gmail.com> <5e0e8325620395196608a0851f1f6fc9408f6090.1742945534.git.gitgitgadget@gmail.com>
 <Z-OWoK-DlvnxXPkO@pks.im> <050f5d65-32eb-fd26-1461-579b06018dc6@gmx.de>
 <ad57203b-8925-4f88-add6-763c2d80afac@gmail.com> <Z+RkmLzciwT6ubIE@nand.local>
In-Reply-To: <Z+RkmLzciwT6ubIE@nand.local>
From: Chris Torek <chris.torek@gmail.com>
Date: Wed, 26 Mar 2025 18:31:27 -0700
X-Gm-Features: AQ5f1JqPJkT0begHIXmh6prbTQAl8c1-vuVtFx9GNso8MIDvRJfTh19Y7dfjy2Q
Message-ID: <CAPx1GvfyzdF9HasG3aPQA=Jdb03=3YJvNEDXabGK793CCow=HA@mail.gmail.com>
Subject: Re: [PATCH v2 06/10] diff-delta: explicitly mark intentional use of
 the comma operator
To: Taylor Blau <me@ttaylorr.com>
Cc: phillip.wood@dunelm.org.uk, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>, Patrick Steinhardt <ps@pks.im>, 
	Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Philip Oakley <philipoakley@iee.email>, Karthik Nayak <karthik.188@gmail.com>, 
	Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"

(Just picking the latest message to reply to, not really quite right)

> > >             if (moff & 0x000000ff)
> > >                     (void)(out[outpos++] = moff >> 0),  i |= 0x01;
> > >             if (moff & 0x0000ff00)
> > >                     (void)(out[outpos++] = moff >> 8),  i |= 0x02;
> > >             if (moff & 0x00ff0000)
> > >                     (void)(out[outpos++] = moff >> 16), i |= 0x04;
> > >             if (moff & 0xff000000)
> > >                     (void)(out[outpos++] = moff >> 24), i |= 0x08;

Might be overkill but:

        #define XXX(index) do { \
                if (moff & (0xffUL << ((index) * 8))) {
                        out[outpos++] = moff >> ((index) * 8);
                        i |= 1 << (index);
                }
        } while (0)

        XXX(0);
        XXX(1);
        XXX(2);
        XXX(3);

        #undef XXX

would do the trick.  Pick a proper name for XXX of course.

Chris
