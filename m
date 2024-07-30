Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F52018A92A
	for <git@vger.kernel.org>; Tue, 30 Jul 2024 10:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722333886; cv=none; b=RUYBkw+5KV8V50rh8j9U2boIvSrSsjjVdU2KV4hsIneUKGae1mZYRSXHQcNpPIMxGpJmBWy7AeOdLKG3fnnzaQzk4XVmKQn1uQgFh1mLC8iJVxEZ0YS6uycmDup3aebMc5LXT1GikERH5ZxmaxYbDkqwYWs+pzq5tzafd5H8cgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722333886; c=relaxed/simple;
	bh=2a3FFYTm/V72hwOQv1jBkgox/OGg4L9VeFH3Fk7ac24=;
	h=Date:To:From:Subject:Message-ID:MIME-Version:Content-Type; b=ueKviF3npD45BhGhTW8nlT8iVYUGLmArZ7Bcsni1XL2PqEUaQ/E7zirlMpXEp3b+Xrcs11jDP6Pw+W2kQHKEULMwuIgJphCLwg/usy5o7mueMHS17sra7FU4uy3nTsHOHjgmmFC3dl6L4qbGrxFryBUQWDzlyQpit7yLWyX1mpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=informer.com; spf=pass smtp.mailfrom=informer.com; dkim=pass (2048-bit key) header.d=informer-com.20230601.gappssmtp.com header.i=@informer-com.20230601.gappssmtp.com header.b=z7eHw5jO; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=informer.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=informer.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=informer-com.20230601.gappssmtp.com header.i=@informer-com.20230601.gappssmtp.com header.b="z7eHw5jO"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7a1df0a9281so277536785a.1
        for <git@vger.kernel.org>; Tue, 30 Jul 2024 03:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=informer-com.20230601.gappssmtp.com; s=20230601; t=1722333883; x=1722938683; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:subject:reply-to
         :from:to:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2a3FFYTm/V72hwOQv1jBkgox/OGg4L9VeFH3Fk7ac24=;
        b=z7eHw5jO1iHnh+FtKtmWJqIZ8tWx2aXid2qtcu0KpXOCk6THQldzLmbx9VAxLfbJmK
         I+TAUbQHGcoJCOGA4j79aR9FH8cHv25OXTfd2Cr7JWr7WdReRgD/WO7jPd6/zvmkQ/1Y
         dZ2gy11DCZLH7WoUvhWzDCqzOyZNWZ8zv0AaljQzCZYADmSv6MEFCStqyTKA0mbQpyLG
         2KTXkTUhXwXad2bD1yZd5IJ6th4mfbZgt7jAwIW1tbeO7GTQEvU2XSZi5qX2J1eDYjcZ
         GT9z98CcuAJcSwK/5JeS07GM6M5rbyCIm+fdSQYd+wGwRuUAQtZtXX3ns0c6RqJXXBl0
         lGnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722333883; x=1722938683;
        h=content-transfer-encoding:mime-version:message-id:subject:reply-to
         :from:to:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2a3FFYTm/V72hwOQv1jBkgox/OGg4L9VeFH3Fk7ac24=;
        b=KrThWJp13WG/oW49YsFm+iQf0srFPnjw38eEE/7k2yjm+jxmAtEwsBPDBfwzF1t6mW
         C8dcontRyVByIb3ovGGb79RSO4v7yjsfM7/TmyvAVLksyzWuCjTLxTSCUv7xzdx8WPck
         FnYMJyys6CpxFCQqU2WUibv61hozUFbP6DoJjOA1jY/FQ85CICgnUUeI0MS4QU0PM3e2
         g97ztoqFb3e6iIZX/4TCeGoZ3+xFoCfAmYlQn3juXShlaFuoUZ4E2fGdqIvhniTfVSNH
         cQMEHlkvdzgC5i2j6IMx/hwf3IAT1PyBhzTFMNT95u+iDTwd9ffN1EczS6X3yrjzkNzO
         smXQ==
X-Gm-Message-State: AOJu0YxcZngyI5E3cSagZ4o9+o7i5I8I77XrmGSNXNU2eDETMNAbpQbT
	SnLQt3GQXlo8Zums1Stzm1y8QK+Fb432vSknpco5uywwjV7XwHC4VJtaPgHV26rVqcoHGuWQ3aO
	FuQ==
X-Google-Smtp-Source: AGHT+IEQZCYEGKY+9CoLJYbcQtJMhX5k3RMn7E3m4qnuIKHLoU9zmpDPbo4jqAA7eXCFdXSD+1tHHw==
X-Received: by 2002:a05:620a:178f:b0:79e:ffdc:5518 with SMTP id af79cd13be357-7a1e5241758mr1126902285a.25.1722333883024;
        Tue, 30 Jul 2024 03:04:43 -0700 (PDT)
Received: from software.informer.com ([208.88.224.100])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a1d73e53desm613845285a.54.2024.07.30.03.04.42
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Jul 2024 03:04:42 -0700 (PDT)
Date: Tue, 30 Jul 2024 06:04:42 -0400
To: git@vger.kernel.org
From: Informer Team <partners@informer.com>
Reply-to: Informer Team <partners@informer.com>
Subject: GIT by github 2.45.2 is listed on Software Informer
Message-ID: <739497c1eefa2c4d99e7ee30393a6e21@software.informer.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="iso-8859-1"

Good day!

 would like to inform you that your product GIT by github 2.45.2 is now listed on our web site and your program got "100% Clean Award" https://git.software.informer.com/.

We would be grateful if you place our award with a link to our review on your website. On our part, we can offer featuring your program in our Today's Highlight block. This block is shown in the rotator at the top of the main page and also on every page of our website in the upper left corner.

You are welcome to order a free video tutorial for your program as well. Once it's finished, you can add it to your website.

We also offer you to take advantage of our free storage by hosting your installation package on our servers and listing us as one of the mirror downloads for your program. There is a selection of predesigned buttons available to fit the look of your website.

Please let me know if you're interested in any of these offers.

We are on the list of the world's 1000 most visited websites, so this could get your program some extra exposure.

Kind regards,
Informer Team


