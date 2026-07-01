Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C75C03B38BB
	for <git@vger.kernel.org>; Wed,  1 Jul 2026 06:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782889183; cv=none; b=ggNzRcNGUtgJTIMa+HZ7oZDL3AgoC97CXtxOPpRYGtRZN553Vos+QPNAWStQnk87chqR+Wc13GYJi+B47kPbMmcgY1t0APNvRN1A6Cnon4kLZg6jfmSGaGXphLg/xxYtchofQ1CupyK7OTYsgiZpdhgPu70cHLKZTEnXngvuybA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782889183; c=relaxed/simple;
	bh=MVuWkFQ/JgYwkjHNiTKuhWkkH3YqOhgdl9oOIwzEs/s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SDBfhKsNCYoUP5tKb3/J7klkdn4jrXIOfYL0JsdtlZ0783MieNxiZ5GTDoS5MGfMgj4DB0MC7n4Bwq9NQhTYcpr3vuJi0VlfKU+JJ2AA641HVtW6NGBCIkrJY8WqP1ne4E2AkR5fwwpud8qOgWUdD5Bg5znn1YMR/i1aBeHl3z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=KdJjaMGK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YX5Pk+5g; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="KdJjaMGK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YX5Pk+5g"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 2534514000DE;
	Wed,  1 Jul 2026 02:59:41 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Wed, 01 Jul 2026 02:59:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1782889181;
	 x=1782975581; bh=fyAbdbQCDjdPPQddfPmGZgPkeYsM1I94vNuFyqCu9z0=; b=
	KdJjaMGKGanLdpiGRCjlVhOPACuD6MLYFQ4Qg/uylDhK72v3ipueZAmxY6MAOiJv
	82nnVbt0vnSiYHeXntXA7OpPE9CfBlTR06yQ69sobzwvrNwthNfiXLXzVxuaxdq/
	SQ5kdWO3ZhhfAIh8AhGGEustiH0vbzhKkbH0yKSND+RXMNUUsXUdhqOLwX8npAcG
	vE7fZrUXaNfO6RBMG3nEXVU3VA6LPDTVI9SNh5KkwNinSPJZkcnNXKMCqbCbGzfP
	Cp1ecD3KHH9pL2lPHFx61q31f8kNcFszMeCGN6Nh6U+7mev2CGykIPg+SslW6LDU
	o7qonJgm3sTCdbPfa0Nk8g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1782889181; x=
	1782975581; bh=fyAbdbQCDjdPPQddfPmGZgPkeYsM1I94vNuFyqCu9z0=; b=Y
	X5Pk+5gZUGbQUaT5Ra6QDMvlJm3+fk0rJFZBYl2D+9tY3ID+8FtEUwrCig9veTZB
	/wy9lx+shMw0Zk848thsFt6icsD0dZAMjMIL8GwsLN4J+n4h09tw80bNAF7mc6Xo
	kyyR+7KazGbRR9WAgFFZ8zRB1soS/+4ChpdAaKnBIC9Cp1pkY3spichxHZNt15vP
	2dA9VyGQxYlZnsy2ARTESmUlGuYlQ+/5KjoI2TfFP+9gBNDcRpZdNkax1Il+6r3a
	hnI9PDa6XHqhFk2bY3c0RyiHz5IWQCpAD0mGYzoIMmwv2xmRSWSfRK6ZGikWvHz9
	ekEg8JpUB+o6oozLlOi2w==
X-ME-Sender: <xms:3LpEauneb4W9YPJue8ulGSDksbPRM0tkXTVn98LOVXN6CBMwwKEdWA>
    <xme:3LpEav1cnFTJObh-uKBoN3EqMlMb1UyhWf4tSeO6wU7Aac0u5G-5LZ0XUqSw9rM55
    auq5FxYNY5wXA7ID_jSOzHEjnf1BJkmq-e9a8yG6flzxq9PzrK3>
X-ME-Received: <xmr:3LpEajR0mclecstZ1-y4udWfVv1Mj20QXS-oMDfnpAz2JXi88DouptY6sGkAuIGmqvJ_VPs_6kpqVez-uFcD5-VbONXGaxf9EaKUQKb0i6U>
X-ME-Proxy-Cause: dmFkZTGANECJKrpOnBa6RYxUTtblH/qBmJ6UBhV4DmaY6qY5o2i+ZHt3X+wkxPHG1OLabG
    1sulWHjmhrjlmEAfxnUOT825YEjkwhYDmCZBAFdo44Zls2Gmh4Ty7kUg74MX03B9ob7D+D
    xHxtLgFuGV/ELZiHMoVhZ+8DiJYnEf50DAM6KuPEVg3ApLuToharsu4Yj3w0cgM8IBlkGZ
    3GxB7fzoQt908vVOVlwv9HM8lofzzCrm52d4OL+j1Kl0huy8VY34TRyl+2BEYd8pmkoKWp
    ODSZZnszhueTxA6LU4+0sB4dfo4uFt8UPBF6tLYOpuNkfEhr/hGIQFiLdTv6worgNZw0SQ
    41wLAI5V/8BlCGs9YSw7q8wJISSjHxnaddUow3mEdbZqVHDoK0WP/L7fIUeZzCHomoUzqt
    JX2IlSO0Z5gQWCvMB0EYzg71Czj877KpU2PwcqREJjO3FFTpxPTcUGSzemagINOt7vZRkV
    ihwSOOwc8wzrCMHbG//y4JhHLzCGNCIWick+v6J+PqVO4efi/9W2LCHT8TxbEE7nqf6MFu
    FILiWICZ+ssCiZROm3gxGIYNaEwlf9HYv3K26cB7FClZELbqZbaMNv3opA8mGgUKGNDybQ
    IzTjG+VvS4i1ehS33kcxqZEGIxB7H+Vgib+nWINFmqXHUhItcPu656OgFcTg
X-ME-Proxy: <xmx:3LpEagwwZc1U7rQ6IYnKG8CDCqRyQ3OJDxrM_BYgUpBkVskOmfmV5Q>
    <xmx:3LpEarCNE5NmR-kMB8f1_2rWDnocLWrhT3UgwNZJUdhMBqCicnH7DA>
    <xmx:3LpEakFUk6GlAAbHKRQPJy8r_xi9540MU419YpcQPnoLUMunsR67Sw>
    <xmx:3LpEaqMad7rxVpipUmYpyH9RobLrm9Vrb_R50l5FItRgrrkwxNJ7kQ>
    <xmx:3bpEal5ih-0W6xk3HBUBbbugzW1ISiDATELRqDg9uhb50J3azmv4HRqo>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Jul 2026 02:59:39 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d8b1d681 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 1 Jul 2026 06:59:39 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 01 Jul 2026 08:59:26 +0200
Subject: [PATCH RFC v3 1/2] t/helper: prepare "test-example-tap.c" for
 introduction of "lib/"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260701-pks-libgit-in-subdir-v3-1-5e4860056094@pks.im>
References: <20260701-pks-libgit-in-subdir-v3-0-5e4860056094@pks.im>
In-Reply-To: <20260701-pks-libgit-in-subdir-v3-0-5e4860056094@pks.im>
To: git@vger.kernel.org
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>, 
 Junio C Hamano <gitster@pobox.com>, Elijah Newren <newren@gmail.com>, 
 Derrick Stolee <stolee@gmail.com>, 
 =?utf-8?q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>, 
 Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
 Phillip Wood <phillip.wood@dunelm.org.uk>
X-Mailer: b4 0.15.2

In the next commit we're about to introduce a new "lib/" directory and
move all of our files into it. With this split the compiler won't be
able to find one of the includes in "test-example-tap.c" anymore. Adjust
it to a relative include to prepare for this change.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/helper/test-example-tap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/helper/test-example-tap.c b/t/helper/test-example-tap.c
index 998a1f0b42..50d46669d1 100644
--- a/t/helper/test-example-tap.c
+++ b/t/helper/test-example-tap.c
@@ -1,5 +1,5 @@
 #include "test-tool.h"
-#include "t/unit-tests/test-lib.h"
+#include "../unit-tests/test-lib.h"
 
 /*
  * The purpose of this "unit test" is to verify a few invariants of the unit

-- 
2.55.0.795.g602f6c329a.dirty

