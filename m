Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC02A3C00
	for <git@vger.kernel.org>; Sun, 29 Sep 2024 10:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727606184; cv=none; b=GR2WmV0fpHyoFE1BLn3mALCF+946SMa9FSob4+OYZzX/y98eoaLG8DxJ4Kyj0PT+EL3y39eE21DxoLRfTa/t8BYMG+y52FXYYta3QGWvQ6oX8H2jEK0td1tYEGqzI30DL1w7B81gpFNXfHlGdeRpk9LDJ5NJgdlA3z+bXeBkOOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727606184; c=relaxed/simple;
	bh=tcz7C6SDtZ/JWslRTdsBeBQlzAOtzwtRoQFtJf20Df4=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=GNNlU5ZPxkTVG3uSDQ/OZsfVocsySj7pp4ZkEFVHz6Q9m4KUbgpVEMDsXToCaeQl21lc5HRL4FFpz73BiQRTtYDPgNwTXYfUXd6NCS6uVHmdaiCqTM4Znf/nq9tKntDV09IKPYsyL6UONevjghzVyP/8m/DYD0REQhS2z30EHak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kv4ya1Z2; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kv4ya1Z2"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a8d6ac24a3bso635482166b.1
        for <git@vger.kernel.org>; Sun, 29 Sep 2024 03:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727606180; x=1728210980; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qlI8fwrFjb/53ufMSr6dk6UUCzBY70DQAJg9C9r9lg8=;
        b=Kv4ya1Z2UgUtr+5r9344CuV0yTjT5aCXstXOLK+Fy3KlHuePmF0utajh7LiS7iaCXf
         gEwpx7p5e8I+iyTkkKGtUzPF2N4aItoFSI1ZwL7g/TevdZCFj7PT3Jl+PoavbmO7vemI
         zpwoF68Ieh9TfjvS2BG2EKeYZ2jalGwmQTrxNRCC1vjhoKSbkSks35vM8UuQClvKVhbJ
         VRgAwfAFNqV+05frB6qT67rvT+ZNpMVb6xf4IKw5wpJeFzlfzJf7zOkaBvqsGWCe6mYj
         zqCAVwfvmqjnRTicEzkWUcgO5d5GAO4/a+NlN6v19awn1PVfoFGS3PlPkq/vt8Eiq38M
         XSKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727606180; x=1728210980;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qlI8fwrFjb/53ufMSr6dk6UUCzBY70DQAJg9C9r9lg8=;
        b=UVP/AJHvcInuQ6F70vguxHbFvfAQB0qsYsK50zvDB2/Zn2W9sbGTefBhqdPPsOwTVu
         M8UbBIamJ/YvpF8aJV+u55+GZdfmtOCt03CEmoiD0K8qoy9tOk8HxRLtJiTj+ljFbeS6
         qtEBRtnDZ0JrOg/owiDBu2zfZTDpubTXbzO/P19QX8PCBwdEaVmW1akisY29QYWaG8CA
         UrXGRpuIUEVyMC0JcLPTmW2sxmcAIpq4OAy89YEM0kURX3uSuqfD99JDCKT4/WbEFDg2
         uu3J9vchLn0d/syytjRjpg0pPTclhH76lpaGWgUDo37dubvusuuht/2C1gxiw4nuJlan
         RfiA==
X-Gm-Message-State: AOJu0YzosKOlqjjkNByXZ6Eb4b1csirWl6m1lFlk/FB8THKABSFarfjG
	QQ6VNR4GVyrNifW+7ugRPrYJVmCgTyPmHKyUbe5yp0b0WGPCVxayvcuaLzu1eoaFizSkdVnMJsJ
	S84gsIlEOFPfAoOhyIdDnIbDnGcP6OW0I
X-Google-Smtp-Source: AGHT+IF1QvwnvCokhoCFuiMszoHVIpWQ1H1+LCdTMa8Igh2mcU2YLju+KEr9Y+yC4nmKdqbZIfL28tuHwf8C93IAMZA=
X-Received: by 2002:a17:907:d18:b0:a77:ca3b:996c with SMTP id
 a640c23a62f3a-a93c30f0cd7mr941810166b.16.1727606180255; Sun, 29 Sep 2024
 03:36:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Christian Couder <christian.couder@gmail.com>
Date: Sun, 29 Sep 2024 12:36:08 +0200
Message-ID: <CAP8UFD350-iO7o0xAw9qg5f5uX8tN86so2TYf6AvD5Y1C=WyEA@mail.gmail.com>
Subject: Draft of Git Rev News edition 115
To: git <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jakub Narebski <jnareb@gmail.com>, 
	Markus Jansen <mja@jansen-preisler.de>, Kaartic Sivaraam <kaartic.sivaraam@gmail.com>, 
	=?UTF-8?B?xaB0xJtww6FuIE7Em21lYw==?= <stepnem@gmail.com>, 
	Taylor Blau <me@ttaylorr.com>, Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>, 
	Patrick Steinhardt <ps@pks.im>, karthik nayak <karthik.188@gmail.com>, 
	Phillip Wood <phillip.wood123@gmail.com>, Jialuo She <shejialuo@gmail.com>, 
	Jeff King <peff@peff.net>, =?UTF-8?B?UnViw6luIEp1c3Rv?= <rjusto@gmail.com>, 
	Scott Chacon <schacon@gmail.com>, Chandra Pratap <chandrapratap3519@gmail.com>, 
	Ghanshyam Thakkar <shyamthakkar001@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Hi everyone,

A draft of a new Git Rev News edition is available here:

  https://github.com/git/git.github.io/blob/master/rev_news/drafts/edition-115.md

Everyone is welcome to contribute in any section either by editing the
above page on GitHub and sending a pull request, or by commenting on
this GitHub issue:

  https://github.com/git/git.github.io/issues/726

You can also reply to this email.

In general all kinds of contributions, for example proofreading,
suggestions for articles or links, help on the issues in GitHub,
volunteering for being interviewed and so on, are very much
appreciated.

I tried to Cc everyone who appears in this edition, but maybe I missed
some people, sorry about that.

Jakub, Markus, Kaartic and I plan to publish this edition on
Tuesday October 1st, 2024.

Thanks,
Christian.
