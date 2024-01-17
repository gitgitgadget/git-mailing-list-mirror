Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5160C14A83
	for <git@vger.kernel.org>; Wed, 17 Jan 2024 09:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705483152; cv=none; b=EsYQvGIjwEoQQx39dijQAO0xXSKM40FMhRjdWq61wEAtxqTrflw+Xa2SEzBXm5Nr4/IH2dhXn3QezZrOG1+nIcXO+KF1Awzwl1MQoGoLoVz6uqWkfQq/cD8a/1BVPEnIjLQ23/MX7tytJfrpViVGxSOKr1moiy10mViKn46eMAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705483152; c=relaxed/simple;
	bh=AT1BaBraPS+fExmuxVRbTjNdw39uCdKRW9k/DhBbSv4=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:Sender:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding; b=uvJYCNkpFvSuoLaSFHr7pPzjEHiy0j5Z9v5GmuByo37veFcNjETuifttv2HkPSvdjRzWVY2c+YJ+CYeP63DUDTrBymt3u98oRsNuLOd3fdgAxpP8G1CN+57zTug/R7/AjT74zU3uYZJ0M0DL8LebdChXYCHqCnh6LieZnuxyjpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QFhFNTAU; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QFhFNTAU"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a2ac304e526so1059990966b.0
        for <git@vger.kernel.org>; Wed, 17 Jan 2024 01:19:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705483149; x=1706087949; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AT1BaBraPS+fExmuxVRbTjNdw39uCdKRW9k/DhBbSv4=;
        b=QFhFNTAUypzz4mroaTFYjvwMufBl/tYmRxNgIhLgMHnpEF6XRxHon2GwYRNFITh2Ir
         5vhkTD+/TUO4wbj9YodIzCX3xnrV1J119DfpumiP8XNBDJMHk9DMIs6utirbPMDCXhMS
         p4Di42px1fqNoWC0FMV8yZpQzgEatSF2A9/sGi9c7c62POwN1uvsY6z8u6UxhVBsAHCF
         up3tGmoEEwtePgFnPOW1OsHl9Uc8Lgflt2GgVaW/vE4/dXvG9xNaBz7vwzhHSU8Lo3M4
         eYa917fsgTFGWFZVXoB6/VNhKoPR74ovxnakXPw3xFlIrPLiCMVU3xp9q1azoE/wWRHX
         yPbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705483149; x=1706087949;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AT1BaBraPS+fExmuxVRbTjNdw39uCdKRW9k/DhBbSv4=;
        b=AFAY9K/lnULg+5aK21vaaz90l0xUT+3Nha/1EMHcuxBs+FOfcZwgINCsV4BDAQ+Poa
         CC7vGtDQ3nL1lmOU7ZDXYfLvKFL0bsB6+N98pJNSEU1W2Z/TZM1z7WYHzhfDWO/XBJlJ
         6Sit/UegvWpWcPYplSbQ1F5MEp8MQbZRhBdKbEBpAVwLbpRH/1XWLPMBMY4Ga7YISrrf
         4a8DJddh9aNuJCAWCc8oX5yhP99tEUkfp3RFfChgZdZmjDiwHCWeqmY3lyvPoyddcjYf
         Z1WpRdcMSm5YISv5ie+U7HIzLHm9kGfI6MqIR/whdhEUBtcgP//LfJAWmFsma0ex2y5L
         G82A==
X-Gm-Message-State: AOJu0YzfCLNFBZejRzoXQACqKMcTYaUnInN28v6FpmBaUeoVZR6A7F78
	EkZqXSLvy/OcCR2DH2mnFUE=
X-Google-Smtp-Source: AGHT+IHD+EuHJNKjLUxZCQp1ToXlkjoZRAneg8PJWrpRWmqEt7VebWKyydmg9klKuQTcrgFLOLWzpg==
X-Received: by 2002:a17:906:ff53:b0:a2c:7293:af58 with SMTP id zo19-20020a170906ff5300b00a2c7293af58mr4128032ejb.79.1705483149142;
        Wed, 17 Jan 2024 01:19:09 -0800 (PST)
Received: from Michaels-MBP.fritz.box (2001-4dd4-dfc5-0-e407-3f73-62bc-9c57.ipv6dyn.netcologne.de. [2001:4dd4:dfc5:0:e407:3f73:62bc:9c57])
        by smtp.gmail.com with ESMTPSA id h20-20020a170906261400b00a28d438a1b0sm7504400ejc.83.2024.01.17.01.19.08
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 17 Jan 2024 01:19:08 -0800 (PST)
Sender: Michael L <mial.lohmann@gmail.com>
From: Michael Lohmann <mi.al.lohmann@gmail.com>
To: mi.al.lohmann@gmail.com
Cc: git@vger.kernel.org,
	gitster@pobox.com,
	j6t@kdbg.org,
	newren@gmail.com,
	phillip.wood123@gmail.com
Subject: Full disclosure
Date: Wed, 17 Jan 2024 10:19:05 +0100
Message-Id: <20240117091905.14354-1-mi.al.lohmann@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
In-Reply-To: <20240117081405.14012-2-mi.al.lohmann@gmail.com>
References: <20240117081405.14012-2-mi.al.lohmann@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Just as a disclosure: I was told that my contributions are not welcome [1]
(even though I have to say that I don't fully agree with the reasoning), but I
did not want to leave these patches alone.

@Junio C Hamano: Please take this into account when deciding if you want to
accept the patches. This is just for transparancy and I will not do any more
contributions than potentially finishing this one. If you do not want these
patches from me, but it was still deemed to be an interesting feature: could
someone else take over?

Michael

[1]: https://lore.kernel.org/git/xmqqil3ybets.fsf@gitster.g/
