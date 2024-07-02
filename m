Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF13E14B941
	for <git@vger.kernel.org>; Tue,  2 Jul 2024 07:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719906615; cv=none; b=pcaq46T0NGIEi08ib4uKu9/YpMPsbOpz2bhkOhfO3HUKG2g3pVy4W6FXpZYoE9IxU1Gq8Dp7OcmscmNVub3PJVZ15iSG3ep9mpdVR0kgvMfgUEE2/saIJba63aeDf4j/8ojJUpteqKYWFhE9jhANpB6oD+G3ugGak/Pu8gbCSrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719906615; c=relaxed/simple;
	bh=ly9/7822hCju/OC4ebJHxM7m+tFhB3TL6VtHqpDc4aY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cRKFEX+kvQJ6tfQidR1yuan9qgIeJG1L5hEu4u0vhJU7KppNVB4MUX8JkoRhGWzTzENkspiZKpBnEma26IY9IRIDpPVv9igqIGgRaS5v1OUrGd75HSRhSu6a8EkOauH686riCe+VXvBSzj+KcrCJnyRgdzIk9M04Ig4DVJdAt88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gWuhmXtL; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gWuhmXtL"
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-701fef57ac1so2078570a34.0
        for <git@vger.kernel.org>; Tue, 02 Jul 2024 00:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719906612; x=1720511412; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4kjzoArxTuZugz+BbAB8T+oPDdYz5PbFujHOY1soELs=;
        b=gWuhmXtLq2ro6kkwbRNqume2QjwMDrViL3v1N8hLD0aEQY40/5/XzY0uXPqtmPJW4N
         KIO+FRsxSksnADQXgV9b4+mLiKWLUZzb0gtcsEcVaBiXBdlXVb5DLmg1C9cYdaCB1emz
         yKivD6pmHRQ9sfSRzhWicOvoUzrLqmKOM2FgoJUYOuWXGH55FixxkA3beXIjZ07Cy08h
         0EKTCf0RodfixSJ4dJEuJ0bIPEGqetOxaQafRffe9E0IuW0urQfsmw0Pt01lRka6j5Mz
         b3sHzpmqLjfuPmes6kRHGINiOy+U4hOaJ6AfYu4WMlEQKmXivVe4OoexrqT9Z6bgaJWt
         ecdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719906612; x=1720511412;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4kjzoArxTuZugz+BbAB8T+oPDdYz5PbFujHOY1soELs=;
        b=TxQV5OaS5RjDtCFFPechA/0GzI8d1WPTyxbD3NsyP0Ty2aUkVyiTcqMtTJrhsYafqQ
         GLU0oaoEji9ssLc89XoZ5wmN3x0As/Pxjd6JQVHzxe5oW42wcSspwGHcboe1RdcDAAX2
         M6HVSun/3eatzFFI15ibqcWfUjOsgQ2JCYe/KP7w/NCoE39Vd09gMFCVdo+OpHuoZUwj
         BbOhgMMbLY20SUb9RARHJoi0oQZuL97Ou2m23wZtsXnQs3x+pUyJGBFoqk82VGx/NVZ7
         cAxK6iqwQGbrIk3CUiGVxpkP+FsQ5mKnja6H1OZ/pn/l2tdmMz1g+D+lm8KQiFRU3riy
         SQ3w==
X-Gm-Message-State: AOJu0YwFDSUvUGUbswIvNBhhaoeKa3xT5J4U7KPzBdWFpKjwcI5gjP4a
	q0F57DsAhVmFaOYxS+M9VVLN1bEH3967+eZGdhUvDiaS7iwDyw310KAe5fkHtGU=
X-Google-Smtp-Source: AGHT+IFURR3LHtdPsu8fmr+Xfa1UmBUxUZsjRa08WhWwjjVZIN3NYAt6s4Hs5/wSkoPOzMrRAMizuw==
X-Received: by 2002:a9d:6f81:0:b0:701:c041:7cfe with SMTP id 46e09a7af769-7020775ebf4mr9769031a34.35.1719906612301;
        Tue, 02 Jul 2024 00:50:12 -0700 (PDT)
Received: from Ubuntu.. ([106.206.197.80])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-708044ac424sm7772626b3a.161.2024.07.02.00.50.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 00:50:11 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: karthik.188@gmail.com,
	Chandra Pratap <chandrapratap3519@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v4 09/11] t-reftable-record: add index tests for reftable_record_is_deletion()
Date: Tue,  2 Jul 2024 12:52:22 +0530
Message-ID: <20240702074906.5587-10-chandrapratap3519@gmail.com>
X-Mailer: git-send-email 2.45.2.404.g9eaef5822c
In-Reply-To: <20240702074906.5587-1-chandrapratap3519@gmail.com>
References: <20240628063625.4092-1-chandrapratap3519@gmail.com>
 <20240702074906.5587-1-chandrapratap3519@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

reftable_record_is_deletion() is a function defined in
reftable/record.{c, h} that determines whether a record is of
type deletion or not. In the current testing setup, this function
is left untested for index records.

Add tests for this function in the case of index records.
Note that since index records cannot be of type deletion, this function
must always return '0' when called on an index record.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
---
 t/unit-tests/t-reftable-record.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/t/unit-tests/t-reftable-record.c b/t/unit-tests/t-reftable-record.c
index 1b52085f46..43b5d40899 100644
--- a/t/unit-tests/t-reftable-record.c
+++ b/t/unit-tests/t-reftable-record.c
@@ -466,6 +466,7 @@ static void t_reftable_index_record_roundtrip(void)
 	reftable_record_key(&in, &key);
 	t_copy(&in);
 
+	check(!reftable_record_is_deletion(&in));
 	check(!strbuf_cmp(&key, &in.u.idx.last_key));
 	n = reftable_record_encode(&in, dest, GIT_SHA1_RAWSZ);
 	check_int(n, >, 0);
-- 
2.45.2.404.g9eaef5822c

