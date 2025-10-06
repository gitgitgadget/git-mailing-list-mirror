Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4033B2D5920
	for <git@vger.kernel.org>; Mon,  6 Oct 2025 14:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759760590; cv=none; b=WVw25WLIukDKNrTABen8KeOW+yF2rSAX2vbbjxl8I8uHgW+/qOWbpLo2gB0IPg6hO4OZQh6fj4A36ZMnPBNpn3cjbk2Nuxs4FGtdawu36Xum62K8Bk7it+d+sZq1QNti8A6nAV3yIqtz8otWzy6IQ5DsPNTPkkLQlIdpIbxsJt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759760590; c=relaxed/simple;
	bh=NrJUe2zo/755ziLfa/YcRS7uqgD2cBYrUKpni6pfRH4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Cp4ZY2VZ73KFWngBYa8Xws/RLREhhyAhR2k+3FNy6ez0lQH7a72bJWWL1Z1ofkPoNxUZy3y2Mqg9HWwyLkoEmdx2Li+LB91fdW/6FtZfc/2iqdFDwmUIDK+mtyZLkbhOIhv2t+fhtgbUaMqwfVHsa/LvDdnLC0goq7pnvnMbm00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TZ7gNUo7; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TZ7gNUo7"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-46e6ba26c50so29427275e9.2
        for <git@vger.kernel.org>; Mon, 06 Oct 2025 07:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759760587; x=1760365387; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cvm1oKFZ+vpkVAHmHsvyiZuwnhtvDFDUJacA5oxlAME=;
        b=TZ7gNUo7/sPouUHnLyrGfYtmgbfD8fXGnswHU4/6u9JexOPKzPmUJXAD1qHTOjIBD4
         YlnQUma3fMK3rtD0DibZ7UWkjxWmPtCRA2J+/qfHqoM9Pp/3Wh5JiVjzRTZ9YNj3apO4
         0JRT7BbOy584JgyuALq22awwprIWjq7EzhCsk1SbadPzF2ji0EGU3G7qdAzdXHF7cV7L
         yvPwMWq5XvnvxTAFLOgBWo3IzTfEEOwore6HLx/rYkXVh0afuKbyul6+s9c8p/97kyw+
         9FKNTS9oNH6be7al1fWLtOdyRXQ+Q1mBCiMmLcMZuMTFF0MsxW2x0ALDdiJVNgmrUF6l
         zKQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759760587; x=1760365387;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cvm1oKFZ+vpkVAHmHsvyiZuwnhtvDFDUJacA5oxlAME=;
        b=H2qbcC2YpDZZdhNttFHyz7lmrmVTGfPP3vQWDGThlWovn/v5DTeUNwW3KZKeLfoUfW
         Z6pil5SzKCAacTuwwhyujqIX5y3lrQiZj/Mu27sVQT27qmqMLhEJoL6qOxhXN2hJv9yr
         epx5XbgNUrdf6eL0donQdT2ir1Ic4UBBFAQvg0eSin8iU5EUOmW9XyvbJjU+Eiv130pN
         vZZNe0qgd4Hi17qd3LjEKGbx4xp/PFhNlO6HyK2B6GHqAybXp60diMQo9d9g6kGn9/jo
         m+I74fOcWSn9iCr0crUBJCUF0Zk/BYSX1ZCcEgTvsraMm5fX1wJuFGE1MZtWze0GEs5L
         jvgw==
X-Gm-Message-State: AOJu0YykM65wJUKiwGwiXNtY4EhFD/Bhoo4utNUkYAoGcQ3MRnCL45Jm
	T4gLZR36SDLCcdmd42lCkbzwSbWj2jIMJMaXj6OO1jKir/aazqzyQJmnCEE228ZV
X-Gm-Gg: ASbGncudDNgHqbvHoWC9sJ48sXhmb26oE/lJp56zOhwDQj7pEQfu3IH3QoRz3y2rSFS
	kNtiMgOST95OsSZj89gPsgNntAmzf45xSHPgeP7nA/K3AevxiBzd3o9oxkaVabqVeVN3Nt3ZxIO
	93QHaQY7ZEznODWB0RiQ232lO822VGzUp9DhDnet49mHNvDVOdszjTbFxzTLw0x3oaTp+okLIZt
	GUi6JawKSOEw0eRdsjgPdu1DOznTd48a44ZXN0O8/wLF6gFy1RqVbAXyriW9+5eJP3hUr3HUkfq
	2PwSZknh36LFyDuo8nTqYvsSbDnSdY0Zp0bf9zafQiSFcDzAK77QmsknFa6NJk6Og31s+n1lM7L
	V/d0x8T2p284Px/Vh6A3vzNnFFHiIM5LUs8aIZadGMXawWVSWlBaPZtYL
X-Google-Smtp-Source: AGHT+IGa2nHmGWyvWxQUswqAUoo4TQNvF4BjjHYypCl/oLHtaO4oCUA3wbxThrNrfpoLZvoK2BWSKw==
X-Received: by 2002:a05:600c:34cc:b0:46e:1f86:aeba with SMTP id 5b1f17b1804b1-46e7113f7a4mr110909765e9.17.1759760587257;
        Mon, 06 Oct 2025 07:23:07 -0700 (PDT)
Received: from [127.0.0.2] ([82.163.201.2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e7234f547sm171237555e9.9.2025.10.06.07.23.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 07:23:06 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Mon, 06 Oct 2025 16:23:02 +0200
Subject: [PATCH v5 4/7] Documentation/fsck-msgids: remove duplicate msg id
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251006-228-reftable-introduce-consistency-checks-v5-4-f196d386214f@gmail.com>
References: <20251006-228-reftable-introduce-consistency-checks-v5-0-f196d386214f@gmail.com>
In-Reply-To: <20251006-228-reftable-introduce-consistency-checks-v5-0-f196d386214f@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, ps@pks.im, gitster@pobox.com
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=649; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=NrJUe2zo/755ziLfa/YcRS7uqgD2cBYrUKpni6pfRH4=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGjj0MYSYNBixPuO3HDs26LJzuiGOdosPhq9a
 0t/5xbLv40MDokBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJo49DGAAoJED7VnySO
 Rox/CVcL/26QaxDYWdWzcc9Y9aNSPYFT0KR03a7OwseVSLEc7eCg07K1qKl0w/eU0mX4uLEKm97
 l7zhYBHaYPquB78xTPNeGV1pYLGRW/qU1gXb1o6yofv8Ly94L8lYiwviEt9kmyZYXXtnCeA2Qsl
 AbPJq+tKeSb764ZqMuniMp+bgt8ZUV1bOXZMxl6I5rmFMnuFSLXF5TP8jLNMqVz809RTCSpra+w
 Ut55dmACcCMNcSVAQ+brOf8rZX7DmqwgUlyqvvSCKQMaiBr7ZjQZZokdcli0FJMQ7CZY7IM0nnV
 9KEmy5JCWeo5eqb6IRiC/ydo8zAmkCZIxSR1WkU63SxlNrDsB6wT+FkCmWse+AgVhBlvQnlMV24
 s9WQAQytYmPCuaL0QCrJvaoIb7OkJ+Ekv5gYX85rnk01nzS2ObG0ID2FnTJhtMKIujgPdn4tM9F
 uAq0bTIjFhz9GT+zvClSWl+561O2buAeyRZX2RYKL7YDMpwUUtrg2BrzEm442Whn9RgwJh8wAK8
 GU=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

The `gitmodulesLarge` is repeated twice. Remove the second duplicate.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 Documentation/fsck-msgids.adoc | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/Documentation/fsck-msgids.adoc b/Documentation/fsck-msgids.adoc
index 0ba4f9a27e..1c912615f9 100644
--- a/Documentation/fsck-msgids.adoc
+++ b/Documentation/fsck-msgids.adoc
@@ -104,9 +104,6 @@
 `gitmodulesParse`::
 	(INFO) Could not parse `.gitmodules` blob.
 
-`gitmodulesLarge`;
-	(ERROR) `.gitmodules` blob is too large to parse.
-
 `gitmodulesPath`::
 	(ERROR) `.gitmodules` path is invalid.
 

-- 
2.51.0

