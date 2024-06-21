Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 492D212F365
	for <git@vger.kernel.org>; Fri, 21 Jun 2024 06:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718950198; cv=none; b=c0JKiB1eNp41a5J7pkuiSlBcSpgEvsmvh3JKB6tpuVwQfh/MUG4NC/4EkOJ2cbuCaKK7424MEzeIIeQQje1O8n1S5uLE9qzm34oZtluUma5rSArOpaf0ix2vBWAiHBIl9cA5ZGrMD9hbrL0WDBjMaF+mwC+o2QoHLhIu357wFR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718950198; c=relaxed/simple;
	bh=Jdb2o8QDYAh1g8pagw5Gpc3RqOYWqmsD9QJNIdNfXAg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TsSrIPOqk53nHvcLvYRmMk38nRd3LVKWRVlBGOz9yezRn02SqL9xRXF6hNb0VFigWaLUtXGONlKHrfWoB2FGQ7972P3JvPyAmbIWK1rGlkZC6EhQWsaYoqjXbSHimevrRsgyH7R/SWyBzcvn3pEEhLzPchtxkT2pfx4COmZxpGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XlBKikGY; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XlBKikGY"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a6e43dad8ecso277333466b.1
        for <git@vger.kernel.org>; Thu, 20 Jun 2024 23:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718950195; x=1719554995; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Jdb2o8QDYAh1g8pagw5Gpc3RqOYWqmsD9QJNIdNfXAg=;
        b=XlBKikGYTmLD+aqfLRYqdB4OnTFWmmzPtcsd9lshY79WFLGhvNOBESjEKshPgA/RXo
         /O2oKTuvqEvuroY2GXWmZcRIZVbGHWkpFDNel2nqVdPFp8omCpE51VpFJF8J2XIcmYMy
         NfvA9w+2DHMtxky6upcyryikVe/USCsOzNu2Zci6AbuEcWvwW2MEIuf1pnOmwgI+/BKg
         TlCFDPpwNbcOoK1CajLbm36tJaSJ3oBDjtt3enNQVKahq6RDDpjtpJDgDTPA3rB8gb4f
         f1MV/FD44USXuefy4lIQkSj+JSYtZwc3Slnl/Fep8zngTktvBbBXlqq2XZZNw+1LGjrS
         yrTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718950195; x=1719554995;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Jdb2o8QDYAh1g8pagw5Gpc3RqOYWqmsD9QJNIdNfXAg=;
        b=BhRhIaX1QlhRDniTLg1ZYFYqraAsV5iOghhBgXbRLW4JGGZIbimjcaBeEk5kJPNhTQ
         Q52PHsGS4YS/9KuGF+sHIGFCRtMjPvcc9P/yRl7ovyJrauAlj+Kot8kzzcbzWd+AerRU
         peXTO0q224vzas1ngFAFKxCb6kdw6rD4v8Mzfmw5bDx3oaE959C/siG1XmPzbNiO6rUl
         fCEQdQFT/wK0aWvew6RZNUrhl+HujK01CLbGW7i4AzbL4eTH+9kDjVLMxFiokVjNq6bP
         SnLJUYQM8EQAA1+5uR779dB5l6nCUWbhwTott1dlOjN+FmMVy8XGm+gVPZJpF5Rma9/U
         4ADg==
X-Gm-Message-State: AOJu0YwRX3VE/cjKlFx/HcvRAY+EF2DSJhPiKaeEt/Q3KaT77MXyEtLk
	sfHCQyWC88tJQXgRC9tOcyDgCktg9Cz4PV/FnFPbxzYGDvveOr74x3/AJVLWR9P1tgJYZH0ed5r
	2K8Eo6cruo1biotbZD2Y1KGQUpX12ZQ==
X-Google-Smtp-Source: AGHT+IGlDn2LRy2RW2RBvgDQ4C4XC0iB0lYUr0qyZtrv+aD4OKRY7hCmjyd91kI+oruB2PjsX6jfN35Xh853RDHSya4=
X-Received: by 2002:a17:907:c205:b0:a6e:f53c:8da0 with SMTP id
 a640c23a62f3a-a6fa40d43c0mr586786166b.8.1718950194984; Thu, 20 Jun 2024
 23:09:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240621060018.12795-1-chandrapratap3519@gmail.com>
In-Reply-To: <20240621060018.12795-1-chandrapratap3519@gmail.com>
From: Chandra Pratap <chandrapratap3519@gmail.com>
Date: Fri, 21 Jun 2024 11:39:43 +0530
Message-ID: <CA+J6zkRN1ivn1pvY5Km_MpmKDUoJsDJx0evfuiHXSzZrgzH79g@mail.gmail.com>
Subject: Re: [GSoC][PATCH 0/11] t: port reftable/record_test.c to the unit
 testing framework
To: git@vger.kernel.org
Cc: karthik188@gmail.com, Patrick Steinhardt <ps@pks.im>, 
	Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"

Please ignore this patch series everyone, I accidentally sent an older version
of this series that wasn't reviewed by Christian. I'll send the reviewed version
in a separate series. Sorry for any inconvenience caused.
