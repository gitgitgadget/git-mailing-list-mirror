Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC3902CA4
	for <git@vger.kernel.org>; Thu, 14 Mar 2024 10:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710412246; cv=none; b=MsV+XQe0EOUc025NPNN9KsQ8UMHQ/GnUzkWPdOFE410+z5DNPZvCgsIhEVG9E8tCwtIJbLIKA5zxYxjh9s+AW3xq48CuDfvUBxeE0mrmLw4dy+tiN4npkxobtHk+xmNeHMJKrelIfPHabCLOGYm2Ib4dH7OTmML8S/unRDTadfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710412246; c=relaxed/simple;
	bh=M2RXxSUaF74GHsuC7LBzBurknCESMC5V7OsXogDfKls=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=GnfOiyn3xO7uJnNzu6REYAIR0OAIwBDb0/bif0JR7YZ/Yj7cTorYxphGymrWPniP9sxRKk7VJHrmBRn3NJ5SotE/EPwNDyDqZtE1VepFZV+ap/wwC5X+U5Dsgz9KDwcXyS3byDmkBDqN6QFbr6enbL6/MBG0hXC0aCg5z6lOV+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=nh4ijkS4; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="nh4ijkS4"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-566e869f631so862905a12.0
        for <git@vger.kernel.org>; Thu, 14 Mar 2024 03:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1710412243; x=1711017043; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=M2RXxSUaF74GHsuC7LBzBurknCESMC5V7OsXogDfKls=;
        b=nh4ijkS4GeLYE4MmPoH31oyqengyB4wQLTxuADX2qBcvoX4jechN1UxFf1P9MaR2Ve
         XYk7tBRF9jVLPf2j/sEUSe2aJsX86igt8ddIZc/zu9g50Pp5CKOgOSRaRbHUBVx7vaGG
         4BWYpAATBpd7H/41zaGUi4eu2QII/UxZ6PJcpehYCZXfOyzgoXlc2dRcHT1FaBocSQuA
         2/khPR0xPfbC1J0t448qZy8obxu9Vs4XIEW8toYiMaEnBiYwDz+SADHLQkicuFNxg+py
         1bMng+UoUM9R+hYRoWDCCuJyWMpJPo/8Zq4MiMd++YLKHcIEKF4tMqziszB65VMaZDoT
         TXmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710412243; x=1711017043;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=M2RXxSUaF74GHsuC7LBzBurknCESMC5V7OsXogDfKls=;
        b=BQe9RM4QUwzoCB+7vtet48DKGqhb6tDR9wRkP8HWFqXFFPs9J5i0oBM9hRAntNmaPd
         uBOFqVrc9S3RYfCVSpLTypzSNvHQSUEI1gH5gvZ9vEugqGiAebO6WNHzPMhCA/TCHpWJ
         sabD6U6WCAfNfJTgwgz3q5Oe21AuohlMzu/tIXS/NvD4SANnIjKzx8G4JIyEkBiN9ocE
         bD0kRx0nO2KznEACE+N+inUPC4LpyL7KDVMix57OVG8i3UT61+zEigb2ZXVP2xP6gkog
         bGyzOlogNZ3j0wSM1l6zsdnME3XKjT4g87N6MFrsoCnCng/sQr84B+yCc9J+qMxX/DF8
         kp6g==
X-Gm-Message-State: AOJu0Yxfvr+LwS4THdGGk9g27i2KvZHkqsTWD4GyNPYTBRrABgjIb8wl
	pvs5xkS42zcQLXPzyNZPtHulP/cKgaTq9nGMbmlFB+IQzLLdtvnmAlYflm7YfAz4mNST+7AmSox
	QO0LH8bbqFpiIQbVXSfBRVyrfphLlU9LW9NDqrA==
X-Google-Smtp-Source: AGHT+IFnxYMe6PF3xdx8FPHqsUQNmgZ72UfKkrOoOnqBYWV2MtA/pSBcjQk6QtPCdOHnbnVbdFVrd/Ox4gp+jZ5hqxo=
X-Received: by 2002:a17:907:384:b0:a46:2b6a:d7aa with SMTP id
 ss4-20020a170907038400b00a462b6ad7aamr741160ejb.41.1710412242819; Thu, 14 Mar
 2024 03:30:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Kai <k.vongrambusch@googlemail.com>
Date: Thu, 14 Mar 2024 12:30:32 +0200
Message-ID: <CA+XMOBuK1_BNqgQRfCne8dVXKGPt+iQ9wt4iZqz0PgEqZ5UCtg@mail.gmail.com>
Subject: Git is not recognizing some merge conflicts and just accepting
 incoming master version
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

I am encountering strange behavior when trying to merge master into a
feature branch. Trying with guis VScode and Gitkraken, both are not
displaying all conflicts in the files correctly and are just accepting
some changes from master which are conflicts and break the code.

I am including two example files as well as screenshots.

In the first example, the conflict of the UseFormReturn type changing
between the two versions of the file is not being recognized.

In the second example the useForm hook is completely different between
master and the feature branch called hook-form, but no conflict is
displayed.

Besides trying to merge the code in VScode and Gitkraken to rule out
an issue with the editor, I also installed Git-2.41.0.3-64-bit.exe to
make sure it is not a problem with Git-2.44.0-64-bit.exe I was using.

I am quite confused because this seems like a major issue that would
not have gone unnoticed so long, but I also don't see what I could be
doing wrong.

Ayn support would be much appreciated.

Example and screenshots:
https://drive.google.com/file/d/1rUaoA1rCYFzaEYeQldTupinQde-AyRjv/view?usp=sharing

VSCode used:
Version: 1.87.2 (user setup)
Commit: 863d258
Datum: 2024-03-08T15:20:17.278Z
Electron: 27.3.2
ElectronBuildId: 26836302
Chromium: 118.0.5993.159
Node.js: 18.17.1
V8: 11.8.172.18-electron.0
Betriebssystem: Windows_NT x64 10.0.22631
