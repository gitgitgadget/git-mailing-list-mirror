Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E7E222577E
	for <git@vger.kernel.org>; Fri, 14 Feb 2025 08:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739521488; cv=none; b=L43hbyYxib30Bt1dtwfzRYif3rc9Ygc43QSa40WGdhVmOjt9iU7aaLhacCYouXpx88gBEiIpcT3s8clDmnop5eNaEAMHB1RhGliXjlhMq2l2AKNuWI0tnnsPxb10VoA3ZPNw6AtgwOvxuEdSWckH+/N/fDe5OMnS3CowHcgY8JM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739521488; c=relaxed/simple;
	bh=wqly4YaJPRoWXxmThOE+33eTaPvCoNLFWtluqUNWvBI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P3CnvuIYThiKkY0cfi5xl3iHWxnty7n1wSEGUJ/IROVXhGIp/y+yZ2WfdZlZJFZn1ldn+Y0peUx6NqZHb7RWplMD8HSatPjeEjdK1NXcLCrL0pHh/HcQ9fZq6g68+8vJJiJQcVwV04DZagE2M/h9RBeIonj3fAasUZLG/L95CmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cLlxFwLr; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cLlxFwLr"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-54505191cdcso1763096e87.2
        for <git@vger.kernel.org>; Fri, 14 Feb 2025 00:24:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739521484; x=1740126284; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K8nX4zN3KhHBeTgznS1BmFgn4oP88BRMfLpEmC0uQKM=;
        b=cLlxFwLrePadq0Al0Z+q8WtayYa1w/3C1ZcyfCxKOc6YP/BTXlHVfSXnWFXN5bhVaF
         0dR1YvxuZ0+j2cESq7eug7CAp19Qj1pjNCYq5u1LwY0kro1jwkB+cdJdZQ9R/6VTBGwE
         FCDnzTZHdQhQVfcB874LeIvoeiYFbECKoXiANyc30b2SHA3G0P3NyWJ3GKzKYiH7Px0+
         gIgG0qL9JztuGjQftyZt/5C8jSaHEhtAIakTPjrjt9ZfVZ/A1MshOb+EVpGmt3pUlDyj
         ZD4Fr7a0CC9R8rsbJ1xfjcv33artCedmycxdbW/ErywfECXC1FylMJvIWvH1vjpMUk3R
         qwVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739521484; x=1740126284;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K8nX4zN3KhHBeTgznS1BmFgn4oP88BRMfLpEmC0uQKM=;
        b=W0TjvJ5ZD0iVaV0o4YgfbcUum6C9NEVF5/fgcg9OXDO/SgnA1rstWCCmnYriql9HpQ
         +H20Qs5uTgamK4ttRO/6g3DGHbG2uxefF/oKhwLkHrLrB8OD3CkZ/4IEoK7VX4bfilER
         2vEXF3K6KJGZyRY0qXAV5EZ87FJD32j53PISdxaMBtzFUtZE6kZsVAF5TL48W/6lzOA5
         s018nKovSZ2QPu48ae/KgwFKhn5/D/iT07/hBwVowo1yh0wY1RbvPyJpLb0fgWmpoZ5o
         UzBJ0WuyOPvwff9q6w3t2i2daLu+BltaIrwXfiyj0vj/0MH/pRajzCroUenlEynKU/XF
         lHSA==
X-Gm-Message-State: AOJu0Yw9c8W+X+7H2ckeIUT1wkTw1pMMSQNZXBmXKhhnoHxp7x8Uw31p
	aYuyCNcGlhLQkaGxO4e29QNlXN9ywQ2geXEy0NV7hM4AFAheVCE7qarHB5VmL4r4M9e0eEy24JZ
	ghh6IXpuh4dt3LGHiLL56bQMtF+w=
X-Gm-Gg: ASbGncvEaxbCz8v3aOsVtcFrPu2PR1cVGauGvjzh/9Cda8vkcS7/3rg8Q0vj/DRXj0W
	HbH0eLkWJdGgVqVEW6QSAzFPjDTzWnwa+g8tvYzRmIHRM/RtpS8YozNbXajmDl4Obxu3Zt1ztiI
	c=
X-Google-Smtp-Source: AGHT+IH/3/GiZ9twqqHYIWsQYGZNNiRPQ+iOb8LZ0cilyzzzOn6JDNT+uNKoEeag8H9+sJ9oeOE8Md6Y1Imm3N7zFDo=
X-Received: by 2002:ac2:58cb:0:b0:545:a89:4dce with SMTP id
 2adb3069b0e04-5451ddd9e5fmr1824734e87.45.1739521484053; Fri, 14 Feb 2025
 00:24:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250211194334.20710-1-meetsoni3017@gmail.com>
 <20250213090040.16133-1-meetsoni3017@gmail.com> <20250213090040.16133-3-meetsoni3017@gmail.com>
 <CABPp-BGqihkPq3o4jnqp2aGdqw12F8a8nOModuAB-5N7BQ1t0w@mail.gmail.com>
 <CAPhwyn0hz16mZ-UoVAczC4qDLx2i0LwfFhhDjdTahe0=4TO57g@mail.gmail.com> <CABPp-BGq-x9Z98scXRtEnqz7BCmPn9ONHd6wDnnm9jL4YeDHxQ@mail.gmail.com>
In-Reply-To: <CABPp-BGq-x9Z98scXRtEnqz7BCmPn9ONHd6wDnnm9jL4YeDHxQ@mail.gmail.com>
From: Meet Soni <meetsoni3017@gmail.com>
Date: Fri, 14 Feb 2025 13:54:32 +0530
X-Gm-Features: AWEUYZl3Lj7jfgrIJA4h3A2IZmxyptaLljjsYk5l2_q_qcnOSvXm1xoqCfhBlpw
Message-ID: <CAPhwyn1oXRy5BFQBvuFsmhfVhkW8+D6Xz6OYB8LpP0O+jH1TFQ@mail.gmail.com>
Subject: Re: [RFC PATCH 2/2] merge-recursive: optimize time complexity for get_unmerged
To: Elijah Newren <newren@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 14 Feb 2025 at 11:35, Elijah Newren <newren@gmail.com> wrote:
>
> > > Did you run any tests?  I'm not sure you maintained correctness here.
> >
> > I didn't run any tests -- I wanted to, but I wasn=E2=80=99t sure how to=
 do it
> > for this change. Since you suggested dropping this patch from the
> > series, I=E2=80=99ll do that. But for similar changes in the future, ho=
w should I go
> > about testing them?
>
> As per Documentation/CodingGuidelines: "After any code change, make
> sure that the entire test suite passes."  You can do that by running:
>     cd t && make
> (You probably want to also run that before making any changes, just to
> verify that they all pass for you.  Then, if any test fails after you
> make changes, you know it's because of your changes rather than
> because you missed something in building or setting up the tests.)
>
>
> And although it doesn't matter since we're dropping this patch, the
> issue I noticed was that if there were, say, three unmerged entries
> with the same path, the original code would create one entry in the
> string list and modify it 3 times (each with a different ce_stage(ce).
> Your modification would create three different entries (each with only
> information from one stage) and drop two of them, meaning we no longer
> have a single string_list_item that contains information from all 3
> unmerged entries for the same path.  I'm pretty sure running the
> existing tests would catch that kind of bug, which is what raised the
> question.

That's the thing -- I did run make in the t/ directory, and it passed. I wa=
s
just wondering if there's any other way to test this in isolation, in case
I want to verify such changes more directly in the future.

Thanks for the clarification!
Meet
