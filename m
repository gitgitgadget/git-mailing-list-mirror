Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B524E179641
	for <git@vger.kernel.org>; Sun, 16 Jun 2024 13:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718544093; cv=none; b=hPkjkZdxecFV4yDV3mAnSaEm0oIZCEvk3j5XN17G+y6O1j7hX+2vtqETXTQJyaR7KKNOATilkvDGcABx0LJz5lWLOw3TcegkyEhGrXXUvgwVZ2+QAoVMMXmRuxxnl86CClaZjQgNZX7Dbr9zlP00ImiTJtfLRo6uPrqOdrUuRhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718544093; c=relaxed/simple;
	bh=B+YqH5zDqt+VXkcogwOeh0Ju1gl+/hdUlfruBV2Hw2Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mRpSHd63PUIPlXd0TehcMY/oSJbuonaf8lZ20MThIiccImZ8n4cm0gWWBjwtbZpQfUh97AMW3ola3Sk5zEvBdZlzRpq2Z6m1Okdg8Brn2O2zx5ULVmv57QjvwDjWAasIQGO+3JHNVZ53/3IqrwoYQzHDtrY4EVUt4ai5PA9ARL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nAJAKdrK; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nAJAKdrK"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-57c8353d8d0so4658854a12.1
        for <git@vger.kernel.org>; Sun, 16 Jun 2024 06:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718544090; x=1719148890; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=B+YqH5zDqt+VXkcogwOeh0Ju1gl+/hdUlfruBV2Hw2Q=;
        b=nAJAKdrK4wvT577AMQCswWZd5cZu/+drZEoULgEi+7X1CX7T8n504xtFPleVi8/lQs
         /0kV5Fyn6CVibfCDcEBj6xIxOB1X2xhJ1Vy3nYtWiP9TwHjgU6q8aN+89AZGpw8A1AWL
         kcvJSSScLmdiEETRPONW3k0n8v5tyY7ke1vkCm+inTCzGvspWIXiagLRxnTkQrnhFy/B
         Gjzo+4Qk8XL4NNNfrV0ExYAmj29uhFWR6XWsSlegY61b/BJyQwvsMQfgf8stFjSbcUay
         uIZeqOsNIQTDg5/MAtL6fGqy0jrHqpkhnO0qFeP//cPI++beRm8qe3XctCQOLtjUrdeE
         bNXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718544090; x=1719148890;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B+YqH5zDqt+VXkcogwOeh0Ju1gl+/hdUlfruBV2Hw2Q=;
        b=fwJ2GECTUeSG/NdrlFfrTle39/jhr/vuy7pPMcmIhFzm9Efq52eMVUD79w1rgpSBIp
         Us+V9l4SLJeV1wstATgAtRRZp+zynRNa98pCaGlgVzsU8VM5rldLYAZ/10VrfEAOfmzK
         Vl1bfAjUBtQYJ0X8FVPwisqZApf6qoJdu+MOuXPneVbB5fA4Upp26I57tLvLRYUeG7Qa
         2eMzl7SP73KKas+VPe/nWQ6jn03QVX9EShOkxkz02WacrgeSnlZiE6L+Igme/AsSo29p
         lXapWgBJYXpBxeE+T2rHEITF3OyXrFnoQ2WydIwWZI0I4tDNdtbYyCJSUEuCoSzzKb4V
         CvWw==
X-Gm-Message-State: AOJu0Yz4kvXPnPGaNt2c2ki2s2j0BFjufgDRirYKriNn3h+aAt0R3+6K
	ah51A/p4QEfhVIl8dAYvhBqCMvDT7rC0JEXkqcMBiljwtnbZpUlwz/80wMmB6cDklMhPG054/dy
	FQb6b48QS2VAG2qmqpaP/TNLE2fjQuzd42J+0tg==
X-Google-Smtp-Source: AGHT+IFugAg8AxxKeNX15e/4ye2AIwyrXdQFrA33FO+8HNmMlcY2A9IA+Q0QDkTHErOX97+vCAoPirDhNI83CG4ULR0=
X-Received: by 2002:a50:8a97:0:b0:578:3335:6e88 with SMTP id
 4fb4d7f45d1cf-57cbd4da967mr5025365a12.0.1718544089568; Sun, 16 Jun 2024
 06:21:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+J6zkRxnvnybM3vnPXX2YwpW1k-as03+A8kxiJoA8GrA4FSMg@mail.gmail.com>
 <CA+J6zkQaV9o7eUaD2bshH7zEmF115BbYv_uCFctySQNMgGQc+g@mail.gmail.com>
In-Reply-To: <CA+J6zkQaV9o7eUaD2bshH7zEmF115BbYv_uCFctySQNMgGQc+g@mail.gmail.com>
From: Chandra Pratap <chandrapratap3519@gmail.com>
Date: Sun, 16 Jun 2024 18:51:18 +0530
Message-ID: <CA+J6zkRzM33MbMr4-U56M1SFLykx029+SzEeo8vBicBd9Xs8RQ@mail.gmail.com>
Subject: Re: [GSoC] Blog: move and improve reftable tests in the unit testing framework
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"

Hello everyone, here is my blog post for the third week of GSoC's
official Coding period:
https://chand-ra.github.io/2024/06/16/Coding-Period-Week-3.html
Please let me know if you have any sort of feedback.
Posts for the rest of the weeks can be found here: https://chand-ra.github.io/
