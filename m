Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63D6D1DED5C
	for <git@vger.kernel.org>; Wed, 11 Mar 2026 13:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773236421; cv=pass; b=WvJegALX6DR6913KKJqxXNCLFjwYNIB4pgRb/Dhwds4wmtbqbvWoyxAcip2AVGrEeq240GjQLHLadtVDWGHm65YE7LiObp8+xRFizazl0TBQsKG76MnCtrCDTEJYc3PUFcbuvNjSUXAr+KIKCNJCByx0GAYI/smy4mBHvrMnZ64=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773236421; c=relaxed/simple;
	bh=21j+eixCMz2hmROCgZ2amoBjDma1Ts5vu+zX7bXqg/g=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=UzoeY41CfqrsGSVGadcK7ZdENnZiW7M/mNrt5Aq/B3L3TBOKaMps9ihZsPmGFPhWOB9UeagsOK+ICh2PoxPm7QJ+/iDNr9t3JDjVaLYAZ22LWFSmv6Acgu1obyXeY2jMc3SfmMhuey3XwYfgx2okPR2Kk23LCWZ61B3yb9nwNHY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=COS+WcsH; arc=pass smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="COS+WcsH"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-358d80f60ccso7808304a91.3
        for <git@vger.kernel.org>; Wed, 11 Mar 2026 06:40:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773236419; cv=none;
        d=google.com; s=arc-20240605;
        b=XcwldhP+JKoZSnQOQKeA/xZJXuKOf808TVpNJU5v0V8WXv70FyZ3+0dsgsXju2GZHn
         jHz4VbshHNQoZt/MXFmnGIfJIlxQlr+Z/XXhrtJ0IZoBqv6Aocl6OH71PnmiuzWA2w1X
         FU+iobmhGIE/xQ88HR0fW1MbNmA79b6pPGIrTT1UN8eMmH884kkllj1O3GE4kN1sI5rk
         p9IFwqdxqxUFDojteW4ZgYfEagOWKTevXd2QfaJ3y+1efuAkbSGakfU3nHE4V6R0tkV6
         2jANWMZaHX4I9zKMIuu2B/Ok0ZYFvPNRGmFA4sHf0JCcDerNpzt7mipfeSjkqjl1C9Q4
         0QuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=UmkfBcocYqE3+RQ/J5+exjk+kyFJjn+xlXLN0kBdaKo=;
        fh=WfJB1YkHjfxkSMCsogHMbYc3pvCTmQRpLXh1eGJSZoM=;
        b=DTO/f/6J7/16Eic6+0WcGe66hRTj8LU0jjPuzVUgeSpvkTg1o4ovD5m7EC34/dbmbT
         ap3k+UUF8Hh9v3i1zfNEQ8NpT45CAjCaxd4hh/a+2tp8ZQwApKzCO4ko29+ib+4EZiUp
         Vty42QmNIuW/r6w1pbxjxG+IsxU2D8TdjZUbcjhqqhciVZxixHN8ql6EvXbLltkJScz8
         DqNTyNYc0QQGU1vJDia8h/6cRw8tTs8NGxdD2bRSkt0lfdnT1TLrllr94zJaQOCS626j
         aybe5BLWnNpvQcK1iT64j2JjD4boqiCp2quDFpcD6Dc38RaqRspdfkDisyXMzuOsSoJU
         y6rQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773236419; x=1773841219; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UmkfBcocYqE3+RQ/J5+exjk+kyFJjn+xlXLN0kBdaKo=;
        b=COS+WcsHGTA9V0epxG/XJdk3mq49k4/3B09z7xvGnbtggnYmcEcl5lX6xeIcQenAat
         HEPkuOoDM/LI60c2Z9bzzuaWEJnDmsM2J7hVp/4nCsJZ4Y/6TJuAH+5ClApwzuZU0/K8
         v+WsHRUeKAspeE6EYQUVhF2+c/L1LR6KfaU0sAYjvaXZ9vVGF9FknZRRylhI/7NKtiqC
         q2TmhXA3mk54xOKU9hSLgtte3iBdCfX0Bj3HQFHEYVYriEi4S4LrsaR1OoNOOpX3XYJt
         VCVnsEiWjurRzXicAo0EWmBkaBHRDVnkNyDxaf7A7A0OFEH8871dVU3xaRBsOx39Nhdj
         sabg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773236419; x=1773841219;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UmkfBcocYqE3+RQ/J5+exjk+kyFJjn+xlXLN0kBdaKo=;
        b=qrvuusQ5A9W4zY097nvDrCa5m/6W/N4NSIqNrbqarJjLtdouXJm1wxKtqJama75rGj
         SKIzyQnG9VRPOkEVHPpWZRZZGfyXdqxlOwFv0iayorU0sRs09J2hxnud2H9zup5SCmHg
         /boeEV61x0EMAk1dEphYNyI4Nn+p56hIRKrrJXq8btQDzE7nkbMeETUN9T5pncrRtaie
         kGT489Oxrss/CucGOUncuPhb3qbqj92HA70YscLA2Lzzq2ZYrfF8eDYGtdgMnV65BjU2
         YaDESFdhkwouefIs73Rf3tqpvu93bWeWbQ1J+R5CPYpoIv2p7EDgspe5Q6E4j8yeIo4p
         p/UA==
X-Gm-Message-State: AOJu0YzLJ/6uhU67yE8354oXFdv4rWvBVNt+VSS+/5tkmMlnUSNxd6Y4
	egmaI2t5+LeFitYrU/p7JVTipdLmxadhpN3/N37gi4WfoF0AaWrNdFc76V37Ldl5uqxRsbGFaVH
	fHAyzTSVsxxWwtR3FDUoKP+GuDeGK3kcva5Td
X-Gm-Gg: ATEYQzwfmMTXrHvXOGMB5Uro8GfrzBCYFsKG3c4xqg/l/AYY9jaP8xlzx08eeX1UWf8
	KhWbAByWoeijyeMW8sKJwln4dsJHVq28jcLJuJtCszpQQRjC24KEkN0EJ2qPDDk5fQxf+kwnoSp
	+X97/qNvPmfXfeHaQNa1EoGS1c3ZGiLcWGbuM4mL2whHlZAXft/0PVMatkkn2eonZdG086AnWJY
	YN8ySWoDZMi7nFw5vP6Ri2Y/EhwHJFLtTUYBrWuYifyOjN5M1FGCm4AChikuqi7oL1GKrJsBYg0
	rewR7wTVFT1dBBB8QsFwIXRNPZ5T/iqLxJNz/3Sip6r4cmq31f2EQ9KnEhGf/R2yrgZHL9sa5hE
	jj7YByJvUJlZumgo=
X-Received: by 2002:a17:90b:1a87:b0:354:bd08:480c with SMTP id
 98e67ed59e1d1-35a01353d20mr2572358a91.30.1773236419339; Wed, 11 Mar 2026
 06:40:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Wed, 11 Mar 2026 09:40:07 -0400
X-Gm-Features: AaiRm51upgslQeyZAe23Nm8X1BXL2GP5h2XLrFtCKqprrS8FdYrJMP0K-MLL0cE
Message-ID: <CALnO6CBiY8NTAigP6aWPq+gQ5+VTvFJFOEaGZQRuJXTtgB7YjA@mail.gmail.com>
Subject: maintenance crontab entries not accepted by some cron implementations
To: Git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

In particular, I've just reported a bug with fcron [1] that their
parsing is broken. Some workarounds are available, and I hope fcron
will fix the bug, so no action is necessarily required here. Just
wanted to let you all know.

[1]: https://github.com/yo8192/fcron/issues/46

-- 
D. Ben Knoble
