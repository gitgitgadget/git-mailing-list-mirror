Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDD4521C165
	for <git@vger.kernel.org>; Wed, 19 Mar 2025 22:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742423031; cv=none; b=Vk33ZLAKDSVlhaS4topoUMHMnfE+bqyXu2flx2otPDoe0YfP1hOUFE5E1xPukYPWfayNpjX0q+QdZ9BKkqyIQ9/FCImE7gxpNiM9xJgdd7Qoab41nQfTZxjLFsNHa8rCCJFaCQCQYxv2cA3QwUhgaxyQzNOVRu2sXxLoNg9w3P4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742423031; c=relaxed/simple;
	bh=44fuOkf9smCJfTZbZeQAk6fjEnv4kItUV1yCA1Cw/3Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sA+nXbuTOSudJ09U0jPzasdMxHMjsFJS05VLzMem42/8dy1iMS4U+thCiUhgDZbMx+z62XLz2eykJjxu6sJ72BCqWEIEHlJtM6kN3oWOKkxalN/iu+UsTQIJzAVBMdVBkqhhiXaVNf/1JJZunXTPxrwqPH+p0rLuiq2WoENAy0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=C9H9KIaz; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="C9H9KIaz"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-46fcbb96ba9so3367761cf.0
        for <git@vger.kernel.org>; Wed, 19 Mar 2025 15:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1742423028; x=1743027828; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=56LGHWOqTO6XqxlWytA+wBgHSoRDX7qpcLtW47pCkdI=;
        b=C9H9KIazXI0wt+TjTGp6f1T+nL5qJrc/aLYBrEgh6l55GfAl9wZd96/wGEJTW2Bh8R
         2r0C6v/TiAEAVdIq2SDfACJjiYajBH8FRKWW7LHcpMBXyaJ22nkR3wttGzoDKcMOfy/G
         yy6EJSZA0nwlF+bX3+tOCJ29hwamLDVBsoYAuuXsJe+9jeLx5qbJDm2rSSpN30/vxQE9
         uuhpEWEqh9/pXxhitqop1H8jmLkyKU3dyqcnm660IGVDmYxnWmLtTeDznxU8dhp8S51d
         ea161if4PpQ2EsZ+TCYeqjksgdm2AW9jXy2RXWUTqNlh0M/cFMe7AvlfZrITyfz3K+XI
         EzFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742423028; x=1743027828;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=56LGHWOqTO6XqxlWytA+wBgHSoRDX7qpcLtW47pCkdI=;
        b=cYAmrY1uRjviU5+NMPZbRXDmfb2q/42yIUM6WF6BA8ZqrtHk/ZqWrRSa+XbxEG3de2
         3zs5+nIUH1X7h21SWMQxj5jj6MXYGSEE3W6Kllk79GJZdcWGSuqbENUWmWzR3/7cnhiY
         PL+x2kIWqUg4d6t7Zlz2oga1zcyBL5PVCaAQ/0h84Lz+ecRwtzVIcL26swKyiYVdkl5d
         4nnUR+QTeyTE/cpkPtDcnvEhQCwl8K9Sbr8DXIpg9eqOBqbFQkXqQ5PQByqrP/2pcetW
         YO2ogX8VdR+1C2ovKNvcZzaSoehfSTFqBbH0iz+unsGiV0/SRNeAWoWY4Ep2XFyqYqOY
         aTZg==
X-Gm-Message-State: AOJu0YwHJDidJJS9KtsgsXh9UipVJyqCwbQ9RaG8WrCgHQ9lE1pABB+L
	53I82TMUTTdIT0/14yle3FPG56uAwZSkZg95Yw7xdPJPVfA0kW2q1/0V7VA2BF+S6V3ywFn3GXX
	ch30=
X-Gm-Gg: ASbGncuJzVe3Vih+m+neLVQ6DR0/WASj3xW7gxMgHQR1awErmI7Z2F8/aYMK13V56Vt
	9qF9FSqsGNTWNVBFRInFpvLpNcA/vrflVmQN7gxBvHoi9BnPUg6L9YhVsL+kEeRSANiwb9jyzwY
	uhg/gHXuQnmHzQ8X85RgsQgECLYBbRXn+ExtBv7utUmnbOWA0GD5kpER59IaVPdfijtCK4eO1/Z
	YZkmoKZwiqiL+Q29mwsp0g4dCpDRIxKIkR3xRMkr5YFfPjFpPRPpGpcZwxmiarS9YXXFIiahFiE
	oXGP8yNIg+q/O9wyIxUqjbydiUp3oOpw/KZmydDMt6vq4JW4l/EffFnHfYehwDuE/uWTv0mbCsi
	4hHJH0pcKO0RN91I5
X-Google-Smtp-Source: AGHT+IFh9Dw5TYO54a1Efac3vgx9Q/wsDmx0+RH2fqtWrIh+U7ddLtiYFVPyPb+vOUAFYCcVnyoAxQ==
X-Received: by 2002:a05:622a:5c92:b0:476:b783:aae8 with SMTP id d75a77b69052e-4770834eaa9mr73059211cf.26.1742423028385;
        Wed, 19 Mar 2025 15:23:48 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-476bb7f1f39sm84400801cf.52.2025.03.19.15.23.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 15:23:48 -0700 (PDT)
Date: Wed, 19 Mar 2025 18:23:46 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 1/4] http.c: remove unnecessary casts to long
Message-ID: <204e5e18d28951c3cb3c2e70f41873b263b65746.1742423021.git.me@ttaylorr.com>
References: <cover.1742336481.git.me@ttaylorr.com>
 <cover.1742423021.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1742423021.git.me@ttaylorr.com>

When parsing 'http.lowSpeedLimit' and 'http.lowSpeedTime', we explicitly
cast the result of 'git_config_int()' to a long before assignment. This
cast has been in place since all the way back in 58e60dd203 (Add support
for pushing to a remote repository using HTTP/DAV, 2005-11-02).

But that cast has always been unnecessary, since long is guaranteed to
be at least as wide as int. Let's drop the cast accordingly.

Noticed-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 http.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/http.c b/http.c
index 0c9a872809..0cbcb079b2 100644
--- a/http.c
+++ b/http.c
@@ -438,11 +438,11 @@ static int http_options(const char *var, const char *value,
 		return 0;
 	}
 	if (!strcmp("http.lowspeedlimit", var)) {
-		curl_low_speed_limit = (long)git_config_int(var, value, ctx->kvi);
+		curl_low_speed_limit = git_config_int(var, value, ctx->kvi);
 		return 0;
 	}
 	if (!strcmp("http.lowspeedtime", var)) {
-		curl_low_speed_time = (long)git_config_int(var, value, ctx->kvi);
+		curl_low_speed_time = git_config_int(var, value, ctx->kvi);
 		return 0;
 	}
 
-- 
2.49.0.4.ge59cf92f8d

