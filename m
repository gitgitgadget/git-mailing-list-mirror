Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80E956CDA8
	for <git@vger.kernel.org>; Fri,  1 Mar 2024 11:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709292999; cv=none; b=BFexaHHumo4A4kqPEaRD03olliha5+dGUBVyiW83oo2LK3/iOdyeLBkulM5qJX5hIq6RlH6P/Cbk2/2fMlDh08yTAxDxpDF/uYjMjRvubbUs0TK+Hnejtg9pWL4SFVGMZOuzDR1jxxeNY/r0x7WPdN4V6rbhL6A2VqyuRNrgPqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709292999; c=relaxed/simple;
	bh=fgUdbvg9bANA6NCh/JrYm8nL44L6l/HDlcqm9kLCnnM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fdxUQCM81RskXM/NBEs1/yXdXyk5RULMyEFl8bJKooAyoW39KImUcQe0/GWkeDLsVvbHarrbwwMfiMEcvGHe48WN/BV6xwsrCV4oLqbIY2qmbm4w4cfRtrXwUJLzdV5Kj2fRESAu3cq98t7nQW9ZEyM+IHYmjyruh/2hfS70sAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hlP7ToWH; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hlP7ToWH"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1dcab44747bso18049695ad.1
        for <git@vger.kernel.org>; Fri, 01 Mar 2024 03:36:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709292998; x=1709897798; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fgUdbvg9bANA6NCh/JrYm8nL44L6l/HDlcqm9kLCnnM=;
        b=hlP7ToWH7NssJZPz2tI0y9lF3gOD736wB+MiNVPQplmXsWk0oM37vAygSrayBfFWoq
         t7Lpmsk4mUsCEiFuwAOT1REJsuPE1F/c3izECRo6/VyspCG+vFTqpLdfS/MAE7Nfeuxw
         7VOql3qvhsGHASA6H2a+CuuvPoqqWlNLQYMV/q8gxQc/8Ya4czB0mhQnBkA5uji08IVT
         9NM4on53+62VEfVqGcgcXDrIma1tYiT5a5CMG/9X9byHq1sqZXqnDv0BopYhsd6GQhIr
         Po30FDUvE6GhuDhhAbzYYSuxkzdLxoCnxNNrWc/xreeiq+4cEa4C2lt1p9oQnYZhNSHh
         VzAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709292998; x=1709897798;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fgUdbvg9bANA6NCh/JrYm8nL44L6l/HDlcqm9kLCnnM=;
        b=BtOpT7puO49SchOsrOlHWh4H+Ji6cddBYDCrRRT3rafkMzY35RO8qXK8cmTyxMsxV7
         CfUSC4yas3cAx5fZb60IOjUaPeF16V9ihbBSavy4JwUIZINb9fef3clvAXiC4KeQJzmB
         OSLy+vwPu8y5ctBl4ItsdDTszwh1x6zP1CQcirelmqwS3MNd+ndqP+LS7fbGxafBttwr
         wfU0k7bzLoBAmhnBTtcltUwD4uaRipoWIoPq9yXRHmLjVrn3bZnQzbkqdA/I0e+WA6xY
         nW4gIZfyYXP/prAVX2mH/FJr/sIf+2lxuEVQJ7c6Rw5Vwddh+TK5qZxQOLKTBQDnwQX1
         or5A==
X-Gm-Message-State: AOJu0YyE5dWMJT7hC96nYXcWwiUXUdcnWrR8+yYTfQ5VvqVHKoCqWB03
	Z2m9EKOpss9Mb9QmFTwT3TFrKP2X1t5ogvM7xY4MeViRcRhw6yGHgo/YS5WdImkPdA==
X-Google-Smtp-Source: AGHT+IGmm4DhB2B2Wgn4AzZYu87PLRizlLbRHwJmNcJqGSmYX7kIxOuX3ZfPEy1pF6kczTgwu3bsTw==
X-Received: by 2002:a17:902:c105:b0:1d7:88de:cff1 with SMTP id 5-20020a170902c10500b001d788decff1mr1175009pli.53.1709292997608;
        Fri, 01 Mar 2024 03:36:37 -0800 (PST)
Received: from ArchLinux.localdomain ([2604:5040:11:69e::e973])
        by smtp.gmail.com with ESMTPSA id q19-20020a170902e31300b001dc23e877c0sm3208033plc.255.2024.03.01.03.36.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 03:36:37 -0800 (PST)
From: shejialuo <shejialuo@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 1/1] t9117: prefer test_path_* helper functions
Date: Fri,  1 Mar 2024 19:36:31 +0800
Message-ID: <20240301113631.122477-1-shejialuo@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <xmqqwmqm8rmr.fsf@gitster.g>
References: <xmqqwmqm8rmr.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Thanks for your wonderful comments. I have known that semantics is
important not only the functionality. I will send a new patch at now.
