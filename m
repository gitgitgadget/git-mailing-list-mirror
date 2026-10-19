Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A7EC33ADA0
	for <git@vger.kernel.org>; Mon, 19 Oct 2026 02:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792377285; cv=none; b=VkSbzIM7CmaEKvC7kZgToURHB55gErPGgnW1m0lsfKGMbWORcVDtn/YSDE1q8Nh6KpN+tt66pDt0uLAKXYQAdnlGbj94lFnD4H5dfltIgv0tAyvkR8BCOS5dBHX0nVyxH3XUVbryGy3zabTXJfqcNbH6/LA3gFNrwrJw4Mbabkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792377285; c=relaxed/simple;
	bh=QzjRQE2Pqwfb2LBYIsgb+nnfaP/jI/inZVAaW+lKXLA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MAwXy1UKXyo4pEvnteE11dBgdfjf4VU1L+0DPbJ6yByy3cHu/oCjAgPjFk3FHV+blJa/VxVEmrFb0NpAaeG761ObSrJIvksgXSV9GeyTda2wLps07+7f2HWnsHAN5f622Bd7LmgbZM21udHXnDIzETnth4NgngCszWI1+cAzHiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la; spf=pass smtp.mailfrom=lex.la; dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b=Be24QsE3; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lex.la
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b="Be24QsE3"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-48e0d1da913so982845f8f.1
        for <git@vger.kernel.org>; Sun, 18 Oct 2026 19:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lex.la; s=google; t=1792377282; x=1792982082; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QzjRQE2Pqwfb2LBYIsgb+nnfaP/jI/inZVAaW+lKXLA=;
        b=Be24QsE3AC6qb+MmzyOVbyLj01WSbYwI9MaX6gTY8rXLhQnSSQrKONzx7TGH8z1hdt
         PjW9Z/vF9l8qbOXNBKgqef1C8yX3RR8OnR5YV/M60HAMSFxeGfgf1wlVCrmpgM3BvAfG
         VlOYDz4G6DIpcuFYFvxbjGXpWqBlHDap57QT8aTIv2MrtcYLlQoQ6wStA7Av+jnjzPGX
         0z+/TgZq18kUvH0+8joYWurtn+1iwtduY2ETVUtPe4/1918w4vXNmNdGjh6PGM39b8a/
         h8ZzwpCSKk1bgR2FSPG2lYVqAGrn+9S5ObT9ls/rUkJoZ/lUGTZ+oyWuOTsaY9gNHWIa
         t1RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792377282; x=1792982082;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=QzjRQE2Pqwfb2LBYIsgb+nnfaP/jI/inZVAaW+lKXLA=;
        b=DHDwyzcHckHBnERYZ6tGQS7sIt1VwgyjnY0tAk39xF7dflwwWExoler9dpYQXjvBBl
         iLUcCBwtLtOj9zh2cjD66v4kug2t5IbhNXZGLqC/u/hjLKgYACwFgT6SJZBaWu0alX08
         /+Vy+ZLjtwS5+aAvPQp6bc5bYv1c/nnLTHgONULm0suNX/6IdbKq5X84Dv04I8l3mvz/
         S2eQ5M9jkEo3zzgF9QOYLLbVMvh/rj1eUL1rowEXlGnqDlglXebUN6zvsjrXGqztHpA5
         B0UF4m6A7F/mXrOgSjYv0xtTbpluymBOcALS5UsjtLylLMc7bHVY/MReWebT+Tl5NS4O
         T18Q==
X-Gm-Message-State: AFq9FYKoivV31qCIgImv15+HZ4hIOQXbCBQWAnG6wC4/COXVDrDAzwJA
	qzIaPod6v1nT7vVqK7Vh1CqRqCqvroiQYhUwDIExuSfUTxl2FF6FcjrYBlIhU/bc16GjxsvYP9E
	kUKlejZVKMQ==
X-Gm-Gg: AYBFou1TaO0AHOu8gmrdkRZ75HOxUCfo7olbVyv6yMTrClXq+2kOVp/TU5BB13YSlhS
	CnqAIO0hyJMzjNhZUbqcRmAKdRXAnyYtGjezzO086WTsMDBSU9MLXY/GpMy6izqkNQmYbETiL9H
	NqxZpCjZTwgPp3y0on0ARvYNUOdXKO4mLpJeF6nGPFEPc+TIK3KFiYAXDlqYHWygDDdIn8ElJ+r
	fmHglVPrib72xnziKIiG1iXQ/UYr/jI4Zg+lGJf9wKMAUdnlBAQ7kZyl1F8Tvfqg77dPfxFihiq
	LDhsiomsRa/vNqQsGyqjVrs976sNhbz59s9qle/CwI2TSf7x6PIVyXTe0KNFcYvuuglJ8QYOcR+
	XroOV2G3cOgciKc9cNjBznqcBg4ULuTIgr0xtqAsEDbUeJ+/vLIPqbxlyw/udhYTA3XyctU30vm
	hsWmHDuN5sPDnTT8AK8915odwk4ov2dXmvu7E+gIW8F7jSSJsr/NBbX7hHsatUZUR0S1U=
X-Received: by 2002:a05:6000:471e:b0:48e:cd3:64dd with SMTP id ffacd0b85a97d-48e0cd36733mr9278666f8f.2.1792377282057;
        Sun, 18 Oct 2026 19:34:42 -0700 (PDT)
Received: from ownbook ([195.181.160.195])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48dfd4f8bb6sm21273199f8f.34.2026.10.18.19.34.41
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 18 Oct 2026 19:34:41 -0700 (PDT)
From: Aleksei Sviridkin <f@lex.la>
To: git@vger.kernel.org
Cc: Aleksei Sviridkin <f@lex.la>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] pack-objects: prefetch in the order objects are checked
Date: Mon, 19 Oct 2026 05:34:34 +0300
Message-ID: <20261019023434.13210-1-f@lex.la>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20260903125529.67971-1-f@lex.la>
References: <20260903125529.67971-1-f@lex.la>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

No comments on this since September 3, and it is not in any branch. It
still applies to master. The index handed to prefetch_to_pack() is a
position in the sorted array, read as a position in to_pack.objects, so
the batch starts at an unrelated entry and some missing objects are
fetched one at a time. Resend, or is this not wanted?
