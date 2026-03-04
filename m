Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 132963C3C12
	for <git@vger.kernel.org>; Wed,  4 Mar 2026 18:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772648266; cv=none; b=FK2QTrZgXD9JD6okBX8O+5aK3qN1ECwejHLhbIQw+YKOU70QKYhBK5ZpRBhRrc9r5aW7g45NHckitro+A+jc+/h1Q1hcOsIAe9sXBGJkQhmUYvw++J6fsw0w7CyiGneoZVA6sz4u3mdcpmaC01p8yyy4uutyEAFRdGKj8H+9BIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772648266; c=relaxed/simple;
	bh=HXBkM6UVdU+2nkz0NDjq+Yxvz99EkHHYts9Z3OTKfUk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LQjv2ED32P4wvVTSTgQZyYXxG0yOds3KnaLyyGEoIq7G1JzRyCPZdJbThUZTYGY6NOlolFbMBcRCEzjD7GWLTKVZepJu7GLPF+bQ18N4BFvJpq/ocTs/JRf8+S/NIBPism3MCWQAp3Bw+cVvvUkgiI5jNDdhv77WZal+B0PsruA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=paultarjan.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wau8dz4w; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=paultarjan.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wau8dz4w"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2ae56f8776dso23707645ad.3
        for <git@vger.kernel.org>; Wed, 04 Mar 2026 10:17:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772648264; x=1773253064; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HXBkM6UVdU+2nkz0NDjq+Yxvz99EkHHYts9Z3OTKfUk=;
        b=Wau8dz4wZQ+qBfAJvEv890Cmyp/cXfPLH2uWgLJUvnruo7VuXWJvronhQqodeTsASp
         mhvLPmleUjqd+tH4TT4QvzJAOhKSwxJTsjPvar31HxNgh4Mm7zT9EqD55logSlN57U9F
         0tV08qlOOeARDGeS7dk8KqvmbZNkucJvJxUQbLQrgMA1DiVePFPdB6oUO/gjZzi60Rxi
         kBcfJfwYjiT8zf5/PCpelHXNSE7o5P/vRZ7P6izPxR5LRE3MwP0Tewx4NqUx/9Ee952/
         x7TDyepzJChmleccUmdfzR6wfb7uKx0BS49lqkR/457BCiAjNszu3digYpNZlz3+gV7g
         GtXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772648264; x=1773253064;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HXBkM6UVdU+2nkz0NDjq+Yxvz99EkHHYts9Z3OTKfUk=;
        b=O6xPOpzMqqfCvMuFF1BiD3Lqapd/DrmPbitdge9qWnG5xrqX6fQxzW6s3+Hemsn/LT
         oX8laB4CB7jtM4BAXY6M+hW0JwiU+o9Pk3j0QyMqhXZCxH7wih21XFZaVtQOyu3o39Hs
         fRk8aaI9l3Sfkxk/Q+VPtDXYVNf+6WN4kwyaedFAxMBfwIX9s+viMLJQEzBrsmTjjaeg
         Jx242kd63TFcCHFCHOvzbrrzT20UQhHxChLay1EAFIAngA5316EZge8g8xUf0UCiPMOc
         l1kNTjQ1YEMz109m3CaxiR5of8USH0ChblBPyHzdoysLofg/VGbnynmcULLbKHjGxLVX
         IYkQ==
X-Gm-Message-State: AOJu0YybuXAXonU55TEPsb8yJKLlr9+NBXVqWYc1oC1gyY3KMITacPB5
	i3lsvBlCozO7Q4T0tndKH1xMLKEyvaG2saBqyIrrDiXR9Rj/trz0RvopCyZyDw==
X-Gm-Gg: ATEYQzyWEHcroX3HYouIlCjIY1wZA0DH1fUI87R/3uBWtGlvotvtK4R0BXW4tOZ3526
	l3b3X11cxaKfjEzeCA8JHxbdsixBY3zNa45S+0raDD5slcht2o6MzQ0JtY17X0/B5kygDfScCrm
	GQdIgoY7z1LH0WIDEDeTyBvcy7M7r4zOOv8x0KgLjeHc6L1LSEo9E24zxQDvdfUAcmLu2kqKOPy
	AAemD2WhIC/39N+qJSCzICiEMp52cTKVpsohb3+C9kxJciw3gHxKYCQ7i1rzFb3GMwaIdcn2HLP
	6c6RbhpMJ2YvFmqWnwWds+S73mJcIxlzUR6uu6eeKqx/laBexLHMNDvZwKXms/3VcqDKTMG1DQs
	siEDLpd9/Xi0hw9YK7RpN5gtz8XSSQcxy6pNReNUQ8wGZBWlA+Si5tBE/UL3o+zGx1/bPbK9y9h
	nSHbsdFVnpAs6M/IhWsXYthCl+f9kImHpQGgP1FNS7WuSKwRdrBFkX13rRTDG/pkVF3ptvicQxU
	MNL8AXFTp9NOda8cjYF
X-Received: by 2002:a17:903:388e:b0:2ad:ba80:df62 with SMTP id d9443c01a7336-2ae6aae8d8amr27134945ad.37.1772648264082;
        Wed, 04 Mar 2026 10:17:44 -0800 (PST)
Received: from localhost.localdomain (d75-158-111-22.abhsia.telus.net. [75.158.111.22])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb5b48f4sm201673665ad.13.2026.03.04.10.17.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 10:17:43 -0800 (PST)
Sender: Paul Tarjan <ptarjan@gmail.com>
From: Paul Tarjan <paul@paultarjan.com>
X-Google-Original-From: Paul Tarjan <github@paulisageek.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	paul@paultarjan.com
Subject: Re: [PATCH v7 02/10] fsmonitor: fix hashmap memory leak in fsmonitor_run_daemon
Date: Wed,  4 Mar 2026 11:17:42 -0700
Message-ID: <20260304181742.25634-1-github@paulisageek.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <aaficy025yUqsgN5@pks.im>
References: <aaficy025yUqsgN5@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, Mar 4, 2026, Patrick Steinhardt wrote:
> Is this actually sufficient? as far as I can see, the cookies are
> inserted in `__wait_for_cookie()`, and each cookie also has a name
> attached to it that was allocated via a strbuf. So don't we have to
> free the name, as well?

You're right, the cookie names come from strbuf_detach() so they need
to be freed too. Fixed in v8: iterates and frees each name before
calling hashmap_clear_and_free().
