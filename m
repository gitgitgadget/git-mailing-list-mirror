Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC23610FD
	for <git@vger.kernel.org>; Sat, 21 Feb 2026 14:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771682474; cv=none; b=ZkIPAYeBdAuTvWxBCQsgvlOpnwj4jxLnlfqQWHcgNtTMg3haZxRjFsnXyKgYbjgOvDorvhqFvWRjzm8TVBGhyMKXI4G13UmWQpi3Wre2NBCKDTtNxGv8huHv6Gi9OTvKonVdpjxl15FnQNJnltcKlV5G1jL2Zim0VKQm8PGSUHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771682474; c=relaxed/simple;
	bh=TGq6R55nIlhs5cSjSrhWdfa+iOG7y1qecFjVQiXbEE0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QO14C15Q3xIFc75/AvZK1H36qb1Xty0sbUQ+5C77ytN0oDuf2YnV9E6Fv/+bxdDHmxgO5acp7HlNHwKvspYFB3/LklPn1N57Ec1gj1K/izoT6JwLSIw0PqODudejrzQLc38RG9yhP7kln9jnXHiBtXH9IfHsznqcO5Vk1uph35k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FimThN0j; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FimThN0j"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-c5513f598c0so1089485a12.0
        for <git@vger.kernel.org>; Sat, 21 Feb 2026 06:01:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771682473; x=1772287273; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zv7vbtGC9oCHoIZCKU0eLgNixaaSBKoyxUCg62pAYS4=;
        b=FimThN0j7rC93AaHXEoCGxiTGScd7zMd4uYh5o5WEyAk9LT/zUQyEyQQGM0br3W/+B
         /vObgpXA3PYr/fp166TMUMRz9SYXLHgANusr3A8SKdYlHVYVhbKsl+7/QIee1LiUI+6/
         8FeSiL/+heSm4UBj1wrx1qR6y0RbA0o5ldslY70e/1NlScFXNAdWs3SjDkJmzfQevqeh
         Cg7HXk6aV1SkTbleXoUKcsr2fkZBrINezPjCpu3+/p+RtlOtNfnRmz0dbP1qcbQc/UoG
         qPRik4vTp772CzjyFW8bw7eplUi50YCzyjWPRurI64N2ZXFj7jztFRILQy9ObOKfCk0u
         G0Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771682473; x=1772287273;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zv7vbtGC9oCHoIZCKU0eLgNixaaSBKoyxUCg62pAYS4=;
        b=BlLgpMNmXwOZ53VtXte/G/jUWeCG2Tyqnlwf27GyOrNQMqwmzILDtHCBjuX9BjiU2q
         ijhNrr2634mhCGJHfh2xCe9aONqxSce2HRXBnNni7sdcJExViBtQUsdu0sdpbyRnyrpV
         P9OZoj2uq7QVfKXIAk0kKS2d3AGCqi2EaI5MPJk2bA24dgVNNae0+HMokIEugHKm32Yv
         DqA7FZIw05Wy0F/oY3CAX5QXF8/KWBowytWL7JpIJS+dU3dxqYhKxd38eTRAoK/+ZLZ9
         4avcyrKJiYJ+5ZetvZbZJPnvr9baeE5JS8erqzc5xncbwaHCbnQw2bnqBdL+7n3rqibb
         lVkA==
X-Gm-Message-State: AOJu0YyEvio820E65FGYkIu9zZh9FGi3DqyRFOQuVnChKndwzocxkupl
	V2jP7YpqfzSl5JyKietnJRkEV6wm5KssZ5E439eqNx0jqxUEDPB05WL/fJv/Qw==
X-Gm-Gg: AZuq6aJcRPJpIImbbtDWDXWTFP/YSdlUWnxFxTDGKCRwS9RlqIXapRn22AKdxFG73aj
	qHSOGPi/eOxJzwewUNEXT/5VLBM8EDpGKWIjBDisZrWDwA7nO3sWxh/1jGvIgk1B6lyEUj3n/Kh
	cr+AxtPnLQ/B+vH9yukpYKUTgzrcQXC69ohc1IKJNKQyc+r5btOq+gDANui9J10ZBgofbrVfmFS
	cB8f9W+rl7K58sGn8VDYs7uHlLeELErw6Nj4mYSjj+YomEiqTud5PudHD9joCo79k49mtqeZ1Pk
	6mDWjJqLcS276ulfXW96ZxUp7ypfMMCGjbKVLcwZ5FsEkx8XCRq366u8ofqBJ8rP6IEh3yFm0Z8
	UzLo59eI/nWThZ/O4f/lT1kRnp1XMRNT6hFd7V7gXk08eG3uen/mvKhHRPbdc4hYe2icxSmt5xA
	dRLLYpvPsUGYBAAydeJs/SnZQGU9yncN3XgEOoKw0MeWvdieO+4fWfSrTSzw==
X-Received: by 2002:a05:6a21:3388:b0:38e:883f:694d with SMTP id adf61e73a8af0-39545e92dffmr2924753637.24.1771682472908;
        Sat, 21 Feb 2026 06:01:12 -0800 (PST)
Received: from Shreyansh-PC.domain.name ([2401:4900:1cd6:375b:d1e2:bbf3:143f:3d5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-826dd8ba11bsm2419241b3a.50.2026.02.21.06.01.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Feb 2026 06:01:12 -0800 (PST)
From: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
To: git@vger.kernel.org
Cc: ben.knoble@gmail.com,
	gitster@pobox.com,
	Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
Subject: Re: [RFC] send-email: UTF-8 encoding in subject line
Date: Sat, 21 Feb 2026 19:08:39 +0530
Message-ID: <20260221140049.579922-1-shreyanshpaliwalcmsmn@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <5EDD26EE-51B6-4BE2-A7C7-E1E0991537E4@gmail.com>
References: <5EDD26EE-51B6-4BE2-A7C7-E1E0991537E4@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

> > Hi,
> >
> > While using git send-email I ran into some confusion around the prompt that
> > appears when any 8-bit (non-ASCII) content is detected.
> >
> > When prompted with,
> >
> >  Which 8bit encoding should I declare [UTF-8]? y
> >  Are you sure you want to use <y> [y/N]? y
>
> Yeah, that was a bit confusing for me until I got used to it. Maybe
> saying “[default: UTF-8]” would be a small and definite improvement?

That makes sense, I tried it below.
I also wondered whether, in addition to this, it might be helpful to warn on
an invalid charset, and/or possibly fall back to UTF-8.

Let me know what you think.

Signed-off-by: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
---
 git-send-email.perl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index cd4b316ddc..12d0e7e6c9 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -1044,7 +1044,7 @@ sub file_declares_8bit_cte {
 	foreach my $f (sort keys %broken_encoding) {
 		print "    $f\n";
 	}
-	$auto_8bit_encoding = ask(__("Which 8bit encoding should I declare [UTF-8]? "),
+	$auto_8bit_encoding = ask(__("Which 8bit encoding should I declare [default: UTF-8]? "),
 				  valid_re => qr/.{4}/, confirm_only => 1,
 				  default => "UTF-8");
 }
--
2.53.0

