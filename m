Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com [209.85.221.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC5962D8DB9
	for <git@vger.kernel.org>; Thu, 12 Feb 2026 10:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770890953; cv=none; b=E/DzE5xwkmmgp8uQmrZnkv2Dee4Gd1QSpmV9QkyrRUQNDzCXQiyUyhIaouwAHZ9tcjNC+FI8PgOCcdxeKu2eIXwTOqZP7arsup3VKC8wtiwzVeplUX/GK1jrEPWjrfbMYqDjHh4d9MlDUnlePtlIsMUBpd8p5bkRn4I3R8lC/qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770890953; c=relaxed/simple;
	bh=cp4q9lpjxYd0VORoipzqEAnLNkD6l5hTvoYZdaSBric=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qxu5t/SlyZC8Q+QDLgzQqNsNR9+y50x1Mncjift89cod5wy+IWJZeTRTYR0Ze74/Ly9IhuR1ie7qwkJyXbynN2RMuiCOycsn5tZd3EQ6ab6RLQBVLCpH6PqZeGUstTGoMPH/f7Eks6VD1LNQRJK23EBahmvpzvdtjmcqxkNxVNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RzqUoiuU; arc=none smtp.client-ip=209.85.221.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RzqUoiuU"
Received: by mail-wr1-f68.google.com with SMTP id ffacd0b85a97d-4375d4fb4d4so2176018f8f.0
        for <git@vger.kernel.org>; Thu, 12 Feb 2026 02:09:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770890950; x=1771495750; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kwpUiu3kI3pqrnBdf+OCPFNXSIZYm7SET60klVO83qU=;
        b=RzqUoiuUeUIozYWIM5Ic31cx+sn00z//LHSFJqU2qT3BC6j2rSmwbRpQhG9J+h8Dug
         K2eUdVwNoc/6zggSv1GyHZaagZACQpmgAH1JpOLRorbHl4Buv30t9C6JQKASQJQfl2Qa
         X+kumNjBjvckUR5j6ldWuasP+KHkzxSI+/rY+tKXbPCUw9CmyTDIP/P0nxQHgWpmO8x4
         7S+snFt9LXylfhBIgQpGl8GPRIK0bhwtRViaEEaskL/dYapE/nRvAM4Eiji0NKuVRwfo
         A1fwU4L9C2jm7+zkpit40ghvJrwPP871b0piht6iVlyy1X4hq6EZxha673HBW+8uPVbV
         Eywg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770890950; x=1771495750;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kwpUiu3kI3pqrnBdf+OCPFNXSIZYm7SET60klVO83qU=;
        b=log48Tfi7PFZb3kTvllAYh4WXlRwK8V79wmpE/gSpCFvvK2bjgHjcNe1mvKAmOIJhY
         Vrj6mWyRc5UKMCtE9K/nIqUsV4AQ0fxFVUCMXgc5HiLoOOaIDP3iDcF/IbLcp1ciB1Bj
         T/eoM4NgKPiRSCoyjih7yanN7+6z/OlTcyTzC4Jsu/ZWIsifKHK5deL/eHqyPIojFRPU
         UILsiiVipT+vo9QExdyvIJJntnhbF+UUPfc4+hd1oYkpcvtg4/wlZVlBQVXouutbs1O1
         frhje1soamnlTS7Cv2a+oCZTHvzCpYevkuZ5/DssEseoGOrqTqReNbHsYgKsmi2P3Yl0
         4K2A==
X-Gm-Message-State: AOJu0YyUQTMZUh3bbLMNiWe+Vi7F3gGnD3AdzbU0+Uj8TLUjGgPnAPN5
	USC6tRk+jq1RA+bDVg06MlHjqTj7yngElOWKXH8CYwTjLmuF+ra52Zbm1pb23VrL
X-Gm-Gg: AZuq6aJzisn87O+FJI+wprnYqIyW9WeAe2JwFmoOni6JOA/hkjlNhXugTWScwXEdwwM
	pvGFsYWqEW2XnrVFgerocnZ6cKoIc1Twke+nx09i5vVc/nFEvoX6+hOK/eRTJVaDDbP1L+21KDd
	gtwiitHKjVJeYznHISm+TgGGe34CcQE5TdKfQuATbkoTpOxZKo5A/sAO99lwx0C3Ih/eLyL8xxW
	57wk70hwLJOZCrDFmvGggC3RlEOaFlf1jI2/uKEnuo60nf+eXxwiJbK4R3ycPj1QdJcg2Tt77zb
	5VAUvZq2A5+5hiLqJAUyV3PHAIw/u18iVQFjxZlZzRhlL5Da57DxMILu6pd0GKwQTssPCIFi/vm
	ZMciO+DeStRf+6DYkHtPY6Rl5GO9uJIqCDPFHvyRet+rQ2IKXEVCP6Uotpva41bL0VGXmxYUGkf
	60IUT3TdHuTABuNRNVK8G86h43YA42+TchOLD8zScNVotQGQlvoeQFPtLDRwgmP/KxuHM//AQFb
	PKYWvFag6R4VA923olTvHb8eu6DVXhUqcfwTFw=
X-Received: by 2002:a05:6000:2586:b0:436:1a4b:de36 with SMTP id ffacd0b85a97d-4378f11f142mr2912249f8f.22.1770890949586;
        Thu, 12 Feb 2026 02:09:09 -0800 (PST)
Received: from christian--20230123--2G7D3 ([62.35.114.108])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43783d3464csm12701151f8f.5.2026.02.12.02.09.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Feb 2026 02:09:09 -0800 (PST)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Taylor Blau <me@ttaylorr.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Elijah Newren <newren@gmail.com>,
	=?UTF-8?q?Jean-No=C3=ABl=20Avila?= <avila.jn@gmail.com>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v3 5/9] doc: fetch: document `--filter=<filter-spec>` option
Date: Thu, 12 Feb 2026 11:08:36 +0100
Message-ID: <20260212100843.883623-6-christian.couder@gmail.com>
X-Mailer: git-send-email 2.53.0.70.g3d1fd9d397.dirty
In-Reply-To: <20260212100843.883623-1-christian.couder@gmail.com>
References: <20260204110818.2919273-1-christian.couder@gmail.com>
 <20260212100843.883623-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The `--filter=<filter-spec>` option is documented in most commands that
support it except `git fetch`.

Let's fix that and document this option. To ensure consistency across
commands, let's reuse the exact description currently found in
`git clone`.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/fetch-options.adoc | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/fetch-options.adoc b/Documentation/fetch-options.adoc
index fcba46ee9e..1ef9807d00 100644
--- a/Documentation/fetch-options.adoc
+++ b/Documentation/fetch-options.adoc
@@ -88,6 +88,16 @@ linkgit:git-config[1].
 This is incompatible with `--recurse-submodules=(yes|on-demand)` and takes
 precedence over the `fetch.output` config option.
 
+`--filter=<filter-spec>`::
+	Use the partial clone feature and request that the server sends
+	a subset of reachable objects according to a given object filter.
+	When using `--filter`, the supplied _<filter-spec>_ is used for
+	the partial fetch. For example, `--filter=blob:none` will filter
+	out all blobs (file contents) until needed by Git. Also,
+	`--filter=blob:limit=<size>` will filter out all blobs of size
+	at least _<size>_. For more details on filter specifications, see
+	the `--filter` option in linkgit:git-rev-list[1].
+
 ifndef::git-pull[]
 `--write-fetch-head`::
 `--no-write-fetch-head`::
-- 
2.53.0.70.g3d1fd9d397.dirty

