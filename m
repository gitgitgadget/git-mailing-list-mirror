Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DEC11805E
	for <git@vger.kernel.org>; Thu,  5 Sep 2024 14:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725547582; cv=none; b=iPxooVbr556c8/Poe6QcYBYko+BWDUwHVsqapoKM0TDlkkxIqkz+BMTtUXcUxhEwCyxjmG8VUExSsve5456Y/3uLgsLz5sM4kMzAHJG+qsMramX31WxiNaz1NL2zTACnN3m8DAgWox7XLEtC7f/c92V9MnR6O725j36QIF4AEFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725547582; c=relaxed/simple;
	bh=Dg3yzmxFe12Fkm7BFBLHASmOh3hEIpQeP0sWJCR7LDo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PHmANCLGQyqKgl7eaBGH+TloXGZfU3ipngqep04/C/GmBQ3Hc0UGyVxyTPVGqLhXojcI3bMuCkkkaINULm7UkO7lQZ/6I6QtJC3wD8OyFMNS3Btuv5VqOzxoirmQaeM1ZtW7L+MxGcQ9jx4oZCunpYwsSklgjkSPogfm9Z4rXsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LrtcI+Ar; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LrtcI+Ar"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-58ef19aa69dso928380a12.3
        for <git@vger.kernel.org>; Thu, 05 Sep 2024 07:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725547579; x=1726152379; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+XhgPUGLxeJgMf54VIL/5BBHCMQpx7dVKNv5W1IcWqY=;
        b=LrtcI+Ar2OR66qd4OEIA9DNf3crLHU/BloGdF9D72dMJJdx5KKjOJOhjnr44dvnLHk
         AqDE2sAaLaERc/9/m/LNkb0C2A7+6niH33bh2eZxr7Jq90Oz1xeKOIgRgEoeEDU6Nu2m
         d5o05mXzVnjxyJ6+Jiwh79MUb6g4YHcrycFdLm8/MZh//h3m8uNSEq1nU3rYgzGX3g7u
         iWclwE4u5dZFLlMYTnUbuU0uaZ/nQfkw72tp1kQVh8NAFR3RLuxoUev7PlyYuUCaOS4S
         R5vmUbIvUFpmunYd5v6lIGgJAqpQkHfRBR47xWjznNdGcXDfqqlZ14vtATagBBvubTT7
         ExLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725547579; x=1726152379;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+XhgPUGLxeJgMf54VIL/5BBHCMQpx7dVKNv5W1IcWqY=;
        b=bnPSVBM+9bufrCNCpHVcJF1qCUrVVDrsD9g8IET42KPYGrKwtwJ3vblsFLLaIEK06R
         PG3SYuYChv78sM6K1UbpisFEj86D0cG5LTANrFusSNhxc3GTK+zdA61lp4jbiCbshGpV
         ua+MCjhQos1TU/OzrI36a70D8Goh3t7KmrC2Jh593kG0osp4EvV6de+h4K5CATd1J/Oy
         sSpC5kq+/5I2bZa2GqhBExbWfKjAbYduA7tBL/HwE7n3rxcIBtVXFjg1ANgQKZyv0NYV
         cVzUN40DSH5Rs4G2XaqFWQrVwiaAU4VG84XI9xIQ21+MiqFEVOGnI5uaqtfN56ZDte32
         p9Tw==
X-Forwarded-Encrypted: i=1; AJvYcCXLouwnqDHTX0BWe1xM1WAXCdqSX8d/upArdPZ6c/3ZzWMG+IrkXtyUdSEbRs0CxIHrsTM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYvY2TVphgGGZd7CT6F1V7XPjp/QOwfNJRo4a2IMbQa+JQ7V7V
	dr8ThQMfGrG/d9BdjubZFqGgCpes7aBkxdZHwyk1u7+D9r5fuXJskrRlLWan849/NLCB9ZTDZre
	BVZA0uR/K1mqoc8ar4DIVb/J3q4A5RQSyUpE=
X-Google-Smtp-Source: AGHT+IH/HM2c9ERLKbj4A19TU+MrfNTetkYBJJf9dGH9D70iJ6q68YAb4uhzMjTjMZpzQ58d/riPDarJ/fui6SFETUM=
X-Received: by 2002:a05:6402:4304:b0:5c2:6343:827a with SMTP id
 4fb4d7f45d1cf-5c263438345mr8824518a12.32.1725547578431; Thu, 05 Sep 2024
 07:46:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240826173627.4525-1-chandrapratap3519@gmail.com>
 <20240904150132.11567-1-chandrapratap3519@gmail.com> <20240904150132.11567-2-chandrapratap3519@gmail.com>
 <xmqqmskn9w3o.fsf@gitster.g> <ZtlafDnM-geVUTQ9@pks.im>
In-Reply-To: <ZtlafDnM-geVUTQ9@pks.im>
From: Chandra Pratap <chandrapratap3519@gmail.com>
Date: Thu, 5 Sep 2024 20:15:53 +0530
Message-ID: <CA+J6zkR35jgmCuWniqDBBcTOW68V3Kzn1x8Yc5PZLHxO_cPtaA@mail.gmail.com>
Subject: Re: [PATCH v4 1/6] t: move reftable/stack_test.c to the unit testing framework
To: Patrick Steinhardt <ps@pks.im>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org, 
	Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 5 Sept 2024 at 12:45, Patrick Steinhardt <ps@pks.im> wrote:
>
> On Wed, Sep 04, 2024 at 10:17:47AM -0700, Junio C Hamano wrote:
> > Chandra Pratap <chandrapratap3519@gmail.com> writes:
> >
> > >  int cmd__reftable(int argc, const char **argv)
> > >  {
> > >     /* test from simple to complex. */
> > > -   stack_test_main(argc, argv);
> > >     return 0;
> > >  }
> >
> > This makes cmd__reftable() a no-op.
> >
> > Even though you cannot remove t/helpter/test-reftable.c, as it
> > contains the implementation for "test-tool dump-reftable", we should
> > at least be able to do something like this.
>
> In addition to Junio's patch you can also remove
> "reftable/reftable-tests.h".

Should we get rid of reftable/test_framework.{c, h} as well?
