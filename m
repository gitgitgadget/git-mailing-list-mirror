Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB9B63C17
	for <git@vger.kernel.org>; Thu,  5 Jun 2025 11:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749122226; cv=none; b=TuNdwuIsZQrftW17JM8mWeWb08Vds+bo0AT32wN8ZL0lDGLeliVjdY4xl8hvcDFXnBD56g5HBWWzMgDZOG/98q4wl8SvkjrSioB+uMyQZh66KBe1O0nPCbCPPbhsJkrhV0vckRht1kGJuixxXp+FPsEqA/RGaEX0zubKnUFlzWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749122226; c=relaxed/simple;
	bh=B29Xcz/OVW5xutkdKKnM1rIzrAAemtoC0FtpmgNHt9k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=exu7ats0VOcvOqa1SvZBpxkBKW5QctKZT3TieU0NfY1dzmgfGhqYlxZh6IQsfK5LzfS+xyRsElBLqCBQ+zip/NpdyRO6dnTRK5ujXPtvAHctwgCuvANd14s0Teez0AMLbU4PQjYCVA9R4QRxGyX1CAOZSX78Kks1R330E7AAUck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AkKT3qkh; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AkKT3qkh"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ad89dc2d8b4so13105366b.3
        for <git@vger.kernel.org>; Thu, 05 Jun 2025 04:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749122223; x=1749727023; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=B29Xcz/OVW5xutkdKKnM1rIzrAAemtoC0FtpmgNHt9k=;
        b=AkKT3qkhsmDKV8vpbwgF/4Qk2uNhHWCLrhprN7UzW/eEz4GYLx7ZELJVeS8dlM/e5U
         KMNmIwXIm11jmGro+QwOOAn3rXYnEfzkM15B7aRREVIZNkyGIL9Sh5PsIVPdlZ22ms9b
         YlLqRpICWwJrK+1SFBJHoFgGqJGZ+udp2aRNlrJKbWdMyCm4+4bzB3LyQBeGRFVcLkwH
         XctM+nY6d6jvECQ9gvomXHp1ATa4yrIl4X0sHH8PiECE0LNXKU4VjyEnf80yuzDmy2Wh
         meS7/WXMSyApzxCHxOFrHWIh4EuO3RaxSlAbi7aD+96dRIu6OKSIv0i1vS0/50BOeLmj
         FSxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749122223; x=1749727023;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B29Xcz/OVW5xutkdKKnM1rIzrAAemtoC0FtpmgNHt9k=;
        b=G+xLEaiVPu7SDpilO97W3/0X02pgcQp2C+ZjzkOKXArAU9im4yfg78HfB9KBdclzsR
         cALM1C5MAjKkxQPvt1LjCYnelMd/rwUN8ODGv9q6UdCVZTiEA4m5ntf1gJU7Hk4E7Z7b
         pE8tPdfaWyLIOktkKdaXktNTpzJX4UxxlN5c7PgSdJQaOVMG6kmPp6dspPl3B3CACe6y
         T5R7ZQ/Okenc0/uEx4EGM5qn5bzttRj5olLClCjmgueMkyuhKzF+6zoIk9PBSBHcehwo
         Wf1dbMlDlAdRFFFvIEgzfU1injqDVlxq0vX8qm9fC0nS69Y3UTiU2hhCZOUlPGuKmeTV
         h8QQ==
X-Gm-Message-State: AOJu0YxNmqVQcpS6RmwLj2ym5Oc8WQ6jW4Qk1y6FRR2GGBivMOjoR9Ba
	BMBmk/WZip4/zEtYsrUsyuH8lgR91rNaMNhmd/FI9bAbKsOb/pakjqcDyzZyikemDuZBAkIoPjD
	OyNVY+CcybCpG8EvgHfeGpbymY/tRTvDd5seq
X-Gm-Gg: ASbGncvjFZjio1F1UJ2Eh1HGucQEJ1EfJzEsOf3jkxB0M2b0De68sAB5xVpcLQD7LLP
	dSPL6OWTrT+4XGrPm6rVrZbapAsrJS379OSi7caHwRmUo9ObMIe1ebagnq++DngJHlqcPhh1fqJ
	EHMT2QSm/Ye8GQWy5hx1xyZbxkKLRhgPAzfB6AaiV77ys=
X-Google-Smtp-Source: AGHT+IHh64PRJGW/84ZMU6OQgafLpQMVUDg1VwnlImqXBoothuzLYjW7jmfWqMrPlApTjJzakAu1TXhl85MLAx+70Mk=
X-Received: by 2002:a17:907:3d8f:b0:ad8:8200:ecfc with SMTP id
 a640c23a62f3a-addf8cecb9emr226901266b.5.1749122222663; Thu, 05 Jun 2025
 04:17:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGJzqs=kJtPcMrWC8Dayd+VW7BvC1rmzS0zT+EwQXfLOpZ3Tfg@mail.gmail.com>
In-Reply-To: <CAGJzqs=kJtPcMrWC8Dayd+VW7BvC1rmzS0zT+EwQXfLOpZ3Tfg@mail.gmail.com>
From: M Hickford <mirth.hickford@gmail.com>
Date: Thu, 5 Jun 2025 12:16:26 +0100
X-Gm-Features: AX0GCFs7-1WXG7loiIoYtRUx61JEKLSw8vrgOOQTuxsJkHRiqfdRk8X_qbIlhv8
Message-ID: <CAGJzqskDumbMSbC3rdYT8fZ8gNJ5MOjR_o8RAo9QS-nuvbBinQ@mail.gmail.com>
Subject: Fetch remote only if remote hasn't been fetched recently
To: M Hickford <mirth.hickford@gmail.com>
Cc: Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi. I'd like to fetch from a particular remote, but only if that
remote hasn't been fetched in the last hour. How could I achieve this?
Is there a relevant option for `git fetch`?

https://git-scm.com/docs/git-fetch
