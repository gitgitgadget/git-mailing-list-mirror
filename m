Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C02B1C5F13
	for <git@vger.kernel.org>; Mon, 14 Apr 2025 20:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744661183; cv=none; b=iW57C7pDX6zi5RqBBH0u5DRfa3kVq7mkRanJnwM1iPnMfFJY6ceN2PBxR7YRb067OKmDK1QgIIgz6s/V4CagHcwFmYLF9bqBBP6BxDHAzhHI5D9l5qLNHO4oHSTcwbU0Jc56bAsc8f9q7XooIhkBuS55qGtq7gKXsXL3UYJIG+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744661183; c=relaxed/simple;
	bh=AeNjwjcZEvW6353WIBeeLqSAE8EU7jAC/OW1/FyFnqw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V+lgaYbKBvK855iCyit3UarQHHNyWjuHFnqw7VvfZ+25Mf1nJ0xavsAfkroscf0HFkr5Oa6/KWNb/0cWCPmoLf3auEWV77zKwg5nWAt0oxa85D0sqtR2GiR1xkX4c4QDHUuzT8uG5jdGx6vXHIfl2N2ltkeyVbZZlqOg+hbT0LQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=G0HF3WQZ; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="G0HF3WQZ"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6e8f94c2698so24189916d6.0
        for <git@vger.kernel.org>; Mon, 14 Apr 2025 13:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1744661179; x=1745265979; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=74DW1SpDcVD7WyYAASO3AJArQZxQkOfUK9Nn5C/y0bo=;
        b=G0HF3WQZmY3WlqjgrfjpKu28Sdy4Z7ZgIBJSMOwYqtOGiD2SyFpybctqw/UfcWtzm+
         EHR8JNZ0ZKsD4WYfE6x9MRhrcr/8ZItd8FJwg4Vg8FcnL/iSJsjeSWZgNvczEHQF0R5k
         DUKdUsPJhEIAnPuKOuaWvMo2Erjleo8HuGyQpbrunS5As9VHYu+oKLU27odAxl2jpfDV
         zOIpt19ch0DH1wQEAWAmB4CblGRNpzDxPVJ871NrW3Qpjn1OHIOPTq2upIELbPD6bHqz
         3IKWQbvmgqiDaPerf6NIpgw6ZeYb18MSMFNLt/gkALozUOomxr0lyf18iC7xqckEOnbz
         6h5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744661179; x=1745265979;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=74DW1SpDcVD7WyYAASO3AJArQZxQkOfUK9Nn5C/y0bo=;
        b=MbeKBZsKN+CKdVkxXeqx+bIpY1stsHAb/9qvT5SldIDI/cwPSqiZOCOwn8p739sWa4
         7InXry/KOfR7VS4hpMUoITS/8p1pvLxSyoWTJgqC2/r3kX7XO48viUb578LiXtdskZIo
         AViHoCjQ0ttU9O+R08Wlgr7Be4q9R+37EUOk6RHD2KQDRlaIfAZz2DcWFqp3v3+U0vGa
         DU1CLvRWYYH0Yf6f5giQ3Bp5MSUoYeEm9SQUYa6YYT8LLmYB4MDBLot0t/lxfjQ9ia/F
         iHU7uA5oVI3UZ6y6YE/i4Ys9cq3qnhnextr+MiHs1lPApoduDCCWEKFnjJsRleQPRW1Y
         zEZQ==
X-Gm-Message-State: AOJu0Yz+7l2mA5DywfLa8IP8cKY7msas3VbWv2A9I+uwGl9vMVY2l1ep
	S03d089Sr8ht8+Hu0d8z28tqnNhhl42irMLjTrJXuIskhbke9i6S25oMwUQ19AKdY6g/jw6CWEb
	+PMI=
X-Gm-Gg: ASbGncuhRohK11/x/9GtM+FlDZgZr2zM6vVHECj8P+YveCPNJk0x64gsU0LIqs7dtXk
	fmejTo0Em7aqeoJuy1XQxkIH3j3YVjgz/jH1l8jxyRoleTpCoY6GdWDC6ASg/Ls3BS8ZJaROO1y
	GqTM8eC0i//Q0ZiKwpTM6dAEoFyFktYJYAYaJ290HjaAwiilMnEkX+VSXsrc0tiXdoP6UqlViXJ
	dPyvIbrSsgCYr9b8DwUFFR0MSa85+zmyiip8BKPUvnCjcRAo/r8lpb9/mqszPR2aoqIn/KBthV9
	2k50wE/GfXtqjDQ82cBfzlPTnasCzl4qs+X4E+6CmsyrhusDhRwNNUd8PubzMFZQLH7b9Y5TShj
	NnkFYOYMwqaLv
X-Google-Smtp-Source: AGHT+IE77qOmQyUQIm0JcqAzSG0A8gblV8ec1jst3QiaClOkflCbnj8eg9NJfHNGwymN6cz9F5O/FA==
X-Received: by 2002:ad4:5ccb:0:b0:6e8:fee2:aade with SMTP id 6a1803df08f44-6f230d9dc9emr233219986d6.25.1744661179258;
        Mon, 14 Apr 2025 13:06:19 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6f0de95f99bsm89183586d6.25.2025.04.14.13.06.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Apr 2025 13:06:19 -0700 (PDT)
Date: Mon, 14 Apr 2025 16:06:17 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 3/8] pack-objects: limit scope in
 'add_object_entry_from_pack()'
Message-ID: <f8ac36b110b91ff3723f5049cfc6bf9f624521bd.1744661167.git.me@ttaylorr.com>
References: <cover.1744413969.git.me@ttaylorr.com>
 <cover.1744661167.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1744661167.git.me@ttaylorr.com>

add_object_entry_from_pack() handles objects from identified packs by
checking their type, before adding commit objects as pending in the
subsequent traversal used by `--stdin-packs`.

There are a couple of quality-of-life refactorings that I noticed while
working in this area:

  - We declare 'revs' (given to us through the miscellaneous context
    argument) earlier in the "if (p)" conditional than is necessary.

  - The 'struct object_info' can use a designated initializer to fill in
    the structures type pointer, since that is the only field that we
    care about.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/pack-objects.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index aaea968ed2..540e5eba9e 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -3490,14 +3490,12 @@ static int add_object_entry_from_pack(const struct object_id *oid,
 		return 0;
 
 	if (p) {
-		struct rev_info *revs = _data;
-		struct object_info oi = OBJECT_INFO_INIT;
-
-		oi.typep = &type;
+		struct object_info oi = { .typep = &type };
 		if (packed_object_info(the_repository, p, ofs, &oi) < 0) {
 			die(_("could not get type of object %s in pack %s"),
 			    oid_to_hex(oid), p->pack_name);
 		} else if (type == OBJ_COMMIT) {
+			struct rev_info *revs = _data;
 			/*
 			 * commits in included packs are used as starting points for the
 			 * subsequent revision walk
-- 
2.49.0.229.gc267761125.dirty

