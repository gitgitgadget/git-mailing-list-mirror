Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCDE82FAC1F
	for <git@vger.kernel.org>; Tue, 12 Aug 2025 17:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755018184; cv=none; b=qsA0OLRWKuitz2Z13DZWLA9G2OctmRiLP6W9S6SnI9Lpj03vCsTZIy9urRu+3k0KU+6UE8kEcZdut749zblb7Dy495Wgoy+BkVfb5UZDnYPDSpWJfAbNk7vjRu3X2yH8hy2Cpu3ACrYvDuob0BMKrsM6JObUTXqOOEV0wVDNMmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755018184; c=relaxed/simple;
	bh=b1rzEUsAbcs60PDDzT1xHi4YKMeXvyQd7bvuSSESTgQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ecr9F+ex+WXsyRMi1dSyRLFXWMowHY0FWDkk18mk269DEXqZc+z+UrkTI8GmbpQgo826KKb8nsl90LPT82sm3xnvJjnC8VsJ3Jq1XpJ8DTMT/PBNx9BFACDqNQr3G1xgUstnCcI/kWiRgX7I53bmHIXrGhuW9i5jUeoWblLk//I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GurLNUDR; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GurLNUDR"
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e8fdbd45e10so4600407276.1
        for <git@vger.kernel.org>; Tue, 12 Aug 2025 10:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755018181; x=1755622981; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1NwR/EcFtwgExg9DA+ZD/vWVg+PUuNVvts9fL89eA8s=;
        b=GurLNUDRxzsl1fPq/gVfF3F/1tj9YHCsFae7fATpw9uo+/viY5DJVfsLDF2ejedmWq
         SAhaw9YnbORSzty6oA1UAQPHjxSn+JBMXTEOxocWq7QNIPPLL97ZNZJmaLRLTrWSUx3F
         7IlfX9yJiZqaS1mKAftSUhCOlHQgJDwp7GEDwCLFyfmz313qKbWu+UaWPl9XivyOloj4
         Nu6nPvhUL5mkCkOJkGmmDIDq+L4UsOzstM1OJ73nV/ivgztHhEmuM88aPqYJmHT4RnHj
         H/4Ldq5AyIkXoPvkQlH6xpkwv0MO3h5D5P2p8dLK8wyjyMWbKe2hYh4VStR7Bu0Vs95+
         yuZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755018181; x=1755622981;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1NwR/EcFtwgExg9DA+ZD/vWVg+PUuNVvts9fL89eA8s=;
        b=W9stHyK9u69GC9blwEb8j9LA4VodTxE5kTQ9Jmq4PnFWjFrcsPCav1se8QReL8+dkV
         FabkxKQqQ6d9Hug7NDhZ7TJdtVwYnUlp/9TrXXXHbTKcHiNSNyQBgNFHouPlP4Wl2C7k
         0YuUXyhLXsJ3xDh0TXDtTv8UBZ6RfIqu1D/assKTacTggmMgirAte3AcC7zjvX3ZsAuo
         ZOaYWxX5sJBioB/vpW8ZiypNyR9ZjcnQZRQVkNZfuLQ8cvkHsJTsYca0Gb/oQ5L8Sa+X
         gSSbr3IH/d6reyBpHTCFMjII7y3e80ShvXVeZHsNH0yzAb08fZ4kW53wnhr206V+54mW
         kmLg==
X-Gm-Message-State: AOJu0YyJakoBOhYZo0Pd90iHZl9tLAhFbU9R33hMlwgxN5gK1k9XAVis
	V28Qtr+g69uAzW6Ki31BwE4RlmrhFw8SSpV1SsaPx6qTT5zL9BKyB0Na2ccuzzNK
X-Gm-Gg: ASbGncv1YO6gtPyDGb30RPGOmJMJ9qucvMtlO4s+mcT/DDnHDFoGF6yeqefBxuAuhbr
	kUylGPJaUcp8LSr1b4NmpuL3UiWgrDvTAy6HWw4hRPQYaJSgy8oYEvbbj+rW2bhtTajosCYJC4G
	ETMtD+RdZ6JNTI/xyB6rpiHNCvme+Y2GwYoOzaQj+xz8tB9T9oZVphmEr5w7pLm3YHxJ6MQVxYj
	X9ZnM9Pu5ezlhMVIoD0HwPGypd4y0cP9Kp02y/CTYQvfddyPVvIlzLvmm8w2XZ7zkFf4vEG1Q4J
	8YnUP+mv4F0aC4rl+bmTUgP8XfToCcSHzr5FNo9FNlO8DhrZIa0PQIBvTdpzBI96riSl7fnw+tw
	S7zIS+z/H/qXINzIQDBNtjweSWtq4EiCZfTvEHvrPpRIPmaaJdw6L/HffzVNHqE7i
X-Google-Smtp-Source: AGHT+IH0l5CrHRH1dkvi5S40Qt4s3wDvxl44ztGY04wK1hOsNiUl0P22CcGQboBx7xakrTxX5psRBw==
X-Received: by 2002:a05:690c:6013:b0:71a:3131:d98d with SMTP id 00721157ae682-71d4ccc3b2emr4633637b3.8.1755018181180;
        Tue, 12 Aug 2025 10:03:01 -0700 (PDT)
Received: from localhost.localdomain ([2605:a601:90a8:8b00:b54a:f21:a9f:3c85])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71b5a3f6cfdsm76960927b3.24.2025.08.12.10.03.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 10:03:00 -0700 (PDT)
Sender: "D. Ben Knoble" <ben.knoble@gmail.com>
From: "D. Ben Knoble" <ben.knoble+github@gmail.com>
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble+github@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v4 2/3] t7005: stop abusing --exec-path
Date: Tue, 12 Aug 2025 13:02:17 -0400
Message-ID: <20250812170256.71751-3-ben.knoble+github@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250811221706.67168-1-ben.knoble+github@gmail.com>
References: <20250811221706.67168-1-ben.knoble+github@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We want the editors in this test on PATH, so put them there.

Signed-off-by: D. Ben Knoble <ben.knoble+github@gmail.com>
---
 t/t7005-editor.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t7005-editor.sh b/t/t7005-editor.sh
index 791e2a0e74..b384eff5d8 100755
--- a/t/t7005-editor.sh
+++ b/t/t7005-editor.sh
@@ -65,7 +65,7 @@
 		;;
 	esac
 	test_expect_success "Using $i" '
-		git --exec-path=. commit --amend &&
+		test_env PATH="$PWD:$PATH" git commit --amend &&
 		test_commit_message HEAD expect
 	'
 done
@@ -85,7 +85,7 @@
 		;;
 	esac
 	test_expect_success "Using $i (override)" '
-		git --exec-path=. commit --amend &&
+		test_env PATH="$PWD:$PATH" git commit --amend &&
 		test_commit_message HEAD expect
 	'
 done
-- 
2.48.1

