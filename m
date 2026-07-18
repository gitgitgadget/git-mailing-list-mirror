Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1746B339708
	for <git@vger.kernel.org>; Sat, 18 Jul 2026 21:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784411410; cv=none; b=NpRjYL0h/4qSemZAedYYM/qLCZshqNGncgGbTaQhClsaAq5OkhTAMaBOKY+BD0mIY8fq0G3iHzJYQ9/k/fm/Gdmkw5s/w3TTnGjtjCM74HryGI3ByF4nwTlGTkyJHZ9wzQ67Z9lLp8ycyKWLeha/FpUQJL9bNhUw6pvBDnmoDnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784411410; c=relaxed/simple;
	bh=ybf0XRPB6fGoYcQWEAjIRJsRXBy407C2wSdjBILB0Ro=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q9XzOCHUwHM6c3i4n9IDGodBgcmH1C+5ep/nqGIXA23f1hZCvoTF9gR77Mn/ARCZW4JLTIclZX6EKRZKmw+DmlJMC2hD1cuPkuhpO+Qo2Phv8q7Z3xJVdMXiA1mxARApUwt6mFb4TpcAOsISIYHOcXbqsqhoqel8NPsvVel5xxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TdEi+8af; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TdEi+8af"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-49548e01d02so8350225e9.0
        for <git@vger.kernel.org>; Sat, 18 Jul 2026 14:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784411407; x=1785016207; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kL6y/at/qZ1hM3e3LquL/YeKXpvxJqFCpAqasseW+Dw=;
        b=TdEi+8afdNDtPdhr6lOE7++uEtYy9Vm8gauE7qHjZa/IpvJo0gomXDQ5Rdl1PflI6e
         99X8S5OlJVGgiX8ItRvENGxvF57WBhC6CF8m/IZVHE5S2wwp2PYtp4qV4WLTG3Ng06Ll
         TBiDbvRZekwavTerZ6ONsoi+3z1pFDuabnQTtlI/tzZZZViIaah9Kh22rPRiWnLOwoi0
         Tgv9ETXBfjprtigSh8fXkWGDRfLmXl5WGhrwBREpE3K2cuxWwTEvNr5sW8v3bhEAx6B5
         Wlv/DTIxGPB3A4K/Kcr6EYMv5wsXQCjcXrEyBQJuwPRuUHnb48mh0/KrmrY1FGGIvD9R
         4bHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784411407; x=1785016207;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kL6y/at/qZ1hM3e3LquL/YeKXpvxJqFCpAqasseW+Dw=;
        b=nv56ajoxtfziYTPy4h7NFhEeSelCwYWzDw79pW5Jm9lnPVJ/Cw3CxDo5XCKJXrAm8O
         5j0rW8aoHZN9eJb380mB5oCbHgWaLOTksGUB65/ObRBST/gWcZ7Up6YlzpCo2+DgrO2E
         FHEUf3bs0cp2PQaSCe0N0DRSfq9hcnxXwPH+c870VJmpGOI2xx0OKgdxo07RuzR5TMo4
         Afijey99GR7CfjPW6RXq/JLic0VB/WVkq4X7C1f7SDZ5OTJ5+J01/3lXaGsigKu33TD7
         GIqmSQYzxlcaRPP/X1IQOpld8yHjuPQwoChhGXWYBwcO4neSgjfkkwEdGUJ8NmSrUVyh
         Dv3Q==
X-Gm-Message-State: AOJu0Yz4o2Wrs2JCz5G136U9yo+VTzO43w3Ko0gpAHntAZMJABRBqK/M
	RLxUxLaEA28cuP9qeGLV5o31h7aMpAtlPs5qZYTyaCxksDG0fthz/nhxRO2ehRuA
X-Gm-Gg: AfdE7ckiaEGZxep6mYogeey+chf1XNc0FQk5oiz5J6xRdx0mNkElrXVXhuxqUJ2kSdh
	MsbU5j0k7i6YgEW8QeCBkMg++GYjtO85YzFV9w8/qrfu7pNNcANnAlETo//qveeatk3yBZ2ls03
	cdEsljMXKBZTKNZay4KtM61RXrWqfawiW4t93tZSqfGNegWNck9HQkqpjscgIh/E4/KwgOSR9Gl
	/5Whn9CIekVbdWzo83vOpdJFcEr6p8is2SjZ+5mxBOrMu43WW58cSHnLvlgyPlhwsa5UJ/3jpx2
	gUWE/HyHCK1rIs6lc0cPBkIBX6/4CC8rzdNw9AUeYvKHnIgFpHIINkBXIxkR8ULSnd/1cdiaiBO
	pWn/RzSdO4PjE3ZsFC34/hllW4UWROReUS2LlrIWE5Ry6cSNziGBGLe2pI8Es7PWLfh0MBG2Yhg
	f8GjI72V3lETfp2AwqfCRqSQKAYnHrEYyw61loEvVgBv1Sfwe4CtLuWBddkwoiJ1NrfIZ3u1D3F
	cIOdvnluZTiJhw0D7WL1y+8GX563Vy4Kpf0oI9f9YSKhf4zoXZleS84wjuRKJ0pI5LsPx+lGE69
	XPbdyIUCqqkv1wvMdCovyPFstiJz3DAdWybdSIQOoCs=
X-Received: by 2002:a05:600c:45d5:b0:495:4056:9473 with SMTP id 5b1f17b1804b1-4954a40d0c3mr88069095e9.28.1784411407081;
        Sat, 18 Jul 2026 14:50:07 -0700 (PDT)
Received: from localhost.localdomain ([47.58.6.31])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4954a2edda2sm146225145e9.13.2026.07.18.14.50.06
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 18 Jul 2026 14:50:06 -0700 (PDT)
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
	toon@iotcl.com,
	szeder.dev@gmail.com
Subject: [PATCH GSoC v20 01/13] transport-helper: fix memory leak of helper on disconnect
Date: Sat, 18 Jul 2026 23:49:50 +0200
Message-ID: <20260718-ps-eric-work-rebase-v20-1-0c13962ac532@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260718-ps-eric-work-rebase-v20-0-0c13962ac532@gmail.com>
References: <20260717-ps-eric-work-rebase-v19-0-d4faee35764b@gmail.com>
 <20260718-ps-eric-work-rebase-v20-0-0c13962ac532@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

disconnect_helper() only frees data inside of the if(data->helper) block
[1]. When the transport is disconnected without the helper being fully
started, data->name allocated in transport_helper_init()
is never freed.

Move FREE_AND_NULL(data->name) outside the conditional block so it's
always freed on disconnect.

[1]: https://lore.kernel.org/git/05fbadbae2184479c87c37675dde7bd79b3e32ab.1716465556.git.ps@pks.im/

Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Mentored-by: Chandra Pratap <chandrapratap3519@gmail.com>
Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
---
 transport-helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/transport-helper.c b/transport-helper.c
index 80f90eb7ba..f195070788 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -266,9 +266,9 @@ static int disconnect_helper(struct transport *transport)
 		close(data->helper->out);
 		fclose(data->out);
 		res = finish_command(data->helper);
-		FREE_AND_NULL(data->name);
 		FREE_AND_NULL(data->helper);
 	}
+	FREE_AND_NULL(data->name);
 	return res;
 }
 

-- 
2.54.0
