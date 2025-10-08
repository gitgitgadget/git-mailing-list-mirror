Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA8422ECE9D
	for <git@vger.kernel.org>; Wed,  8 Oct 2025 09:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759916267; cv=none; b=s+d/DCbM3FC1WjMk096kO2lHlwVTCaV77yjtxC6Zq9nCp44CKmDqtHrZOcyniKwb7jR9aEoOuE54WU3Kg7NfS3S1vhbwlNjDOU9OrUyl2DzgtvjRrswTbbZGXquUWdWZK+UcEeCM6F2xOa+MXJ1sJowXlIlF2GNuV7CpxRPY/Kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759916267; c=relaxed/simple;
	bh=z2l2CVUP5/YV1KixBefSGurQEG3qCba/YyxamkAL+a0=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=GH3M8k6HGltLb2CplIWQ4rCGq8pVvZCPx2IvnUT60lIBR5iVmci2VCos4kHjMNzM0v8SY9ltOtI92tj9RfA2rV6eW7pgd14nCQGRWHrgn7JSDYUC4E1LlAgxX7b8ulxRD/yu2yPtzn+9DMQvx1QFMhhWRIQomZOukkxwCyAmjLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W1TQFF6a; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W1TQFF6a"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-273a0aeed57so9333585ad.1
        for <git@vger.kernel.org>; Wed, 08 Oct 2025 02:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759916265; x=1760521065; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=z2l2CVUP5/YV1KixBefSGurQEG3qCba/YyxamkAL+a0=;
        b=W1TQFF6adfhdS1uiqx1dNxSF5EkUAbVtfc+N1Ah2DoyfimbcYwG2HWb3JjMGoCVKaE
         CMVh9b/6nJpmuAUTX5vTOq164TccjoJVWfOrGL6u8Bp5WqiRRURl77iUqx5ZhfuhvMHl
         uhrZCMujHx50O2kOUlEpbYWb/4Nsh6xFddc7zujSTdm/VDEMSuNuoLa/CwfgAiSKexHd
         ic/7XyKunn+eZZbjvhWsnNS2WtOlKgon/L32Lu2326n0u0QleX+hn81tsMRyFSdWkf7t
         BN7aA+AvT8luIndmoeai4Xg55GQQpvviAvqavXNLmcl2MSuxPOubRz/YadRJSDVx7YyP
         LuRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759916265; x=1760521065;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=z2l2CVUP5/YV1KixBefSGurQEG3qCba/YyxamkAL+a0=;
        b=RH2XRrz+NvnnI2XAXI6eC7MgHqTmG8HqzjyzPWqWGrLv6YikxTo8l/v+0+ckCJ9FNb
         AdVk40f0VruxHXhU/zYN/2xEd7Mhn0sxvZGNlktaHEO7gTPYTtt5i7irPDx60e0BdFyX
         999pg4CXBz1u+aaY7x4m70myo2jWIiBeAaXfj1MPsEc6JoLPALRD3yQw9JkDFp4RlJnG
         BjKw16CVXBHzoY6ye45Kjxm2g3vJWtZ4Kcsr8xF1lUsliKOTRN6EImwG8ZbaamQZxf29
         XXkUXX1MSN+UjSVOkpZX9iRAwAL6UjCOQRjdHLYPRXmDS2ob0ciYv55UrZH9asJrl9Lk
         wp3Q==
X-Gm-Message-State: AOJu0YyF+sRZIydL9eY4Mv1ZrHyTPXDxHKOmpZZh5HvNYfFOJoUZiW/W
	dK7HRTNOVkE8+6O/6A8EzB5gGLq4uXfMa6RGfODa3d8jrsmgFtov6blwBwhAepUPKac0iMVsoo0
	fd+0sME4nBmJrN5sfd7vUuBQ2gUvZQX7CowQW
X-Gm-Gg: ASbGncvhnDIZIdwx9LE8Tiqt3ybAcjnaoGosjDP/ScEWKH1FSuBXdqCKkLORoo25mZL
	iaT05t6Hk1cC5A7gD0vgQ3DGPEBLZUoYf9OnFgNay4da3V/F6PSoptEnUUmK1UP81GaoUTLcZDk
	PYHemhAAIfa7tekpM0YWrZe43susyq7ihG3oehmV/k4EQ4Il3gsCDwH60o/xzzdZtQfNYSYhg8v
	r3Ct+IZwvHESCYRpNZOH5a4rc4br1m5CcdCwMA9Z7zvdQs=
X-Google-Smtp-Source: AGHT+IGo0FtlNt4SictZkNBWKShiTK4rOmx++K/0SK/BoVDjEljwjyyzw8sTRpQmntJ9zdIR7wE2ESy1VNFst4g/4Tw=
X-Received: by 2002:a17:902:e550:b0:265:f460:ab26 with SMTP id
 d9443c01a7336-28ec9c0c7d6mr89219705ad.3.1759916264839; Wed, 08 Oct 2025
 02:37:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Bello Olamide <belkid98@gmail.com>
Date: Wed, 8 Oct 2025 10:37:45 +0100
X-Gm-Features: AS18NWBqqG7p62DVpFGUo0kYW9Q8Bbu6xA8zEwssBETBpL-6pTZCWKsOEx-QEKA
Message-ID: <CAD=f0L-nH2T5PdJctHHUpDXP2bxiKvt4oaas+ndsmySecXhHdQ@mail.gmail.com>
Subject: [Outreachy] Introduction
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello Git Community,

My name is Olamide Caleb Bello and I am an Outreachy applicant in the
ongoing internship round.
I am excited with the opportunity to contribute to this great
community and I am interested in working on the "Refactor in order to
reduce Git's global state" project.

I have also started studying the materials suggested by Mentor Usman
Akinyemi and will look forward to interacting with the community while
submitting quality patches.

Regards,
Bello
