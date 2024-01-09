Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9822A39FEA
	for <git@vger.kernel.org>; Tue,  9 Jan 2024 15:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G9VOJps+"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-5c21e185df5so2288327a12.1
        for <git@vger.kernel.org>; Tue, 09 Jan 2024 07:34:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704814459; x=1705419259; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5zpRVmOYNHh4Zh6l14pHXkTzQeAM2DhtGWUCvWWRkA0=;
        b=G9VOJps+BKmTAHg1NV8h1R+zfNX62fvbTL51hYroPprv2KV+rkBThbbN7UK426zUtQ
         LBelYG5n6JLBbwWd3nKso7rQX9Kf4SYmiAraJD1DsM7TJQYr58VD/cVGxOgZsnnfQDbi
         1Ke8rEl0a+oKMSw84WHBgt3op6RFRTmOdAu+7XbGsi/E1JkN2MVLbR0jLGeuymyz2QlC
         qo4Wy3WWXR27FexSceKVQ43bECCG5HLwZMfk3AB3u1cz8ljRLcEP0U6CAyy17MggDCBT
         jtUs5/MitkNVPmFyWB3KbQ2d+NnltW591dQ8FsbnxjmPViihiOg5eEo7DuGObv5ddFvp
         yDVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704814459; x=1705419259;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5zpRVmOYNHh4Zh6l14pHXkTzQeAM2DhtGWUCvWWRkA0=;
        b=ipYxyjDn1czh1R/yINoEyBoP1lbDvn9y00Rx/XjQNdmJHER+C9xLUyh8W+LSqrJljc
         MNpLRJTFbetIzqK1KPRijq1t0/Z54to5UrM+vaMxjYgPPHU1NXcXeNlbkjPr+hjdSMlC
         n5mCR+7havqD/EO72vksudf4J/lTXTikVn3EQu7A59y+Lj855ePuTbu+bL9vHuX9PEUi
         VVzdUpRflyvAoxeAc/c/wu172kh9q7v9I+ACaCLItw24TusezFr2Erjl767WoKrLy7Rj
         pSsB7MBcdK4Cv2mK8NILXtW+a175rZDdTZc4khSEYQzFUSqlEXeZpiUoQMfU7pDmVOXI
         +m+w==
X-Gm-Message-State: AOJu0Yy69zyc8rD5husi0Dsk4ibkLdpujB+NbHbMCekW6nJZvgjOAxnf
	QjB7S5lvua7VnlA/w9mscG+JiiidKG+ZIYi8ZLhW29aYeaZA8A==
X-Google-Smtp-Source: AGHT+IFCqqU0DCF24tDo8QhMjYf/S5weP5GYD3tjdRGM0DRzNEoJQCL+XxsXqIK2hjiQUReBBgAfUN4BnmAwnOo2XUU=
X-Received: by 2002:a17:90a:602:b0:28b:dc75:bef8 with SMTP id
 j2-20020a17090a060200b0028bdc75bef8mr3431005pjj.22.1704814459432; Tue, 09 Jan
 2024 07:34:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Domen Golob <domen.golob.px@gmail.com>
Date: Tue, 9 Jan 2024 16:33:43 +0100
Message-ID: <CAF6dN-oEy-svp+6Bw_NAeOMrWc61ObcZ4Q2huVj9PPK1EQHquw@mail.gmail.com>
Subject: Bug: Git spawns subprocesses on windows
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,
the problem is exactly the same as what was reported here on stackoverflow:
c# - Git for windows seems to create sub-processes that never die -
Stack Overflow
https://stackoverflow.com/questions/69579065/git-for-windows-seems-to-create-sub-processes-that-never-die

Additionally I have found out that:
- a Git for Windows subprocess is created for each repository and
every time a git command is issued this process grows in size and it
never dies.
- you cannot delete the .git folder from the terminal, but it works
via file explorer
- deleting the .git folder kills the Git for windows process
- creating changes in several repos creates multiple processes, and
sometimes the process is created as a subprocess

Here are some screenshots:
https://photos.app.goo.gl/oinHVY1NAzHChU6CA

Hope this helps,

Thanks for making git awesome :)

Best regards,
Domen
