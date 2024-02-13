Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5420E62A1D
	for <git@vger.kernel.org>; Tue, 13 Feb 2024 23:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707866753; cv=none; b=oQJWVS0bmDr/E0lg/qz4IVa0srpmSlIs383gTTKeKjs1C+R3/9ePLcbM28hWuXjDeV5RsJMhL4FguYCxUYA6AMK+/G55W7ZnpIV9KwmZkjvNd9xbI84c10QazhvgWXswjfDTOfZJwHphzPvcJObHmRGy6Gw6MSptDFZgFBQ75W0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707866753; c=relaxed/simple;
	bh=ZfdaeiXNPenhk9H4YCK43iP0nYDeCV8Vc7Y7ub+C0/U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gzCTs51QfYpmdK0SHpICFWNC3y37e4x3DfkKWmRTrr4qtWx8KNHvsvAz1FlsK5VwDF7MAOdoHvGZ9EO12rRyGwjyJn8yeR29nrmvWRV2t+yFAI7kha9vzN8UklMTgTJqSuKew3HL6IdNwcjcI64z9X66PCnEzdqGF/y6y70kakw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pngf1gd2; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pngf1gd2"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-33ce2d1ab86so346498f8f.2
        for <git@vger.kernel.org>; Tue, 13 Feb 2024 15:25:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707866749; x=1708471549; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q/0pB0eeR6xJeseZwkaq0dthtDra4QHJooqV3r1Xy98=;
        b=Pngf1gd23pxDWASDHsI3L9NZs+UHVE+/plKEP6GCcmadVsGA+6YhID7GP32FsSjHtS
         WVq/StfCOfAby0CWayMIdwImhvPjcQ5n9Pxn1lCn2uaL+1Xyh1lgo90jbF19NMD8d9qi
         +rM34HQ56HmwKGFHWh6RJc3Zw5tvPPwiaHnNR1ptNoRP/AEh15ZBOH/zoqsjBuctIKXI
         UVh+7Oaa83H9bqTPPltovk+hmq/qlVS28QR0XA2kZzOH/lulIMJzOevW0ywvywwx6/it
         cdzTreK4JctJelT7a+t0B2QJmSImUKOb+4ziEYgGb7XPCg0LiI/dXp/ImtopqksWBCmZ
         Xgew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707866749; x=1708471549;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q/0pB0eeR6xJeseZwkaq0dthtDra4QHJooqV3r1Xy98=;
        b=cdJ+xWBh6O7+OUzuWjVTha0HuULY1V+1iSkrS1yUjmDoQIrRmEhMPKRkzrN3EJJb/L
         trDI1LhpBctiPUIBa7mDQ10VZFzu+HKSybbmRYV8Sg/ve7uyJEsJinh48Oz9pQT7MQlP
         PDwkWPRnQLzom4X3G7r2N9wOhl+W9c9diYuF76RXDP6mAAYD8/fgZKruEjfY4c5HvRCK
         DrNy9EoAEPKqjizt/WqDK3xy3GkfeaimjTlb0uj6ypXh80f8xKszw+6CJoB3gQXvHbJP
         I16lY1K71+VveCGj4WXfdRIA9rB/pSZckkTojN3JlzkOCNp5xvncgeLyYUIxKSsYatVM
         y9Tw==
X-Forwarded-Encrypted: i=1; AJvYcCV5y92GeA1gkRBNHGoxYEav/vNOHy9oxMk+e61/Hq44PlAbie/SHAQJ1jtlMJbc+fylnpuboVug98G4eWtLfN71XYvL
X-Gm-Message-State: AOJu0Yx2PxQBrn8NwEcAix7XqnF5/fGT0eBJ3Ols0hG90HnNmgpqmqpz
	DupbUO7Va9OOZhmi1XSF4tfHt9oa2UUMoF3JhOuW1y9G2auvghrA
X-Google-Smtp-Source: AGHT+IHhBgjz/0DhEsI9aNYImu9wDIOEdpAoOimIu3+dGzaVC9Sj+RvLieWaRWn0dH0jysXaq+i0RA==
X-Received: by 2002:a5d:4204:0:b0:33b:4d13:30a1 with SMTP id n4-20020a5d4204000000b0033b4d1330a1mr469576wrq.2.1707866749346;
        Tue, 13 Feb 2024 15:25:49 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXKMirfOntZaJYaBwu56otWpQEmKNK99W/AiHdlJ1Z8Tn2SohVvZ6tA/o5+iJnbj92PwuejwPVXWk/z+GhOKQMtmDAw
Received: from gmail.com (15.red-88-14-198.dynamicip.rima-tde.net. [88.14.198.15])
        by smtp.gmail.com with ESMTPSA id q17-20020a5d61d1000000b0033940016d6esm10587351wrv.93.2024.02.13.15.25.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Feb 2024 15:25:48 -0800 (PST)
Message-ID: <8acde766-e2cd-4901-b665-f677cd15295d@gmail.com>
Date: Wed, 14 Feb 2024 00:25:46 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] column: guard against negative padding
Content-Language: en-US
To: Junio C Hamano <gitster@pobox.com>
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>, git@vger.kernel.org
References: <1c959378cf495d7a3d70d0c7bdf08cc501ed6e5d.1707679627.git.code@khaugsbakk.name>
 <cover.1707839454.git.code@khaugsbakk.name>
 <9355fc98e3dac5768ecaf9e179be2f7a0e74d633.1707839454.git.code@khaugsbakk.name>
 <xmqqcyt08fa1.fsf@gitster.g> <69f60c3a-ff47-4cb9-a229-6c5a36e7d9fa@gmail.com>
 <xmqqle7o5f34.fsf@gitster.g>
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
In-Reply-To: <xmqqle7o5f34.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 13-feb-2024 11:39:11, Junio C Hamano wrote:
> Rubén Justo <rjusto@gmail.com> writes:
> 
> >> This one happens to be safe currently because "git tag" passes 2 in
> >> opts->padding, but I do not think this is needed.
> >
> > At first glance, I also thought this was not necessary.
> >
> > However, callers of run_column_filter() might forget to check the return
> > value, and the BUG() triggered by the underlying process could be buried
> > and ignored.  Having the BUG() here, in the same process, makes it more
> > noticeable.
> 
> The point of BUG() is to help developers catch the silly breakage
> before it excapes from the lab, and we can expect these careless
> developers to ignore the return value.  But "column --padding=-1"
> invoked as a subprocess will show a human-readable error message
> to such a developer, so it is less important than the BUG() in the
> other place.

Thinking again about this; you are right.  That BUG() in
run_column_filter() does not make sense in this series.

It is addressing a different error, and perhaps a solution could be:

--- >8 ---
Subject: [PATCH] tag: error when git-column fails

If the user asks for the list of tags to be displayed in columns
("--columns"), a child git-column process is used to format the output
as expected.

In a rare situation where we encounter a problem spawning that child
process, we will work erroneously.

Make noticeable we're having a problem executing git-column, so the user
can act accordingly.

Signed-off-by: Rubén Justo <rjusto@gmail.com>
---
 builtin/tag.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/builtin/tag.c b/builtin/tag.c
index 37473ac21f..30532b76d5 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -530,7 +530,8 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 			struct column_options copts;
 			memset(&copts, 0, sizeof(copts));
 			copts.padding = 2;
-			run_column_filter(colopts, &copts);
+			if (run_column_filter(colopts, &copts))
+				die(_("could not start 'git column'")
 		}
 		filter.name_patterns = argv;
 		ret = list_tags(&filter, sorting, &format);
-- 
2.43.0
