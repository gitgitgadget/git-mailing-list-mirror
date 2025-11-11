Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A38337BBD
	for <git@vger.kernel.org>; Tue, 11 Nov 2025 19:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762890167; cv=none; b=tHJESqsQDxrYA+SZGz8tA2t6VPnbNeZJV3X1HGgonHeZql6seZWXX/Nlg+MXeLj2YDHFnk537FP/SmLeYULMA+2TPduteQpN21JtWr37pLqWxMqXY3NB3vx3l8OSDmss55vOn37BhEJVy12uZPdVYE9WrvIbMG8dKD4RghFZYV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762890167; c=relaxed/simple;
	bh=ojFXTcu6lo7/f4BJurC/Fo9xkl1ge+sjBxobXGeg6qQ=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Cv7RC48fzM3F8Wb0+fIFoRvighMVqHv9ry5RpketmGfm4663XLyopM7jeIoOIHXu3PsPfSJvuW0E0HlVsUZ9EkB282kToMBURv5e/svEkTJ5AQ3aobwHJNXKRaxMgeiV6lyPv5qQX8mDsfStQK6sTf+/GsxP0FjJmqtULq34lY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bO5HZ4nU; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bO5HZ4nU"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-891667bcd82so564285a.1
        for <git@vger.kernel.org>; Tue, 11 Nov 2025 11:42:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762890164; x=1763494964; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CWTAF6/3g1AgNvpaHc8JTz8Lhxkt5//gFPNw+j+MPh4=;
        b=bO5HZ4nUHwW9YmIp9yjSGXeW+MPbBF3igj9Qk6nVaLXYQHvCoPjxomFLuIXmcjFPMW
         bf/4Yg0ltycttMqgnqXBO/Hbiv+U3lEsn8e+tjkTZ1RC74fOue9Nt9AyXj/1F8QYS2lO
         Jql3FSHeESo6hys8T0XpFFtiiJUoF1Z/BZujCgpcJ5gXywlTuQar7wnhyjnbfE3zD+8i
         CsbJJNwa7pv8t47QAn+VKfrSOkYTw4Tr6SYjFxMbQoV2engQ05iR8vWFIfbcNyoP8TVb
         jkd2bXU2IIlYQxwdhtD9x6YiOi2bqpkNdyqxkmUHIYJymm8fbmZhRqknvJ3+JQfRnd3k
         gKWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762890164; x=1763494964;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CWTAF6/3g1AgNvpaHc8JTz8Lhxkt5//gFPNw+j+MPh4=;
        b=mJj7ZvIyZ67L4etos2HneNPFoWFBXBmI5697BKKpEs4JOgFQDS5cDt5nlyuHr9GEF+
         c4zSeMlgjSvTnjWkQbnFCBhdRnuOZuH7zsvlA2h5Fr3o5L+CNea91t2OCULrGxAdjKtF
         FM/3Ven/pQOAKYJ9pWZsua6PgdiwiPW+6BGSnwbxKlFMY9WvQNs0W8kdpJ5SZDax+bpw
         H8K/HSCltXoxLrc9MKHm/I/5jIp4eE/p3PIiIb7Dd5duiiVDT9NWgFf85EV8CLYvukqO
         8//XtCbQksW9bAsEzl5d2RIS+q6elv0/gzAke0xH3ZHIdioWREeXk6g8rCYxAfUnzlbX
         zcqA==
X-Gm-Message-State: AOJu0YxtM7+I4+Gx+5JlMZ9cLq3XaPi0KJ6MLNM3g3yskUfGbod6l4TC
	O4Tp17EpA+yfhh2ScrmoK4DTNsMn/OIFRuCycUU/fLaaVhnkyfSBy9MnXWBdfg==
X-Gm-Gg: ASbGncsfwPWBa4CcRnxtbh0AovDtGqCt9Ss0zCjuagCtvEz+b8ehClonq7llhfKyiyH
	eQJdgtocYjdEwEegLzX1Ot2ewR1R6CI/d7gR1qjtyI6QJgy5yt2N7kO2Z2kGuwk4p0o7WSKqE1b
	DlCVjOKS9ZARjdGxoz3+Jf+s5XNfhse2xEvfUIyhonU4+yX6EuZjK2ZdHLVKhZwyoJrMEE+c5rE
	zK52z+IgNKQxqr6ULpdp9XHEYz2pEBliOSjvQwOgvAV07GN6nfbK11r2LjzhJVEZbFtYoXcBhst
	nU/4cmimyCbZAlvTAnYAqd2xDhupkCifm1XxdYqPuMPh0XUI9cVVL3W/wDIGtYQtfmok3wF6syR
	/ZTGOmbd8DDfBkn/AmdukODO0VGKtNTL1O6UIY/5foR3bPCQ0i+0HBr6yDpHOyy8MTN3RYwLBat
	1XUh4=
X-Google-Smtp-Source: AGHT+IGlHpQBjvy6tJ4PSxKbMrRUdDG6uiFQeJIigFYhz4NX5ifAfTC/16x+Al9BFKXm/qo1RAdA6g==
X-Received: by 2002:a05:620a:410f:b0:8b2:64db:7f3e with SMTP id af79cd13be357-8b29b5fd21dmr69202585a.23.1762890164605;
        Tue, 11 Nov 2025 11:42:44 -0800 (PST)
Received: from [127.0.0.1] ([172.208.127.36])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b29a9e6e6asm42032685a.35.2025.11.11.11.42.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 11:42:44 -0800 (PST)
Message-Id: <aee0d3958b8b72a93773466d1c1ff386a3ac4872.1762890152.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2070.v3.git.git.1762890152.gitgitgadget@gmail.com>
References: <pull.2070.v2.git.git.1761776388.gitgitgadget@gmail.com>
	<pull.2070.v3.git.git.1762890152.gitgitgadget@gmail.com>
From: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 11 Nov 2025 19:42:31 +0000
Subject: [PATCH v3 09/10] xdiff: change rindex from long to size_t in xdfile_t
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
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    Patrick Steinhardt <ps@pks.im>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Chris Torek <chris.torek@gmail.com>,
    Ezekiel Newren <ezekielnewren@gmail.com>,
    Ezekiel Newren <ezekielnewren@gmail.com>

From: Ezekiel Newren <ezekielnewren@gmail.com>

The field rindex describes an index offset for other arrays. Change it
to size_t.

Changing the type of rindex from long to size_t has no cascading
refactor impact because it is only ever used to directly index other
arrays.

Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
---
 xdiff/xtypes.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/xdiff/xtypes.h b/xdiff/xtypes.h
index df4c5cab1a..3bcc0920e0 100644
--- a/xdiff/xtypes.h
+++ b/xdiff/xtypes.h
@@ -49,7 +49,7 @@ typedef struct s_xdfile {
 	xrecord_t *recs;
 	size_t nrec;
 	bool *changed;
-	long *rindex;
+	size_t *rindex;
 	size_t nreff;
 	ptrdiff_t dstart, dend;
 } xdfile_t;
-- 
gitgitgadget

