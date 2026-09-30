Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C4AD293458
	for <git@vger.kernel.org>; Wed, 30 Sep 2026 00:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790727720; cv=none; b=tgWKQGrOtQdFKBWpJvOfQxlW1pL4mQWsPtOHRKF4TwaX6EvMcuaMVrLAi7bVCsuSGoz/BAI9luuqyiiNB0hyFZt15kCasd3dYtaPQ+XVNQhyofBvG4z6g/bbjRfPD0wvR6RBY1QdN2551qNs5gEb9UdEvINlgzDV4/3knvzuIDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790727720; c=relaxed/simple;
	bh=SnWtw4Z02lAHbcPatiFGL6/jW8TQnNzrvGJ6EF+yzCU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Z5uXEaRN1zxpTHS3vwNi74iisynEykiyq8upfqUCprvmJjS1sGShRybwmP99Lyt7zl1aU23JJeWZbQK0cdXhYlWUa2SpNPz25EQV0b8MCTWcKxVWzelYwTFNMeDdUz3S5rqRLfSH5TMXYq/VK6voiF99PnVz67yk1VDSvpBdXHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qvhbnoKx; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qvhbnoKx"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49b912d3920so35538765e9.1
        for <git@vger.kernel.org>; Tue, 29 Sep 2026 17:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790727717; x=1791332517; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=S2UcBgPt0Un3n5ZlWtx8WjjXFZRRDyO9N2lW7Xjhejg=;
        b=qvhbnoKxaOcxvtFzFyhXn79T87tdNXtSF2YTAbnFPIZLvk+YklYu/TCapR3OD+GtJh
         qBVobICfn14PTl3HRnDeTkfOfGgvs3zVHFjDvSf+0jA2tDobuKXTSSjIAkBgihk8ZyoD
         hP4koZg1k3mG4P6DcyUf+CnCb0XDyvZ1xwpwdQZI+hMZ0hPQSm4hPbCNhQsPj3VEaSzh
         5Vy4xUaD7o0fsv0Uq0NQDjTkUhxlqbHOdUrZ1jmOV+kb7xHTNS4R87qO7Pz8xg5WRCGF
         iMgZhSoHc4U0RuvGw+1StM7JrnXKMWvUx6v72AlQhE0XXhF0qMbWJTBZrZumFvSs7TKE
         VNSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790727717; x=1791332517;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=S2UcBgPt0Un3n5ZlWtx8WjjXFZRRDyO9N2lW7Xjhejg=;
        b=K7Skr1dOoUQ6hVjgMNG3NlRA3WyAFNftAe9uxkGzkNjaDldocRS4VuG4NpPL8kijQc
         Vj2ZxNsnrPUM9nfIiRiyTyzRihaSfX2D7iWXNv2oPwWzgZHZgzuLEsHslinSUyJEiRJR
         eReE0rYaw6RIMcTw0pOI2QxK3w1UCIIuJTZ6ZGBpOab7Cf0g1qRloblpipBOXEM/Cr8k
         j818lmHamJwL1fy7TrdSu32/XVviWkm10x21SM16k1kWkcSK753GHgpESCZKIImiSw7L
         yhAR9MCAZJeMj9Iq27vMYX8ntAa6BBhIC5iIKEP171Kfi2KYVU3S/DZQAgeIs6r9XUyw
         ZkWQ==
X-Gm-Message-State: AFuF++lH1rVOFgJldh8IVmWWMsEXz74eKDypjrHu2KOQCssWcSn3OIp8
	+Tja25CNC8zqpHNwmEw9Vwco+4up8+fAHgyG4h5JX6KKoFzi5frfAeYPi0x9XR/oAoM=
X-Gm-Gg: AYBFou3CukYWyUKWrkNgCPHM8M+mrZ9xOBnRYpori1uf17dsKVltHJeAjyyS2CiXjYu
	re5ZB53SRkD2uVffO9eFj04xFpRiZzLxADP67tVuR9tSM+Th+UtijS+9E/Tk02F/SGp9KHDZxpI
	JNUO5Z2GP8TfM9seRG6U70Yd682NAw6NUZDSF+w8KTaxUoYF+yhKWj0njC2oxH/CdgU2cpqAX/d
	Sfd4EQnEbyuxidLh928MvKMhUtW1dVTw5mCIbQprPY6Wg1wNUGDfNb0vxGQFaG3ZvCrHceH6yXP
	fmJ0Oj1H2h3KiVhOvfb2gLu0zKaFoBBurwHk3fvT1AlJN1Wfgmqo2QfLQ0YKQhA8kmOoAQTL8LB
	KoV+zDBDlIA3+h5YWLs/1CGcDOjJQ9AVHKfXDpNR1OOS7++Zw2q6zOcQ71MR5sHIVYNWyWYjVgg
	G9WwR7V004TIrMIX4McQg+0dDzfgvwYAWXZ8uqMo08q8CzK+tTXvCnlMJtwdC6N8vWdgF6P9Yx1
	XQeG23LLezhEVhoT1Ljvksv6ekxBcLwbZCxGNfCqKzouzHhY37dVq3hpbCEvqAekUF19qCdXYLV
	XpcyAtfyA+Gk/HKGTeLh+PVt2q/x/iTtlEsSs7oF0Fo4jwpuqc/vRCdLP6Pov20RNNhMAPe2pIW
	j3VvqIeNhKVUbHl9j6tX2m0s/aXCxRzQ=
X-Received: by 2002:a05:600c:310b:b0:49d:34:420d with SMTP id 5b1f17b1804b1-4a01513be5cmr11528545e9.20.1790727716576;
        Tue, 29 Sep 2026 17:21:56 -0700 (PDT)
Received: from mac.lan ([2001:818:c665:a700:4e1:afcc:bdec:a44d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a015cde27asm5135615e9.3.2026.09.29.17.21.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 17:21:56 -0700 (PDT)
From: Pablo Sabater <pabloosabaterr@gmail.com>
Date: Wed, 30 Sep 2026 01:21:47 +0100
Subject: [PATCH RFC 2/5] fetch-object-info: add enum for
 fetch_object_info() statuses
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260930-backfill-dryrun-v1-2-1128f247ee01@gmail.com>
References: <20260930-backfill-dryrun-v1-0-1128f247ee01@gmail.com>
In-Reply-To: <20260930-backfill-dryrun-v1-0-1128f247ee01@gmail.com>
To: git@vger.kernel.org
Cc: Derrick Stolee <stolee@gmail.com>, 
 Pablo Sabater <pabloosabaterr@gmail.com>
X-Mailer: b4 0.15.2

fetch_object_info() dies when the server does not advertise the
object-info capability. That is fine for git cat-file
remote-object-info command, which cannot work without it. However
a subsequent commit needs fetch_object_info() to not die, to be
able to fallback.

Add "enum fetch_object_info_status" so that fetch_object_info() can
report this case to its callers. It is used in a subsequent commit.

Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
---
 fetch-object-info.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fetch-object-info.h b/fetch-object-info.h
index 2fba96c6f7..663a7f3ae7 100644
--- a/fetch-object-info.h
+++ b/fetch-object-info.h
@@ -16,6 +16,12 @@ struct fetch_object_info_results {
 
 #define FETCH_OBJECT_INFO_RESULTS_INIT { 0 }
 
+enum fetch_object_info_status {
+	FETCH_OBJECT_INFO_OK = 0,
+	FETCH_OBJECT_INFO_ERR = -1,
+	FETCH_OBJECT_INFO_NOT_ENABLED = -2,
+};
+
 struct oid_array;
 /*
  * Sends git-cat-file object-info command into the request buf and reads the

-- 
2.54.0

