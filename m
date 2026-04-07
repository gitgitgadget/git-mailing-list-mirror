Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 015203A5421
	for <git@vger.kernel.org>; Tue,  7 Apr 2026 11:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775562789; cv=none; b=j55uB2n0mMFbk6x8kYRLcVLvtqazcc4g/njihR0cBpYf6rsJXceGBAA65gC9RwJkyk6sFkG5LumK1oDT4GPq7XU58VUm4XlsbykAo7c20SXsjuXr98HzFVjrvK9E62tlLkdmbDuNLmvLfyem6AhuMonINj+RkvrAIw3M0SWq5Kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775562789; c=relaxed/simple;
	bh=dV00p/3ed03oWf8VZpfcoXQtWV9jmYRXCYvfYCGDKUQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GI3m20l2eON5NKCU2iIQKnLWzJr+Y7aZxm3WQRPzlFJ3bYpB/tA3PPe0BJ52LQWz5kS1H/fDxEHB5y6IAyc4csfAcQvNpv6xiz/PfTw3c/tgCs5T8Sk/AZW91quP9SelSQh13mmEhn8w8vTrI/2DWxVmKBNcIe3NGNr/6gLga+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kkSbPJQE; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kkSbPJQE"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-43cf8d550bdso4533701f8f.0
        for <git@vger.kernel.org>; Tue, 07 Apr 2026 04:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775562786; x=1776167586; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2S/OdA17721OMefW8Kr9qB+tx1LcL2+rDEh1y40JVtQ=;
        b=kkSbPJQEmJoCZBTirUXMkEDG15IOgX7SnyIoJ4O5fJBnsgSmEOm9GRqwy7Nby61c0I
         ve98kujQsxRbJy0ub8Uo+KzKtc286v86a6yi7/v5M08ILY/WjYvvRGtV/3JY78ARvEo2
         2+ER9fh8LdBLLCYi2RXiL/XQQ173q6dIp8KVDgy08Bw5y6JPmlZeWL9zpoGjIzjJ9yvK
         9Iavpva0NQOgqIX35XyxvB+mxOZasTW2gWl5Z49A2ggmKIXGgHt9MRPBkbhBa0GIS7xh
         L5EOtucW+PnuaJ6ctumN6SrGtRdOErsnAqlL+AwVhviUxYGTDlHlRk3DGvE3giTN7KOq
         0Amw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775562786; x=1776167586;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2S/OdA17721OMefW8Kr9qB+tx1LcL2+rDEh1y40JVtQ=;
        b=TPGhoMUzNW0CRlViMeq8ZtZXvsye2ejKCLwwwY+/0Pb0JRnRkI14Ng7dTT8r3uzcCE
         wfWho/v3Rpa8a3Ksf/uVlZ4DRuyRv4MmcQBejfR8hQ8pETQRjxTRk3is8Xa6fU/F9WjU
         brJc6O9iBQ2SorO0hi6GF3orIp6qMhskuWP/j6e9AyIs6rz0NAzqtAqFsQCyMkmcKRrY
         3XNEFw7UM/Y9rpXICNKOx5WPJYiUAO1ZJRgWjsgxBQymzKQZUlKw/GGeWZ7Bqa3zM/+F
         30EovFb+4oLOwBThpBvzJZC8aH2oPm3fR8hMBEAtdnXCrVAmfCapxm1Y9Co+svTz30Ok
         k1og==
X-Gm-Message-State: AOJu0Yx6B203fE18whH6RR+SYT8jEEPc8Tt1g2TSLRqMyEheYDWVJhi3
	sUhpv40aKN0npc78duqBAzEpY/Kk8gsVM0jtKQNN85UebDdRQM/cGa139lGwTg==
X-Gm-Gg: AeBDiet4y6fKXBuiWFD+CYY5q74VxjKHIsxmgSXGPaHQMBPZtsqvPs0XfSxf+7jUefz
	49Je1vjVF/8u7h/8FxHpd7WFdiMbqxo061fte62STka8JzurlHLqKwTcKrBf7BvV7FWly6ZXNJW
	f1xxfibqVj6JeBY2qJEAwyR4gKAgWgiR/GCfYgLNJxz0Z0JKfCiOMNS5W28Mdpnu9J6EYzafgyk
	MikRCNvDMbQUfqnUMMHFfsjkldVz6nF0GaNTUlQNFotEs29n4cWXXtRyHAdNlOop6isU9SgLUE9
	hdD2k0JUcPZH+9V8Rgv/7LBeHpP6GAY2Yhj0a315pIENNjisU8FhWa8rrx252Ya858rpWbicWCQ
	XZb46ca7eXP86wGAZFLnBgksmHUpbx2FWeQlz7IQm+5i4tG/rGau4Y/Mbz79PeiwunDaVJ669vE
	ljMm3bo7SGTe5AjkXecC5UtboJnCNgWtPTc/hoTzyjiPJGhFN6NRl6jFIRWBEUVRcjW5cKMjcWB
	XktnJQ8wIiS3ddXTNhF+32cQJXj8V9Mp95Dta0=
X-Received: by 2002:a05:6000:1a8d:b0:43d:b99:bde3 with SMTP id ffacd0b85a97d-43d292d51e0mr23883675f8f.25.1775562785787;
        Tue, 07 Apr 2026 04:53:05 -0700 (PDT)
Received: from christian--20230123--2G7D3 ([62.35.114.108])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e2a6f5bsm45050794f8f.7.2026.04.07.04.53.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 04:53:05 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Taylor Blau <me@ttaylorr.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Elijah Newren <newren@gmail.com>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 04/10] promisor-remote: reject empty name or URL in advertised remote
Date: Tue,  7 Apr 2026 13:52:37 +0200
Message-ID: <20260407115243.358642-5-christian.couder@gmail.com>
X-Mailer: git-send-email 2.54.0.rc0.114.g05d466edb8
In-Reply-To: <20260407115243.358642-1-christian.couder@gmail.com>
References: <20260402070613.85934-1-christian.couder@gmail.com>
 <20260407115243.358642-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In parse_one_advertised_remote(), we check for a NULL remote name and
remote URL, but not for empty ones. An empty URL seems possible as
url_percent_decode("") doesn't return NULL.

In promisor_config_info_list(), we ignore remotes with empty URLs, so a
Git server should not advertise remotes with empty URLs. It's possible
that a buggy or malicious server would do it though.

So let's tighten the check in parse_one_advertised_remote() to also
reject empty strings at parse time.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 promisor-remote.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/promisor-remote.c b/promisor-remote.c
index 8e062ec160..8322349ae8 100644
--- a/promisor-remote.c
+++ b/promisor-remote.c
@@ -722,7 +722,7 @@ static struct promisor_info *parse_one_advertised_remote(const char *remote_info
 
 	string_list_clear(&elem_list, 0);
 
-	if (!info->name || !info->url) {
+	if (!info->name || !*info->name || !info->url || !*info->url) {
 		warning(_("server advertised a promisor remote without a name or URL: '%s', "
 			  "ignoring this remote"), remote_info);
 		promisor_info_free(info);
-- 
2.54.0.rc0.114.g05d466edb8

