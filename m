Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D35633B6EE
	for <git@vger.kernel.org>; Sat, 10 Jan 2026 11:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768043677; cv=none; b=qHwAx5AC00qZfLoJmOZaJ93xACDjixYHfSrnt8RZkUKdGoVy3NnsnkP7qbLV4H/mnmcqhzfCYJJEw8hzIbzGFKRvZ/jdT9PjiCqUvrNXK+hv+s7v55U0n7y8Jothm+FJuxXokh1LIuN0hM3U/UK0nN6FwvIpfYwgw2iJ5hhjbgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768043677; c=relaxed/simple;
	bh=6vo8uVZsHIuOqJMdRVYQwRHVDgZCuLeTSPZHATtxnss=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=K7eyuX/qaBOHxspS5g5QtTmqsvxjaZCGAt9sYqoT/ALwyAKQLqgR+j0EGHGq4Wmi/vvPwPr+o8MFsAUcl8JbQialg0wKUm2NJwjGr4F/2te+S6plal4q15QmgVcLVp+Pv/QiuthtztVxyL34SjDFdvia/qGw/xQafpskvCzteA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VQOZi88N; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VQOZi88N"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-59b73193dc8so3873046e87.0
        for <git@vger.kernel.org>; Sat, 10 Jan 2026 03:14:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768043673; x=1768648473; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6vo8uVZsHIuOqJMdRVYQwRHVDgZCuLeTSPZHATtxnss=;
        b=VQOZi88NyPmfTS2XSSxafkaOHz6geEl/0Il2xcoOifsenwCyqaDMMhyGgvIvUeGyzQ
         YhE5DabXF5poRPHUUeU8SVaDgwhOIG8kq561BTL2kwLhAO5dQUfqGFaXVbFFgxuzuxme
         mo0wtLUqiuDb30HukPUvrfOuP0pQyQQdR4vfeWn0ygW8ZB3coh9K+2UjRzCd51vcLGK9
         EGM5pfG5P9l8LT0ZzRrhZrTbW0cPmQxh4gvmLxd5JtxpkcoS9Sez9WztXlhMdjOlK3tc
         1Y4LcTMRNq1OTu+aiVx3gqgfybVu9DT74LPHG8W/upBVPT9I6vk03/a+LgZFAPeq5rV3
         qzfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768043673; x=1768648473;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6vo8uVZsHIuOqJMdRVYQwRHVDgZCuLeTSPZHATtxnss=;
        b=X988hSrSPnqjK6b1PY6VkIcJNcnDmkIh6ABO2hpHMFXxXtv1WMJG6ObtITf0WJBXJ7
         Op8vP4BDbtbn/GgQkrQmGsTIyHTQqfY8DfU4ATi3DhqPB2AKA+CRYFgeGqk+C+oNzKr1
         3HLKp9b/69EVxzPs7R4aSVhktb2YgyzMHsXBospCF+2ieHGxo2quaG4eoWOq1OLMmMoI
         96ZR/U+oHeuwlsOwxjQalkoL7+9wrgXgwsvGgGRHOQnOXSWDFUafczEJGW9/QQe2VAHw
         dam+AQsdfkQ47892y8N4tM6okoXPNGnSUAJt/yUgWMO5S2Iu/ZvE62eJ7iGvEUYE/TpX
         GNjQ==
X-Gm-Message-State: AOJu0YxdIVc4MPOxhp07z9VdI66c/g3zPctbIY6jJNZXe7nd6pD7otG6
	y5+irlI2CfPki88D0iEvsMyec0qhEzwniOe2zfiErqyQi/5ZTzDwgXlo3ioNzw==
X-Gm-Gg: AY/fxX6QOcqE33YjuKsX7u1uikcHJ02rPysl405b+/ubS9H7eIIAC8t6UDOcusurMjL
	6Y6WAZ8icNeLCk+MpqZJA3W2bDpH2Bq/Hcd6UTriPsr0cLiy2AG3dHL6/43cAF9XwKf/EUT1myd
	KVtCwIngMY6fwFwQsJnaxcBiAdh1pBZ+OlrI4urV4NqS0rF+EuQ4QT761AH4vtKhze4W0pskxlk
	BIoA+DOqZ9M+2a+J+giBlW2diDezKeF7GOaVn4d7qswMnEX8KCF9Zu4IABQuk9TUAwbkwFRji76
	HSI7CGTn7/HYgYVoZ7FVsQZvau96B8rvDCRKb9JMj84fDpZKMelgpBb7Y7OehQiB6jqwMQuz8xM
	+bOy+n7km6hRqkmjIfiPRko0Kf3yXbF8bGKKLNpvdWnzOLS6grKZWNENAdXbYcIs4eUdSQ1hYxb
	KEsPEM2Sk51VV3Gk2nqORmfXDaQcoB5WS7+TQAAiZP1EgODOkYcZVnsKlDndTHm5GpCkjbsis=
X-Google-Smtp-Source: AGHT+IFwfHJ5AJ+pYx5XssBdH/EJxz6zdvxJnKtsf0QjhIURa8btclFTDyyHeCT/acKWTWhDeQMfig==
X-Received: by 2002:a05:6512:3da9:b0:591:ec0f:fa92 with SMTP id 2adb3069b0e04-59b6ef02983mr4825039e87.3.1768043672799;
        Sat, 10 Jan 2026 03:14:32 -0800 (PST)
Received: from Mac.localdomain (h-85-24-230-197.A753.priv.bahnhof.se. [85.24.230.197])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59b7376b64fsm2200261e87.7.2026.01.10.03.14.32
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 10 Jan 2026 03:14:32 -0800 (PST)
From: Harald Nordgren <haraldnordgren@gmail.com>
To: gitster@pobox.com
Cc: git@vger.kernel.org,
	gitgitgadget@gmail.com,
	haraldnordgren@gmail.com
Subject: Re: [PATCH v17 1/2] refactor format_branch_comparison in preparation
Date: Sat, 10 Jan 2026 12:14:31 +0100
Message-Id: <20260110111431.27230-1-haraldnordgren@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <xmqqbjj2tdu0.fsf@gitster.g>
References: <xmqqbjj2tdu0.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> This is not a new issue introduced by this series, but it is curious
> there is "ours + theirs" there #leftoverbits.
>
> It is part of ngetext() aka Q_() call, used this way:

Agreed, I thought about this one too. Will update it!


Harald
