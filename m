Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CD041667E1
	for <git@vger.kernel.org>; Mon,  1 Jul 2024 15:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719848056; cv=none; b=tEH/N13SJEvZNBAmLLuK7kdn5Ij7C7WiyBzYgqIHt/m26CpF73c9FpApxdeV2ySolDPVVfMzeUdgm3sqNAYpvW0748tJbEOor/eN30PtrgbZnHOxA1AB8Lw7oeqK0KCxC8RyUE506yyrcqsv9adXd34PQceMAX9DB/B6vPYYGF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719848056; c=relaxed/simple;
	bh=KQlk6AZVdY1mQVBSw/82dzflPauCL6nhEXreHivnUeI=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=uaeUs7p2k5L+3EcbVvribWrG51xTl4qPa3hLC0M+iqH/WR4qgHkr9LfU0wDQNcbahvv3x0zsB3FbkdjJtEyKACVNBjqcXhJwq+VhNju1Z80FARa7XfM7cLt2iU2N1cXILw8UGlQLUmZNgQaeqaZHdEL5YoROA4bkiGEC5qUX6Dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bucknell.edu; spf=pass smtp.mailfrom=bucknell.edu; dkim=pass (1024-bit key) header.d=bucknell.edu header.i=@bucknell.edu header.b=UmOeuETj; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bucknell.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bucknell.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bucknell.edu header.i=@bucknell.edu header.b="UmOeuETj"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a724b3a32d2so358185266b.2
        for <git@vger.kernel.org>; Mon, 01 Jul 2024 08:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bucknell.edu; s=google; t=1719848053; x=1720452853; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DPxGMdSN2Uz6AIZBvUzKTgEOy3lwO2wq6BzSZgPxpdQ=;
        b=UmOeuETjqMeOQLdQbX+7dILjvu4PxOXEFzpAL7bF1bdcjKA91RrwdVi4HCbuZToV0K
         Urp3JWM1S9+CXVH0K7ffYkdOmn4msYN4qkPuo7JOy9J1KiEpXbba4592DifkG+2v3Xz2
         v6SEHN0C/k2qFdKRiCXJ1HlEPp5qmqp60gY9k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719848053; x=1720452853;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DPxGMdSN2Uz6AIZBvUzKTgEOy3lwO2wq6BzSZgPxpdQ=;
        b=wmmr+qtDD7zjgYY13KCHpaXfp9DSFIkhrhfF3r7/OqQIb2zAeUHrBkSa3HjvKMpPCw
         P6CpGbE65AxA4lABLXJtipgnITpKNL7rUU4pG1XvmdBJLC5PqnJIUPUD2LrmULWWgVpF
         yBCFvstO77c2UEaT7LZCFw6rOZQcbFNGpFpHdQz3dnJg6jL6xJvyDoF1G4vbNFKbxu6M
         hx5InplZu8HqrCQdb/pvAi/Z6ojZUVABL4uaUjABVcoygGiaUYCnEr3DMsd32zozglmz
         Nin8s25pmBbHfQidmemzmg4wMI59Io6KJz9AvYmzq0ky5a4NxSGoSdUJgA2YZ9Z4xQw4
         IlEw==
X-Gm-Message-State: AOJu0YxfWgY6Sft/S7nhj+WdU6LUb4TwHZO2lU6TqgPzMiXLrosPA2s2
	Bmxi2J8J4FJFHf92FCOfOL4SY5G0ypeufO5FN2MQscb8oA0UWrv9Lh3fFD4E6EZf1lLWZ33JQYF
	1CtTI0TAhBJbQM7exPBV4PaO6fgX/t+g5axqnzSQpZHsAWahP/7P5T/aPZSJi8UBIeaUaVc0+gZ
	CWzkHi974TEoMEKWpowylVCyONCFWJXV9Y7iNN6uLGD4avGbIRd4xCDIYQIYODCtNUMFcgHjTkz
	+DOAFfu65a3/U37rBIuvaC7m6Jb7NvbQIQOz3dkS6kSKrWjRuKF5A==
X-Google-Smtp-Source: AGHT+IGWO79twga1KBYPF8yVv7/KIF0T6hZarNY6b3+tVFr17Fhqp4/nColN1k7mdcsVDYnSad6HU3Dk+xeGfDA5bSo=
X-Received: by 2002:a17:906:1e0b:b0:a6f:38:6968 with SMTP id
 a640c23a62f3a-a751448587cmr336480266b.32.1719848053008; Mon, 01 Jul 2024
 08:34:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Alec Sanders <aws022@bucknell.edu>
Date: Mon, 1 Jul 2024 11:34:04 -0400
Message-ID: <CA+Gods=0N9yYZ2tMSiV2GRO2uwpQTvvWB=Gcv9CfS4XrMYWN=A@mail.gmail.com>
Subject: Trouble with Gaia binary files
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-CLOUD-SEC-AV-Sent: true
X-CLOUD-SEC-AV-Info: bucknell,google_mail,monitor
X-Gm-Spam: 0
X-Gm-Phishy: 0

Hello,

I am running into an issue with Git and Gaia files
This error persists when I perform a git checkout or git merge.
The error is as follows

error: Your local changes to the following files would be overwritten
by checkout:

*Insert filepath here*
Filepath directs the user to the project folder and within it, Assets,
Gaia User Data, Sessions, ... , Terrain data, etc

Please commit your changes or stash them before you switch branches.
aborting

Thank you


-- 
Alec Sanders
B.S. Computer Science
Bucknell University 2025
College of Arts and Sciences
