Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F5CD1D5CDD
	for <git@vger.kernel.org>; Fri,  6 Sep 2024 19:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725651973; cv=none; b=VHZL+6kDVgfLgY9PX9x8ArXBYLJlViWAs08a1llUTXDaExRrx52gm1dIP6N08YwmzPzekm8DX0i8o+q4Zw9Mte+BW9QPKCB0+zG24DkNDqvr7PFKIrRB7UG3tlHZFnpKTiT1F+U91y6PcllsKYjYAfuG0+BggcJAHso6AKyYLFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725651973; c=relaxed/simple;
	bh=0PCuwznYuuMmJwyBB8SBMMCsV0vgqVxxIK0Z1qKxcJQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BuuAMvh8ck60qVFbLgux7Cgy2agyuY9IkZzMEHUDdExSHZKMf0c7jUPuR8rzw4CAmRLrPI3pdSm3Q1QwB6KiF747XTSMPE4NARiTtQdiLU/7RH/BBNO00ss2/X7hKWDu53PikqLAaz8L+XE8x8Wb1tcDjzTjO9Ak1KIP98mZmh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=R7WGgxSI; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="R7WGgxSI"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-6b8d96aa4c3so21271177b3.1
        for <git@vger.kernel.org>; Fri, 06 Sep 2024 12:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1725651971; x=1726256771; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3M/vSL32y+A00DK3aNCbx/JcjT4YoZydZ4tyP6jjVlk=;
        b=R7WGgxSIX9i1Vnt/ibffKhKuTDcPWrJtIoC0W0BDHM878K8MyG5KcoSRBM7b3mm4HP
         bPuq0AmGN6z96U4t6WDcLAmXrcmFMrUw7CXXEG8k5tFD2PxNr/J22BW1pj9Uh3lfVuJ1
         dUFY4yxQIgAzl+qrjrd9kLDitEed/XVKd9Tdw7GmlGrJJSPOhsiwOBHZcYnE14D4EbHn
         RLXLXWADkgDTBNW8zhXQy8g08lOD8r1lQYPhbAj9ToJ80LuveQT3Y39OPAmCFfhZMx1O
         KyqqDCw9nOljp31y4kozH0R3BH6zz5L1rx++k38F9zeX07zQnG+lun4SyjQlpPWPafv9
         4NVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725651971; x=1726256771;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3M/vSL32y+A00DK3aNCbx/JcjT4YoZydZ4tyP6jjVlk=;
        b=RzFglZURPLI/JGxka9BiBwKUrgbF1rKVO+UpJX6uQEZfBVtNtVCzAnMnjVRipW8tr4
         oul/8ejSyQp3GuUK/573/bGaJFd6mmrghaWCXZiZKlpGqfdW9uuukT/B2ruY8TGC8q/h
         nJtnuNmzs2p16TaAN81XCsoo644dHkj6xoxCrmzxV7X9se3YnrleDnnyLeYZSVBnaX5T
         91hrZI4y/cknXTL8ZePDaGuXdJ2eWyEyNUboE7U49tufomexSlzN2/yc5Y3Tg+vMQzj8
         i4pYAPO5v9a1GsToIUP5dZr72zooRdKMHxC2zxcl/zcbm7MsIIQ/Gz0rQe0t8snRe3BW
         WaRQ==
X-Gm-Message-State: AOJu0YynyVajEJpLhMBqYlN0YW4u7qAF4sUicCtOGPPhWLfUApy3rtVN
	S708/5N8mD2yUajvKOFZGKDNOSuVQRtQ4v2+0mqTOK97e9iB/irFN6+GKre0EHMTKDA+qzEsBB2
	J0s8=
X-Google-Smtp-Source: AGHT+IF1HbIRXxAVgb92612GcMQ6URQ9NQ0YgYdEruWxwb3N0Foy6h1djiVGknrLNeKmeOwZ3KGVzQ==
X-Received: by 2002:a05:690c:f01:b0:6b3:a6ff:76a7 with SMTP id 00721157ae682-6db44a612ebmr51390707b3.0.1725651971050;
        Fri, 06 Sep 2024 12:46:11 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6db56337dbcsm1145247b3.44.2024.09.06.12.46.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 12:46:10 -0700 (PDT)
Date: Fri, 6 Sep 2024 15:46:09 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 2/9] finalize_object_file(): refactor unlink_or_warn()
 placement
Message-ID: <e1c2c39711fe57da3592eb35175497f690a505a3.1725651952.git.me@ttaylorr.com>
References: <cover.1725206584.git.me@ttaylorr.com>
 <cover.1725651952.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1725651952.git.me@ttaylorr.com>

As soon as we've tried to link() a temporary object into place, we then
unlink() the tempfile immediately, whether we were successful or not.

For the success case, this is because we no longer need the old file
(it's now linked into place).

For the error case, there are two outcomes. Either we got EEXIST, in
which case we consider the collision to be a noop. Or we got a system
error, in which we case we are just cleaning up after ourselves.

Using a single line for all of these cases has some problems:

  - in the error case, our unlink() may clobber errno, which we use in
    the error message

  - for the collision case, there's a FIXME that indicates we should do
    a collision check. In preparation for implementing that, we'll need
    to actually hold on to the file.

Split these three cases into their own calls to unlink_or_warn(). This
is more verbose, but lets us do the right thing in each case.

Co-authored-by: Jeff King <peff@peff.net>
Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 object-file.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/object-file.c b/object-file.c
index 683e6b2a0bd..54a82a5f7a0 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1911,6 +1911,8 @@ int finalize_object_file(const char *tmpfile, const char *filename)
 		goto try_rename;
 	else if (link(tmpfile, filename))
 		ret = errno;
+	else
+		unlink_or_warn(tmpfile);
 
 	/*
 	 * Coda hack - coda doesn't like cross-directory links,
@@ -1932,12 +1934,15 @@ int finalize_object_file(const char *tmpfile, const char *filename)
 		else
 			ret = errno;
 	}
-	unlink_or_warn(tmpfile);
 	if (ret) {
 		if (ret != EEXIST) {
+			int saved_errno = errno;
+			unlink_or_warn(tmpfile);
+			errno = saved_errno;
 			return error_errno(_("unable to write file %s"), filename);
 		}
 		/* FIXME!!! Collision check here ? */
+		unlink_or_warn(tmpfile);
 	}
 
 out:
-- 
2.46.0.430.gca674632b70

