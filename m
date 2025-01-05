Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 679851F931
	for <git@vger.kernel.org>; Sun,  5 Jan 2025 09:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736069981; cv=none; b=YVnfaBo5/GPohFnYcduls558KReEW0vUH2kgCoc0gSDBpsxrG+/cLuxkKtTHQImRQ0YpWs9Mcqikg3iBvjvS3UA123S2f7GoVeBrtTNCPZ7sDWQpGX5EeBazJYzUb53KgtK7ltQXmcgAWPPusYpAQCrMJtcCValYOBtx5q5kjQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736069981; c=relaxed/simple;
	bh=zYvRqsnqpTV1ZxGQaIKDPai5a0+P//ZdIFm1+8tPiwg=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=JGhrt0BCBRWv9PU2Je5PhQ0JMT1vnnKqXaXAynXX/ynlTlWljkkQRFMV/J3kwbiWeBuVR9roql1/xUDLAcxDmb6jNl/m5f2MCh8aS9aFJr1R6Dmmko/aVGUQo8qVin1pYzg5piqNI3vWzS9wyXgciFx4LtOF3hXnP+Vzh4uKkXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CtMG+yvL; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CtMG+yvL"
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-303489e8775so153776351fa.3
        for <git@vger.kernel.org>; Sun, 05 Jan 2025 01:39:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736069977; x=1736674777; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=w8fFe1osaep9OYohMfE+0xhEeCwyLqCS01JvTqQ8Evg=;
        b=CtMG+yvLgDbdpjdT/F0NEbaU5QTh0YIrczlt/DmpT90Msg8+TIq5aVpzWaWsaGGP6O
         mp+DWhokJL1C5ZLUR0bEwJWRCMa1R/WlB0zH0kLgincmwLLXAL5nVYbUY9sjl6ROM3ZO
         5ETBB/T3T7jji8lGRD6IEXyxCs4ZZeSkxrfBK+sCmhikE72ZLA3kSxAQHwOydMyRqpCU
         gG5FN3AaU8L6nJrTpNDdAZhYxATe6rLPy1jhiI/j4hMN+kM2WQkGp4rVLZ4GADMn9Dzo
         13XoswQoeMN347F3EB4qSq3QTN+Z/lwTsiyYreTR5ReMydqMnjStFuepE0SqxGDyNkQH
         C5iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736069977; x=1736674777;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w8fFe1osaep9OYohMfE+0xhEeCwyLqCS01JvTqQ8Evg=;
        b=JHgo3bGuLdHGntUChyUszN5mpbVvWGCc7OyIhfmHm3Aj+vDxY8ursRdLOPG8tS8JDK
         bJ77phVB307sg15K7gUUFqr/w/JEWltK9bdTku8qsYUFu4UBkEmSvUe4ZW9OXqsvbDjd
         F8z6/fCl881Awm3ydHEbT8hajBqrYBXKAcq+Nc1YQKie4JxILCpwH03WSAbyfvlBUnN4
         CzQvefB84dUvCCPN6zYzr4SeN5x+CB1klcCqJuGYUU27T+dW3PtNhu+g0jAFILOY0td/
         LLGSwHbbLfMbInbG2wiOdWYH3JSrNpZLONRx/1ugbXjiI1YkrmH7MgBJj06oZhVdJ0K5
         p7vA==
X-Gm-Message-State: AOJu0Yw4UOUvqcZqt8Pzj+NTdv0SbgDXxt8rky4Y9qSP5mx4PHdag3e0
	nZI35j2qcYwZ7/dcTY7QrGLGjIul+o9cra4b3NFhCG2aUng/GgxPLIlEntjy/2DCI5Y3VChTgTV
	Iq9G24yUbgPD58RTAwLnBbdnsVE9ivN5mhjA=
X-Gm-Gg: ASbGncut5ErJTmCo0OmimAfmsfimtdZR4MaZKlhZiy/1DlFuWdysMgM+vabowUprfPY
	h9d4MePNVGQHxJ4UUBBy3TYx1vzwkYUffKOzhZ7U=
X-Google-Smtp-Source: AGHT+IFrjz5UBmbUwNCnYHBTsyZzsSNlPTTmCDfY2SSeXgLHoCfelcfSypwUtCmdp1jhEm/zUuiYiS/KLAugO/2n1lc=
X-Received: by 2002:a05:651c:f04:b0:302:3356:7751 with SMTP id
 38308e7fff4ca-3046865f080mr164921661fa.40.1736069976958; Sun, 05 Jan 2025
 01:39:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rhythm Narula <rhythm.narula26@gmail.com>
Date: Sun, 5 Jan 2025 15:09:25 +0530
Message-ID: <CAKz1=ZOY7GziF9DNTLXv=G+OX8_vAbvOYS4L2s-D2C3kpr-zOg@mail.gmail.com>
Subject: [GSoC][Newbie] Test Script Enhancements
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Everyone,
My name is Rhythm Narula and I am currently working as a Software
Engineer. I had the privilege of participating in GSoC 2023 with
Pitivi, GNOME, where I completed a project on generating closing
credit clips. LinkedIn -
https://www.linkedin.com/in/rhythm-narula-34b652191/

As someone who uses Git daily for version control and collaboration, I
have developed a strong interest in understanding its internals and
contributing to its improvement, allowing me to impact millions of
developers worldwide.

I understand that GSoC 2025 mini project ideas have not yet been
released, however, I have been exploring 2024 mini project ideas and
noticed a few areas where improvements might still be possible. I have
outlined these below and world appreciate your feedback on whether
these are accurate and worth pursuing:

1. Avoid suppressing git=E2=80=99s exit code in test scripts
a.  diff --git a/t/t5801-remote-helpers.sh b/t/t5801-remote-helpers.sh
index d21877150e..3433fcfc44 100755
--- a/t/t5801-remote-helpers.sh
+++ b/t/t5801-remote-helpers.sh
@@ -271,7 +271,7 @@ test_expect_success 'push update refs failure' '

 clean_mark () {
        cut -f 2 -d ' ' "$1" |
-       git cat-file --batch-check |
+       git cat-file --batch-check >actual &&
        grep commit |
        sort >$(basename "$1")
 }

2. Modernize a test script
Is there anyone working on t/t5801-remote-helpers.sh? Can I take this up?

Regards,
Rhythm
