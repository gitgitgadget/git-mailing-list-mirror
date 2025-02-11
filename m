Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AFF81F0E2C
	for <git@vger.kernel.org>; Tue, 11 Feb 2025 08:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739263852; cv=none; b=fwzKBwW/7wzx0oZjZgEInBDaNaAX0p/3ucKZhgbYb9VNdVx9w6anZkmTbYJoNdqrA211yz+axKrpnvKwdsVWrc8PnfIh1S9NxpGCBdHUig5YGqbYp2vYGGsunByGi0TNW7lLDWY9D+QJZ3cni5XOkzk29vPBDLKdEe3+jzmCV5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739263852; c=relaxed/simple;
	bh=Rr6m/A9IQb396HWEa+1Qnky1V1CFb9AfduJm2EFAYOo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hQTFSBi9mwwS3GMEuyFcb2REi3/apu7h3syWkWWhM1hbF1x+v2quTYAdxWsYrVFuYPCEoV3BmI0Kta9NJsl6Fys3B2DPk0H4jdevlWybGem9WEo7aUpxyMiNQSp1bJeuqXJAbDgJfmEhEncprs8OCiteyj/ElAVX19gjMZMsrVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ok+a05Nr; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ok+a05Nr"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2fa19e1d027so6746251a91.0
        for <git@vger.kernel.org>; Tue, 11 Feb 2025 00:50:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739263850; x=1739868650; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VKzQoKAngCs6HWu9yDO+usfiXV22m58qAkD3sftzJCg=;
        b=Ok+a05NrNNtmXETnc7yrS7YWyN9j7nNfL6w4KgGXYCnmPBiJG1lI5Und4xs8o+hZTk
         HOuqpJIBuX93Tyysr6n9nN1AmH3gzLBGvTpv7fNTtbwlunjQq6mOdhzQmXfLUgO36pOJ
         axMyrhILszNqRnYrlvhnrjaqolPwzMYtmhhswJIrvJv1b/Q21Cg6jXUAvskwkb7Pm0kx
         QeIYLEJI5g0EcBMxGNsZfN7W9+vqRzDS/CLaupK86TPukXIf1VbERl4ebz8TiU8PYHRQ
         DhSircik8QxglamWYke6+wq5w288VkbuIkagolC0QqI75m0ZsUpQIjusy3l6KhxN+rjc
         enBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739263850; x=1739868650;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VKzQoKAngCs6HWu9yDO+usfiXV22m58qAkD3sftzJCg=;
        b=TSY2gMIRJyQaGoGeHvDDz21HXGfDtgG7R+Bvk2mO+vFJNagQCns2U+N8wVTaSycAXE
         wtgFk5DNMymOqomKtlFIrPoBjuBj9Jh7W5CbJDqSpLquAKTCHKxc+mqbHCwuWsRAiWUq
         2nOHx7KMn0PxMjAH/YebA61BiIkDOMbIDnaoa9J4Nqbp8I/73Pb1wTSUbh3NK72aMfYs
         UU2FAYYQbe95bqGHePhh2F4p9V5y5Kko25gePZwH9SU1fj2StB1IobORbdbkslIcaJ0U
         ftz1kzB3dQj4IlIMIkN/qTYyLysu0WoTuIir+GzeDc52FLDk3Ezn8bumiZ514a1UBAq+
         W7pw==
X-Forwarded-Encrypted: i=1; AJvYcCWEps92Tfqfd0yqEnUiIuDu5HGkzEcvABziEGFXyxoiqH0R89LiQOG6InN9iDcR6Ul/1yI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYiL0fvWCqPP+2iAOo6stgg9issXnJ+z1BjcszJ2JTPs2fb4SB
	8t+8cZxJiFt9i9cG7yUFX6JofW+eOSx8RovIKHfjiAFOmcJbSNo5
X-Gm-Gg: ASbGncvRUrBtMY468NsjXIZBlVgcOm6Jp0m6p/ldbJTAHCqhwE6ZkrMBKo0kckhhWtO
	IhAE1M4Papf7+76JvysjDLJeYowicRXQHtDkgIuPo4O/yAYtH71EfDs3UJUtbaSLrzpJSWLzpqL
	hj6UnOFIYR4OcrWxJVcMI5gY8BZgCaUt2JJXZPvTK92SvoSgI6w0Psf9xoqVsMM0sqh+iSGBHeP
	Oie+NLl9BkCjPs0mZ9xMysA2Mbt+0bnRz3LgY5sNu8WXoocFEVx+1wmrcAajltqYWARh1qpC18y
	dkLAjqspGz0JlI+7jMGZHTB6p3ctBOWido0AW6k=
X-Google-Smtp-Source: AGHT+IG44WLRqyYkX2F8zCOG+NaUwe69xnS05CCE46Rx2BU52FjZ06IoSQSoLt1PxZgj27QRP80XvQ==
X-Received: by 2002:a17:90b:358e:b0:2ee:e18b:c1fa with SMTP id 98e67ed59e1d1-2fa242e5c8cmr25005704a91.28.1739263850360;
        Tue, 11 Feb 2025 00:50:50 -0800 (PST)
Received: from gamma.hsd1.ca.comcast.net ([2601:647:5580:5760:3858:1e16:caad:e1d4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fa09a46534sm10201701a91.21.2025.02.11.00.50.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 00:50:50 -0800 (PST)
From: Illia Bobyr <illia.bobyr@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Illia Bobyr <illia.bobyr@gmail.com>,
	git@vger.kernel.org
Subject: [PATCH v4 01/10] t/t4209-log-pickaxe: Naming typo: -G takes a regex
Date: Tue, 11 Feb 2025 00:50:13 -0800
Message-ID: <20250211085028.3923875-2-illia.bobyr@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250206014324.1839232-1-illia.bobyr@gmail.com>
References: <20250206014324.1839232-1-illia.bobyr@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Not effect on the test logic, but as "-G" argument is a regex it is more
accurate to use "regex" as a dummy argument value rather than "string".
In all the other case when "-G" is passed a dummy value it is spelled as
"regex" rather than as "string".
---
 t/t4209-log-pickaxe.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t4209-log-pickaxe.sh b/t/t4209-log-pickaxe.sh
index a675ac..ed70c 100755
--- a/t/t4209-log-pickaxe.sh
+++ b/t/t4209-log-pickaxe.sh
@@ -89,7 +89,7 @@ test_expect_success 'usage: --no-pickaxe-regex' '
 	test_expect_code 128 git log -Sstring --no-pickaxe-regex 2>actual &&
 	test_cmp expect actual &&
 
-	test_expect_code 128 git log -Gstring --no-pickaxe-regex 2>err &&
+	test_expect_code 128 git log -Gregex --no-pickaxe-regex 2>err &&
 	test_cmp expect actual
 '
 
-- 
2.45.2

