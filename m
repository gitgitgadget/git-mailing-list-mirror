Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B3B93D349E
	for <git@vger.kernel.org>; Wed,  5 Aug 2026 18:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785954679; cv=none; b=ryG8HNpZ/Mav5hbQUNVTrgc452Q6UOyc439tLpcJn4+5ZbpYUv4MZX4uapV/ldBkMj2UMbmIqmH0ZkeC8SDw1pd4/q6CAPEh9Tdm/P19Puct/kFgWvLaZkfYEJXQ6/QpZY6yVnP/LtUbPi59mwZAvYrpLNJJqL+vFrAVa+5T+RU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785954679; c=relaxed/simple;
	bh=+Muevasa9jPcYd7V1K/wLI+mK/GrFv6eGna0Joyn92g=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=aE/TKvZApxfzJSxY0AeUUI3EsCi6GH5EDkAnmxabCtf431plqbvNbacGtbD9VvRonXVQR4PEOKns6iaOV5lm4R6popV7PK2bp3JSX63tpmch+/QQAaFsub/fNVzLY1Kaa1ZBKB9jSrOlGIw6Nq+UA4qdpZqU6cYezGfgz9OBbL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j5fc2xuw; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j5fc2xuw"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-8485ef63b68so1993257b3a.1
        for <git@vger.kernel.org>; Wed, 05 Aug 2026 11:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785954675; x=1786559475; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=sNwElakNprIyz8vd0DZzwqm0QIUBxJKxuV/ofs2Zw+8=;
        b=j5fc2xuwbrjaS92oYk0LBEK1RQAMI+sa+pH4iYu8mu6nQ9Id4OaZ9/j6qNO+HvFS1M
         58ieITB3HsHbe63Ewm+cajbTduumh0/QTlXJ0S2fJgubm9K9XZg+Jgmw9XnoTd8GfvFZ
         7+5OfvpVbLtpcAtiwwX6imtKtJCAK43r2OW5ep0QyTNLcDxXKlNwNthl/XPePGIld+Pa
         WHNrAMLAi4Trdf5L1XjIdXmbZH80JmGGXxW2LLFlfW/yLOO2doPgjDIvsJXdvv0HXw8B
         oJG93XxQ1YIprJLIgNLF8YUtSichckkrphIIedm5/rcqkAzf1LYDhcdkhE38oB3YJobK
         kQuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785954675; x=1786559475;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sNwElakNprIyz8vd0DZzwqm0QIUBxJKxuV/ofs2Zw+8=;
        b=AkcH9P49J1QSPM/Fz6z6hT366mdG5t2XnKg+BbEEzeD/E9N9fwj6L8MNoOoKvbYJ+t
         yBnhSR2120upv1NRflYfuYP8Tdht58r+MAQf60ST1XPpeMSOy0la6PBZceyYlZezo3nW
         oatUMLfKTecMMMWjHRQOq3t7FcBCqqb5Psi5M8A7G7AlPb0o+FXck1hveGOOdAgXIveQ
         /sINa8OywNLXcN98caxnfXUozaIILa9IliBYx/gakwOdbXotHf29ukkztGEKZs5sBqPr
         jqsyWuJWTLSJrFloC2CZpHsJUFRDmOKAMuIXUDlOPdCiqQD26DvkL7FUsZtrHsK4xIcC
         OAOA==
X-Gm-Message-State: AOJu0Yz3ebApgld76Eyp9wdGH+3SmHYjYc6lXbkG2GgzHuk58mkTAq0S
	TTKacw3w2RAzQ7nb/Xz8BViaW+euNAziKHmFISwioNrseYbk13yYnseUklRecA==
X-Gm-Gg: AR+sD13QQiCEQPu4iaWeOYYoI5b02t53m5s2cLpjr9LuVbKUW5i+k7Bx/EYvKqWYTSv
	VjOoNBWcuNmt0jucw0ZLyQtgo40uKcICZHk9ZIS6SpF9QdCk+K9yHnxW3y4t7xRllkDj/sYqK8c
	uP3EngnYUNJZWFWWpoUo31MOKAJ8hEXf0HWrnAbBwtlvh+sydFNLjTZyLZBdKVLSnYgYMxfwFw4
	v8v4drmJBBtr0vQVqEylxH2XVMOIMEXDvgFsc7MFnNVw1bQMW5OxNy4FFMz2OV0b315fhNOQqTR
	gDAseRyworriz/NlKg9VtFH/tT3b4zEi/XDqkLVLTRqBu/+xd3qhHlGRh4IzanZBMKJb2MW5hAw
	hc1qHPqANDkofq4ct8HHidqQOSQpkHjipVeJbhvMhhOh/fwSexGjJ1go9UNEtmxQcoIJ0/4IUXn
	FbYdoY3gK7NykNPuGQ2XYbaRXcAOaimX+bUPUznKPhsL8j32cgkPeT67lk9DbvzMyjmG8=
X-Received: by 2002:a05:6a00:2d0b:b0:848:4d1a:9554 with SMTP id d2e1a72fcca58-84f2e0ed972mr9631489b3a.38.1785954675387;
        Wed, 05 Aug 2026 11:31:15 -0700 (PDT)
Received: from [127.0.0.1] ([172.184.220.200])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84f2e52e28fsm1259149b3a.53.2026.08.05.11.31.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 11:31:13 -0700 (PDT)
Message-Id: <0facb9e8cabc739cf05829934fb2399ed9a58259.1785954661.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2179.v2.git.1785954661.gitgitgadget@gmail.com>
References: <pull.2179.git.1784069325.gitgitgadget@gmail.com>
	<pull.2179.v2.git.1785954661.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 05 Aug 2026 18:30:56 +0000
Subject: [PATCH v2 07/11] transport-helper: check dup() return in get_exporter
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
Cc: Patrick Steinhardt <ps@pks.im>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

get_exporter() duplicates helper->in via dup() and stores the
result in fastexport->out. If dup() fails (fd exhaustion), it
returns -1. The child_process machinery interprets out = -1 as
"create a pipe for stdout", which would silently change the
fast-export process's output wiring: instead of sending data
back through the helper's input fd, it would write to a new pipe
that nobody reads from.

Check the return value and report the error before proceeding.

Pointed out by Coverity.

Assisted-by: Claude Opus 4.6
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 transport-helper.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/transport-helper.c b/transport-helper.c
index 80f90eb7ba..31883b244e 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -487,6 +487,8 @@ static int get_exporter(struct transport *transport,
 	/* we need to duplicate helper->in because we want to use it after
 	 * fastexport is done with it. */
 	fastexport->out = dup(helper->in);
+	if (fastexport->out < 0)
+		return error_errno(_("could not dup helper output fd"));
 	strvec_push(&fastexport->args, "fast-export");
 	strvec_push(&fastexport->args, "--use-done-feature");
 	strvec_push(&fastexport->args, data->signed_tags ?
-- 
gitgitgadget

