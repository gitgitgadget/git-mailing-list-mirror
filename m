Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55DE18003D
	for <git@vger.kernel.org>; Mon, 22 Dec 2025 02:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766372387; cv=none; b=Kikc5oU0C08UL7NE1OmRayvm1o4rqdnkH8Bwm2xtPWR9dhSwLm16PA0oP9al/NIE5JlMSkUgQcoTsHsmIZabQezbJpFRxeM3IIk18x+DLz1LC8qYjPFmPj5JOUfY7hEcSW6I3XKhOMkHVGcAXM6A6KKHjC2hzkX16XGb8YYfsR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766372387; c=relaxed/simple;
	bh=DbsGFjyi5hYd/2IeNPjyn96HaCBPugXk9WGz9WqFcxk=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=TSDcIxjlpC0KAZuz+FZwHycZ8PmLGswGlSYMEBGX18k8fQGLtZ0Mz7NQdU/In3c1I8diQEIGMK2P3m7plFOEpi/4dDBqCjpryOkv97CnYgpcVtw132q6F3fX2UWh6u8Omn0y49RJ9TmktpbyQNGrSayPhJ3tUCVVOh+VLiR8E+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aK5v2Wbn; arc=none smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aK5v2Wbn"
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-6446704997cso2834863d50.2
        for <git@vger.kernel.org>; Sun, 21 Dec 2025 18:59:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766372385; x=1766977185; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DbsGFjyi5hYd/2IeNPjyn96HaCBPugXk9WGz9WqFcxk=;
        b=aK5v2WbnBESdusPzZbMTmhj69x1J4Vqe+shpR6tB9fHwDjIR42vK7Yu0AMsodsgq+c
         +aaT2AWl1M5Sq4n/ro9rSGtHtvD4tNBlDbuxe9M96qvUFhPp+9XvVW5vGjaaeNB1Y/uU
         fz4U/G/qpZckSnK/NARLtk8G5MVRjMyQiGZd+RAEnapB8OdKvws9euLq/7sjydMCWRz6
         rk5zLHDDKdDxedPlM3mtxdacEYw6nUGMyMZ464KHnJzcutDbluTJQdGW6pgfSJG9ov6/
         +CkCgts1CUsYiVZrvHiqqKkvP8c3ESQtygn1IgQfxw36rtY5rLlAOANwqMblpYnm7ZrP
         vutg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766372385; x=1766977185;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DbsGFjyi5hYd/2IeNPjyn96HaCBPugXk9WGz9WqFcxk=;
        b=b/65N5dh6J/IhfymRDaf2l1g7eXZug9F8JHlxP/oKN1P5dkuAs/u2U+RLy6eNSkCT9
         I0jXm14HvUvqD9qxwr+eswqeoCI0j9gn1KDOWz+VFrdfVaE86QrbS6+DzV3dAIC3lRQN
         6D4o/CqXhnrYU681Zdx5vzRTifnH3y8Ugrx8qO2Z4/k05N1OYl+kYicNJLO1KSu7NrpO
         z2hCRC7uvLtaI2g0bV53T/qS+o2CQ1oqvBorXct82tCo0FIEeOA+zji4ccyb4G0uyXLl
         cxrIgJiVnSaXBJgYttQnaOphC2doVeXaD1nxAdRZeu9l9HHtNuufHYimFaiPqSflXrGS
         i72A==
X-Gm-Message-State: AOJu0YwPKTYQi1IbUUhhmwmLS2+NWBiPBk8r1yRY0PkF2jLfVRhhBP90
	UVqs3RuaC67T3CqgzmXpn/gXyDxqxiZGLHmZ7nS9sbvydqz1sDy8q9l0UMfzvKWKHksrFmYxox4
	ccLBphrh2CPryVUQg30InEW+cIJ2K84wiOaWp
X-Gm-Gg: AY/fxX47RoJj6VJpunpLKQXLSZ75XwcdPl3s9wheHkem4zOS92Il5Ty1EwQq0V59CSH
	c9aMzb+5Q5YYGZ3eovFp9frr0n0casRvhy/OjemWsTlNt7uKHEk9IZuoDMtHYlTXMSHk+DpoC3R
	Ac6dz+iaJVJRTZzW7dEf8hpucRfsLd+JWJg/jJi2wo1T95SIXHBIu5a1ySn3mv6Aro85GdOQEQA
	ELXDwdRnp1rIPOMXrmUMIab7ZYqF+cckutJngfAF2qNzUgS29HBYmjW6mZ1WldF4Lj0tvCdiWu0
	5Q==
X-Google-Smtp-Source: AGHT+IFvBdl0O9pQOV+m7ykHtCDzayGBPDFzZQj+exURKqEQcXYGN57l9gxc8CB6s1vhQFA1IZnr/WlBzC8IzNPgnC4=
X-Received: by 2002:a53:ccc6:0:b0:63f:9a42:f21 with SMTP id
 956f58d0204a3-6466a83770cmr6005883d50.19.1766372385144; Sun, 21 Dec 2025
 18:59:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Klaus Sembritzki <klausem@gmail.com>
Date: Mon, 22 Dec 2025 03:59:34 +0100
X-Gm-Features: AQt7F2r5fJWHi4N79O7YHNCNfDR7TXH10sDaHBJRWjSGribvzZbu19TRq_0x0NU
Message-ID: <CADMnYXDqHYLjDBT8D3-VqctY1fG8ag+Nb+eeopuOvmmWNho4UA@mail.gmail.com>
Subject: The alignment problem is now solved for LLMs
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Dear all,

I am happy to inform you that the alignment problem is now solved for
LLMs. It is published here:
https://gist.github.com/gre-42/857f74235fa62be7f2641c3e9f1dabc5

# Solving the LLM alignment problem

The well-known alignment problem of LLMs can be solved in the following manner.

## LLMs used as world models

LLMs should be viewed as black box systems, taking an input and
producing an output.

### Low-dimensional input and output vectors

Both, input and output, should be restricted to single sentences or
function graphs (with an x-axis and a y-axis). The sentences should
additionally adhere to rigid sentence templates. This makes it
possible to compare output sentences to gold standard data.

### Model evaluation by splitting data into training and test data

Additionally, data should be split into training and test data, as is
common practice in machine learning.

### Implementation hints

- You can get curated data from [an encyclopedia](https://www.britannica.com/).
- You can avoid overfitting by fuzzing. This generates different input
data that should generate the same output (regularization).
- You can train domain-specific models with dedicated (reduced) input
fields instead of fuzzing or regularization.
- Unlearning selected input data generates different models without
exploding storage requirements.

## LLMs used for summarizing text

LLMs should not be used for summarizing text, as they employ causal
filters for what can be viewed as low-pass filtering. Instead,
dedicated text summarizers like the modified Edmundson summarizer
should be used. [One such implementation is available on
GitHub](https://gist.github.com/gre-42/79b763019a9a14b9e5d19d4855c466f8).

Cheers,
Klaus
