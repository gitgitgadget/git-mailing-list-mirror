Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD9AA44685A
	for <git@vger.kernel.org>; Wed, 15 Jul 2026 20:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784146211; cv=none; b=s65ol4zQeAZyHmViq2O1XAA+fxtbi+iFvFnwDyftB4aMzvW0cNi0zc2aR9p+GUmQ8WGotDhGZBKNNdhNpbFwf4Nde8n1Z7hTf3wjD4JzVZ4H4F6cKmhc8ZxEAJNAn5A840w5P9zyeMVvu7n1XYpRuLPYrP8msHv4zHCsPLLKLeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784146211; c=relaxed/simple;
	bh=1q+0qx/yvthBPXWjxMH1BWStECVUsH6WrsGVD9HqSa8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QoFMVRvVVAn3sbd9OkixZwORdqOeLYZSIfpgRBnIJ2LEXEnYs6IjfGGGkMD4RyJ2u5iiBCvjhHEGUdG/FP8Fep2SG+ODUjffzeM4VUwm/xs2NfJerg4v/Ff5SbKQjrxXUj8zKNqBfaMXCWzA6VganGojBbpb7Yj2AhdKbgIv3g4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=jY0Rnobj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YtcYqXhP; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="jY0Rnobj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YtcYqXhP"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id DD4321D00072;
	Wed, 15 Jul 2026 16:10:08 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Wed, 15 Jul 2026 16:10:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm1;
	 t=1784146208; x=1784232608; bh=odEcVxrAl/2yLJMXorm42nfpDg7FND6s
	uBTxkqVQ/L4=; b=jY0Rnobj5ynZ8VCdTCLHkMJM5ORsMrz4KLIdnnfPHWa4cfCB
	BE/OB2fUAIviLlfd2vUJd7t11nTF1UxMaB2KeJVyc/8xF2ik2dvXWwcoYSvPqpQe
	W2uRkSymgF7LKZnS/Y2t6ZdtgC6rTdb31b8BHtg85jiwgGdqU5lH3PMVv7fLJqPT
	xLfHaqUYWBhV5vzFsnoC03j2QQDtMzA1Gq94WLvvGwPK8TQ1DAbliYjjxSTbix3Q
	rDoYeJwpklHc07icW2tA/wq/YR+Mqa0CzRij73arCoqfTi06Rkqc+86+JoT9P4sv
	SMfxe6xk1ujDkE1o9L5vg5zCPJbg7PLD9jwL6w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1784146208; x=
	1784232608; bh=odEcVxrAl/2yLJMXorm42nfpDg7FND6suBTxkqVQ/L4=; b=Y
	tcYqXhPo8KHoLVGfCQssGQbAgeQJrXgWpknYD6qYbcdFUsFd1mApiS8piYk99Lom
	Dccz8+tMhK+QoDksoF+K17Q2oM6Q5sW5GM+5GkfRVMPGHIU3L4kYqQmTFzjnkvO0
	Li9Z5IfCSyVBLIYI/CqAVyj74j8QRKBeIW/FYcT0dWNc82f6W5N+nYKWFEAzaOvu
	06ojeuAyfNKHie3N/1C68basYw4FwrmvCzBpEsZLMZEL3LGcFRR2j+gi3x/WaL2f
	05bu/pTRzqQ/MZV6KSIEDjsn/jsCGpYhDlh3DAb39sCqLnT8++/knJqsWayCOj4p
	Sj0npXqyYQv6nUI4xoZJw==
X-ME-Sender: <xms:IOlXar8MzXflR0nI3NMAOu9MoXERDTGRNlncd7cn_fYjwBcSPduZow>
    <xme:IOlXavL-p0-2PBtNAk7XXW768826yA11QEYKT459dLRgbTc9JNASJjSwT9YiqOlTT
    UVc87uemlYwHt_ov6CP7FM7diTiqUEMwOQ2DOt6f-Z1uuJFucgHdQ>
X-ME-Received: <xmr:IOlXamYBK_GeCxEY_XuyUYZ4pvpQfCvB0rb04JOPq8pjkE9KZT3VLvwxqMSYKa3BBZxpwwn5KvCd7bM9xsCXNoE3uMDsYncp19I0dW0>
X-ME-Proxy-Cause: dmFkZTGgrhd7e0r2chsrDdFDaFRUvSRxkRCxepQlrZfu2jLAzolp7v8EsZ/KkwwL6VMVV0
    /yn18QBlZSbzJ2OifsGqb7ZYB/aAFrNVWU/3faH/BrgCtYwifZcHabzsp6qOAVo7r5s4LD
    2+Irio3+N5rchONC+B6ki7jWP5XHwQyIbq0v9+RRvYUjxJTLgWtkT7yzR7wZrfoU8AF5je
    epBxBJz4P5Q90mLzFinFgYSCTZVMcVP1UA9OmM8m+uDMbjIuiz5H+7YNE3VWouZQfMg1DE
    Xo9e7+SNo9wh3nqGB/Q1I3KwtFZz6w8K/3GF1Tjqq3/9sDBLcz3KX+xjBMpRBsjYYtLCVL
    HzKWpa7+btOurrRqY7rup9PEEfOjuSQ8MuYYdG1qEa321MsMewUOyawfhFHShtVF9K0t5m
    V6fw/K4PMrB0yNJF04yPiG/wd0LjAgs06UBOwrRsl0dy4d1GR+MqS0jhGfVpCVt4gojGWy
    /6vMSUhZskZpSVXTi4CXyd4mxzCoqCZSY1OkQ0YMBpPU7re7L1jytYD22plxPSufkOyFro
    cnXxIsuLv75fzXyFwiooMqoCwbnOkdrPouHIEtCYB0QqnwxpazlcWx78uhXqwPfAXyKkfT
    STWUa9KQt6ImYfZ3V+PVFFB401hux5EnvnPLlV0kRr+Wb90UB8ztRpgcfZSw
X-ME-Proxy: <xmx:IOlXahLAY_m4WRdcrUFwgM1E7REchYi-5Abi2kVVMwsqxpfeQG6WlQ>
    <xmx:IOlXakBvAuV4-WV0XQpFTLWqYktmbH2ZL2gZYoScpqAODPIEzz-bTw>
    <xmx:IOlXampfjstbhh9u0nXyqxfeKj8fPVVUw74CKoGkGEhAxy0nETYwRA>
    <xmx:IOlXavjl4uQ3I9X7ZytuC38TeySUbTsFYrjE9VPthQ0fYGeK5P3UJA>
    <xmx:IOlXagZi4bOB2C4tUHvm7rwgyxRawV01FY-1in4_12M0iDI_hIAgteNV>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Jul 2026 16:10:08 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Adrian Ratiu <adrian.ratiu@collabora.com>
Subject: [PATCH] submodule--helper: avoid use of %zu for now
Date: Wed, 15 Jul 2026 13:10:06 -0700
Message-ID: <xmqq4ii0ko9t.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Since d7d850e2b9 (CodingGuidelines: mention C99 features we can't
use, 2022-10-10), our CodingGuidelines document has explicitly
forbidden the use of '%z' and '%zu' printf() format specifiers,
even though C99 does support them.  However, a new instance crept
in via 82c36fa0a9 (submodule: hash the submodule name for the
gitdir path, 2026-01-12).

We could claim that this is an unintentional weather balloon that
nobody has complained about for the past six months since Git 2.54,
proving that it is now safe to use these format specifiers.  But
(1) it is probably too early to make that claim, as distributions
often stick to a stale version for several releases, and (2) it is
unlikely that a failure in this code path would manifest as a
major user-visible breakage that would trigger a failure report to
percolate down to us.

Instead, let's stick to the established workaround recommended by
our CodingGuidelines, which is to cast the value to (uintmax_t) and
format it with PRIuMAX, at least for now.  Even if we eventually
perform a bulk update using a Coccinelle script to transition to %z
and %zu in the future, adding one more instance to the pile that
will need such a conversion is hardly a tragedy.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/submodule--helper.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git i/builtin/submodule--helper.c w/builtin/submodule--helper.c
index 1cc82a134d..92e38106c1 100644
--- i/builtin/submodule--helper.c
+++ w/builtin/submodule--helper.c
@@ -549,7 +549,8 @@ static void create_default_gitdir_config(const char *submodule_name)
 	}
 
 	/* Case 2.4: If all the above failed, try a hash of the name as a last resort */
-	header_len = snprintf(header, sizeof(header), "blob %zu", strlen(submodule_name));
+	header_len = snprintf(header, sizeof(header),
+			      "blob %"PRIuMAX, (uintmax_t)strlen(submodule_name));
 	the_hash_algo->init_fn(&ctx);
 	the_hash_algo->update_fn(&ctx, header, header_len);
 	the_hash_algo->update_fn(&ctx, "\0", 1);
