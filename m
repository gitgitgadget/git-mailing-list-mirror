Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B6611A5AC
	for <git@vger.kernel.org>; Fri, 15 Mar 2024 06:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710485713; cv=none; b=GsmVSOW7GrMTSOY7Z1Yxc0P6NujRAsyKvGAgQqoryuR7W4YHp/cej1MnchF4uENiIcKAmK9F8jqigMSd0XjzNM/vcmPdZb5or57WAs5r+mDSkY6MEjrLv6FZohZno8DLm2pHUIDjw3uDUFeeBDaJmaubHIfO6e+KAVNvaKpAmYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710485713; c=relaxed/simple;
	bh=JavJ6KCiiAQXm+ynkOcmLx3ghWRqMHQmDDEGFzgTiaI=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Ze+Y3+FanwRAZcJjGcpDo2vKw/8h8sgJANl7OWddAJxAfdtW8nc6vWqNLcBJoEAaB4hlQ4o+D7TMDZ2w+TtMdik7E1kwjusPKSL1OfaicEzGmrGNV8cT1up8P9SmrX/5U6RdhMVT7OeSBpsvGeFBgy9SVvYoNDtx58b6GWzNlFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FzSqZf8G; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FzSqZf8G"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-513d212f818so1764414e87.2
        for <git@vger.kernel.org>; Thu, 14 Mar 2024 23:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710485709; x=1711090509; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AB8UPD4LBLRuKnNbNnRabZe0AVzRirc1GhW5gbYWJFc=;
        b=FzSqZf8GIy8MOlAux0ud3+PqFH9CCDPOQ0Gno7f7r8gamEQBPcFd0WK5UwJhW18mgz
         c3Ju5oclMupEfWiap2ESHocob39r7rWQ43xZoDlktupdNxiZGenF0elf8WwBiyEZec+f
         VedyYJbNuuCKnpTE3UuxogkfCJnAgv/QEmeQWXuWNlIQnEbCOO7tWl56/7NP0gNHe3b8
         9wRSXX06BDjw3YwBIRfzYIxP1/10ASJCpGNbI58D2w9mgxuFx3Jy9POh7IxfMK18AAm7
         +Yx7RLoK+KEpsSSJtMF6rcTsLjfRmbEiT++xF4Wg7CpMsqJ4FuZhDP6sIe+YYDlR/9tS
         V2bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710485709; x=1711090509;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AB8UPD4LBLRuKnNbNnRabZe0AVzRirc1GhW5gbYWJFc=;
        b=FbTeoIEYRbLsULo95INez2D0GM/arKvxLi+wGIifGfDNIUjT8e1F8XV7LbgkS6bSWi
         copRWXBUzI45mf4QAaegArhqQDdxyPg6s0koeVFCphkkhYATaMJba6DvqYE65L6nV9jH
         Gv0zlWBQ+yL8s9FhwtbZejHdKOFX+5OOu8h5PxchZV0RznC5o1O55eIY5Jiw8TBBeGUj
         vb66yQeJdyvFTlut8Cwp02Ha1JNhW2x57gPL+GTvIsKUqSfosCLmV6MWhKlObHD3NnBD
         sUbPD/DSk+rp+qN0Hw4QGn8ptzrGUNiQuV6cNjNPLoZkZebnIWEG3x/gjonbeiPqlczv
         7P+g==
X-Gm-Message-State: AOJu0YwQLBCY4jev5r4uNITWl8X0uxaeo0XQjSZ67LXzlEuNXuzpCWHs
	HRZMeZyK2ZcJrKa7essKpUWTVKY/kb+WCvlBMhMBBqo8CrEjAJN4FmYlmPJF
X-Google-Smtp-Source: AGHT+IHJ8LYZny5+04m6FjYyeunFmbS2Zesp15LySouHRYQU2Tep8+kugSLr2iBO+J0QTlNuYqseAA==
X-Received: by 2002:a19:2d51:0:b0:513:82e2:4193 with SMTP id t17-20020a192d51000000b0051382e24193mr801894lft.10.1710485709395;
        Thu, 14 Mar 2024 23:55:09 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z18-20020adfec92000000b0033e7de97214sm2428136wrn.40.2024.03.14.23.55.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Mar 2024 23:55:07 -0700 (PDT)
Message-ID: <5f9e444197468d065264b85c8cf7434df0e08070.1710485706.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1694.git.1710485706.gitgitgadget@gmail.com>
References: <pull.1694.git.1710485706.gitgitgadget@gmail.com>
From: "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 15 Mar 2024 06:55:02 +0000
Subject: [PATCH 2/5] format_trailer_info(): drop redundant unfold_value()
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: "Christian Couder [ ]" <chriscool@tuxfamily.org>,
    "Junio C Hamano [ ]" <gitster@pobox.com>,
    "Emily Shaffer [ ]" <nasamuffin@google.com>,
    "Josh Steadmon [ ]" <steadmon@google.com>,
    "Randall S. Becker [ ]" <rsbecker@nexbridge.com>,
    "Christian Couder [ ]" <christian.couder@gmail.com>,
    Kristoffer Haugsbakk <[code@khaugsbakk.name]>,
    Linus Arver <linusa@google.com>,
    Linus Arver <linusa@google.com>

From: Linus Arver <linusa@google.com>

This is another preparatory refactor to unify the trailer formatters.

In the last patch we made format_trailer_info() use trailer_item objects
instead of the "trailers" string array. This means that the call to
unfold_value() here is redundant because the trailer_item objects are
already unfolded in parse_trailers() which is a dependency of our
caller, format_trailers_from_commit().

Remove the redundant call.

Signed-off-by: Linus Arver <linusa@google.com>
---
 trailer.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/trailer.c b/trailer.c
index a74f05db55c..2c0dd8ac829 100644
--- a/trailer.c
+++ b/trailer.c
@@ -1101,9 +1101,6 @@ static void format_trailer_info(const struct process_trailer_options *opts,
 			strbuf_addstr(&val, item->value);
 
 			if (!opts->filter || opts->filter(&tok, opts->filter_data)) {
-				if (opts->unfold)
-					unfold_value(&val);
-
 				if (opts->separator && out->len != origlen)
 					strbuf_addbuf(out, opts->separator);
 				if (!opts->value_only)
-- 
gitgitgadget

