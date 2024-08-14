Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0AC81BD508
	for <git@vger.kernel.org>; Wed, 14 Aug 2024 19:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723663803; cv=none; b=KNlsJRgIeBjfTJbaVI9QZE63s3Ux7MVfQHFKAIadF2Ol9HZUzugOH+ttJHY+DjwVv9/lzWJhO5OlOYmEA7IXCYY3DB7japRIQkPOXg2pZEoXceYh6if4zKYTa9I7oF10KCYnOFDAhobApdJrz0U0Loh0INQf7Wm0uaw99dXka7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723663803; c=relaxed/simple;
	bh=IlzuH0QJcEuhV0tvfQujEoxN3QYUezxFsl0tZ/hfUVc=;
	h=Date:In-Reply-To:Mime-Version:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=urvp55x8Rxw9A4aS1GETSHG/IotiJvefClQcXzMSVNTs2QEWWePjZECsKyhvAfM+Z1DD3rzXHgmKaHYb3CLqvSc0By8S1PeFDV+Vv/4xKfJeYs0wFRjkxY0v2NgERzvWPiOm0J13E/Ka+5nSAzKjc7/Kb64yM4nB9Zac1HW8vb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--calvinwan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SZ03OJ9I; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--calvinwan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SZ03OJ9I"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-7bbe0ab18caso236359a12.0
        for <git@vger.kernel.org>; Wed, 14 Aug 2024 12:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723663801; x=1724268601; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=IlzuH0QJcEuhV0tvfQujEoxN3QYUezxFsl0tZ/hfUVc=;
        b=SZ03OJ9I/aLV3WZsUszlhq8lw6Uac9gGWIBg63fFwnpGp6C6C0gL+5uXeZoHFswo+l
         phmi8ccAy3D6Yqobokg5uVNuwXFW3poXJKjOqfm5oFTNzYtobNHcTKXiB3W/9My+EXM0
         832JRusOup40BlPwpwXCkz1EKh+k9JZkodpachLt3Auc+ObzS1q451OWGCx6SRyQyQGM
         eBljXY5ZMv/cTHCSDe7qi6AuYsayvEvrE8AK2QMmCL3uylSDvodkXeq6aEA7aZtwtsyf
         Z8j2poJEddO/0G02DPV9hcmQLPcRI3wIVDFgHqGyN/6ZXEy3pdj+0bo3YJvG2t8h4U6o
         2j4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723663801; x=1724268601;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IlzuH0QJcEuhV0tvfQujEoxN3QYUezxFsl0tZ/hfUVc=;
        b=tUUxf2RuWMyWp/2TCT0lFwtYOF2nQdtmHVRnHsC6SsREvCU+zumMfgeGj9MWB3wW6U
         hAyL7te8gciiIrrKgqlM8PL1649+MvAYtVkYvckTtHybzdmUrB0VOybFEjsDhaAMnFAs
         LTho/YVhomlEFNI61uFrrHJ9hkDEYI83XARu9wXBFe/ueV1afL1URfb/NWMA5T46YUzh
         i1kfMkhUkRKXq0OXgJUwBY9Zb/SS9lpjbbHI3WLvRXPlMCtnoFQIdCLzHDkQqYKnr3Fx
         jaG/LmDmiCakZ5BOMjN7JWWGN77CWQRO0oD9yMbmc06GtD68oKxStL0Ksp40ETeSSMNm
         qmgg==
X-Forwarded-Encrypted: i=1; AJvYcCXmxcqoUxkGsoVlNYe/m9RuSP8cPcjnIaoWM8nQBr6pXYVJBqrjMoD4RmcTREC2G9iIGlsjhGdBkpszz/ZxRHbTdBRk
X-Gm-Message-State: AOJu0YyywfLt02/B9qA9kYvLj1xS9IZyf2kkDUOcCZ45hcLMepcU/5/j
	sAYHNWsU7Bf5sfkHyR8of+9Ep8t5ci3izgJzP1vtdhiKSApuDRIwykl9RX/GayU+tBucqGIHpR3
	/H/5qODfelha6zg==
X-Google-Smtp-Source: AGHT+IEPYk7CYN6Ys5Vl40iA/q/fPFkSrcYJG4vvliGyXZrSxHwJvnm8d3a4jPCJQxXwBa2E6lNmxGHO1sVWEJE=
X-Received: from barleywine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3bd4])
 (user=calvinwan job=sendgmr) by 2002:a17:902:d4c8:b0:200:ac2c:677f with SMTP
 id d9443c01a7336-201d6467e41mr3833715ad.7.1723663800888; Wed, 14 Aug 2024
 12:30:00 -0700 (PDT)
Date: Wed, 14 Aug 2024 19:29:57 +0000
In-Reply-To: <cover.1723540226.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.184.g6999bdac58-goog
Message-ID: <20240814192957.1518560-1-calvinwan@google.com>
Subject: Re: [PATCH v2 00/20] Stop using `the_repository` in "config.c"
From: Calvin Wan <calvinwan@google.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Calvin Wan <calvinwan@google.com>, git@vger.kernel.org, 
	Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"

Hi Patrick,

Glad to see us slowly getting rid of the global, `the_repository`! I had
missed your original series[1] introducing the
USE_THE_REPOSITORY_AVAILABLE macro, but going thru it provided all the
context necessary for this series.

I see there have been a few cleanups since the first version, and I
didn't spot any typos on my end. Overall, this is a good step towards
reducing our dependency on `the_repository` by removing it from the
config subsystem. Additionally, this makes libifying that subsystem much
easier since removing globals usage is a prerequisite for libification.
I only left a non-blocking comment on one of the patches, but besides
that this series LGTM. Feel free to cc me on any related series in the
future!

[1] https://lore.kernel.org/git/cover.1718106284.git.ps@pks.im/

Reviewed-by: Calvin Wan <calvinwan@google.com>
