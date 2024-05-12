Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C43AE56C
	for <git@vger.kernel.org>; Sun, 12 May 2024 06:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715496434; cv=none; b=Pk85TngTTIJ2TJk8zIPgBdPFqEGn87711TzKjMqggl7lhH7krHYtV8pPhBivu+ssh6VZwA4OiOvQ3rsHkuxLuavTtvGwEsViXicJa3CW0ELE7MQ3hh9p4tcWI9PDFOwkWPbe5OAeNXUFzIWojM8nES99hvQinLbfk7xgpGNWmcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715496434; c=relaxed/simple;
	bh=qlyJNTYsgsW38c5SWhauzwUQm7rS0FMtUhS056bPikE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YWgvNu76/vEB/aWRTY/lViiWO3QIfejy0eFj9ivs1EQYvJqLK+FCUxWUMGkJ8BbeY2Qcblgl1zc+i6mpg1O0QypiCna6BEI4t4C/ROHtAdz8V7XPIk7/b8ngExQunt1Akd6wxgAr6HUceLioj76rvJhl0Rj18NZ8FiLPa3Rdjxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gree.net; spf=pass smtp.mailfrom=gree.net; dkim=pass (2048-bit key) header.d=gree-net.20230601.gappssmtp.com header.i=@gree-net.20230601.gappssmtp.com header.b=R7PIF9AZ; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gree.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gree.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gree-net.20230601.gappssmtp.com header.i=@gree-net.20230601.gappssmtp.com header.b="R7PIF9AZ"
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-de8b683f76cso3340308276.1
        for <git@vger.kernel.org>; Sat, 11 May 2024 23:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gree-net.20230601.gappssmtp.com; s=20230601; t=1715496432; x=1716101232; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qlyJNTYsgsW38c5SWhauzwUQm7rS0FMtUhS056bPikE=;
        b=R7PIF9AZ+QAM5jX6wSVwxgag4huRqYYajOy0PIW8B0k4aZYGUAZ09wr6C5yBUVp1KA
         x+N1j31CS7fuZtw2uEkL5UdZ0zT1bEZOoYUlUtbrWqzyWPaiYzKxhagkF6JHrrUazPSp
         qFwpS8e94paWP1zv7siRvb8W9w42zQzv70yG+Afa7VJWbOybzXvXCJAv89qrEVO6Ejzp
         LcDOEk7uyn1etNTwT8QkUZhhIJahxPLkZ3JMg/wLlfD80pDVqVDNpHsZ4ixL4RmmRbdd
         +i3fMOYR7TApK41B/9mW9N/RbRrKn82OqKyJSQzqzyaT31aPKmI6Znzp1pmW8SQt3J/x
         EBAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715496432; x=1716101232;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qlyJNTYsgsW38c5SWhauzwUQm7rS0FMtUhS056bPikE=;
        b=uUkSi7VjMAfRehGMTjZeBQb+rvFyRqrCqfrI+XgjRboq64CXXY/SibwuaNBnXxAqD7
         QUSZ9k27NZymNNlo0wEEp3gK37IDrl9aMbi5mq3FnrhP8di+Azels8BJhPi5849jY3xZ
         GyXmpKsP6aSI6vWGmLFr4Xha6OY1NkVkwkUtTeUYDvPMj0BwUSyupL8VXBwvewUICdew
         5mNIk/+XiYrRo62xA+aPJYq0oJ/YHiAis3Ac/Jo5T8WNSYtpzr897KTFSbfmlTSrBsAa
         RwkSRZn8g7KeHtz1YNASUbN/ADZBC7g36wrPA8cjPSXGxLwEsNehqkaLQYty3WjITA99
         g0dQ==
X-Forwarded-Encrypted: i=1; AJvYcCVjzZzAFJrnSXfYv/rtBmQIuyoHMAMyA6k70Q+cCWE1kCdSiX2a3e6T8XzlvxWn5DlO/5iifH1KZMheHYtD5rkjqoUJ
X-Gm-Message-State: AOJu0YwJNZD0wtPeuaIF/tjPmFU7VK4nikOQw1nmKdk4nSsjP+ASG9no
	p9HMRNRCrk+XAClhvF53PJH/S5U4Ghb7sj4YoRDkO2vqHS1A4Qi5A/zHZ6eeEUaWRMJFA3alAXy
	xZaglkoyqPEOKvVWIpBR4s33dgq4zLhJsR7XHSY6/Z8BEcBcNUuAFgVsAlO4c+8G9fJ/WLTml6B
	sDLPmr7YhAD9GJANxm/6MhguWWiKodcUPhaaO8NYD7O5wbn+/2foYKH+4AsjK+1ZCl9WMUOJo7q
	w/5YNgXT1QtwJGWWD/98/dJI+j1HZNJi+b8i1p00o7hH0kD2icBB5Lat+jf+1pNGFZ6rD9kiG5Z
	5AZef8n5hQddSqGqmibLLzXKM30=
X-Google-Smtp-Source: AGHT+IEY5rDliUy9mrTYx+mpUMAI3bIXei9QxFMqT8eIOlE3XWcHOBu7gijkm6R5+b4mao/BVcj/4Cu5GEkQnJJ/niM=
X-Received: by 2002:a25:ef0c:0:b0:dc6:e1ed:bd1c with SMTP id
 3f1490d57ef6-debcfc10c11mr7094949276.21.1715496431948; Sat, 11 May 2024
 23:47:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1729.git.1715328467099.gitgitgadget@gmail.com>
 <pull.1729.v2.git.1715428542.gitgitgadget@gmail.com> <309c17c78f35296dd47e8b203413860eb62b239e.1715428542.git.gitgitgadget@gmail.com>
 <xmqqseynisc9.fsf@gitster.g>
In-Reply-To: <xmqqseynisc9.fsf@gitster.g>
From: Koji Nakamaru <koji.nakamaru@gree.net>
Date: Sun, 12 May 2024 15:47:01 +0900
Message-ID: <CAOTNsDwMJigjZKZh74pB_TUdt=LYXO1=2RWEW0KS=_s19Y=8MQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] osxkeychain: lock for exclusive execution
To: Junio C Hamano <gitster@pobox.com>
Cc: Koji Nakamaru via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Bo Anderson <mail@boanderson.me>, Jeff King <peff@peff.net>, 
	"brian m. carlson" <sandals@crustytoothpaste.net>
Content-Type: text/plain; charset="UTF-8"

Thank you for the instruction about a log message. I'll follow it.

> Is this step still needed, though?

For solving the issue I originally had, just utilizing state[] to skip
"store" operations is enough.

Since the osxkeychain implementation doesn't seem to be aware that it
can run in parallel, I thought it would be better to leave this step in
case a similar problem occurs. If this reason is weak, I'll remove this
step.

Koji Nakamaru
