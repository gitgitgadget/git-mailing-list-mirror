Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBE6BEADA
	for <git@vger.kernel.org>; Mon, 23 Sep 2024 10:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727087176; cv=none; b=U+t0rw2J87sQtQcQupWgrQl8RaDynzSZWzM2+gRnlJWwY4jhvuwCMq+aPt28Y7deNENXs1Xi132QZYzkVjJnthmFxjaSBehg1LAWQ9bTHZsMo8DQuLU2wzcrcWtZi2w4szo86+jjR3r3w1zx7TdK+7T1kLyBwUHjX+yieNMxcO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727087176; c=relaxed/simple;
	bh=Z7qPShFdKx39DaPitJyDFCwjaKfhNH3Sbi796GHonSc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ksqlrHLRzEWHtnVAXDcLFSgQaQwnpxclC5k5JoTvwYp8QvGq6WD+KgZMy5prjZw0H9qRM8v5uEosuaGNl6cISajAldwH/jMY40lw3MwU6CpNLPMZDjnOqfbtOvuyrr1HllIVROC11+lo8tFW5785e5v1A/HJQfdktm/lUeHXgRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dDngPfdH; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dDngPfdH"
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-277df202ca9so1914226fac.0
        for <git@vger.kernel.org>; Mon, 23 Sep 2024 03:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727087174; x=1727691974; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z7qPShFdKx39DaPitJyDFCwjaKfhNH3Sbi796GHonSc=;
        b=dDngPfdHc3Omyi9DibGSYHBHyZhWr+TA7C6/44eUeaA6oENLJ0r4Jmpi0j4DuYOr3J
         ZMbI4m63D3AtGX/qNNZMzeTI3wnXSPl2QSHlD3ARAxrG0ypZbErkgFF3MfxD8UpYQZgH
         8LmqSeSqXnvP3zvLyPHahALzPdGfe5zBPDuYyGMmO5dLFsiwyrTJJylbUT37MvbwGPs3
         Kk4R7D8go5VTl6k8y+nu54dHktfiUsmUuITTF9qZA4Wc880PC7J33LqRV4rhGWBksfyl
         D5XnmmS5mWF472ovgb2ovU/2SukZXdt9NWETwwLbETOH/Gv8254Jf5bZNnSJkFhFJva2
         3vtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727087174; x=1727691974;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z7qPShFdKx39DaPitJyDFCwjaKfhNH3Sbi796GHonSc=;
        b=fveBLQcF1S3adT9Ssmc8yg7BET4z9vuCHZNdrbXNnAy7y4ZSt8gCTydcwpIoL32Ord
         b3TRDhLturNn+a6zJ6g71/CHZXOMhjlILxWp++KO8am7ZOIxaHXhH25mAajbqX2SlYlW
         DJX69rA36xRtm22Ff0JHfBCVexSeMcFV4hni5sYxgwVUfWvuDLLe4+p5B8LjjqYSl1NY
         aBEH3avPsTMy56x/5lwwUY9xllmJAtcVFIZHJKVj+v18TCadVRLu1RqmBadIMKtd2D1X
         bm7hE0anXvw53mmRi5n5H557gt3SvEQ4Y4nMCqDhoGjmjQWMUZRfJg42P8FBkq48DB1A
         0wGQ==
X-Gm-Message-State: AOJu0Yz3rnvTH9kCR1KL1VbXkq3nhoGHsxiLAzbYC2wqNfaXbeFYSN4F
	U4lPXyYQcOE3a5RtS4WSj65sYfFJZdZ2mveysVQu/YwJ8jTUhO6bkSBtDXNxb3wWqSrP6ykMGlS
	a36GSkrVPhyFB4i3L/dWpyhc3JhnIqjW2W5Q=
X-Google-Smtp-Source: AGHT+IGDMRQaVOzgu1ewz1OXplMD9gk7Ar9Ko5aiTy3zQPJAqx/KYiRCuZ1Df6Br5laT7aWNRSjuUp4MGQUrZyAvRpM=
X-Received: by 2002:a05:6871:7a9:b0:27c:52a1:f311 with SMTP id
 586e51a60fabf-2803d18d466mr6580965fac.42.1727087173814; Mon, 23 Sep 2024
 03:26:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAN477tHJnVnOKfUsG5G9QAVdzYvmUuC8A8Vxt8mtHB23fd=hAQ@mail.gmail.com>
 <cce1d054-911e-407e-bc26-1c0bac4dd8e4@gmail.com>
In-Reply-To: <cce1d054-911e-407e-bc26-1c0bac4dd8e4@gmail.com>
From: =?UTF-8?B?5YiY6ZKf5Y2a?= <liuzhongbo.gg@gmail.com>
Date: Mon, 23 Sep 2024 18:26:02 +0800
Message-ID: <CAN477tFqDM64NsoXYKww7Xh7rNajMGn0DK062AjxDOmp+_7Lig@mail.gmail.com>
Subject: Re: The maintenance tasks will never run if maintenance.lock is
 accidentally not deleted
To: Derrick Stolee <stolee@gmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thank you for your response.
On Thu, Sep 19, 2024 at 8:56=E2=80=AFPM Derrick Stolee <stolee@gmail.com> w=
rote:
> At least, I haven't been able to find a reason why Git would be
> failing with something like a segfault which would also cause leftover
> .lock files.
Yes, it is not necessarily a problem caused by git failure. I think it
is a natural
shortcoming of file existence lock, which cannot guarantee that the lock wi=
ll be
released when the process exits abnormally.

> I can speak from experience of previously having a lock timeout
> that this could cause problems where maintenance processes start
> running on the same repo concurrently.
> [1] https://github.com/microsoft/git/pull/598
I read your commit and explored more. Perhaps the file locks provided by th=
e
systems are a better choice, such as fcntl() on POSIX and LockFileEx()
on Windows.
They can be automatically released when the process exits abnormally.
If there are
no objections, I'll give it a try and send a patch in a few days.

Thanks
Liuzhongbo
