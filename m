Received: from mail-oi2-f13.google.com (mail-oi2-f13.google.com [74.125.231.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96ABA4D0A1C
	for <git@vger.kernel.org>; Fri, 25 Sep 2026 16:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790354163; cv=none; b=cI9y6IkvQES3oFHcfB936IKYLnhaRbX3luyOQFcNhxFxVMCYDE1f40UpIQlLCebmyUjI7D+rW1JEtUxnYC3enUaEcv8xlqsKTZFeL7lQ7dulelIN+qi+eSQThDpg5DXel+vi3u9ZqQQQnQCN47jTDWNpnLgpiZjuO7Fuq6X6L3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790354163; c=relaxed/simple;
	bh=jlnu3b35JFYy/TVX+jWPGjBnWu/REdsOcCfy6nFzHNo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lgZhJyvgqeiigyj2W3DJAN0MZqiDn3vn+x8Xk1QOp87rHLfu64X9uEsKb2rcnsetxFQb+eeOtFc3dbE78HFIxAbzO6lW3zVizcHl12RSLMZtizLfv/Bxy+G2BUeBeCpZbz4qE3s16Vw1HbU4CwU8g4cDUZ2DIKKsNKQg0nFWiWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TmTZN6FK; arc=none smtp.client-ip=74.125.231.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TmTZN6FK"
Received: by mail-oi2-f13.google.com with SMTP id 5614622812f47-4b37a3a9768so880029b6e.0
        for <git@vger.kernel.org>; Fri, 25 Sep 2026 09:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790354160; x=1790958960; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=otBUVID5cpnynOcX2V5uhON7JiX8lFfwfDM0bfHQV0Q=;
        b=TmTZN6FKQtVeeuHAvbprHbHKNZfiCPT7k9Wx7LqlAHxlEgvc2+2JZWKFEbhAsIfqbB
         CepJdk841PPanuFYoSsmMQUpUwoXW0fabSNkKQKuyGL/rxfJMFD/rla2W2nQJZtlMLFs
         J0G7G61F4uAkOYhdJ+ZbZGIFem4cY8/V+HPCOcyZytIP/IPu3c92ZVfEJWbO8oSPkiJI
         VD5SSDT4UhDILbtpJLQRcS+pxNaN3zT9hMjHpcDQMeZ+a4Vxd96OLzopfL0t8SrrNFln
         MDkf/sbXezx0kwbc181GSKe/IFvykAmfz69D7V9mGlRQXqSQ8+DloHmRnYo+Yl/s7tRB
         UDVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790354160; x=1790958960;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=otBUVID5cpnynOcX2V5uhON7JiX8lFfwfDM0bfHQV0Q=;
        b=VsMdvrT3ZAfzUXMGv8wBxQEJ3VhGVXuMF4m5F/xGYpg8ViXt/LpMqHWnzKvyCzhnvp
         netSd26LoK1EPcdmV/MLA7ZqhBOX2+qWgOO9jEmyXyUHDJdGthrlAR6UQdvI7oGuEsNk
         KEJpyYX7ELNK2MBQniDdAuqdPomp+3lBl1Fm/kzh31dmxPhEvpBpaHpCji1H2pbEdDzU
         ZANaEn1JUl/6DziMnelnC5ccD9LT+vy5pOTev0NnydcvEAFnc1MtR59pvVuSgcz1Tsh9
         tWa5+0kv0YDSJIBKSqlKmjC6maMw4LwcRIaIGGTe87LvVCDhZMJBOXnHZ6vyXZZrBQ22
         xCjQ==
X-Gm-Message-State: AFuF++nUP/rnMVXt63SSSHFOwFCAbRLVAhj9GARCaUfdp+gqMP0bjqaK
	hK3johNdD8uw4mXCgeMRemJ4K+bdBwT19nTuqFUUnVZaJ5H2QlnT59ua3GdYL/0o
X-Gm-Gg: AYBFou3MeqrWIGaeaxHYtob+DX4f3br2EqmYpAldW5kzXWuCa16lO87g3sdTtEV+0Kp
	DacgxgRzpZqLHJ65CnB01DmjQMvqp0qN488w8j/Cvy1mfmasokLCYrCcdwKRS57kyk67g7ct/Cd
	veDNEQizOe/GNuX3CkZoQ3beSPjC7sVYNK0KQ61Lo/miRWtq9YDUGZaRdlWvhvzdItaKsUmaeIf
	17JEiSrH9bVrkkHJLqQ8GbFDKg/tXzHzzCrnYnx+YzMOewyVBOiKvrMdxzOqataiCDWAa7F9jug
	TUyZ6/FE4emmK+PrSSJWrHk9mtUPu1yrE1ferC4IeJ3nNVja4PHnix9vFm1AwxjEGE1txIur8Rx
	k6WvePhzFOZTU2Nc9HmmiaucscE9vXaH6Xwpyv8nZoQDptMpgiMf3EdnH1fLzfgYcoTdMIo97/O
	87WI7tPfptTeaxuaZNAdbG5/sucqv+2VlNIW0yrPw9d7HYW4YbZ11G3CTQSpqEkGOiBTL6vrCHa
	ATQrMAIew7Dg0kFq7XE4p5+gQsSJhXEsRKSTa5l5ENgJfDQyEF3KQf1dcWMuc+7G7Uif9DOcLOl
	FQXS0FpinAyjv0to48FTirXRgo1M1jKn8Ld1gFjUTHvOx+fdlnxr5z6WyiDWT7jwvtiwTh0ZRzE
	Nx5m+pMXjsaY+krsNYwyCH3z7B3iQD+wUpJKNB+qkKh6kEDG9n1XuwMObgd0=
X-Received: by 2002:a05:6808:238e:b0:4d5:27da:a497 with SMTP id 5614622812f47-4d72ed6980bmr5530309b6e.49.1790354160418;
        Fri, 25 Sep 2026 09:36:00 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa (vpn-centralus-01.tradc-corp.com. [172.169.249.3])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4dbe7e76bcdsm2113204b6e.1.2026.09.25.09.35.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 09:35:59 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Fri, 25 Sep 2026 12:35:38 -0400
Subject: [PATCH v2 1/2] t4205: compare huge output without diff
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260925-ci-large-test-resources-v2-1-f632cf319756@gmail.com>
References: <20260925-ci-large-test-resources-v2-0-f632cf319756@gmail.com>
In-Reply-To: <20260925-ci-large-test-resources-v2-0-f632cf319756@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>, 
 Jeff King <peff@peff.net>, Tamir Duberstein <tamird@gmail.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openssh-sha256; t=1790354151; l=1402;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=jlnu3b35JFYy/TVX+jWPGjBnWu/REdsOcCfy6nFzHNo=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QBvBuroU3LT5uSfGwsMB3IIv//UQE1GMrI7DfALYKRrfYX3aC2of03qL5PWb1Nlg5lkZ5V7Zv/g
 C3n3NTyexTA8=
X-Developer-Key: i=tamird@gmail.com; a=openssh;
 fpr=SHA256:264rPmnnrb+ERkS7DDS3tuwqcJss/zevJRzoylqMsbc

The huge-commit test compares output containing a line larger than 2 GiB.
For two identical files containing 2,147,483,649 "1" bytes followed by
"0\n", GNU diffutils 3.8 on Linux arm64 gives these measurements:

  Command               Mean +/- stddev       Maximum RSS (KiB)
  diff -u expect actual  5.276 +/- 0.572 s              4199924
  cmp expect actual      0.506 +/- 0.099 s                 1264

The test needs only an equality check. Use test_cmp_bin, which runs cmp,
to compare the output byte for byte with less time and memory.

Assisted-by: LLM
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 t/t4205-log-pretty-formats.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t4205-log-pretty-formats.sh b/t/t4205-log-pretty-formats.sh
index 4be5c51489..01b97c8888 100755
--- a/t/t4205-log-pretty-formats.sh
+++ b/t/t4205-log-pretty-formats.sh
@@ -1189,7 +1189,7 @@ test_expect_success EXPENSIVE,SIZE_T_IS_64BIT 'set up huge commit' '
 test_expect_success EXPENSIVE,SIZE_T_IS_64BIT 'log --pretty with huge commit message' '
 	git log -1 --format="%B%<(1)%x30" $huge_commit >actual &&
 	echo 0 >>expect &&
-	test_cmp expect actual
+	test_cmp_bin expect actual
 '
 
 test_expect_success EXPENSIVE,SIZE_T_IS_64BIT 'log --pretty with huge commit message does not cause allocation failure' '

-- 
2.56.0.rc2.815.g5b995412e4.frankengit

