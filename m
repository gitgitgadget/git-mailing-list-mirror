Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90F77142E73
	for <git@vger.kernel.org>; Wed,  2 Jul 2025 04:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751431854; cv=none; b=bQHqTnLntyWOu3xT5/PRRnxDyEFi9Jc8jX1NM3+ZXUscQcNS6ATMuVzVbWKxeNXDELtnyyvnfQqqiKXcdbBz/8WrSyGIv4jndcq/BgHf4RTY6suO1Mw0Tw4cNNJp9BfQXTw4no8uC0UeHR95sXEU9jmkMiNxh++UX9HQ+AsT2ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751431854; c=relaxed/simple;
	bh=lmPEf9ImG15j67mNL8Y6qT5zFI/7saO8UzOhdZjTv5Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=m8GhAYusRUmH86N2Ny4f0rHrziyNigDyX5feXn3nN+aem/TJf54HUvCbh8F0YmkYumzkvHDv/tzuiy+ytUZIdNfyAVNXP6F6mmuj0a5ezloXeR9T0E57iMJBd7wZFApMXLjmW6GsuNV+devGbkjIJlQIFIoVs+8lgYs4DigFGME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bSuMgaqA; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bSuMgaqA"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-553b82f3767so4582759e87.3
        for <git@vger.kernel.org>; Tue, 01 Jul 2025 21:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751431851; x=1752036651; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ie0yoEjbOGnPVjHT6gN06YfB8lTr2HXRmDzrW8E8Ab8=;
        b=bSuMgaqA2+k2lkmjqfheGaXtTwyCtQSOCYuTE0ML/r2FzJ3Z7SupIVDHTUhbUzz+lQ
         zIUAcQuMEXjS7ZyFwrcrGXsmZKuPlSIIAHvVGVdvR2++1eC9Im1XMDWFJWABaVvJHvFg
         Hhcm94miVfACHYP59S7Aus0sX9KghB7gxMeGmNWy8PRPFPPzQIjMieJ/hJpTpVLU2Dqk
         if5dYGZ0GIYeTjNHFIKgxbJox1EmrZWshTpEJ/ldeEd2qmHY22DB13aBovx2DIHPuQZY
         6lJ32KG1Uuoy/bBLdvIHzhSgfOtMGPYDeL38p1VR2x8ipauIZ/ndVjRMIanNE+Z+u1K+
         Q4Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751431851; x=1752036651;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ie0yoEjbOGnPVjHT6gN06YfB8lTr2HXRmDzrW8E8Ab8=;
        b=QmbRFJjhAGPRAUO4KX+UyhAJvntr5g1jyY20JVNa890zRd6/FEQEVZ0SQZE+Q2k+2M
         opyD4M7ypY1tF/7IufKEbJf1HgnAemXEDXh8oX4gFio1AIqh8XLyVusSf78cNS+6cw8D
         fB+0J2+O2mzZV2Yw/OJTagUuCy2CApIatb6evIZj0EeoebqSZrl5yoWxNmY65r8kXOpK
         lvwDVy9Q9RTNV+9RCCUd7WwG7IeWkH/DKlR4aMt2HzVqt/4RXpp26KhEsiH65UjWdAU+
         LGCIcXJD5RVQuJ5rzsgX4WuGM4f4ZANMa3Q4eoGWh0kbVwDQchILfPcLbQ2cYf/0eiQV
         tGow==
X-Forwarded-Encrypted: i=1; AJvYcCUH9EVASCr1inS1H00sY03+47QLdCD2EFDKCx1iM+4XhfLce+oRSIr+OkvY318K3+EcY5I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yya8l4S58ub/IUiPUXgw5yGf2O6vM//xfoL1vDtnY66i/efOiFH
	fuvH8wlxqKFJTHIyRAmLq0d9CtOrfSEQ0Y/wfOmlG91SW29Eb03bQff9oYZXjZ7OnNF+nsXx3C2
	c1UYoN0VnyFCFGTRm2ovq/edT3jKkfqs=
X-Gm-Gg: ASbGncuiBBdBYwFwa5S4dhe6jMERVXHYaovWZk3XA4CyjtuYVG5iJ3vRG8CaU8E3Dtl
	KRgxochNhLJmVt4L8rbgRnPKgLrzZ74C6xhbWVBFGIdEr7Cli4ftdlpcrSWJaL/MV5U8gYG1/2L
	XLnfaxn3gblC5ikGwcg/sDCpSo6cPNJhh57GyqOdPyKSbP
X-Google-Smtp-Source: AGHT+IEIZ8wa9pZKM1cQUZEXT4Mmf3GljO7nQoC4c5oV9DMNtXGhQDXV2JmklHVoc6tk1YtL5j+em6TFnI5ya6b20XY=
X-Received: by 2002:a05:6512:a82:b0:553:2f8c:e631 with SMTP id
 2adb3069b0e04-556282e103fmr424519e87.9.1751431850355; Tue, 01 Jul 2025
 21:50:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKkAvaw0sZ0sW9o_0NZdnZknS8M34UST3PetaPBQj5wwvJyjBA@mail.gmail.com>
 <20250625141849.78834-1-jayatheerthkulkarni2005@gmail.com>
 <CAOLa=ZSA273KGPnwZ2aRBU_ybcCTYogBHvUwpa+5CfDOc2bEWg@mail.gmail.com> <aGKdICvmKlumU0ru@fruit.crustytoothpaste.net>
In-Reply-To: <aGKdICvmKlumU0ru@fruit.crustytoothpaste.net>
From: Chris Torek <chris.torek@gmail.com>
Date: Tue, 1 Jul 2025 21:50:37 -0700
X-Gm-Features: Ac12FXw89xpcIvBiFb1kqEOfYnHT5Zx-UpixWhQ_Hd9O2HM-cwB9mcLiEybungo
Message-ID: <CAPx1Gveenh075k5W-KAKnyJKfdzMNL0iry-043mLB8rKZ_2wuQ@mail.gmail.com>
Subject: Re: Re [bug] pull --prune could not delete references due to lock
 file already exists error
To: "brian m. carlson" <sandals@crustytoothpaste.net>, Karthik Nayak <karthik.188@gmail.com>, 
	K Jayatheerth <jayatheerthkulkarni2005@gmail.com>, ryenus@gmail.com, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 30, 2025 at 7:21=E2=80=AFAM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
[regarding]
> > +                             if (ignore_case && prev && !strcasecmp(re=
f->next, prev))
> This won't work in the general case, since the two refs that match case
> insensitively aren't guaranteed to be adjacent.

Also worth mention: it's not just case-folding that matters.

On OS X (Macs), path names get "normalized" so that the names

   s c h combining-umlaut o n

and

   s c h umlaut-o n

refer to the *same* file or directory. On a typical Linux/Unix FS, they dif=
fer.

(I don't know what Windows does!)

So, if you have a "folder-full" of "pretty" German refnames, some
spelled one way and some another, well...

(It's not clear to me what, if anything, Git should attempt to do here.)

Chris
