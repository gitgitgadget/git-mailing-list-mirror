Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16A98192D63
	for <git@vger.kernel.org>; Wed, 29 Jan 2025 10:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738147770; cv=none; b=Pp8ojE/nCdwNxPbG+BXlCaIYd7rdBZyAGJ6zeLbuqNFI57njaz2kLurEHZACLe71Q2jqVqPP2WxeIsnlk4PWW6NW9CTUjU/gku477R0yuCLF8cHArUn0MUh4RV1g7N5A0tuIw8HpqHAKv1iDuOx2u6cBEA7TuYZqAUUi1xQghwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738147770; c=relaxed/simple;
	bh=WwQejdpJkjJnbSqAdwiAFo7ijD7bFDDhnSVxXsPVs8g=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=Xdh+lYj/oxPbHB2eDG5XaAB5rQFxvx+X1jT4pXJOXULdgdHJQMSApDBceCc+QyetLig8YfsHqAHTrFAoYVgvgfVYwn9x2khR8JPc+/5PgB2AaQIpmg99mNSBNz/OzfOCm73LyW2Hy9GMQSeG4MpnLoX/pa9NV22Hdme9++Tw/TA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lWiKsOoC; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lWiKsOoC"
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3cfeff44d94so7064415ab.0
        for <git@vger.kernel.org>; Wed, 29 Jan 2025 02:49:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738147768; x=1738752568; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WwQejdpJkjJnbSqAdwiAFo7ijD7bFDDhnSVxXsPVs8g=;
        b=lWiKsOoCllNRa7ywkRJxpwLsWf6wsBuF902DESdlP3TA/dNx7goenQlWRSkgZE+HGe
         Cy92v+/+EYb/07FL4g5li2gq0vsiufe0bOqPBgQYL3V/EhvCkB7bQMbriF9Qwa/K7uRC
         r8oTx4JLBxRmWmzinFeXbG0zzAcpvUZAthG6v3OvljeTAq4CEo8qP3PtxmjgaJQ+tS7p
         TwMRRtWPrc382pw8Bh8ZVX+34sWJNzUz4SlWxulJhbk/KxxIjMTl2VmW7BHg2EQpcj71
         s3JR40Wtx4BBEkk6jSQlf0sFKix/kqNuSc49azaw+z6b+JeFS7xvwqAgufEJF1YmfoDY
         eLFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738147768; x=1738752568;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WwQejdpJkjJnbSqAdwiAFo7ijD7bFDDhnSVxXsPVs8g=;
        b=G+loKnBYt/M1eeoKLZxHnA31Hx3bWpn0GdHjiMi6Ne+M+8NvjFNBXBZ7IW4/XgGihi
         YG55iTfqNvirm9IYQ3vkgj1W3981gH/ESH159KS7NchjyEg8m+gMBWikitf5CA35/0Rx
         YsfKI1xfhempKe2+6IOwOBWfXgiyPrZFNuqPdW+j5bAs7wRsKgMmQ/+PvQ7NyKM1hhpb
         yOHZrwLJO6E/INCVsh0EzcMMvzLcb/2Ba9FrE1seOaLoterNiBOITqDdfkmb8lhEL+Z1
         E4Di0m6EFmsN83+agsA653EqXEdvsfwDwA6WTSCu0RtOC6oR5SLivxjym7X9QnFyfzHX
         XpwA==
X-Gm-Message-State: AOJu0Yzfun1gOQaXflOBip66esVqc5x+Hspbjz0K3uHlQYPxacdmI/vO
	0Lh0JZDzBIv2BwQVHXnMlrB5GdY25DKO7HLyNT29z22SfCKF5NVN0o+sX7juqUydB64dkouJyWR
	/8uZz2/Sdkk7UcTnsMkUWxBXvCKJExsfN
X-Gm-Gg: ASbGnctbFYRQDxu8nIOJy1lEJ37D+BuGuif54y4XXI6q9bAbHTDLdWEgRsH6Ul+K79P
	w6o/p5YEtvZ/PndbHJQDTgGHrcCzTl3eI3/cQUUyM7NseQSIyp8Ob3K0IvtW96Mt11LHf9/51HL
	x62eLD/kl8DF2wz8GjCBY4irZYbgYhPizVURadBiKfsg==
X-Google-Smtp-Source: AGHT+IFjIenr6+h1QnoGJ53pMotgvy/KlFRE98HeSv2l24k5v0hnSYuQyL76t1UXdMUe8sybZFQNOU27q9cRsts7lI4=
X-Received: by 2002:a05:6e02:17ca:b0:3ce:6628:3c4 with SMTP id
 e9e14a558f8ab-3cffe3a6c3dmr20434135ab.6.1738147768060; Wed, 29 Jan 2025
 02:49:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Mike Weltevrede <mikeweltevrede@gmail.com>
Date: Wed, 29 Jan 2025 11:49:15 +0100
X-Gm-Features: AWEUYZnzBuUZT0Rt1b2C5xQAatQDhSSx_jlET1fn2Kr9Hq67EvC--yUvv7EpdGs
Message-ID: <CAAE-bwUQ+0ERbvC=SS=-R_K4H3p2su+=Ogf7BSkyq5J4GmmRYw@mail.gmail.com>
Subject: Feature idea: Git hook for pre-checkout
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Good morning,

I had an idea for a feature in Git. I am not sure if this is the
correct channel, but I could not find anything else. If not, could you
please let me know the best way to submit this?

Below, I will explain the idea and then the problem that this would solve.

<The idea>
I have a project that is using Git hooks. Besides pre-commit and
pre-push, I would like to use pre-checkout (rather than the already
available post-checkout). However, it seems like an active choice not
to have pre-checkout given the existing hooks, so I am curious as to
the reason behind this.

<The problem>
I want to do branch name validation when someone does git checkout -b.
If the branch name does not meet the requirements, the user should not
be allowed to checkout to it. As such, the post-checkout hook does not
fully meet my needs. It helps with doing the branch name validation,
but if it fails, the user is still on the feature branch. As such, if
they are ignorant about the error message, this does not stop them. I
am currently combining post-checkout and pre-push but would prefer
pre-checkout because this would prevent the user from doing work on
this feature branch and having to move their work.


I am looking forward to your thoughts. Thank you for your consideration.


Met vriendelijke groet / Kind regards,

Mike Weltevrede
