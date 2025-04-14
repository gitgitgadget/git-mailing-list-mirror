Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7EE2274661
	for <git@vger.kernel.org>; Mon, 14 Apr 2025 15:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744644359; cv=none; b=RoOioiZQ65wF5JZRUlNAVz/a/3ESXFvRphtQrlzd8khkHXy6k0Ndvr0piyZEcINaMSPxcET+QSC0bPX+b/EErTywHCkvgV3bE7yfE5Kv5uqo4p5IwNY3HP3uo5mRp0WSann22q1oZ+7nlXRJ6owprkEY1OlWdkN+eMlEJsiiVes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744644359; c=relaxed/simple;
	bh=UNvNIyM7GOdCb1Lj9Gn+Esb4VF8YYgIQEE+Guk2oPXg=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=UUAhNbTc7sNl8tyrtz+EXt2G+kmGmzZDjKkOx/Zfc7lJhkJsFHElwRfPKiGVrC2Cpmn0x+dxMLjaJYOmVMO1NANl6Nr4ETbWuFgEFmkYkJSGruRvV+3cb5Ro2VxBG7UkN0Y9MnLAmri4cpYB3yfEfCd122AkzctC74Nm7bia/B4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mReLHIQN; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mReLHIQN"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-22401f4d35aso50758785ad.2
        for <git@vger.kernel.org>; Mon, 14 Apr 2025 08:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744644357; x=1745249157; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UNvNIyM7GOdCb1Lj9Gn+Esb4VF8YYgIQEE+Guk2oPXg=;
        b=mReLHIQN12AbyK+gRPetpcpOoQxXQfFS+h1+NZrApezORTVGUnrSL0kuLlKElllQ1P
         LV0VPiRm/OMT613TGPNja0Y2/F7qipqqN3Fu0JsInTFa3n4btnrNa0zqlVUTzPb3kCNt
         2GgUl4T61N4JL9LaZNW68ztZq+fFhGlxQRFQhyseQoQLoeAGU+7bQA8ZIco9gzeQn75l
         FwM3FK30u4tYOMC49GAjhygiTOUwW7wxT7Zc91/3EIpMat4BTTfeSGoz2ypi0BS+rzGo
         jN6UVrZKfyzuknrI+bsXDkAPhPAfuVemVnZsBwgECITqyDWl8EO3icFEwj4RSH8WbGTf
         4XMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744644357; x=1745249157;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UNvNIyM7GOdCb1Lj9Gn+Esb4VF8YYgIQEE+Guk2oPXg=;
        b=nUSgdyvapRcXJCVbB1Wic5GYWntxch+SDDMP97tzUNxIeHPpKvuz6aQk0Cq0DQqC9f
         PpCOCnghZ8vwlIQa2wUFD+hXk0XhtLn8c2BLvzxuE1v5npf4MbgHMQ+lx7uzMti3PMMd
         JCyGnKaJky1pCM928s40Mq3YECcpo4Kx16+OYrkZX0xONiVd73f8qDSUPUlR4ynmDox7
         1n0LBHUeurJZrikrG1FgnY08tkeNAXuaBBB/LnAq+FmMmp6TbBgh2UCkborCRzTU5YfM
         +39QIIXoTBMiXoUr/VLeMScN41QJ6UbAQzo1iMEmhfqng4h605jn7lo307eyq2m00m44
         YB0w==
X-Forwarded-Encrypted: i=1; AJvYcCWaqrkxmu1WyK6gKoH52Z3x0/A1T+Tl4hJO+pXJnwnN3zlA2GUXEIwhtoRV5p2NzZsbRkc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzxlkqmpg06F03mbB/uKyFEl8G5TE7FCiQZnsNUn0YcOEzDz14H
	eDI1+Z832lIFYFMqQmk6mCcVuumOivaej/KXuf+2OskgVZAh9eSq
X-Gm-Gg: ASbGncve1sccX8A78UUdwFh47ZCrSeM3WZvKdPuqjgdrjhAJCTlIdzCHR3P83WWnh50
	k66tDXjO/gCM9uN288bN55lWqE55xJ3PiRZIm4IUFTVxKIg0F8cH6hnOGpgsbRc6TTkOlea02Dx
	uHZaONpBpfhlI4rbctWB4RF7whoqSU9JFLz7OYTBjKwc4I8IviiCMS6p9h3YtY2dwZHj/jMh+zl
	3karjXbm65CPlsnTYPntVVBznFk3jAOxxzGeynyDoR0I38vOZvKsCxw/h97zSxsnKLmeI0lPwRZ
	VBaRab0OEDfiQ0vlqAGlQmf0qZ/mwar5Odshu/EMp3aWQm2WOmT8WHpkFUhPgzTmftdmzjrHdYV
	kn7Fv7XM=
X-Google-Smtp-Source: AGHT+IE1NZebxiSQ637a8OlszF1NrkjSrQGW0q+V1ESevXo9LgTKe8c0MPBrax5l474Js4B+TLfpMw==
X-Received: by 2002:a17:903:144e:b0:21f:4c8b:c4de with SMTP id d9443c01a7336-22bea4f26dcmr149821655ad.42.1744644356788;
        Mon, 14 Apr 2025 08:25:56 -0700 (PDT)
Received: from smtpclient.apple ([2804:14c:32:8e7e:85b7:aff:5cfe:b6e5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22ac7b62b96sm101302045ad.13.2025.04.14.08.25.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 Apr 2025 08:25:56 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.500.181.1.5\))
Subject: Re: [PATCH] git: add --no-hooks global option
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
In-Reply-To: <2c7994bc-2be0-43a5-9627-0d530746b3ab@gmail.com>
Date: Mon, 14 Apr 2025 12:25:42 -0300
Cc: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org,
 gitster@pobox.com,
 james@jamesliu.io,
 Derrick Stolee <stolee@gmail.com>,
 "brian m. carlson" <sandals@crustytoothpaste.net>
Content-Transfer-Encoding: quoted-printable
Message-Id: <1602379A-B5FB-410D-9622-F31333461E74@gmail.com>
References: <pull.1899.git.1743719888430.gitgitgadget@gmail.com>
 <2c7994bc-2be0-43a5-9627-0d530746b3ab@gmail.com>
To: phillip.wood@dunelm.org.uk
X-Mailer: Apple Mail (2.3826.500.181.1.5)

Hi!

> I thought "git -c core.hooksPath=3D/dev/null" was a fairly standard =
way of disabling hooks

Given that, wouldn't it be a case to turn this into a documentation =
patch?

I just searched here I found that we even have a test for it (introduced
in c8f6478), but I couldn't find that as a recommendation in our docs.=
