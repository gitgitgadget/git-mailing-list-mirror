Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C65522F12B6
	for <git@vger.kernel.org>; Mon, 27 Oct 2025 08:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761554975; cv=none; b=XaDqocOg9rsa7LBY9yKC0pEmAcRJ/zug0E5FhrIvEVi/S2h4KAXNPw9YGE3fxZJTBdHy4cHdR8Yj7AVcfA6EvMw/vbsf4IUI0I5REIH4NF3Gb14RzjKI3XbRJ7wXR8QisjjqKIoOt3KibH2TwvyG9M+IiU9N7JAAbQHHCvzQNL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761554975; c=relaxed/simple;
	bh=chy/iRoOFeVMY8TFOCzSTLjVbJF5XFF6Q+PaxgSK3nU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r+2DW85yluDu7I2/ui5iOpLqOJd9E+LTOiFc0C4wh6FUc17BmgsoZaHB7YrThhriSJrTBZc3CUkerHOtIFHwyq1OgDZ6g/d6PnLTOe5nAPMoDFQqoBmu3a3Zrqq6cQaGi4NycKorhz4Ku4fnygGcxevJE1OBGE9BfgNnEcLBfkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nkwy/AWR; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nkwy/AWR"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b608df6d2a0so3982427a12.1
        for <git@vger.kernel.org>; Mon, 27 Oct 2025 01:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761554973; x=1762159773; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=chy/iRoOFeVMY8TFOCzSTLjVbJF5XFF6Q+PaxgSK3nU=;
        b=nkwy/AWRt/0VT6S4t2M6JTv1RuxlZ6sbivvmCCGgK/VWJM7O/mBvQCEnQ5CGocE4Iv
         a1+DfArDAtdTWdUVJOJketP7Soi1t9YRddml9eeqvDaaFFai4wd9bdIrBSAsxYP9OZN5
         4vmf1B5a33daPBFC3fiRCizcIfOv9AgIvY3Ai9nqaSahi9D6W/Ih9WO9dMeo6s6NUWk+
         76dK0Aw/j909RgWN8Mhq93SujceRbMveBBctLUFI51lq4x1EB/n1EzMIA0jpSRO/a7fC
         W7dINCKOI7OtyxHVEHWsdzLYZYQzsIVi++wv0dqHRVFDvwJy6rM4/ZhjTXMLiCcbuPA5
         sWsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761554973; x=1762159773;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=chy/iRoOFeVMY8TFOCzSTLjVbJF5XFF6Q+PaxgSK3nU=;
        b=uSpEzqwxw4albH73f/KBQNDd3I3zOEw+GfZldPMkxEg0IekiEsR4HiCQgcn3zr+LR+
         6Zg/GGNbj2uNfOmeOw/VOZRoE6vR+bL1zGOF7NOiBL9aaY9sOP3re1FfbllXNDu19QW5
         MlLBmNoILhKC+c5VYCjfC3AIBD0V99lNKNNW5qwc7MVeg0zJIkszDFltfq+Q9BvlIW6M
         kF/kPPLbt5wfNFJrC6KQ9HUnpadOrMUJTggvH4De5h6wfmMfHoMwiZ2KO6mtIt1HbQfW
         j3yQ2k+0RUYZdPdBUcaiZGDJggO4SQKgF3MjYgwUgduWYolnFt6idTob2SBVH2AKjZLB
         IDZg==
X-Gm-Message-State: AOJu0Ywfb8lC/w9ry2H/M30iB7WJMO4jPPalURy5/IKFrskIS91MDU3P
	NFmhv592RWTixULm6ClOavEC5LgUhcwzw7XZFZf9zQXeMvv0eSwOpVT+RtDdH8ywx/d+WYlk2qn
	hWSfQK6mhFhT486CD3M9JMkIfkD1Ayls=
X-Gm-Gg: ASbGncvMq5E1prorWSQWX2kNkdDC2ilukElyEA8VuG3jJMN2pJCZ0NSaQZPqnVNmT23
	4qE5psKRpQbcyOsPvXRsRv+Z448gPM4nSOFWtrbQq3M5wX+yDxRVZ6ucyhhI7jJSmAg8pfex0Yc
	DJTtxq5FXKGp1tOisfE0a3K1p/I0bc/3K+1kouBVB3hsmkdKSKvlW4o7jCGbzAm+aPbBn7cJcqq
	ZP2KynTnBlPsiHLk/nNaGJEx/qQcMDEw1iUXXTDA3MJdZCRLj9euv74bZAUQ8N7oTzOdKm2
X-Google-Smtp-Source: AGHT+IHK/9FtOqXVUYMi/AULECvN2HiLa727gkPkbHvVbV7XeDfJi7i//TpEFOzDbwWIMdtjy/f/Eo7cT7aoR8szPrE=
X-Received: by 2002:a17:903:2341:b0:290:b14c:4f37 with SMTP id
 d9443c01a7336-2948ba3ba92mr127987275ad.30.1761554972960; Mon, 27 Oct 2025
 01:49:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAD=f0L-Pr9MtQ1=Wrm3tybZFWKDUtDpVcOahoFUgdVcGKJm7Vg@mail.gmail.com>
 <CAPSxiM9o-rM63jas8YWu6_-ELrzvsQTyhUs-PXDkmgS9OFe5jg@mail.gmail.com>
In-Reply-To: <CAPSxiM9o-rM63jas8YWu6_-ELrzvsQTyhUs-PXDkmgS9OFe5jg@mail.gmail.com>
From: Bello Olamide <belkid98@gmail.com>
Date: Mon, 27 Oct 2025 09:49:33 +0100
X-Gm-Features: AWmQ_bmJveODyOFhkD3aLmBcDS2yuD2DDGRK65B-U6aBFYtvzDgDgBDsmLP-jf0
Message-ID: <CAD=f0L9qP70y7RVQ_E8YbC6F9eMfv9LAP8=hssXvgfo28yJACA@mail.gmail.com>
Subject: Re: [Outrechy][RFC] Request for final application guides
To: Usman Akinyemi <usmanakinyemi202@gmail.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 27 Oct 2025 at 08:41, Usman Akinyemi <usmanakinyemi202@gmail.com> wrote:
>
> > Hello, I hope you all are doing well.
> > I'd like to appreciate everyone including Christian, Junio,
> > Usman and Kristoffer for the guides and assistance during
> > this contribution phase.
> > The deadline for the final application is in exactly a week's time.
> > I'd like to know if there is any new information on how to submit
> > the final application as the Outreachy page requires us to record
> > a contribution by submitting a link to the contribution and also
> > submit a final application to the project.
> >
> > While going through the mailing list for previous final applications,
> > I came across this thread
> > https://lore.kernel.org/git/CAPSxiM-kf8U=vzp5MoD3tUuOtnNjcCgPhLdriyeQo5CGf=EhyQ@mail.gmail.com/
> Good you found this link.
> > where the main points regarding my questions were answered as follows.
> > 1. We should use the link to the microprojects for the patch reviews as the
> > contribution link.
> > 2. We should specify the current status of the patch, 'master' or 'next'
> > 3. Send the final application to the mailing list for review which should
> > include an explanation of the project we want to tackle, links to the
> > microprojects and a rough estimate of the project timeline.
> Yeah, correct.
> >
> > Is there any other information we should know of or is this good enough?
> There is no further thing to do apart from the above.
>
> Importantly, ensure you record your contribution on the Outreachy page.
>
> Also, you can check this thread to understand the format for writing a
> proposal to the mailing list.
>
> https://public-inbox.org/git/CAPSxiM-YAAMwOvH8KYO+qKahCBHgw-NDb-eHJKNCZyk8xtpeGQ@mail.gmail.com/t/#u
>
Thank you very much for this information Usman.
It is indeed a well written proposal :)

Bello
