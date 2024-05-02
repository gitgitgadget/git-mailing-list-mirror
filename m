Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1E2F611E
	for <git@vger.kernel.org>; Thu,  2 May 2024 00:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714610778; cv=none; b=JPlM4+ovXyjx5lNNEVfNqOVZFhHK6LItdAW73sfqbdPzhUhcCIwa4+PzSPKja3EY6UcwoHEp4YS5oeJabewLVuH4douGEqmD0eGppljqnuHvDjGskBUrQPpUQPG62OA3RQJf0sB1sBS/XzULHzxCPHGBilO1da6JvUJcPv0tmlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714610778; c=relaxed/simple;
	bh=xLg95Br3gJfJ4qR8FHPo6K+PYYx5tXiaIlrtJvLhUyA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WbVrW5B4QzqvnzeujNkZSmVuZkp/eZKxCvDI+2+6BMlRhjZnfmi5maWrQpV9SKO/ct0A+gEvoDMR5/lcp6+NRXAMmzmPikEocuqAy4SC/qK84xWl6hfq2H0wwGeBUurj9O0CF5B7Bjb0fEZeQ7KRpzN57vSCv18Zi4su8aBVcDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GA2mcAaE; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GA2mcAaE"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-571ba432477so7848015a12.1
        for <git@vger.kernel.org>; Wed, 01 May 2024 17:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714610775; x=1715215575; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xLg95Br3gJfJ4qR8FHPo6K+PYYx5tXiaIlrtJvLhUyA=;
        b=GA2mcAaErjdumMt2hNNd5s9oZ6DAavoS2pFhsLQgkWN/zN82jbip4jZXFaAWfmqnB9
         KpzJobkXJhqZqm74hUBs5X8pdIPlsQJb3ocrK7vEHi4ke8w9Lp8q1VoP4pBszam3AYDk
         etFBV/t0Bne1xS1YU0qhbHBJ5IN2p73dSYcB6CK6uv05E/AFCsWCT6FQ1KxfMLbe4Sao
         xrPZ0XXsYQy4OqVzAhkTm9hOkQU/OGeK1Tr1JQbg1fhNG9pJByHhPffW60oVh9J8MpB7
         Cq0EE6AN6DWXE5FXw63lHLMjW/YqT2Q/ZDutuViEWnOJfe6djhzUpPAZRvbXi/jH2v7l
         ERdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714610775; x=1715215575;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xLg95Br3gJfJ4qR8FHPo6K+PYYx5tXiaIlrtJvLhUyA=;
        b=dnVRnzR502fMjZ9VFl15BlIMy3bTjoSFr9WkRn52GyuUVHUvTDhsTAJUCh8rjAzpQS
         ud98QG7Hb46vEF+gLM1OAPEGu4G1coAi08Z5cGCR10xTM6ekPkPe/Gg0AEwE2d08t9A5
         328ZV8MHEfl2skNTr1y/bAnJJ7lWKLXx2VR+PzsQ9bYKz9E2bneqZH7Lhyu6eb0Uf9i0
         zrC/Elfl/TBlRLQM7A9n8PeGALd1WuAIfXx2Telgw7tzP/fzyFw0qoJOxgxgR5MQWR4f
         h3X0aw3+PqF/CxH6aOQJUxedUica/QEJgrz/EdWyFSXYVQRFp1YbKcAsXlreEFVOa3de
         sEuQ==
X-Forwarded-Encrypted: i=1; AJvYcCU6GkKnxcfnusYOalzYe5K1nJ9xLcpFJS4G0HS/6SKzFO2S7sVmapx5w9jl+AaZCYSrC20w05Sd5iL4S2BtnKiYUF73
X-Gm-Message-State: AOJu0YxtYqDWoMfYKixP8CBURQtAm+nOVmyX8URT7Mtykv//X9Q5700h
	iBRd3SWylb1xL/39ftGOPZBb7A5g5eWdnIhWpSDDB7uF6frLGaEJHthP/NBog33ctHZcR5q6xPR
	KTRjkZaTettRpTmgTMErqSp0SafgCWE9p
X-Google-Smtp-Source: AGHT+IEda9t+laMU2NeEnfXSUezGidRtNfYN6ukvWejmR1/zpp483ssr5F/QE9URgwmG5npDBCxfNLcNQKrJ9fzKaow=
X-Received: by 2002:a50:d49e:0:b0:570:db4:e5cd with SMTP id
 s30-20020a50d49e000000b005700db4e5cdmr2769062edi.34.1714610775031; Wed, 01
 May 2024 17:46:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKOHPAn1btewYTdLYWpW+fOaXMY+JQZsLCQxUSwoUqnnFN_ohA@mail.gmail.com>
 <20240501220030.GA1442509@coredump.intra.peff.net>
In-Reply-To: <20240501220030.GA1442509@coredump.intra.peff.net>
From: Dhruva Krishnamurthy <dhruvakm@gmail.com>
Date: Wed, 1 May 2024 17:45:38 -0700
Message-ID: <CAKOHPA=ow5-TVG6FZd8fZRCx_takHyBQxj18WmEzKaFW9-F8nA@mail.gmail.com>
Subject: Re: using tree as attribute source is slow, was Re: Help troubleshoot
 performance regression cloning with depth: git 2.44 vs git 2.42
To: Jeff King <peff@peff.net>
Cc: John Cai <johncai86@gmail.com>, Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 1, 2024 at 3:00=E2=80=AFPM Jeff King <peff@peff.net> wrote:
> Oof. I was able to reproduce this regression, and the impact can be
> pretty severe. You can reproduce it without NFS and without shallow
> clones. Get a bare clone of something big like the kernel:

Wow, that was really fast! I spent quite some time narrowing down and
still was far off. I hope to develop such deep insights and
understanding of git code some day. Thank you very much for sharing
all the details and giving me leads to further explore.

-dhruva
