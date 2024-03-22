Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E45095FB81
	for <git@vger.kernel.org>; Fri, 22 Mar 2024 17:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711127714; cv=none; b=cP/+Aux3j5c6b38NdYjyqamqCTNrM6PI9mW5f/m3u8Uqqk99a2TREDE4c/cx2KxLuFCQVOTxZhZEQ4XgXqfIPSud1wO4uydxvqnpGxEfIje8D9Rv/g/5B7mOOc43s1j1FlOpdP5gRGOtOPwQM1ekkAAlMexxol240kt0Nk6y9Yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711127714; c=relaxed/simple;
	bh=r5cog2SYxhNlTR67nRFuSHQ9BdIXeP7WzwpLOd1uvN8=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:Cc:
	 In-Reply-To:Content-Type; b=SVFcqQatLexZOOCYj1tNsw9af6GrSjunJN6tOWPW2ZfO4lYH6hnIcmZgQXjh8Jgg3jyIvt8Y8qvJ7mrDECN/5bH3G9k3onmF7G4Uiyk2VfaPCzCt50hV36Fke7G6xWngZGxKcUVv0aEmC4Ek/QcUqDEbnq6k8GfLBJ44mR5xRhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f9meraZ9; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f9meraZ9"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2d68cf90ec4so40087991fa.1
        for <git@vger.kernel.org>; Fri, 22 Mar 2024 10:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711127711; x=1711732511; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:cc:content-language
         :references:to:from:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=r5cog2SYxhNlTR67nRFuSHQ9BdIXeP7WzwpLOd1uvN8=;
        b=f9meraZ95eCHSXNbWgb66q3f6Dr3Lf6x2zjieUSoSfYQ/uCJrGkH95IGO2BE2SeqLI
         UHljgqb9kKVlaVxybKriUwMp1B87LqZRRx1ceIcJFI5FLwS6gcIwnie92yNowunR9X/a
         CxX8C7PoV6jigRoWLZTf/QW3dTvHseTJk2AqH2jMaJuzh6aiSp2s3JV7XUBPWfcHWjA2
         FbD34TdoNKsGBUICBUwbEy2ZhCzH4HdChm9jlq1HgT7G+vkWfYWtwfKNOe9KdOYyPiJm
         2xnRKkWf/oe4yXcUi7yR7wwJ53UWlGEaM/TxbO6jWN1Z1rHvRmkaACUvWKDX4LsJfGnt
         9Mdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711127711; x=1711732511;
        h=content-transfer-encoding:in-reply-to:cc:content-language
         :references:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r5cog2SYxhNlTR67nRFuSHQ9BdIXeP7WzwpLOd1uvN8=;
        b=jXprUKtlaTVUr4cGeeq1kRdNzr3BrhiiRIUH8SZByIrKK9ERKLpMnBsO8Yb6sAwSGs
         8WnSbVgz1gQbhYU3FK39pgCJKAqvhAmLznwIMrLSn3ynzbFUkaMeorgs1csXZqmjJkF7
         DPMVoFQpYlg01pprO/ryy8aCv+9KiEPcE/KZMIrTlwhM3OepBYiY7UakPCrKhz5ACSwx
         c8ZKXSlyoDAp7NgM3oUw+JDus6WGkc8YP3JLwGpHWca9Fe4HjSHRlI1b5vt/FoBsHBdl
         glDdkqYtjbXFTPTREoaN02sbOLzXxXIYw4N/kWLHqshaGTLv284fh6GWT71WVM6o3nYE
         a4dQ==
X-Gm-Message-State: AOJu0YxC6zIkJcBLFETAZ2PPN2bw1TyBPwuaw44ybJ5C+zn1ZrztAwwT
	vVsoFX3YnMD3T0BpqMi7wXwppyy47FQQvo7kW3DAbOwiw54Sg9o4
X-Google-Smtp-Source: AGHT+IFCTxD2hU5zktQeGFAvo5pet3pBysUz2/YNr+10KlBUNJ5KmlC/bych42UoVTsZInwJBHCG9w==
X-Received: by 2002:a2e:a609:0:b0:2d6:bad0:88a8 with SMTP id v9-20020a2ea609000000b002d6bad088a8mr93637ljp.6.1711127710746;
        Fri, 22 Mar 2024 10:15:10 -0700 (PDT)
Received: from gmail.com (181.red-88-14-47.dynamicip.rima-tde.net. [88.14.47.181])
        by smtp.gmail.com with ESMTPSA id he11-20020a05600c540b00b0041465c859d0sm64114wmb.39.2024.03.22.10.15.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Mar 2024 10:15:10 -0700 (PDT)
Message-ID: <cd50671c-d3a1-4e72-89ae-e66567ee14ca@gmail.com>
Date: Fri, 22 Mar 2024 18:15:09 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Worktree shares a common remote with main checkout
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
To: Bill Wallace <wayfarer3130@gmail.com>
References: <CA+2m0i8E5Qnj520LXitoE49U_8V17v_NUnrqcRfzHz0cA_ONSQ@mail.gmail.com>
 <0ad0371c-c6ac-4ccb-b9a8-b30715f74308@gmail.com>
Content-Language: en-US
Cc: git@vger.kernel.org
In-Reply-To: <0ad0371c-c6ac-4ccb-b9a8-b30715f74308@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Fri, Mar 22, 2024 at 06:00:43PM +0100, Rubén Justo wrote:

> describe them, perhaps with sketches, it would be a great help.

Of course, a series would be much better received ;-)
