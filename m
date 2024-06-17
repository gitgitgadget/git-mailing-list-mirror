Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D857191481
	for <git@vger.kernel.org>; Mon, 17 Jun 2024 09:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718615853; cv=none; b=Ne4ESZQ9w93TTsYzaekjfMW3aOQs8mKbSpugf4mwAAVFCUfBcvEy6vXpgIrn6T0gKmBUSLy3thz2gIq2pO7+V1JIt3wnkbZQ6GcpCO468BxR9/l3APz3Dl44YXrKpSyLjA/SOPcCtk3SotXnHo5O1eypvYZxq7kTwpkeFQcFjnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718615853; c=relaxed/simple;
	bh=f3WVgmLw9pzB/TG4U9czLiz9qr7JGpG2rhbFV7wI2oo=;
	h=Date:From:To:Cc:Subject:References:Mime-Version:Message-ID:
	 Content-Type; b=mfOOLFW93kS3ja0cN68wzXs0AGc+UFsK8ejpnHqo55tY1TgVpZhwcahKx2xmYsWnITxKhDXTPNhioMp4KVEoV8wNF3NDXEJtI9Y8xsiGhx2N7nOpHKrahfcJH5vgKctjsuQ230bTx0fwRmxUqmC4qe1+Ny3+hQz3rMoW9hxS2As=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b61B3WC+; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b61B3WC+"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2c2d25b5432so3217007a91.2
        for <git@vger.kernel.org>; Mon, 17 Jun 2024 02:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718615852; x=1719220652; darn=vger.kernel.org;
        h=content-transfer-encoding:message-id:mime-version:references
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=f3WVgmLw9pzB/TG4U9czLiz9qr7JGpG2rhbFV7wI2oo=;
        b=b61B3WC+mKcYzT49ILDXFrdjdS3x4iOPksGJ2xWADAJx1G8oAxvc4eF+PAvGgxWx1O
         M/R+5paviiob+aQOqkuF+tFS4vh6abAl2OajgpQJca1BPG/2BbexT2vLDoObuMfcQAl+
         2ZGi+pN86s4YO4fLELwgVzxhO0tFHutO3aa+st6CoAYZVqTwJRc1c8TTi4YTumCdB74l
         NnGBcfg5RP2aNKRyJIdJLx9jV0Pf2yfzrBgn85c73YmZbsNzMsjcW+R0bUAYx2YxtkYy
         TLLXlj9BDg5MCt5A/J0XEblKwIpV/UZtD1fRXPEqKE7LN2bA50IELnoS0mm7pl1RzB/S
         hjsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718615852; x=1719220652;
        h=content-transfer-encoding:message-id:mime-version:references
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f3WVgmLw9pzB/TG4U9czLiz9qr7JGpG2rhbFV7wI2oo=;
        b=X7rdsL116/dbtx6gA2ILJfkR3Qwhw7hbTsjpa7rmFhiRtqCO7DwHkp19My0xNs1M7G
         1F3MclFmn9i33xFx3s/fL6fm361yPcsSYYYlVjI77DZRSPZKISff3VqbWZIpvFePcPpR
         sbSvbrs4oOv/iImXnST38p2XMCpR45rnTiRjyFY/rwE+q/MiZKOFmlR7Xi6NSFBMGCPQ
         3iUhh8kAlPgH/woB1/qDckJKM7T0uVkSoUz7wZNkWGHb19ZDHrir2Sk4T6S443cbpA6q
         LOVDwdd2o0R0oBlPHFXHpd/31v9pOoAPNE1j39sCLPfrLiWAs5wS9TgzChadOy7sWfwn
         e05w==
X-Gm-Message-State: AOJu0Yx2s2scIC+VyemBTNeH96tNXpr68EV8gJB1sbdrBuQWTJQDUQZu
	j70eXQJiuCxRMYEk/uyoZIA1bIUk/wu0UDwK7YQxZnYv1TrYDQ3h
X-Google-Smtp-Source: AGHT+IHTh+DvqWDfQeNuwakGIM0UJ5H0HNHXXDwiRNBhdFP8f2yd1jcxl0ZcvWkMnLq1HZvW653kcA==
X-Received: by 2002:a17:90a:d710:b0:2c2:dd0b:3d78 with SMTP id 98e67ed59e1d1-2c4db242536mr146022a91.18.1718615851551;
        Mon, 17 Jun 2024 02:17:31 -0700 (PDT)
Received: from kylezhao-PC1 ([43.132.141.21])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c4a7504541sm10863232a91.0.2024.06.17.02.17.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Jun 2024 02:17:31 -0700 (PDT)
Date: Mon, 17 Jun 2024 17:17:29 +0800
From: "goldofzky@gmail.com" <goldofzky@gmail.com>
To: gitster <gitster@pobox.com>, 
	gitgitgadget <gitgitgadget@gmail.com>
Cc: git <git@vger.kernel.org>, 
	"Kyle Zhao" <kylezhao@tencent.com>
Subject: Re: Re: [Internet]Re: [PATCH v5] merge: avoid write merge state when unable to write index
References: <pull.1731.v4.git.1715920862420.gitgitgadget@gmail.com>, 
	<pull.1731.v5.git.1718173639942.gitgitgadget@gmail.com>, 
	<xmqqh6dwlpnb.fsf@gitster.g>, 
	<202406171101133354904@gmail.com>
X-Priority: 3
X-GUID: 40465239-7A6F-4172-8B46-F0DA808CDDBB
X-Has-Attach: no
X-Mailer: Foxmail 7.2.25.254[cn]
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Message-ID: <202406171717292856283@gmail.com>
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: base64

PiBbMl0gRnJvbSBhIHVzYWJpbGl0eSBwZXJzcGVjdGl2ZSwgdGhlIG1lcmdlIHN0YXRlIHNob3Vs
ZCBub3QgYmUgd3JpdHRlbiB3aGVuIHRoZSBpbmRleCBpcyBiZWluZwo+IHdyaXR0ZW4gKG1lcmdl
IGNvbmZsaWN0cyBhcmUgbm90IGNvbnNpZGVyZWQgZmFpbHVyZXMpLiBUbyBhdm9pZCBsb3Npbmcg
Y2hhbmdlcyBpbiB0aGUgc291cmNlIGJyYW5jaCwKCiJ0aGUgbWVyZ2Ugc3RhdGUgc2hvdWxkIG5v
dCBiZSB3cml0dGVuIHdoZW4gdGhlIGluZGV4IGlzIGJlaW5nIHdyaXR0ZW4iIHNob3VsZCBiZToK
dGhlIG1lcmdlIHN0YXRlIHNob3VsZCBub3QgYmUgd3JpdHRlbiBpZiB0aGUgaW5kZXggd3JpdGUg
ZmFpbHMuCgoKCj4gdXNlcnMgY2FuIG9ubHkgZXhlY3V0ZSAnZ2l0IG1lcmdlIC0tYWJvcnQnIGFu
ZCB0cnkgJ2dpdCBtZXJnZScgYWdhaW4uIEhvd2V2ZXIsIGlmIHRoZSBtZXJnZSBzdGF0ZSBpcwo+
IG5vdCB3cml0dGVuIGluIHRoZSBmaXJzdCBwbGFjZSwgdGhlIHVzZXIgb25seSBuZWVkcyB0byBy
ZXRyeSAnZ2l0IG1lcmdlJy4KCgo+SW4gb3RoZXIgd29yZHMsIHdyaXRpbmcgdGhlIG1lcmdlIHN0
YXRlIGFmdGVyIHRoZSBpbmRleCB3cml0ZSBmYWlscyBpcyBtZWFuaW5nbGVzcyBhbmQgY291bGQK
PnBvdGVudGlhbGx5IGNhdXNlIEdpdCB0byBsb3NlIGNoYW5nZXMuCgoK

