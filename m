Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA23C8F48
	for <git@vger.kernel.org>; Sat, 16 Mar 2024 06:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710570433; cv=none; b=YzIVlDchqcF47nAcwXoIsxv6P8YKqAVhR9NJAu11E3qpdT8RWV3lZr1SBzrkDpJTigGHGQLxCsh2ExsLaLzXsMNtYOqwlEqfQ6yOpWtsqt/HuCO3Gh998Hp4Wh9dJGrlOQjjlv2Q9d5HDUU2InJ4pS097PWteHhaIXKxkTyF3aI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710570433; c=relaxed/simple;
	bh=Y63dmkxXt5z3esklrAkY2jzdOa0er/l3gT1yDEWqtw8=;
	h=Message-ID:From:Date:Subject:MIME-Version:Content-Type:To:Cc; b=mq6A2HDcqs3inCmABG5GNjIPCt5abjRgVb2ZS1tZYiwgPnOpUrQv8pAlFnCmRusWRKd4fOqbJJP78E8k5JCMZ8YSmgr6yZZ7qe1xbXmFyfL774hbS7XMpbLv7YKiv1BqUK1N8jZjYGZnqIdR+ub0mDbQsx59cjeI3RtPGlWsPdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RAgkSkfL; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RAgkSkfL"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-414025406d7so7677315e9.2
        for <git@vger.kernel.org>; Fri, 15 Mar 2024 23:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710570429; x=1711175229; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=PMZaP8QpunXSipsMt2XqhUzREqZav8TYn5Vlc4gYwi8=;
        b=RAgkSkfL7vYHClZdcTjrtivGF6tkh5Vcn396QvEnwjg6YRwLHymriLI2/xXKc5dZub
         ar6hFxZjMF+IDqSfXdTEYqes7Ri/2z0Yq6OL3mQeXpNCeBi38JiaY9vN5hz3n2qbIR1b
         yo8PJ1O8M0hUzbgOit/S6nYxRLnqMNtOT7vHbtoLbzWJG9pb2OqE7QFxT1XwSc4yjVTI
         0rzrTmvH1SJS3Q8xNJbe2Y1ZvUi5S8N+2Rr4Q5Q7O7bMEUNj0tsRqp8tJw+Kod7iGfwV
         wLTrwzeFH+/WtiB9FgkGxcwvtiLF8TIkM6nAuDFPZgO+ctu7GOVTJZr1/6rGzM8JVuWi
         a7SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710570429; x=1711175229;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PMZaP8QpunXSipsMt2XqhUzREqZav8TYn5Vlc4gYwi8=;
        b=RVqrsaiwojiPOX55uWTD8dtPZwJcux+guxYNVIE2PQg1uSdkM+7D3svRGS0YcNqmN4
         HDcHT8HIRC62CO6YwCh7wrybuLSqv5KsHvqXRx1vT4+YcN6QHk/+Ir+mYFUIjDLTpTQ8
         e5/mHZ6egeh8pv9Wa0OtXQwQd+qu6WF37GBggQ8+sTnEM7LZ3XeNw0wXSj5c38O77Hg8
         7Rk3HL7fCZPLChbp73q2onSlHkMIKsvDR9G5bwyLEWPSiCYc1OV4w1Mt22jkI97X59ru
         T6ycvIKX7WWfZz0pvKnDVW+kUYHg9epHZJadyNNtDDl5Hyfq4SdbWByHbCtEjv0hEv8n
         GQHA==
X-Gm-Message-State: AOJu0YyhfYR8anh8PpV59M1+KZ8AvSVW2wLKTXqtZEI2qdLpuQ99CkU+
	tBXLf+ymBMzz8Qd7dIRCqPS3J6lSU8/RFe554K0L4MYCeC/sM9NVlXvHjgyX
X-Google-Smtp-Source: AGHT+IGswLpk1nWPaQVu1dQflkRth7ThEpRaLHxW/e0bSDbPST7NK+5olUwzyCs0jWHLAEgZDMt/7A==
X-Received: by 2002:a05:600c:a47:b0:414:860:bdc9 with SMTP id c7-20020a05600c0a4700b004140860bdc9mr284730wmq.33.1710570429308;
        Fri, 15 Mar 2024 23:27:09 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r11-20020a05600c35cb00b00414038162e1sm3307469wmq.23.2024.03.15.23.27.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Mar 2024 23:27:08 -0700 (PDT)
Message-ID: <pull.1696.git.1710570428.gitgitgadget@gmail.com>
From: "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 16 Mar 2024 06:27:02 +0000
Subject: [PATCH 0/6] Make trailer_info struct private (plus sequencer cleanup)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc: Sent
To: git@vger.kernel.org
Cc: Christian Couder <chriscool@tuxfamily.org>,
    Junio C Hamano <gitster@pobox.com>,
    Emily Shaffer <nasamuffin@google.com>,
    Josh Steadmon <steadmon@google.com>,
    "Randall S. Becker" <rsbecker@nexbridge.com>,
    Christian Couder <christian.couder@gmail.com>,
    Kristoffer Haugsbakk <code@khaugsbakk.name>,
    Linus Arver <linusa@google.com>

NOTE: This series is based on the la/format-trailer-info topic branch (see
its discussion at [1]).

This series is based on the initial series [2], notably the v4 version of
patches 17-20 as suggested by Christian [3]. This version addresses the
review comments for those patches, namely the splitting up of Patch 19 there
into 3 separate patches [4] (as Patches 03-05 here) .

The central idea is to make the trailer_info struct private (that is, move
its definition from trailer.h to trailer.c) --- aka the "pimpl" idiom. See
the detailed commit message for Patch 05 for the motivation behind the
change.

Patch 02 makes sequencer.c a well-behaved trailer API consumer, by making
use of the trailer iterator. Patch 01 prepares us for Patch 02. Patch 06
slightly reduces the weight of the API by removing (from the API surface) an
unused function.

[1]
https://lore.kernel.org/git/pull.1694.git.1710485706.gitgitgadget@gmail.com/
[2]
https://lore.kernel.org/git/pull.1632.v4.git.1707196348.gitgitgadget@gmail.com/
[3]
https://lore.kernel.org/git/CAP8UFD08F0V13X0+CJ1uhMPzPWVMs2okGVMJch0DkQg5M3BWLA@mail.gmail.com/
[4]
https://lore.kernel.org/git/CAP8UFD1twELGKvvesxgCrZrypKZpgSt04ira3mvurG1UbpDfxQ@mail.gmail.com/

Linus Arver (6):
  trailer: teach iterator about non-trailer lines
  sequencer: use the trailer iterator
  interpret-trailers: access trailer_info with new helpers
  trailer: make parse_trailers() return trailer_info pointer
  trailer: make trailer_info struct private
  trailer: retire trailer_info_get() from API

 builtin/interpret-trailers.c |  12 +--
 sequencer.c                  |  27 +++---
 trailer.c                    | 161 ++++++++++++++++++++++-------------
 trailer.h                    |  46 ++++------
 4 files changed, 137 insertions(+), 109 deletions(-)


base-commit: 3452d173241c8b87ecdd67f91f594cb14327e394
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1696%2Flistx%2Ftrailer-api-part-3-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1696/listx/trailer-api-part-3-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1696
-- 
gitgitgadget
