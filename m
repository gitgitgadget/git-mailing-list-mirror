Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4FB74AEE7
	for <git@vger.kernel.org>; Mon, 22 Jul 2024 23:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721690689; cv=none; b=oNUqjl12bLBvfltby5qvk1kiO7raDeSIf5FKAzm9vjkF05V7chw93KVsPhCoXm2dRKs8jWud/Tq6VfBMSh33xEzQJpkybuyNG9NbN6OoSZ9WRwCfqwHiobsaOGYIb0rDpzXG9iFYMK3dIZJirehnOuGuMrTojQ3hiPDKuW/fnWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721690689; c=relaxed/simple;
	bh=TqCQBqz86R3cHRmo5NW78d8VkCQG+qYj4Dbyg7Ng7Qo=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=a1GRsu39P44dOMkyph3NM65I06s+ty0jfqZDeX8DNLTlBSKbXEEn/u9g7NoWz8/IS13kS2IO4DkZxWbpMzb+qvS6YnsM8JLLeIJ0JmaMobWKUhcUlkdq+Nt230q0OoS3AtzlGYT6fH2TX18UbS2MlKC+3VuE2go8wnfaoLhNqNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xx650Am4; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xx650Am4"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-42122ac2f38so24513105e9.1
        for <git@vger.kernel.org>; Mon, 22 Jul 2024 16:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721690686; x=1722295486; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZugFX4HJL4wyNBvLuhfWdHY9HRyhnnYsrWXVn+1XK5k=;
        b=Xx650Am4NCh52pWmhE0yY2GkUqYqU188ZcYSV5iWC9tL73EpnnS4/0YqN7Lb0vOxsT
         ujSnyiMYQgbNDF5zfdpxlXk9KcSu4eEE6DEYd+N0BgOFAZZ9b3uooM7oEwNp8r3pxrqE
         1tn+Z9HP2AjBubixlw5F0KqCE+HWiL2V2Tp+nQiksetUFfQ21e9qrWs0XKkplkrpzFA5
         hz2FLlxEIPezXQkkHkPq8lL4dLxJUgnt8iGoT09TJZTOqGWEnHhigHTC/N9fThptqSGk
         KWHjcSpnfxwvRV18taXNsLJ7GRZvCyaQETaXS4n1gem6CSkdhid2BLMtDjXhgvP6bXKC
         AL7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721690686; x=1722295486;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZugFX4HJL4wyNBvLuhfWdHY9HRyhnnYsrWXVn+1XK5k=;
        b=lxVoUlZlhyK3mazIoVnISGLkKwhaFUHIrPbO5GInFtnGIjbxVO8hbJ918agoLCRDAB
         MmmXcQw1/9AJusX/EoW0ycTMWLDmdZOiuU6wqVT5BC0yJ2r9DKAp7gkDEzqENbganuJR
         1KNGgfl5ylBeG+3Wc4sX7h/a6uGMfmnmV/MFeC5XB+dcL1mdVYceFP+75kcjgD7Y6dgJ
         XMJsg01hIZ6U10zOUOWM4f/PR2kZ1NnuzLRMekjo+6zx0NRqbaV7sk0UgXaMAgY3qLcP
         kYGT/8ORbbmVY9SCGwAeOGH3hOswpdMPFlnneZq4+9E+PXO7MDJhp0BrTavNXYZXR/22
         DgCw==
X-Forwarded-Encrypted: i=1; AJvYcCWE/0WMGbj7KXOVHsQzT68G3xam6MOgwtPyyhughsaDpWPMo0gSpjJXWsmHbhEL4VjmG1YevdIjpdRRzzPgl8Imobxj
X-Gm-Message-State: AOJu0YyiKwZClsVrxMII/NcbsjmIKJeMTJLWHLTmGN3cCh+WIjYiPFYX
	tmNY7PzsZyxDoxdlk9bg3RMSOUfH1c2I+5QQfFTAVGd/uVHodaYK
X-Google-Smtp-Source: AGHT+IH11HhDvelM7N7a7XYLNafanfk6UU3ckSsDxDH+fjd8UJELH45veE+chcEfyrMODbsA3U98pw==
X-Received: by 2002:a05:600c:1c89:b0:424:8743:86b4 with SMTP id 5b1f17b1804b1-427ef32d8cfmr1868105e9.6.1721690686266;
        Mon, 22 Jul 2024 16:24:46 -0700 (PDT)
Received: from gmail.com (89.red-88-14-41.dynamicip.rima-tde.net. [88.14.41.89])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427d2a94380sm173432445e9.39.2024.07.22.16.24.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jul 2024 16:24:45 -0700 (PDT)
Message-ID: <c37f0d54-4ead-422c-8193-f0c2ec84ca4a@gmail.com>
Date: Tue, 23 Jul 2024 01:24:45 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 2/2] pager: make wait_for_pager a no-op for "cat"
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: phillip.wood@dunelm.org.uk, Git List <git@vger.kernel.org>,
 Dragan Simic <dsimic@manjaro.org>, Jeff King <peff@peff.net>
References: <2653fb37-c8a8-49b1-a804-4be6654a2cad@gmail.com>
 <ebcba08f-3fbb-4130-93eb-d0e62bfe0a8a@gmail.com>
 <efa98aec-f117-4cfe-a7c2-e8c0adbdb399@gmail.com>
 <1dc9ebad-768b-4c1a-8a58-8a7a5d24d49e@gmail.com> <xmqqttgqyzwa.fsf@gitster.g>
 <2b57479c-29c8-4a6e-b7b0-1309395cfbd9@gmail.com>
 <88f9256e-04ba-4799-8048-406863054106@gmail.com>
 <a2ea00e2-08e4-4e6b-b81c-ef3ba02b4b1f@gmail.com> <xmqqv80xcpe5.fsf@gitster.g>
 <079901fe-7889-4e1f-bb91-610e1eae25d3@gmail.com> <xmqq7cdd9l0m.fsf@gitster.g>
 <43e045e5-4c92-4c5f-b183-d63c5b510023@gmail.com>
Content-Language: en-US
In-Reply-To: <43e045e5-4c92-4c5f-b183-d63c5b510023@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

If we find that the configured pager is an empty string [*1*] or simply
"cat" [*2*], then we return from `setup_pager()` silently without doing
anything, allowing the output to go directly to the normal stdout.

Let's make the call to `wait_for_pager()` for these cases, or any other
future optimizations that may occur, also exit silently without doing
anything.

   1.- 402461aab1 (pager: do not fork a pager if PAGER is set to empty.,
                   2006-04-16)

   2.- caef71a535 (Do not fork PAGER=cat, 2006-04-16)

Signed-off-by: Rubén Justo <rjusto@gmail.com>
---
 pager.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/pager.c b/pager.c
index bea4345f6f..896f40fcd2 100644
--- a/pager.c
+++ b/pager.c
@@ -46,6 +46,9 @@ static void wait_for_pager_atexit(void)
 
 void wait_for_pager(void)
 {
+	if (old_fd1 == -1)
+		return;
+
 	finish_pager();
 	sigchain_pop_common();
 	unsetenv("GIT_PAGER_IN_USE");
-- 
2.45.1
