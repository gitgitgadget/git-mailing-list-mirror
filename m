Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FD2D1EB37
	for <git@vger.kernel.org>; Sun, 21 Jan 2024 13:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705842945; cv=none; b=u+JVxHodg+IL/bXs0AdLJdHnNG/3OKt35b/9Wb1hn8OLbuZkJZSpr7ttYyPv7dUYVmILFd+YnPWZ6E9IurvIn6hriFj/R8FgnmU3iDvLD5D8e6319y2/xyyZd0jUb9jAHRCNMQrwJHy1QduA1IHxUQ8IcSjw3grrrW9zAXFyjo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705842945; c=relaxed/simple;
	bh=VTTvXlnLMU0oFGoD6VkDrMjbGf0bfpv+0/vY7ftzt6Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BRUa/923CMATVGd56k53MFjbDFXWBWw7f3yn9j1E9W1f7nK2YebQvyI64xQ709YHWHluJLp4Z9XkcZyQe7/AlBVlptwIhLYWkWhaCDN8dDe24s4HBvgvA+g81Xc31Tw+i14k+6/gVmEp1VX8rc/oCHuuEk5PleBGF3Nsl3E/2yE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WZdz43Km; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WZdz43Km"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6dbcdbe13e1so492224b3a.3
        for <git@vger.kernel.org>; Sun, 21 Jan 2024 05:15:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705842943; x=1706447743; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wOc2EDUTzVq2aO/+vtOZQZl3p1U45Gfk21S5wJoNoxo=;
        b=WZdz43KmLQF/8PfT/o2PZnZ/fHMnbj4VaqtFKCE5SXeY3ULOpPeESotVEW+A+zzsrQ
         9blzCcACAb1kR2d2Jc/Ok4UfuEqLrtcS/nLfstWrBLtZXrQKxsZWnO4zV9PgJNPybFO5
         rChPUYCMnqKQY4ECZBbYtIWR+JyBiyiQLUTL539SQhI9WOhpKHXKxqrAEYNMgUEtXVP/
         OJwD8ZkptnLfo8O7EUz3H+wYUA5PoQI0F1aV2kVD7C60CTuShgXmNKWdkcN1oymSn+PS
         /2Qe997uR4utLi/6xnPqwlUQdksLNrYwqoi3tL+b9Gg6cjwj+2VHfQDUG2DG2lYTsG7k
         cqfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705842943; x=1706447743;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wOc2EDUTzVq2aO/+vtOZQZl3p1U45Gfk21S5wJoNoxo=;
        b=Ge+Gdda5tHlCr2LTJgvpLFHyPcY+mdwxtCRAn1CZWjomtrCND4c1top7dlx8INP1xb
         kz3lOUTy525+zIX5YOXXXjWTQfasYF+CNWjsdB7pHUuqoKdtFgOY/2Ls1Y3BdQHUYccP
         YWTcb6njhDQLhvj5JV57Lf3qolcN0t/OBGNOwJbBRv+mN5HPjYF/v6oKBki/jZnKgo5N
         kbLZGpH0UusWu6a1hFjV0Ek2kiRcg/fMCVhpG6z4FClJmFMHid4jpPTNmaxy8I7/kuEP
         u2F8sazf/bBULULs4FSjAGNR2ZEATExBvuc1GV+yWvW+DaUepTjcoiJmpuaSmfYCkBSS
         zIVA==
X-Gm-Message-State: AOJu0YwBH4w+/8Yr5LZ5XmUI3T0LSE83B+1hm7UpKcWj5C6VXnEbXwjr
	ybhuLF0xkYcGjYEvl0Mm4twaR9MpPhs8X3Xvu1VnrTcKDGqOLTSrZEhVeDNC
X-Google-Smtp-Source: AGHT+IFmuVcYOxRv8/rEEQif1/w/YBETEmGMLWdXvChcpcs1oAQHicHzcxgJupjUJn4qpmdcTzZqDA==
X-Received: by 2002:a05:6a00:a93:b0:6da:cbee:9d9c with SMTP id b19-20020a056a000a9300b006dacbee9d9cmr1129357pfl.29.1705842943356;
        Sun, 21 Jan 2024 05:15:43 -0800 (PST)
Received: from tigtog-proxy.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id g5-20020a636b05000000b005bd980cca56sm6619005pgc.29.2024.01.21.05.15.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 21 Jan 2024 05:15:42 -0800 (PST)
From: Jiang Xin <worldhello.net@gmail.com>
To: Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Linus Arver <linusa@google.com>
Cc: Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: [PATCH v6 1/6] transport-helper: no connection restriction in connect_helper
Date: Sun, 21 Jan 2024 21:15:33 +0800
Message-Id: <0994bc2d642501d0f9874773996cbb7ce26ef488.1705841443.git.zhiyou.jx@alibaba-inc.com>
X-Mailer: git-send-email 2.32.0.rc3
In-Reply-To: <cover.1705841443.git.zhiyou.jx@alibaba-inc.com>
References: <cover.1705411391.git.zhiyou.jx@alibaba-inc.com> <cover.1705841443.git.zhiyou.jx@alibaba-inc.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiang Xin <zhiyou.jx@alibaba-inc.com>

When commit b236752a (Support remote archive from all smart transports,
2009-12-09) added "remote archive" support for "smart transports", it
was for transport that supports the ".connect" method. The
"connect_helper()" function protected itself from getting called for a
transport without the method before calling process_connect_service(),
which only worked with the ".connect" method.

Later, commit edc9caf7 (transport-helper: introduce stateless-connect,
2018-03-15) added a way for a transport without the ".connect" method
to establish a "stateless" connection in protocol v2, where
process_connect_service() was taught to handle the ".stateless_connect"
method, making the old protection too strict. But commit edc9caf7 forgot
to adjust this protection accordingly. Even at the time of commit
b236752a, this protection seemed redundant, since
process_connect_service() would return 0 if the connection could not be
established, and connect_helper() would still die() early.

Remove the restriction in connect_helper() and give the function
process_connect_service() the opportunity to establish a connection
using ".connect" or ".stateless_connect" for protocol v2. So we can
connect with a stateless-rpc and do something useful. E.g., in a later
commit, implements remote archive for a repository over HTTP protocol.

Helped-by: Junio C Hamano <gitster@pobox.com>
Helped-by: Linus Arver <linusa@google.com>
Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
---
 transport-helper.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/transport-helper.c b/transport-helper.c
index 49811ef176..2e127d24a5 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -662,8 +662,6 @@ static int connect_helper(struct transport *transport, const char *name,
 
 	/* Get_helper so connect is inited. */
 	get_helper(transport);
-	if (!data->connect)
-		die(_("operation not supported by protocol"));
 
 	if (!process_connect_service(transport, name, exec))
 		die(_("can't connect to subservice %s"), name);
-- 
2.43.0

