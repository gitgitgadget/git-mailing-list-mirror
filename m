Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C6EE2136A
	for <git@vger.kernel.org>; Tue, 16 Jan 2024 22:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705442990; cv=none; b=q7hMlIyaPeOZ2uoPsRjXHiMi+uYz4/eLIiymALnDWtdCW8p04xasTPga8/S114swyxsl4A7gPbYtPcYEyH2lNLkvNQbOizBNrcVaIlKnWmqq36QBxf5fikTivdeJHuxAxDKn+KW0Fe0oJvKJZhg+f16ewyZbx+kMZx+riHvWDaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705442990; c=relaxed/simple;
	bh=22F9Bhu28H1UjgXGUBadL4LV+KptX6Xj9iVcYUxIoAM=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:Date:
	 From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=OxUwcq9YLuzLL5D5aaz4MB3O0CM436bYEwz6VUdPiS/gqnQGiH8fw+0CUqfzOVlBpxrbgD78le5Sy9g+Qq9YOggvzWkN+W+hxgpEv92tTBk1fjf60hW/4ymuAFNsnpmhSXzxO7pUE/tEIc4QgnXxolQels3i9cjWzkhFly/K0dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=0byTZHGZ; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="0byTZHGZ"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-68176e698e3so4548746d6.1
        for <git@vger.kernel.org>; Tue, 16 Jan 2024 14:09:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1705442988; x=1706047788; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GRw+VCe4f+5VG4o6oN1F+ZzVT/It3zgP/nQn8mbSGaU=;
        b=0byTZHGZ6QsZKJBX/CdoQeqXBNbngS5z+Xi61Utdqotd6CdXh6tI653HsMl+NeZzF9
         4vx7w8cnApaaOn/Dp/6guh9BUgcULdZawbKqVTOC1eyY9pvBbzTWGQ1QjmiyEBBdFsHo
         1fSs9U6vvxK6OPXtN2YjIi0PiMnnQf+4a2Y3I52tkSASr3cv8O6qG/H4WxkjFMmzzHMP
         we7Oe3nqIMlF50O437sVSry0teFz6Ws1AfigdJH2lBg6NO5H/BgtQs/+cHni0IaSKbBW
         0DjZOIlfg2FIzGK/S+1EnMexRHijoBIHWIVUP3nFoe9OhqnhBqEipRo8BZgb2U8Pabm2
         CUyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705442988; x=1706047788;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GRw+VCe4f+5VG4o6oN1F+ZzVT/It3zgP/nQn8mbSGaU=;
        b=RBzHOAmRFuiyIqJWnu2DGit/8auFMRC7nszR87WdhcX1o7N9G5ENTgCzQFkBujpoSH
         XVNfj+YE/SIqoU4nq4tD8N2eCrYV4uTG4w0VmBz1IVsW8HEfKA6dGoX7sOkGYcYEHFie
         afVAb0UVaBDumnXfgaRSQOiyC98EPeoZqRildT8mtTgdGExwggTY53aqzLf/0E+PM0k3
         qDDhUvAUYoC4D3ooXLuzyyA9eEao2aFjr+wdJyaAkLriDWpm63b8nlrkxAnjRoGaGeBu
         mi5TPChso8FkdSnLILhB1C4nYJwtmFYYtJS6a77uxkcJCnvdnaKGbmLvEMVrrRNaI3S7
         3muA==
X-Gm-Message-State: AOJu0YyYb3OW0oYMlaY9HglpjqKXtuFGd3YQP6ix9QBdp65eePoinYyQ
	lw355FIK20iSa4mRgzs9OrPgIsPbMzIFg0ro6WmluWEbceZzQg==
X-Google-Smtp-Source: AGHT+IElABwJNp7IAWiuyO2IzeAbjs63+Ig6emNx0/jzQyjyTpolFT9kKYaVhS/+a8eHpe/gWuTZiQ==
X-Received: by 2002:a05:6214:410:b0:681:3a94:789 with SMTP id z16-20020a056214041000b006813a940789mr10425035qvx.78.1705442988462;
        Tue, 16 Jan 2024 14:09:48 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id db6-20020a056214170600b00681770c1aaesm488198qvb.125.2024.01.16.14.09.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jan 2024 14:09:48 -0800 (PST)
Date: Tue, 16 Jan 2024 17:09:47 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>,
	"Eric W. Biederman" <ebiederm@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
	Jonathan Tan <jonathantanmy@google.com>,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Subject: [PATCH v5 15/17] object.h: fix mis-aligned flag bits table
Message-ID: <c683697efacc1c8f53951bf28895d83ce436b5d8.1705442923.git.me@ttaylorr.com>
References: <cover.1697653929.git.me@ttaylorr.com>
 <cover.1705442923.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1705442923.git.me@ttaylorr.com>

Bit position 23 is one column too far to the left.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 object.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/object.h b/object.h
index 114d45954d..db25714b4e 100644
--- a/object.h
+++ b/object.h
@@ -62,7 +62,7 @@ void object_array_init(struct object_array *array);
 
 /*
  * object flag allocation:
- * revision.h:               0---------10         15             23------27
+ * revision.h:               0---------10         15               23------27
  * fetch-pack.c:             01    67
  * negotiator/default.c:       2--5
  * walker.c:                 0-2
-- 
2.43.0.334.gd4dbce1db5.dirty

