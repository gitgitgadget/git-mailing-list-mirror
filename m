Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12A235672
	for <git@vger.kernel.org>; Thu, 26 Sep 2024 15:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727364156; cv=none; b=Kvm0YvoLUa4WAc86EQOtzuoC9vASLDjWtByW8sUzckig5k60Avlk7AyGwIcdALxDqKKyKtqfFt2nw/5xWdfLeMRncFiUGxlT/+wPq1ovdYjtIbzNebjtl+mFAcKjpffwhQVk74JOYU4fwjgr/Eb3fCrSP09CqAkusi7wzLz57vU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727364156; c=relaxed/simple;
	bh=gFldgANGjE9FE8m8avklbkSZQ+IfRpTbs4Pllt771x0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YR/oHkY2yeBywp5PqetHXdtk4jFuBxcPNSH2ZUxSyaso/PrN0epKYi7GXGft++DMPGWH6k5VthjayDGGltKOh8K75KGapcFHkdw64RDxulw536FmgP/V//HiekCh+Mo2AtgdLCC4GnMB5BlIn4q3Jhb4iH4vrrDDrQnCTZXVji0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=CGeHL93w; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="CGeHL93w"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-6e22f10cc11so10105717b3.1
        for <git@vger.kernel.org>; Thu, 26 Sep 2024 08:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1727364153; x=1727968953; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6I9WriWDw0/ZYmtXlKlhRpyxeBFdZ0cIHHSDg2mVVHk=;
        b=CGeHL93wesk9K9+VwNvfRgoKj1qu0W+uu/N6RVWN2Kv9x9i3UHp4138tLUKIIOHNEM
         agdPRDtUQSQt04Z0LC5oC/CEIEiq3u4qMR/umOjpbHkoXYRWEciidRH2dJU6V1tJpIrL
         J9FQP5qo9I7vMxz3PrbWYWAW9k6UU37LCnEifYGmEEKen+A4yURPQNs80xazo3+b9xKj
         hd+0TsVOgk+NdgP8IzQa8gT9s4MGFalQ3RJ4Ohls9XQuW4aUUbCJsJn208n6d7gtzwcL
         SXz/iypXZ0AFIMe166iLGBesuxGtK7uzUFrrarTbItIFOm2qyMbcdrp+U6WJreXy3tvh
         Ru0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727364153; x=1727968953;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6I9WriWDw0/ZYmtXlKlhRpyxeBFdZ0cIHHSDg2mVVHk=;
        b=isZOyjtoYBVTtK6wNBJi1iQyG3kSDamQ3+CU9zHAuXAnCTMzwjzNBkPHHeB8cDikUm
         AdnTOKYkTwlNmeiC2EafFoldWSlPqLFLoBmocmpjFdH9V0iFwI65K86MxbiKKUo4tIU7
         3Y+cFzG4QNi/7WQ5xiKeakUVbW6Jqt7w02EYFj8p3ZZz/goOhTpEWMk4FctCcFaD6NGs
         DwDNRCrztlrfOqmqE/8Oo68PSgHrdXqdSQDtBWJczIHnYthvbi39i0mzx/xwRFfj/4rO
         oQvlI+7co4xTOldM84cER0I74L6ewXWezNCBPnRIoY6h1+Y7cTzxy2Ut0Yy/PGIHbBQF
         K2yw==
X-Gm-Message-State: AOJu0Yxi6VNrJld9X9A1JRXpwAoEyQ7jDEbJ/k8RRbjykjUaUQL7mjWn
	g3qwsmMjR9BbaVfd6x3ine6haZuzfCkR2IDwVBBzDe2/QtnP3Co09ORKAqtNg+jSjCOQrnlugYN
	XZHw=
X-Google-Smtp-Source: AGHT+IFBj34vMJpZTQWM0W9Sk9hcyNdPBkvDz1/h8Z1pw9FNk4ghJd2hXVparpB8P/yQYF4B0tKoSA==
X-Received: by 2002:a05:690c:1e:b0:6e2:d80:d844 with SMTP id 00721157ae682-6e21da60076mr64328297b3.33.1727364153526;
        Thu, 26 Sep 2024 08:22:33 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e2452f7eb5sm192707b3.18.2024.09.26.08.22.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2024 08:22:33 -0700 (PDT)
Date: Thu, 26 Sep 2024 11:22:32 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v5 1/8] finalize_object_file(): check for name collision
 before renaming
Message-ID: <6f1ee91fff315678fef39a54220eae91632d2df9.1727364141.git.me@ttaylorr.com>
References: <cover.1725206584.git.me@ttaylorr.com>
 <cover.1727364141.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1727364141.git.me@ttaylorr.com>

We prefer link()/unlink() to rename() for object files, with the idea
that we should prefer the data that is already on disk to what is
incoming. But we may fall back to rename() if the user has configured us
to do so, or if the filesystem seems not to support cross-directory
links. This loses the "prefer what is on disk" property.

We can mitigate this somewhat by trying to stat() the destination
filename before doing the rename. This is racy, since the object could
be created between the stat() and rename() calls. But in practice it is
expanding the definition of "what is already on disk" to be the point
that the function is called. That is enough to deal with any potential
attacks where an attacker is trying to collide hashes with what's
already in the repository.

Co-authored-by: Jeff King <peff@peff.net>
Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 object-file.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/object-file.c b/object-file.c
index 968da27cd4..38407f468a 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1937,6 +1937,7 @@ static void write_object_file_prepare_literally(const struct git_hash_algo *algo
  */
 int finalize_object_file(const char *tmpfile, const char *filename)
 {
+	struct stat st;
 	int ret = 0;
 
 	if (object_creation_mode == OBJECT_CREATION_USES_RENAMES)
@@ -1957,9 +1958,12 @@ int finalize_object_file(const char *tmpfile, const char *filename)
 	 */
 	if (ret && ret != EEXIST) {
 	try_rename:
-		if (!rename(tmpfile, filename))
+		if (!stat(filename, &st))
+			ret = EEXIST;
+		else if (!rename(tmpfile, filename))
 			goto out;
-		ret = errno;
+		else
+			ret = errno;
 	}
 	unlink_or_warn(tmpfile);
 	if (ret) {
-- 
2.46.1.507.gffd0c9a15b2.dirty

