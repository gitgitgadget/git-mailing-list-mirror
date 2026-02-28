Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23907426D18
	for <git@vger.kernel.org>; Sat, 28 Feb 2026 10:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772275647; cv=none; b=ezT7VpabgRnuEfomTDKqQxz+EolS41vL2H53GlfFzcSCrnd71Eg9rHfKSv8gr+VvUakpXCXAo/Kxmo2QDyA1ruZ5FgTpVR64ZwvuxcvG2ujFoNiLTQINLKcCVI9SnMKkm2hl5AoUmOweKaY/wnJeF/l7+9PX7JN0zX/fVq0Y5+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772275647; c=relaxed/simple;
	bh=/5mcaSQmR1h5EDwmd+yUhzFOguwnLvcEh6JlkCGUBPw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XyW8R+BTGVMoG164HT7p18gYFvX1pJIUjl4e9sVOyjP8kPzjUUpwojBqDXoEtPye6dEnTqy/sPwNvC8lb1kQQ0hqRXHJ+Y02L/L/ko5Wf7yjP5Ib7u0OGVtlqbQJiVM9f33Cfd41/LM+zeYHwBVU5p0ZirE8zIlv0PDfaFsWymg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c2jJucZG; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c2jJucZG"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-48375f10628so18984035e9.1
        for <git@vger.kernel.org>; Sat, 28 Feb 2026 02:47:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772275644; x=1772880444; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gl2A8C+N/bRCVys6VqvtaPAWLnAAC+xwiNUJwlojmHk=;
        b=c2jJucZG++ttvHG4Sm613o1a0yvHL/HB1Juf/Dsq8NsJAUE5b+KIgRZ6rhVxmSH5Cg
         wnsCTwB7+oms3FH7AaMouiYbmoMZMARzmYPnNjI0Tjy7TE0e+wtRsBkIo9QaCEQbbjzp
         V4PUn67ZYkMQQ+5kB1L4Xq+bWHdgU5LkiCQAAs2WkTgi4wucJxEXw4Xr/koZlRfTXn6C
         Tv4A3eX0dA49Yg+PAZIk3STY3Q3LI+1GKkTcxYwA6cgh5rfmvk12PwZb73GD8mOw1sp7
         /3UKj8qo9jnmAEMzXAi26MRbTx3qMohdBOeBCLUNrMnmG1oKjGazX5i2b9qK9f6HGqbk
         p/Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772275644; x=1772880444;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Gl2A8C+N/bRCVys6VqvtaPAWLnAAC+xwiNUJwlojmHk=;
        b=sTM23WIsl+QkaoWb9/xvfCH2J1Dy2NiKuWRPp0C2VoG1RzjOO5EK4ho86Qk+M57w7x
         WkanBcuS1VnDcAmdQTZYv6QWCAQOUuKteR4dqKY3nNzzurWuuTxVBuPBlZodoPPVwal3
         csZO1v8RNzcGt3eAl/pfLzOqNCR7SkUt/jTVCIQzC3i7mhfvT1lT4zuitJTBC7eQvmlY
         /liS2F3F5216uPo0BT2nMKg+oF9l+epSadQwoUx2bBM2y88470cQmP7WqkGFyaCUzMvv
         Vh8CUGiEvK2rl+Ia/9gENry34g+JEpUG41fi97YShod/ZH2GPJNhCuRwH7YYBpuY4Kre
         KjAQ==
X-Gm-Message-State: AOJu0YylwCtTG6zZLzv8Tea5ThbpYokcfR+XGkRmJidZPGRFqn2EI8hx
	usyvvaxpNOB6gFJmkPUGeqZ2Q5VscHSxEuVVypnHx8LJdF3SEJ+izusxgtchLA==
X-Gm-Gg: ATEYQzxMtQ8lNAuzZ12NCAq7LpuaL9ES47+NI6Fk067Xm6f1C9hL0bDA5pFa9c1PVPc
	xb9Vhgbe9VpVo638s1CBZr2XU+kUKKOEdzo0U/MX/gxDhg+OCLFfIuWQwMgnbiKJLbgzZQ6ij7p
	9vZp7Zfru3Iq7/OKiy9UhRsAH/WYRedigjI8NsqkucWL5zcaQ7YMDN7pCbtnh3IXgnshtZz2YGH
	RtGXqjN7Mjvz6PNPmvomO4cIRmMnAm4T12N5mIto9P7i5+AgWJJoWnV62Pr1zkglSUaYOq4DgLu
	zT/Ypdmxj65ThtY0OxxzdfMaZpkRq5Rp/QVd3k0+jqWLMw6/Lopk2OMeVSeUHt5lbdpZVAFRjp+
	122C0mFMtJcAY+3C10IpH7R2m8bw8ZzbZXsvHJXVfu1N/zakutBDbkAq6OW2ieSz1tYTN0YWEpC
	4Q2EI6AfeOY4Z9Vos4nJgrbN19VF3qAk8SzeHW6MJpwPfsfi7auLKy8gK6VJx9PIZ5Ujf18kfg/
	tKo4vg=
X-Received: by 2002:a05:600c:4fc8:b0:483:6f37:1b51 with SMTP id 5b1f17b1804b1-483c9bedb07mr108407935e9.23.1772275643940;
        Sat, 28 Feb 2026 02:47:23 -0800 (PST)
Received: from localhost.localdomain ([115.98.235.89])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483c3b84139sm179357795e9.14.2026.02.28.02.47.19
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 28 Feb 2026 02:47:23 -0800 (PST)
From: Amisha Chhajed <amishhhaaaa@gmail.com>
To: git@vger.kernel.org
Cc: avarab@gmail.com,
	gitster@pobox.com,
	peff@peff.net,
	stolee@gmail.com,
	Amisha Chhajed <amishhhaaaa@gmail.com>
Subject: [PATCH v4 0/1] Make keys_uniq stop depending on sort of keys_uniq
Date: Sat, 28 Feb 2026 16:16:53 +0530
Message-ID: <20260228104654.80831-1-amishhhaaaa@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260212041017.91370-1-amishhhaaaa@gmail.com>
References: <20260212041017.91370-1-amishhhaaaa@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While its problematic for keys_uniq to depend on sort operation on keys,
reproduction of the issue as a test is complex, when we add something to the
documentation we will need to re-build git so the array(config-list.h)
is also rebuilt with our new test case so the functions which fail on the test
can catch it during runtime.

The details for the test are as follows:
the case[0] and steps to reproduce[1].
[0] https://lore.kernel.org/git/CAPvEtrfEZXHxcDf=z60ODfUA8cS81rhF1y7KEZApEBby7aCa1A@mail.gmail.com/
[1] https://lore.kernel.org/git/20260212041017.91370-1-amishhhaaaa@gmail.com/T/#m64880c5cd0d36e35bc78692757cf206b13496aea

Community help is appreciated as i tried various ways to reproduce the issue
in a test, including cat to config-list.h, cat to documentation config,
applied patch
https://lore.kernel.org/git/9cdcc9de04f0f8fff657f0474b31c063466ed808.1771280837.git.ben.knoble+github@gmail.com/T/#me826da3b6a128e1ceb7215d64328b7d6aa2b211e
as well, but unfortunately, I couldn't get the test in config-list during
test runtime as that array is baked into the binary and needs rebuild to show.

Thanks.

Amisha Chhajed (1):
  help: cleanup the contruction of keys_uniq

 builtin/help.c  | 84 ++++++++++++++++++++++++++++++-------------------
 t/t0012-help.sh | 26 +++++++--------
 2 files changed, 65 insertions(+), 45 deletions(-)

-- 
2.52.0

