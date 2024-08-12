Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4785317C7CB
	for <git@vger.kernel.org>; Mon, 12 Aug 2024 15:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723475438; cv=none; b=tfsY7iyEtrKI9oCZfuNRzkY/D048uG0s/kR0YQa1FGqvTGClgisTNKfZOa1BdY0D0eUMhIoW3wWaDb175HUG19mgOL6c318ezp6D9d3n7AOhOIdcJaLkikmKIXJ9iHegAiyIp+qqzoLH84if+PLe1nu/JxPkAfv/ih1cBvHims4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723475438; c=relaxed/simple;
	bh=Ft8UxG7okiS1MwB0DHr3Ykp588F6im08DYk/hGQFTes=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=LYy5cz1o3InoiqD2upm1i6/g68ogCR0GL+HqN/dBLGJiF9qngU29FFqQpZaBcrTxhvpNKgbQJWk+51UmvmH3AcNOdE8HSgy0FdBzNI37txNd4kJ2PrhbTo2C9HHEG5qEOuPhU+8kcMGz53qw2G7YtEmt9OrbROyAwcgAL5eyfXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jf0FQvAV; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jf0FQvAV"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a7aabb71bb2so465715366b.2
        for <git@vger.kernel.org>; Mon, 12 Aug 2024 08:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723475435; x=1724080235; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NaCsg7p6Qv1kCHtTaON2GPeoVW5Qeam3uxyQyQsDK+M=;
        b=jf0FQvAVCzZzrlKwv5SIAr3tDC+6CPvM1NS3gtucE9ML8crN7mu7jF5SgkfjnsFEbI
         OajiBCNXIQ9H2CmUnglQju6nzJk6s9s+R8g/OKvXo/OyfBGg/ypmkGlzf95SaRUeBVdi
         u6JkCmeoap3nihK6IS5iz/ZW0xJJk+oJjFFlLSxaFoW0OIVY7NZvWpoQ6+/d58Z9wjli
         deal/j9dAm/HgFZDhofOj1LsfUqXwDZI6XSbQnEEgB+C1MRInFzLbuSBdqJiRgbcin9M
         vx3NO9QbFW5amXPI2q+sQEqy4zmCyzX2ju0liU3vWvjq2Q3eYNlcYM2Hnt99j8ZrAmh0
         +P4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723475435; x=1724080235;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NaCsg7p6Qv1kCHtTaON2GPeoVW5Qeam3uxyQyQsDK+M=;
        b=srifXZQO2euZxvG6InhH2w0LAWyHKbv9Rqm6v451FL8H6Sk+QGtv0Nxo61Nx1vMvlC
         EAjiMF3wUvCUNQbPuOdwbGfNrZNrviiX8u1BGcwwEle6KtBWBg02vr4s40lJjNkcR2K0
         QcspcLiHa5i3yELcVw9lKoVK6R/2V2lVSnL6gsG5InsVLMFejQIaQnwmFYoFUEmJEEnD
         MmEJ00vF0uXD+BnwFnqUYnOxhY7cs6YcI9anXQEsBbSjLn9SXoyeB+rb2tlBTxa5bgzV
         w2/aWVDi2wExN/vtIZQC66TnHa2QTYf7wkZh+dAMjjgEHmT3gosOPCoXx/+fH8Lc9gZd
         YDmg==
X-Gm-Message-State: AOJu0Yy4dVP3gPQ0hEnOhvMUiYiNBTeYd4+VzLgklnfcRC82mut9IgFm
	mDosr76DBKUAdy4/fKrfom6yBCsAVow7poJsB2Uc5Phs40Vc1+20kSRNfqAZpfTef+f80DErIIM
	hFAsNZjDHzFU1z/HhHFNrZxCzULmVlvO0
X-Google-Smtp-Source: AGHT+IHOuJm0Oi+HOz3JfPYK8B3zQlsRddpXvFH7m0y2yatMfBw1Cqy+cBrLl/mINyPyiHel4PkPPrVWxz1XqWY+oXk=
X-Received: by 2002:a17:906:bc1c:b0:a7d:ea36:b294 with SMTP id
 a640c23a62f3a-a80ed1c1ec3mr44021466b.26.1723475435072; Mon, 12 Aug 2024
 08:10:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Mike Castle <dalgoda@gmail.com>
Date: Mon, 12 Aug 2024 08:10:23 -0700
Message-ID: <CA+t9iMyT8fAR_fvQXOer=ivLnNKDnH8g_M8iQiq7gdrnfG7aCg@mail.gmail.com>
Subject: Heads up: GMail regularly marking list messages as spam
To: git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

If you read the list via GMail, you may want to regularly check your
Spam label for messages from the git list.

I'm not sure what's up with that.  A handful of real spam had made it
through vger, but GMail seems to be hitting a fair number of false
positives lately.

Sometimes it is just one message in a patch set.  Others, it is whole
sets of patches.  I didn't check to see if there was anything in
common across the messages.  Maybe if anyone has a large batch, they
can check?

It would be interesting to see if this affects domain specific users
as well (e.g., Google itself).

Cheers,
mrc
