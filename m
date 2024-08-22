Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF0C11514E4
	for <git@vger.kernel.org>; Thu, 22 Aug 2024 21:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724363872; cv=none; b=OjvIMMb6uiDqlrXjA5/YtXatDP5Pdb1vjn6q9vUX17gKX2Wpi3mFqOzRNMIG7u3vavd0tBXQwlu9hvUGGxDD8KhsE1BDJRp0CvQwksHW5rk0hCOYTNWe+SRIXe09VANeze8Okstxro5TRHiSGJdplRHwZ8RlJ3oA84JExiihV9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724363872; c=relaxed/simple;
	bh=tJDPKMFjupJDd7jhQXUJOYVXADSVKz7hmQfrPZKJdHY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HgB0DSqQ8/X7+WNp3z0eEwsx45HwtyU9YACotafCOizISwFj4qSVbuxFleiTjdwjJcorJtBP9ngo13VlJpAvoDkzf9kQiDHMxwoiyKmRkNCx14NVRfxCBWv8vrg7Baweo0r5TxFY6pnoErKXQtcVltfdGcTWqBxvK5YgK/jU1RY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--steadmon.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=udv08FMS; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--steadmon.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="udv08FMS"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6b052c5939cso14628857b3.1
        for <git@vger.kernel.org>; Thu, 22 Aug 2024 14:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724363870; x=1724968670; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=06MCh5YdIx6uO0G5ToJUmaQXC/JPeovs/YwbFBmN/9U=;
        b=udv08FMSnTUDlBfntINlGI3kG1gQ3cpzan6Fc4RAkTq4QyblSBYXkf1HC9gUYZjFnH
         61bE7x1ZWeXdyH4BiXdT3jTsLo6ljyIA8ilhPNSpv6P7m8zMi0a+lMWT9nM8DNu0X5B7
         Ws+WTsmNFzypn3Io6Cz71cALTrRpM3VdhPG5lLbu2lLVRjbJEbq9KmHLJZ6CU8wSaTti
         daWhyy9YTO9WkYf+ipdjwAYbbNZMOzHgmfMZUjKTrz/ZhJxCLr9qvmVe6Su1jg9emmdi
         G1lxaqEzQ0eWnTmzHhEcBpI9QkPL39tmKSd3uXQQgCAvPA7cVAiX29miXw8aDrzqhaTD
         B0sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724363870; x=1724968670;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=06MCh5YdIx6uO0G5ToJUmaQXC/JPeovs/YwbFBmN/9U=;
        b=KlNA2Xb/uFGtan11LMEiQ+ai6ro2sdMEqAKXGe56+iUZ5X1q3FQ1RyMaQIp9P7z0Hm
         8de4fcrtoWOhxlM9A8BZn720V7HijRx7MPcFDH5KpfI+cJ/m0s4d1JJeS5eu+DE7ypTx
         f0O0jC7H6wA46UQJPZUZsE33T1Fe40s2p8lpiTQblixTyi1zCh4MfVpkG2R1ALBciKDj
         HOyUvYBmkZehj7StvT8Sqn1QGfzdXMPrqo99o6uYeUUkoBJS9byvBGzuEu2sJQ0cJ/GU
         20D8hI22cC7Bqux/Jal01DUSQQm+3M7XL3zKRcMo04UDapkxC1ub4UmjXinNixeb18IX
         3WVQ==
X-Gm-Message-State: AOJu0YwWtt1kRbGOr0AHQTIndcZHWGRcdNkXu4CpsWe368L+YCNhLbOe
	b3AcE/6mzPXTc8LKWn/8SzZAfVrRjsR0Y9XaMuzfn+kxs6j+oat150+iO0RYsv82FFrc9QfQ8km
	cNqF3fnxH8iNnlR6vWYjVnGqcwK2JZD/0dXriDCFpC3Z+tm9rRXjLQ02t/qx4qa2d8RgIS4o7GM
	6SBnLY5ptSMztx4HmykSQxf+XbtOwjLvO/r4AwEfo=
X-Google-Smtp-Source: AGHT+IHZVY/vZf1IMGuaIATIttxEcHhSEvNGMorWYZzd2gaWpPf7CI8LrDWxzja4mi5CopkvPGPwkvXjzZxLYw==
X-Received: from lunarfall.svl.corp.google.com ([2620:15c:2d3:204:9ba9:7ac3:74ce:2b8f])
 (user=steadmon job=sendgmr) by 2002:a81:f008:0:b0:68e:8de6:617c with SMTP id
 00721157ae682-6c60490d9demr230167b3.5.1724363869615; Thu, 22 Aug 2024
 14:57:49 -0700 (PDT)
Date: Thu, 22 Aug 2024 14:57:44 -0700
In-Reply-To: <cover.1723747832.git.steadmon@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1723747832.git.steadmon@google.com>
X-Mailer: git-send-email 2.46.0.295.g3b9ea8a38a-goog
Message-ID: <cover.1724363615.git.steadmon@google.com>
Subject: [PATCH v2 0/3] Add additional trace2 regions for fetch and push
From: Josh Steadmon <steadmon@google.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"

Last year at $DAYJOB we were having issues with slow
fetches/pulls/pushes. We added some additional trace2 regions which
helped us narrow down the issue to some server-side negotiation
problems. We've been carrying these patches downstream ever since, but
they might be useful to others as well.

Changes in V2:

* Added a new patch to implement trace2_printf() for event targets.

* Move some fetch trace regions deeper in the call stack to simplify
  control flow.

* Move some push trace regions deeper in the call stack to target the
  actual slow functions, and to not tie tracing to whether or not
  sideband communication is used.


Calvin Wan (1):
  send-pack: add new tracing regions for push

Josh Steadmon (2):
  trace2: implement trace2_printf() for event target
  fetch: add top-level trace2 regions

 Documentation/technical/api-trace2.txt | 17 +++++++++++++++--
 builtin/fetch.c                        | 16 +++++++++++++++-
 bundle-uri.c                           |  4 ++++
 send-pack.c                            | 16 +++++++++++++---
 trace2/tr2_tgt_event.c                 | 22 ++++++++++++++++++++--
 5 files changed, 67 insertions(+), 8 deletions(-)

base-commit: 25673b1c476756ec0587fb0596ab3c22b96dc52a
-- 
2.46.0.295.g3b9ea8a38a-goog

