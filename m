Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F3B1D589C
	for <git@vger.kernel.org>; Tue,  3 Sep 2024 22:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725401175; cv=none; b=G8TtYh272dpxdFUKiNUbvZnYcImrJLV3bQSsyirhEpkZb8qIWXXGwF1+Fon1kbUJ03ZuB+8p9rzJIjEWJLxQJ4qKpVKFP9QjIBHA8beCBazXR5nQMweZLWF78Y7JhMGBbB/4UPLkN2BhmU+EdO+XlgNoHbmJ69Ye8x7DuVKEXUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725401175; c=relaxed/simple;
	bh=Lp8BUtwJb4BmNMUleeFvfk1vS/XsEkncxa6WXnv36+o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pzdqbHvy/x6/IbBOurgzF9UNHZzcAwJxBSYRBs+9DRC8j3UxkjjQjtaLw5eI1NhGK6HNJK5rpXjeBSuuh3zHkqgUHCsHwyvINBem2AWM0KWieZs+iwdf9CMESn6ajq0VJCI/5kYXO5/lUeRBt3aaCs2JEAj6mX6Ou0FjS1SAYP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ku+K0NU/; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ku+K0NU/"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-42bbd16fca8so38908685e9.0
        for <git@vger.kernel.org>; Tue, 03 Sep 2024 15:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725401172; x=1726005972; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dNLDd92lV3MkndNd7g1R05F6TKM/GUU2bbB10LzKd1Y=;
        b=ku+K0NU/WdV7RqkRql8UBeV736MPSUtpOKxSg9z/NlEKeQZXwOSMn/TQ2a110xuOSt
         PYvXC52fpDhFMCSXuPlsPIw6mkfF2/R//mUHP97qakKZV/1EcI1zPNsukvzshLCBgSTw
         sxH3cafYHo9rUsCpL+NpxOJlORSoHxKbVK/QCeRPlReEJefA5VrqpvRvtxdCqC8xCRgQ
         m/sb9uII6bUKW7YNMdgu+07gXmRPWDsuERxT0pK6NaPkVKqqXBLmkVA6chi+ZV+3m9jD
         pjCfwkIve3zZKR+ux3qwrk9vX6pwGQEm9RN6ZvRlQYh9oeMYPoya0h/jVsKEe3ZBiy1S
         z93A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725401172; x=1726005972;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dNLDd92lV3MkndNd7g1R05F6TKM/GUU2bbB10LzKd1Y=;
        b=Fivwz0N3PjXdkkHkTWzuuoUDQqatpCkbgCvMMMCySZZO91ti18eeE958rSkUAX0W3H
         AZVasJTIyQW7a1WAeGBRAYBPWV1k4vApGjDjWcHUKf3wmyLhjqm12HRlebN/NFr8yH7U
         /W8478JuuOHnxMxKY8ZR1B3gDfOEwkpJSe4brgFrwtUpAQGEIQ0ENkkRTVP/Oahlf7Ya
         GuVioLhJ9IlLShHCcwmXgbRrYOQIp+zb2f3IZD1pUaVcKSg96/fQ9GIJKyim3QkG4o6R
         3DZp2eSyoFitiA/jp7qSH2tNf3ltw/GojSpNfRAqeUiGCNEcBbROP1xi1fFFI+B/QYYL
         JwPQ==
X-Gm-Message-State: AOJu0Yy1TYLUsNOaRdfpBkyleoidMiRaMOkGHskMPB+z7uB9awUWmkus
	yWn+qxm2XQxFZtYghZTN6f14J9A/o1bw8ztTpVQfTT/pz4RqOCET0aUpow==
X-Google-Smtp-Source: AGHT+IHFSkdG/Tgt6phQieuXC6ACJLPNCEwQfQrCVVAp+HZrQWIUaaFXyzNEKB76EpLOYRdCXRP7BA==
X-Received: by 2002:a5d:68cb:0:b0:374:c022:fa76 with SMTP id ffacd0b85a97d-374eccc7e5dmr3380694f8f.37.1725401171676;
        Tue, 03 Sep 2024 15:06:11 -0700 (PDT)
Received: from gmail.com (57.red-88-14-211.dynamicip.rima-tde.net. [88.14.211.57])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3749eead897sm15171960f8f.65.2024.09.03.15.06.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Sep 2024 15:06:11 -0700 (PDT)
Message-ID: <50d85a93-6711-4b42-87a5-f26b58b8c5c7@gmail.com>
Date: Wed, 4 Sep 2024 00:06:10 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] apply: honor `ignore_ws_none` with `correct_ws_error`
To: Junio C Hamano <gitster@pobox.com>
Cc: Git List <git@vger.kernel.org>
References: <6dd964c2-9dee-4257-8f1a-5bc31a73722e@gmail.com>
 <1eb33969-1739-4a27-a77b-3f4268f5519d@gmail.com> <xmqqseuqerb1.fsf@gitster.g>
 <afade304-51e3-441d-9ae6-e0a422d00bc4@gmail.com> <xmqqed66udmd.fsf@gitster.g>
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
Content-Language: en-US
In-Reply-To: <xmqqed66udmd.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Thu, Aug 29, 2024 at 04:13:14PM -0700, Junio C Hamano wrote:
> Rubén Justo <rjusto@gmail.com> writes:
> 
> > I'm not very happy with the new enum, but I haven't come up with a
> > better idea.
> > ...
> > None of them are better, I think.
> 
> Not adding a new enum is probably much better.  See the "additional
> thought" in my review on [3/5], for example.

If I understand correctly the example you mentioned, using
`in_fn_table()` cannot help us in `parse_fragment()`.  But I could be
completely wrong and misunderstanding your intention.

I still don't see a better option than introducing a new value
`default`.  Perhaps described like this:

diff --git a/Documentation/config/apply.txt b/Documentation/config/apply.txt
index f9908e210a..7b642d2f3a 100644
--- a/Documentation/config/apply.txt
+++ b/Documentation/config/apply.txt
@@ -4,6 +4,10 @@ apply.ignoreWhitespace::
        option.
        When set to one of: no, none, never, false, it tells 'git apply' to
        respect all whitespace differences.
+       When not set or set to `default`, it tells `git apply` to
+       behave like the previous setting: `no`.  However, when
+       combined with 'whitespace=fix', some whitespace errors
+       will still be ignored because they are being fixed.
        See linkgit:git-apply[1].

 apply.whitespace:
