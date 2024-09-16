Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F46E2E646
	for <git@vger.kernel.org>; Mon, 16 Sep 2024 17:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726509539; cv=none; b=X9DF+mpSXD9ORpVtw+Ln1C+645a+nrY5YCkLBv9nMRBR5699yaTsAS8BC/1XLTCBMOzt7ngrk0RWEiRpzT1Z6ICsKVWu7s2pmCS/lNj0d5iNBKul18uJlAxOQFaWUbyOPGfnQ7n12Fjw1+6C8K/EQisaXqowhzxQkp8S/HRvxeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726509539; c=relaxed/simple;
	bh=hCiiw395PF8nBDJzpG4H03nJivRolGkeHHSl1+6m27Y=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=Eq1OjwBm979EuR+vxuylB082E54oC25ZBEZYlmxTChOCiAsPSLs0r0j0FtDWkL08ZmXMm8mxQO1eChUqdii5aVdpN22AE8W9GgJ2OmrAnlpZ1VkwpoqJl4Cog5zPxJ3pzGXe6VHGc+lCnnIXiTa/CeMMkjWIlLImXFkhtSqZWS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WLMdGCr6; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WLMdGCr6"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a8d60e23b33so621410166b.0
        for <git@vger.kernel.org>; Mon, 16 Sep 2024 10:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726509535; x=1727114335; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jPJWs4LG+q9yyML8YVAYRGMZitzEEE71LP2YOWi4Id4=;
        b=WLMdGCr6U67+5SnjkDoKahtFAc4XL1CBmtFD8y7MMzVCN9VyNqyZkmQ35MkgNowqSD
         pY+Oa+t2s13MydPOLwqUm7yNpL8OzBNImkw3cy8GvTs/Fu/1fuiZZXY6Ty7fW18XqTOU
         4m7WyPNxUXzqbkSd6he2nIVeTdxwZVFfpC1mV43xjVxLME2leOg+cGUI/ZoLhUOsMo8q
         izShBkImt4k/2fwYdiTNEcRr78BYEq16iu/SGo8G8DtoouLdUKm4oos1gYX0PiilG7M7
         sCphMn4A7Tg/8I285F+ZoefZwak9NXwlCEHnFZvjXQ+RqTzoaQGpJMkGK2SG9eQ+EuzY
         JRYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726509535; x=1727114335;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jPJWs4LG+q9yyML8YVAYRGMZitzEEE71LP2YOWi4Id4=;
        b=OhFFgl98DVBLJIn2e6qKy89wlvqEWBUJQmn0Cz4DshxYzms4xwRtRk9WRw1tL3Pokk
         l0BoFiyb6goHsDnIN/0IFSHhrfSbRubQ+e0W33kjaU8i88h9eCNjCgwd0cX1ethZjIki
         l3wv8K4cnyqSHRQrUGwimlq/hZALjXiJ0EYagOq27TbvokN5Yi7Umm3OYymTOOAC9oMT
         CrSz5+AWJIcDJBNEaKQa6Q4dZamNuozS5B0eILw35bkkFXiaGdsuK1pRm8a4bej+uos4
         yTWSAeaYMBXMm7u9qQOFITE+Spsb2GcjokZn7MCbyF5umwLZAzboM8+xSQVhGV6jHy6x
         5BGA==
X-Gm-Message-State: AOJu0YzjD7OH9FrlZ3PkzFAWUGUWur8rUD/eeahyUqCp/Rxmvis7vS53
	0tWFDVOjAGQelZ8FJDb4sOEBuO1ESsR5FkpI6W6PCGr7QUDTRiMn11oAiVQYqQS1oKn41PlQR+h
	EnqbPIjnS4GD1d8Cp6VWWP1mYifyvBu6hCydJyQ==
X-Google-Smtp-Source: AGHT+IHhUvxby3RYWa7afuRM4pC8LsimtmZ8fC15mNiN5YTkrHSurmwxKyby5N/fieOdEgc3SRovvEixEjTaBRPmCj8=
X-Received: by 2002:a17:907:f14a:b0:a86:9ba1:639e with SMTP id
 a640c23a62f3a-a9029486e83mr1593941466b.26.1726509535241; Mon, 16 Sep 2024
 10:58:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: =?UTF-8?Q?Pawe=C5=82_Lipski?= <pawel.p.lipski@gmail.com>
Date: Mon, 16 Sep 2024 19:58:18 +0200
Message-ID: <CAB+6q+Ks1BVE-PAP0sKDKzjMZ4=Lfcv7LfwGrB9GToRTn24oww@mail.gmail.com>
Subject: patch-id doesn't recognize 2nd and further commit id since v2.46.1
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Let's consider the following patch (=3D=3D=3D=3D=3D=3D=3D are delimiters):

=3D=3D=3D=3D=3D=3D=3D
commit 8db0161b9bb897d9cbe68bc1ed8ba8f43f39da00
Author: Tester Test <tester@test.com>
Date:   Mon Aug 20 20:19:19 2018 +0200

    another master commit

diff --git a/3.txt b/3.txt
new file mode 100644
index 0000000..e69de29

commit 4d5917beba89d2e267ea632b7e78958b3736eabe
Author: Tester Test <tester@test.com>
Date:   Mon Aug 20 20:19:19 2018 +0200

    squashed

diff --git a/1.txt b/1.txt
new file mode 100644
index 0000000..e69de29
=3D=3D=3D=3D=3D=3D=3D

In `git patch-id` v2.46.0, this gives the output of :
85da93bf95da4433da1ce20a2b822ec3c72a1b92
8db0161b9bb897d9cbe68bc1ed8ba8f43f39da00
3a7470bbbca005289ab50c5297a4d7712cad5a81
4d5917beba89d2e267ea632b7e78958b3736eabe

but in v2.46.1 (apparently after the commit
a6e9429f728d088999b815c25adbd2f2c115e051 aka `patch-id: tighten code
to detect the patch header`):

85da93bf95da4433da1ce20a2b822ec3c72a1b92
8db0161b9bb897d9cbe68bc1ed8ba8f43f39da00
3a7470bbbca005289ab50c5297a4d7712cad5a81
0000000000000000000000000000000000000000

Same for 3+ commits in the input: correct patch id but object id set
to zeros since 2nd commit.

I've discovered the issue via the failing tests of
https://github.com/VirtusLab/git-machete, which relies on `git
patch-id`.

Best,
--=20
Pawe=C5=82 Lipski
