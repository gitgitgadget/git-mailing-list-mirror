Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57D992905
	for <git@vger.kernel.org>; Sun, 19 Jan 2025 05:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737264565; cv=none; b=iR5lh0II7KaLXOQaP0p4JwAGUojufR2Adc5ncydsmEiHkUAd2qfSq+qDxQ/FUlhLmZ4WRvuxWwApQc7N4JHP+NbsbDuQfx5MLiTrTrclb96rycPz4td0OsaqjzopKDYk1FtD5IWpEhFCFiI3aiR8dvLV/OlSz2/lqZtORmkYzJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737264565; c=relaxed/simple;
	bh=l3V6shhJX+mgt1jUTYOlNr9xJH7jcGVvmaNwwO6enW0=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=eh88xv8zkuGC662KYiXlSS3OOY++pVacP3aOcnmgeQr5/35VFn8V7TeFUu3kQhCYXMgcOI46417YgZkQMGcSI8LC0a99+gFi+xGyycRFRHGomutLp8vnbrwi5FxvPGXtaa/hgC57NmUk+XACNJrdjpI8bm474aeV2q6U8m7bKKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HLMUWhCn; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HLMUWhCn"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5d3e9a88793so5855106a12.1
        for <git@vger.kernel.org>; Sat, 18 Jan 2025 21:29:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737264561; x=1737869361; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=l3V6shhJX+mgt1jUTYOlNr9xJH7jcGVvmaNwwO6enW0=;
        b=HLMUWhCnOUjVXUrKjpXj8xbwKJpyYUWa4qcAzyVNLWeUV5WlB/iuvqJrPdpxNExWNu
         K+sJaHDI4PkuTeuAzp1pXYYjDJlmRwVLHj3UFJ1bp82/mraUQOrjkoK+hmpk50RIAEFt
         1den+75+hAqOqwu16jMpPwxHNfj7k0S1O3jsGRmGpJE25k3EbCLsAw1++1asDp2vdCgh
         xgPNoyTeDozLFgODYqIwm7oHmhqqNntdD3gpfSccz3Qb+dLcGduVFgHVcO3/+iIf0Q9Y
         6HcRhmlggyYaw08Fw/P398V7mcB8gw94Qw5pZUyVh4gBfFCfdPnUCdkgGA4hqWrGUkqi
         Tzxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737264561; x=1737869361;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l3V6shhJX+mgt1jUTYOlNr9xJH7jcGVvmaNwwO6enW0=;
        b=DlDpIuVzwIWQ2byOFa98Z/zdh977jgeJ1T9h0BAXLo5020sPkxs3V1zuK/QXLuQEle
         IxX96EaYECk9wW7U5M3MIyCKHcHf7AZDa9g47lM+GnJ20bRwdwsFdhR0kfnwO11ILG+b
         Luuavh+qJp49K/85nZuFAtqs42SLmYjgD04RX8PjXrGj56ztOtvA+LqDiYynNFOfkvRf
         zOfUQg2NgalWTVlGG90QIj/mPpKsO4UnwrCIItm4r7n+g9UxyyDZfhlgRzNpt/08gj4M
         cYfsPwXk/71pKb2uqP/kJT3TgxLnsubkZpEbesaNHSOuxvffWoeuSGJlFhAW6WseJUuc
         A0QA==
X-Gm-Message-State: AOJu0Yx1wPnHkMBV7lAy9GGEKb3lCYM17ToTodk8a83jpNhT03RoFlKY
	U8ECrJQnp+iFnRs3IiU8UHk9BDtFRnfvnTbNmSu8g1zCYE11rlB3piDt5rVZkfU4FjN51Vq7gIe
	6Oh6ROt3Sa3p6qgkJZH8IwZQkzUy5dxq6
X-Gm-Gg: ASbGncsh7wYxMQ6WpO0q0Mqodgds+PCVNt8BAg58krKPG/ejzQ0mM2ZQcPezIULgtbE
	MqwfS39wc21irYV1yqrJKwJu0e+2JVHJOKS2xfGnMJQ/zU/yeviQ=
X-Google-Smtp-Source: AGHT+IEFVouO2lYBdtA+M55R6+eh0v46XKlkFhwYKzSwyp76T7+UGdfYB+Sw+J7+wl+3mNZof83B3yLFlV/8EKQ0RQs=
X-Received: by 2002:a17:907:9707:b0:ab2:b4bc:41ef with SMTP id
 a640c23a62f3a-ab38b1a2cbbmr641239366b.29.1737264560845; Sat, 18 Jan 2025
 21:29:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Al Grant <bigal.nz@gmail.com>
Date: Sun, 19 Jan 2025 18:29:09 +1300
X-Gm-Features: AbW1kvauP3VZmElaT_Zk4Lw86WTvxPSm5cbY6aXrLPsI_rW3Mms-lXkLlftKnJI
Message-ID: <CAODtcdcTjquNUBaTWKzyy54J5NoH7WO+9uMzJ+wWRDf0Na3OPA@mail.gmail.com>
Subject: Rebase
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

I am looking for some assistance rebasing please.

I have a feature branch which has the many recent commits and a main
branch which has not had a commit for a long time. I want to make the
code in the feature branch the code in the main branch.

I think a rebase is the command I need, but the exact steps I am not sure of.

I did try this:

1. Sync both branches with remote (github)
2. git checkout feature
3. git rebase main

That resulted in the following perge conflicts:

PS C:\Users\AlGrant\andrej_branch\test_fft> git rebase main
error: could not apply 1f893dc... Make project runnable on Linux
Resolve all conflicts manually, mark them as resolved with
"git add/rm <conflicted_files>", then run "git rebase --continue".
You can instead skip this commit: run "git rebase --skip".
To abort and get back to the state before "git rebase", run "git
rebase --abort".
Could not apply 1f893dc... Make project runnable on Linux
Auto-merging src/kiwitracker/sample_processor.py
CONFLICT (content): Merge conflict in src/kiwitracker/sample_processor.py
Auto-merging src/kiwitracker/common.py
CONFLICT (content): Merge conflict in src/kiwitracker/common.py
PS C:\Users\AlGrant\andrej_branch\test_fft> git rebase --abort

Which I have now aborted. I dont understand why I even have to deal
with merge conflicts when I want to keep the code in feature and make
it main.

Help.

Thanks

Al
