Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F36253D47B2
	for <git@vger.kernel.org>; Fri, 24 Jul 2026 10:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784890485; cv=none; b=iV+x2dn4yuHDpV9ihNTyudCCTVTlSkIJW2Zzjpp2ufZhX9+dRaBBwPeBKoU1FtCwFzxNsyhtEyG/HboHvW96MqD6KHbW4XubX5bs45wfSOqdrSj6jEQkDaDewihcKEPOewOFfSjpC8gCkj7Tdwn+ZHXNUuDrKdEjc71OiIU+uHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784890485; c=relaxed/simple;
	bh=7R5lPx1h9vPMbKIqpPhCO21OWUdtq1b/9pV8dY/N2JQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Vx9PRWPH8/yk+Ev/qfoBbon/Yx2rTWV343bE130xRRPUybhhgSDVLxfuJ7SZjdXmOn+BDAFE7Rrtdn0g2uUn/34rLNSP9auBCgnYBuZDd6o9L3USUtFpq3LLJniDrQ3p093v/dS5LKQiCla9cGYVWaVcQav/m77soz9erhQ3mTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JC+pnzt3; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JC+pnzt3"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-493f75f7172so2958585e9.1
        for <git@vger.kernel.org>; Fri, 24 Jul 2026 03:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784890481; x=1785495281; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1WWvImKuevgwQO7wSsxmfyADqWZ9fs366ywo6QqDaRc=;
        b=JC+pnzt3zXOKhpjdKRY9gataMKvzEfjeWw9XpvT5xza34CaXYz3cVNzBnC99IJLG8g
         iPt7GbkJCU7PSfkBBLtRNtBLGoXk+0D9gNf5omm99TJ3+BrxV0wWdpVKsPQDKtqutXB9
         V/eqBaY0UVn7AF66tkD5Np8uOzI0QeI13kOA3BYqTZtP/Ddtbvr3/eekPmNBz9r27EDu
         Jylz8nVjmgLvSoimEmhCISRmFDjQe0Mm2T5/ialp1buqM4nEksisdquCk1AVk8uRwVk9
         P4b5TqSXZqp3OCZMVn95quKwEsdTKPluhIkcNvQz7M6y2xUhYqUWjzW0hrSyVLx4Zd6R
         eomw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784890481; x=1785495281;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1WWvImKuevgwQO7wSsxmfyADqWZ9fs366ywo6QqDaRc=;
        b=PnFiaCisy9Z3aW+HtYRiYb99KRxyluWzRcG7rC04RLao07/YMi4EphooKyLmLpzHcU
         aoqehRUJ1eFyxTXxBfviOYkMMU5+5Htod1/ZVuQ6LwKcU8NwqyC9nfR0Z81FQCn6+/qF
         fRb1d/SyasYDmPWs8RYx2VcbdkVw0Rq5Y2bcVInXcJeLuehWeVQfkFo/rzeuSkQ7+/Pj
         pWuWw1X+sW4IZqQB1fJHrA2CFu42GXJnHN7iMfVAajA+1Ng6Zd+nTVHG5xvIxy74JSxF
         jXpO0HfPMo/lcvhA7dUdOY7clhIIHJ9pl0+oQRg5kPBcVgEuxg1NUtXb2WtElwWgsRxN
         ik0A==
X-Gm-Message-State: AOJu0YzFG1YSmcFzg8zP4Aps/DUaWtzh5j8mali0+RC9FYa9LQMwJROU
	USsR7sWrnssU5XNylsrfL9JY6tK/0HIm+DcJqgm/4L/LzO9CvIFS6+S5HvvJZNix
X-Gm-Gg: AR+sD11uLlDt22u7RpYQrVAf2wmakO8NMZveNWGo1OYOJvqZ10Lm5xkC9dlaHdHCd/o
	VIBzj69Yyqe82rX6APXID//cxH/axP2W8WlYUrpPC54LRblBLeGszzHIMwm0VUqN2OFxuv3rD8Y
	5b4bZSznhZYjuxHaeHvbw7tGcNbiRXIk1Vyl46+8Mi1nj88gY+tIBRoXDqHV26DYk06UPbitmTC
	cL+Q1r0e3hwnYLKOzxYD4jYhp9d0rO6c4gsXtu5islmTUuQK9pvXONQN6hMonSfqyqZGcWXwovW
	CQKxDKk9wtqKUh8EAhLroKaoDVjxo8xv0MOBJIIwRDXH0dDa+N2/m7wnDOurSO5O/gkMDO9eiXp
	ftJoHSYPWn8imJtqPEzNdTyQc54YfH2uCwXjZeDv6HNZwcYI2qqqaGl3Of1Sec0arGT+A+ihz+/
	SljNaOW/7Z3dNfqx7VXAABfl3pnG4qM13+gZmfqcBmkJ5ZHmlMRkhDt8aQzi8uBz0TvgmHJFd1G
	j/SE7o2OJcWK3WvsFauS54fGI3fr6mazgOgzAHCpzgJmbF4FVbtPMtCjVrLharzViaM+9ezSIsO
	NZg8BPLMw+Gl7lmw0OBdXPmxoA0PE9r7Cp+Y
X-Received: by 2002:a05:600c:534b:b0:495:69eb:27fe with SMTP id 5b1f17b1804b1-49573cc6cc9mr52293305e9.11.1784890480591;
        Fri, 24 Jul 2026 03:54:40 -0700 (PDT)
Received: from localhost.localdomain ([148.56.122.71])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4957b5f35a1sm41797645e9.0.2026.07.24.03.54.39
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 24 Jul 2026 03:54:40 -0700 (PDT)
From: Pablo Sabater <pabloosabaterr@gmail.com>
To: git@vger.kernel.org
Cc: pabloosabaterr@gmail.com,
	chandrapratap3519@gmail.com,
	chriscool@tuxfamily.org,
	eric.peijian@gmail.com,
	gitster@pobox.com,
	jltobler@gmail.com,
	karthik.188@gmail.com,
	peff@peff.net,
	szeder.dev@gmail.com,
	toon@iotcl.com
Subject: [PATCH GSoC v21 10/13] serve: advertise object-info feature
Date: Fri, 24 Jul 2026 12:54:21 +0200
Message-ID: <20260724-ps-eric-work-rebase-v21-10-ba67f024fdff@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260724-ps-eric-work-rebase-v21-0-ba67f024fdff@gmail.com>
References: <20260718-ps-eric-work-rebase-v20-0-0c13962ac532@gmail.com>
 <20260724-ps-eric-work-rebase-v21-0-ba67f024fdff@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Calvin Wan <calvinwan@google.com>

In order for a client to know what object-info components a server can
provide, advertise supported object-info features. This allows a client
to decide whether to query the server for object-info or fetch as a
fallback.

Helped-by: Jonathan Tan <jonathantanmy@google.com>
Helped-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Calvin Wan <calvinwan@google.com>
Signed-off-by: Eric Ju <eric.peijian@gmail.com>
Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
---
 serve.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/serve.c b/serve.c
index 49a6e39b1d..2b07d922b3 100644
--- a/serve.c
+++ b/serve.c
@@ -89,7 +89,7 @@ static void session_id_receive(struct repository *r UNUSED,
 	trace2_data_string("transfer", NULL, "client-sid", client_sid);
 }
 
-static int object_info_advertise(struct repository *r, struct strbuf *value UNUSED)
+static int object_info_advertise(struct repository *r, struct strbuf *value)
 {
 	if (advertise_object_info == -1 &&
 	    repo_config_get_bool(r, "transfer.advertiseobjectinfo",
@@ -97,6 +97,9 @@ static int object_info_advertise(struct repository *r, struct strbuf *value UNUS
 		/* disabled by default */
 		advertise_object_info = 0;
 	}
+	/* Currently only size is supported */
+	if (value && advertise_object_info)
+		strbuf_addstr(value, "size");
 	return advertise_object_info;
 }
 

-- 
2.54.0
