Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C94E31A05E
	for <git@vger.kernel.org>; Fri, 31 Oct 2025 11:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761911024; cv=none; b=Yb4uPN2FT0pdhYbPTNVm4FyVS0cVumUTFX1gc3AYfBay65e1o4EnL9K/IneOb3x6VWPTCn2GTGYFOXG8A9BXIqM7gukTsqnjH7qLk1Eiw5LFDpF68PwBbgcdA2riHtTVI/lHjjhSF9FG62jgFjh089+2OM2Gmr16jrkxew5jeAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761911024; c=relaxed/simple;
	bh=m4Dbjt+oQ6oqrvTdMU5W1AKPQHELhXZUFN5tbE5gIFc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y70FZxqlS4U2MpYgg+KNXuEqqSxCDJtwFFAgYCCuRUmANaN9tH6s92D1jaMFJEeKjC4WEBMIcC/nms9W0tBrZpuoHIz4/WC/Ufcs37Jairn6MR0DfYVs72Svp0Y8ld9ncB5aR89eTthQCMwJY4kPbtOxttU+SWW4zDiYapVwfvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NLYzUm3v; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NLYzUm3v"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-295070beaa4so15597205ad.0
        for <git@vger.kernel.org>; Fri, 31 Oct 2025 04:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761911022; x=1762515822; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=m4Dbjt+oQ6oqrvTdMU5W1AKPQHELhXZUFN5tbE5gIFc=;
        b=NLYzUm3vksOd+FEa7GWc2/OoZ9WfLl5pJ5gM8exSX/2cTY3RnMUPWbTjIRJIAf2G9Y
         WvKRVP9cBBatVQt3YZahJpsEge7QGqcxrs7svvBtWB7INPdv4lHYzEpCvv2rxR5N0YoY
         I6XEJqldj+InkXyZHuZF9QtmXE0yM5gJ4iKPUTRCXi3kJh2ymjFEPh9iBodSuLguz3bb
         GIJhsjJQOlj+8E6aY1QloIcW2XtERB0Iae7KqVhDZ9KQVopMwwnBrTlht5InRtVlCH3o
         pt4P57clF5KV3zhwYQU3fw55PIayXp+dq57vIGhLlutDhu3E/VvvYExAQn5+xn1zZl/l
         V7iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761911022; x=1762515822;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m4Dbjt+oQ6oqrvTdMU5W1AKPQHELhXZUFN5tbE5gIFc=;
        b=QAL1iSXawmvhj/hN4wESeiC6SDh4MB2OKtO/GGmaCWXmN1g2W3ivN00C8TIcsDQAY/
         gpeYTnXN8+LNOIuos/JN7nRpSE5uBBdlB6AcmH5V+GVYdTkebtGxkPPba3MrD5z8jjwY
         qLVERoahhzcXBkjiFC9urUClBVvPEPx27WLBfadng4or6dWsg7Wzttf7eFNtq/ZE8ujH
         slz7sAN4ynrVlfuAHz+XwBZ6F3KUqtI6mivw43arS2HUvj7tvhXWEB/FgNGesFbRM//v
         jK9h72hke+I/so7V9/ZEfz/7agb2rFeD+e10ItNy8okpzZ2yidEs1RtRbSDtn/Gh7mZD
         Aw/A==
X-Gm-Message-State: AOJu0YwSLYNIraR9BCG3+ujQU7ZmfKoWSnpaBXQalY/rOIfUeRzQIrO5
	AAmAgmqpkM2Ckgr32FKrqOG1Prbx/OpN1lSBdYqkp5O3u/f47w5OZmEjQCRgV7xj512blJtN8Fy
	tMmQWV/MmnBp1m1xka0M9Pekldp895ko=
X-Gm-Gg: ASbGncvaxClfRCkchwK+QLvUYFKf7aS7Qumyv7eu8nZkDGHDvRZBEV3SLmB0b/xZ767
	SO0FTiJTnwVcv6jzwLpDW6dlefMct1ObpXhr0uvtlyR8bAZV0v0phkZ7lEktRG/KzeejBc9Al2V
	CfSCyQq3tYS3Me5PmT5Nh6vj9m1fiyEIrcVsgfQMjUoEE+jYbskh4X9ZN5TH5kGKSw07O4De0T7
	zNdBO8Q8zp9bjMXcUsH2HCZ9Uel9OKM1WTij8TxTspiWZbE6MQbD4nNIDEOcNI=
X-Google-Smtp-Source: AGHT+IHvcGUWhY9snY9BkSSU2gl0ic5W/MB82J9dEzRbP5vjMe28Fd+0PjBObOVPhMkjbTu639ws7x+cQXPgqeldNtE=
X-Received: by 2002:a17:903:37cd:b0:273:3f62:6eca with SMTP id
 d9443c01a7336-2951a3eac4emr50166505ad.18.1761911022286; Fri, 31 Oct 2025
 04:43:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAD=f0L9anYu4LKWGDKrwzBBytMunJ3UjTehNN9m2DigG8yCNHA@mail.gmail.com>
 <CAP8UFD0a+RxQ-pPWrmwOYhBic6Oy9C1NeA7EmEyj2KYYDyS4QA@mail.gmail.com>
 <CAD=f0L8=eBJjj77xBw7m7WcQf80sYbF-X1wbFc9ToC9F0AWVAQ@mail.gmail.com> <CAP8UFD1v7yec7JwBGekJPvcq7kNJPuPTgWOVn+gBaw1+Sh2mdA@mail.gmail.com>
In-Reply-To: <CAP8UFD1v7yec7JwBGekJPvcq7kNJPuPTgWOVn+gBaw1+Sh2mdA@mail.gmail.com>
From: Bello Olamide <belkid98@gmail.com>
Date: Fri, 31 Oct 2025 12:43:43 +0100
X-Gm-Features: AWmQ_bnIeQbAmn9yp-LaAB_6BVuRjzV72kocbenKrGha1oKc6aA6DmiG5RUugpQ
Message-ID: <CAD=f0L8aMT+Qjgk4Gij1fVCVjKSyGfWS_tb6O54PT1=4KpbRJA@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_=5BOutreachy=5D=5BProposal=5D=3A_Refactor_in_order_to_redu?=
	=?UTF-8?Q?ce_Git=E2=80=99s_global_state?=
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org, Usman Akinyemi <usmanakinyemi202@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 30 Oct 2025 at 13:55, Christian Couder
<christian.couder@gmail.com> wrote:
>
> > Yes there were cases where the functions were adapted to use
> > exactly what it needs down the call chain rather than writing new
> > accessor functions.
> > An example is
> > https://public-inbox.org/git/20250306-b4-pks-objects-without-the-repository-v2-1-f3465327be69@pks.im/#Z31csum-file.h
> > where the global variable `the_hash_algo` is replaced with an explicit parameter
> > `const struct git_hash_algo *algo` in low-level functions such as
> > `static struct hashfile *hashfd_internal()` and the call sites adapted
> > to use r->hash_algo
> > or the_repository->hash_algo in places where the subsystem has not gotten rid of
> > `the-repository`.
> >
> > This is also a strategy that can be used to replace global variables.
>
> Your answers are appreciated, but, just to be clear, I think it would
> be nice if the answers to my questions like this one were part of a v2
> of your proposal. If I don't see a v2, I am less tempted to discuss
> this further (which could hopefully help move the analysis forward and
> make your proposal better).
>
> Thanks.

Hello Christian
Thank you very much.
I have added the answers to your question and submitted a v2 of the
proposal.

Bello
