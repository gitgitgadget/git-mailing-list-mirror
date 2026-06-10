Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 539B834AB14
	for <git@vger.kernel.org>; Wed, 10 Jun 2026 21:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781127551; cv=none; b=ULPSH8V2sU5a+jO6wbr85IHcz/uB+e926UESrg9mX67ZIRkBDn74RtH2zkKygKP+OTG0Owbe40l0l79am/yXfvaPhSpv47ZQ/DZbqPv45a6YRayas9I6+dO1dVNq8VEVrQ6doapMt7hidn4snz7eAQXhu2M5wnwyi3JLNdHi0Y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781127551; c=relaxed/simple;
	bh=Lrk0kkdPFZsfdo9z/N8hvTRxRDj7o32Tp78poE/Dp2Q=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pDauhVKevcvQIzZhtqfuk8iGwC/UGc8WZklR450OeAXIjEzKt4PJrogJcEqGHtjGh4mnn9PGkblJ6jlTSs/7h8/IfKf8TU184UdE02QhFjMXMBzQ7GjFYGDD98Vwo5bCA01gpeDhKeuEuJtfEwWl9eWCeEXRvlPEVCK7h5XujlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=gpykmLei; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=U+cFTx7j; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="gpykmLei";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="U+cFTx7j"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 97831EC0104;
	Wed, 10 Jun 2026 17:39:09 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Wed, 10 Jun 2026 17:39:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm3;
	 t=1781127549; x=1781213949; bh=RFephfJems4UAYk0rLWKEonCiPqd9Qth
	XzfV71nBxDk=; b=gpykmLeiy5oXF9SlUlYO0oaIcW3qDjEux7VuZ0SHvbk2B+GK
	FE7F24Pi+ylEV+4TN1rgiQKljoa+HDlpeSxxvPAy8oK3/yp5QkOzuaVfePqf8If9
	iS5zQ+/Ua5FYziBjNadEei2Sy0bKG1rupk+Z/jk4WaqkPHvCbQb1GM302eterURo
	B3oz0wfZqLjhktrXK9ZKYNBZWmYxSl0RQCblaw5TSI1+65LqNXiYlfExR94mnWqr
	ldxa40LG+fDI9UcBnxBjSkQwDjAomJ7ucXVyZh5ESuOhRKT5ZpZgpQyKLRxmoP7l
	kHXICuEDWNCWFyD7+Eov8YEDlr11JqqY+KIxuA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781127549; x=
	1781213949; bh=RFephfJems4UAYk0rLWKEonCiPqd9QthXzfV71nBxDk=; b=U
	+cFTx7jf/9D7wxGJFxIKV5Ug4i15zzoy5YCzCbSudJ4yTLrm8UkDJylg40HECQjm
	rOOYO2EQewRoLGDzoZpaszmq4Kaf6mHBqmb3W5U3jh+cVxP1FRd1FRybrwkEfrjm
	fWqqrnYXJqXVYQZ9JGdSM5fFJuvoE+cVC8Y5DUKh884117ljzY/iKZd9Elkfivxz
	MY+UcGPBnqzWE7WhpbHutCTHwGMRIa9jvpQ/+KpDSflPgz7X/c21vOG6M848jD65
	AiY5YRyIwkirIJWBpCcB08TWqqtxivWCgHAE8pWc9essElAzWtnwLM+yiDsVqfhs
	zf5LdMDpqOURKfGbicZVQ==
X-ME-Sender: <xms:fdkpaoVbQ_sZzZroGSco1yyjnU9PV8cB343TUVua2RceI9X9z_ijTA>
    <xme:fdkpaikVFw3rdwYFJhefPN0X2g5lJC-zp0T1-EiDtF-jUqnww-N4C7FLuUK3uBeZE
    3NyIZNxxQw3pTjBejdF3Wvo4GH-bIqXj6FN3uj8TTVw876L20PbQw>
X-ME-Received: <xmr:fdkpaqDO65O-f-BABBPGrtKM38I2oRhxSqxNNiuaA7KJCXq6oxu9PoueJt9ElF5Xy680rhqtqJ5mHrQCcAonHGJcP2p6h6mH7gaa>
X-ME-Proxy-Cause: dmFkZTG27V5c/DZv402pro73Py42mvyd3mtCC5ok73boIvUWFXwEUUm/Fjeo/C5iA13Ueg
    XTL+nF5/r5K7fhNa69y02sHKL4o3dE+4CP/GU7yEH93CAqMumYdH4UVlXC1ODLandpJnmy
    /5TOXgA/oNCtiLamOlFn6RI4Lio8+H/tXc8cHYZag1eSb+rywSGoan8wRHy/4Lyf8ifi8l
    gMl8PZZzySVNZokrSeR9WrcJEmlV4rnXniU+8D76C4Hf+e6LVZMPHzypQwkngmUqeCzred
    9AelbVt3xRIRwm1YgMVH/PqFTIQq/5QTK6/aQwiBKiPjDvWqP9P4hYYIqi5ATZcUhpvfVW
    uPwe+DU7hk8h1wPrICaTK9BgvlsbrMir9W5CZQFmFIRJfL7oLdF6fIUgr1RPCQ6G23AGaf
    u8Uh6xby3fRHZKRSnv/1vK5E9iD5pffSxleAI32855nPIeaeaGTG1gYakOE0ZczdCwUkxA
    1i3eNCdO8NLtRfZZz88vcv319QNjl9Jq6uvvO9gTTethCyISRwBqXfj3WDbM5tkyOMbgtX
    Bx33kG2BCJbVBAzbIMil8d2DQ9pZbGX7GZbzdEMRaREKMRZD+3LHEAxu6+feTYl7ck+5y5
    aNUZMNK30EWGabvLMUa8auE+a8W4LeIXSXvUpBHwhVDSRRAB/KCIM83nUq0w
X-ME-Proxy: <xmx:fdkpaicDZTpRyoUAKwlkWPdMrZx_TwUBR0S428XZk-BUAqXugkCIdg>
    <xmx:fdkpalLfkUHmwTpaQj0JaS3WIg-ylaiJMeyT2wkY5PvJ24r08ktytA>
    <xmx:fdkpalet75LUm_d5tqYRT6EVjaDbifu5UBud2oRp1s00efOPSeWgVA>
    <xmx:fdkpas2qkf_4rfuumRCcTUM3cG3HXuYIrs3UNd25yiVbWMUTauhW6g>
    <xmx:fdkpajuQjTKwradHTNcIYqOPurdiC5KILbLSUNTUrtL_kGgqP6zZZLdk>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Jun 2026 17:39:09 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH] t1400: have fifo test clean after itself
Date: Wed, 10 Jun 2026 14:39:08 -0700
Message-ID: <xmqqo6hit6rn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

One test in this script creates a pair of FIFOs, "in" and "out",
that are named so generically that later tests may be tempted to use
them.  By the time those later tests run a command with its output
redirected to the file (e.g., "git foobar >out"), however, nobody is
reading from the lingering FIFO, and the test gets blocked forever.

Clean them up when the test finishes.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t1400-update-ref.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
index db7f5444da..477af544bc 100755
--- a/t/t1400-update-ref.sh
+++ b/t/t1400-update-ref.sh
@@ -1610,6 +1610,7 @@ test_expect_success 'transaction cannot restart ongoing transaction' '
 '
 
 test_expect_success PIPE 'transaction flushes status updates' '
+	test_when_finished "rm -f in out" &&
 	mkfifo in out &&
 	(git update-ref --stdin <in >out &) &&
 
-- 
2.54.0-615-g639a4a7340

