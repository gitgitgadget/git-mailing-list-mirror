Received: from mail-dy2-f41.google.com (mail-dy2-f41.google.com [74.125.229.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F0074E01F6
	for <git@vger.kernel.org>; Fri,  2 Oct 2026 16:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.229.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790958357; cv=pass; b=RBT9ukmIXKWa7ZzgElnqCyau62CtamGDhuMIO0ljSD1Hrcrx0lzd8B/LNsl/JJft4mot1Bj+8Zdn6lOTSUqPAwfHzr0NWawaOeeHhb7UyLvoLgqe37DEAIez9r/7bCQPjWRFP0RcUSsJRwelb1y3SlXlcNuYEU2+GEaZtlPOHnk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790958357; c=relaxed/simple;
	bh=VUDCtxCqc7SdIA5Z+aAxsWrDz9Dctn3tCUUK1fFmrPU=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=q7wshSKPaMosR9bDwWLA5erqM60LDTauuqT4paaEUxbx7OYbAHp98+3SbxCuZSsaV4WKw9EAcKfNt4SoLLsSjqhYqsj+YsjkRDQIfMd8gmr0MvtiXBKyQtR8r99qR6/qlcmF0C+canKAPdbjU6igTGTg5NF03h5X7CYMRJ7V94M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eghXvd1B; arc=pass smtp.client-ip=74.125.229.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eghXvd1B"
Received: by mail-dy2-f41.google.com with SMTP id 5a478bee46e88-34b590a5b5eso4957456eec.2
        for <git@vger.kernel.org>; Fri, 02 Oct 2026 09:25:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790958356; cv=none;
        d=google.com; s=arc-20260327;
        b=OdHzLI2Z3/t3DPMQZPdcvVJslFrRwCqyu6Ojsbtt+dR1aWrEpii+IQnjp9mfV4xpsO
         alnQ62Cg2ziV59oBlXEq2x1bQiewNYeSoUy8nggOXVRipoIqDyE9YsuzJQZE52g4Fj2T
         uzIolrf3UQockcxoGbNWFP4vRUC+sAn5gbQqBNwwYdGxQvJbGyo6PwBWNw8YKeED2+FO
         79Ym+PqnhVaFGuDy5bD7bSoK2PFtH1nJ9QTLuivTzPe+/5XztOe+vGLSxpgOK7cxUS19
         0GL8gI7OY5Tj+QmZIkivnuZAQMQc4t/3niMxERMx4EAPmCXfrEkyzI4J/csibGmttQ69
         wjwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:dkim-signature;
        bh=7HzxvHXAcajPnTMIsm/EikSdajosZJghM2VHC7HHz4Y=;
        fh=YfO6OQk/ycZML3HJeSL/mg63Z4/ys1URcFL9n2yhSpI=;
        b=IKwly72nc21wpV+9ChI2QLplrKdXwBn0rpqF9VaWEZUnvz+/3xFGqU9qbJxgVMNUu/
         CAHsS/8E44KYUvRGeUquByLwTv0mFXWARn5LozFW/ZwncYK2OiaBNgaxUVuM3nhSVUA4
         EXCdjP3NEOFMg1oh3njgLR8bER6Z8W6tv/QpWMIP0HRKvQDjUkdYoOvajA1W6JYr2Wuc
         M7JPAgSa8++deFkLl8y5bOA2wC6XJo+3wbAw02Qt3vOaQBtiQ3Cw2r5c+jCoIs4dkSVK
         0xzV+i7aeg5vKdehj0tOwxaG4xdskUS2gMXjXHKjHeCEw2YUMYzKbU7O237qeK/H7FXz
         KGPg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790958356; x=1791563156; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7HzxvHXAcajPnTMIsm/EikSdajosZJghM2VHC7HHz4Y=;
        b=eghXvd1BHAzrcRh0PrSBUfCG6dqhhk9pGOBlZg0tVo8AM/lYpCZBLslcaqjalBBdyx
         2bjVisiBC8gEvbu5oQOwuPT7c1qtB/Ht1UKfB5Sy9GUkXk+7WkjW2h0X9RVbIK7LuWBr
         HDPlfAr1rXcwkqq+mhv7FpPyM2e1KEJY05YmuGiGXmIx88RjLxIu7J8Lv8pDTlO3k1ay
         3AmvPylaQ86X29AaCBvmkRXx/+FssfYTedXu7zNz3LLNIzYmezqWWUCKlWJ4Radl8Xrz
         jLcr7l1oWmSWdN1F9OSnZRyntprRwJvv7voYf1SBIQh+JTwYE0JO+WTKJGoIzV8cIkZH
         PvAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790958356; x=1791563156;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=7HzxvHXAcajPnTMIsm/EikSdajosZJghM2VHC7HHz4Y=;
        b=BY3MciAN2p42zi+pWpGtQBWm4Xv6UwPg2Wrtxdv24ei/FqK6SwQoKlRgRFz/DgMpqm
         RiV8SViqbAiOCWSJPwoLdqhgkQsWBMS9aQaR93vC+1QNOww4mR9Xkkh34vWd9WQ3ZprO
         Jsb+IeFnlPjRZlRYFYiO9bkHpSJ62z2OYUlAfTE8PxVwIkSmm5Ro3bcNGh/H83Co9avY
         DtzuH0kQi1IaJi02FmDUieVLybHDdYkaZ4WB4CrPSUw8DQ+rT14roiLFBv/WgyYf2fUt
         E077z1nYS83HEWDI9BpKazwsIidATWgWmQs6Yu4UvrlsEflkjt+owiLpL+a8q751QBSy
         NwOg==
X-Gm-Message-State: AFuF++lU7D7apJ7Ye+Xvh7ohhe7z9klOhizU7Z9H95BT/Cb5QMDc4Aej
	46IMclUHHaIxB/bkt2wAUbPc4EnM6gzEB9KDYaWMJVOc63cFXmMYpYYZuSHz0nVJHGYzcAvbwbq
	UqFDqeOwppbbMKiMFAmVb0IzbOSFClclDD7xK7w+Piw==
X-Gm-Gg: AYBFou3sYhpErXjBF9xJQH+Iz0B9vYmkApXraaRMbvzYAgFcAqueR1oPk11W6PjNu3Z
	UVtLbCwEPPHLI5v8EF+fYJH1MYNM/7jlsbOWm3aSPxJ7jK5NvGRdqXZkKRFl60YMSqqef7bm5y3
	m8U16yCrwAdgGZaEPA8vnVsy2HPOH0JaMMizqnjsuEXylCB5IO+A0Uay217OxV3U9Wka9PJmB5V
	LgCyYGWgAd6utrBEvWqEtVpfpUQ4eDnEFFUGwo1EEUOzGPyIDd2s2mF3M2PtHQJMm+fIZcXixbG
	bMje0i72mfO+rRtmnPuXSFtnW51cRiegybk9hlTQfkwMBRR1CxrHC6nj6LlqGg69bNp/4hAw4pf
	Bl0l+hfep9R24veSjohnc25uB/umeEbYtdgQPg4jWw9R16xFnqBXhsvqLfelcSmRkWLfoaChtpY
	AJoPG6mHYyuiPHJFLL1FNBGHbEx0aYPl/AsgOcfG56xdmLEOT5Pw==
X-Received: by 2002:a05:7022:b90d:b0:14a:8df8:56b9 with SMTP id
 a92af1059eb24-14f5bff4895mr4468244c88.18.1790958355613; Fri, 02 Oct 2026
 09:25:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Christian Couder <christian.couder@gmail.com>
Date: Fri, 2 Oct 2026 18:25:42 +0200
X-Gm-Features: AclHuK-94LhNGoQ6uHqHTKCMRK6p05chif28RpomF5T97FzC2f1oB9p4LMyACx8
Message-ID: <CAP8UFD0KAHvXvV-SqLd=sYohTvcgm2Dd52EfEY1XEbt3649Htg@mail.gmail.com>
Subject: [ANNOUNCE] Git Rev News edition 139
To: git <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jakub Narebski <jnareb@gmail.com>, 
	Markus Jansen <mja@jansen-preisler.de>, Kaartic Sivaraam <kaartic.sivaraam@gmail.com>, 
	=?UTF-8?B?xaB0xJtww6FuIE7Em21lYw==?= <stepnem@gmail.com>, 
	Taylor Blau <me@ttaylorr.com>, Elijah Newren <newren@gmail.com>, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>, Jeff King <peff@peff.net>, 
	Patrick Steinhardt <ps@pks.im>, "D. Ben Knoble" <ben.knoble@gmail.com>, 
	Harald Nordgren <haraldnordgren@gmail.com>, Toon Claes <toon@iotcl.com>, 
	Maciej Ciemborowicz <maciej.ciemborowicz@gmail.com>, DaiAoki <a.dai.0814ap@gmail.com>, 
	Salami <salamiiiiiiiiii9@gmail.com>, lwn@lwn.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi everyone,

The 139th edition of Git Rev News is now published:

  https://git.github.io/rev_news/2026/09/30/edition-139/

Thanks a lot to Harald Nordgren, Maciej Ciemborowicz, Toon Claes,
@Sal-ami, @DaiAoki and =C5=A0t=C4=9Bp=C3=A1n N=C4=9Bmec who helped this mon=
th!

Enjoy,
Christian, Jakub, Markus and Kaartic.

PS: An issue for the next edition is already opened and contributions
are welcome:

  https://github.com/git/git.github.io/issues/872
