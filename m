Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 364718174E
	for <git@vger.kernel.org>; Mon,  5 Aug 2024 11:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722857534; cv=none; b=Jg7tL1I+voCyMVT86Mm7ASOX0BsY/c9Y+raY+9eKl0iEuWK/sbNyebLazLC5JJkogSOx9PVs00QYxsHWsYTzo0Adb63znfh5fRcl2e1qYjtbr3Sdh/O5SnaH+0ch+v9jVlg1+jU96paLyl1LKNJS2QntpzGVaZKWdB+cFpTkwFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722857534; c=relaxed/simple;
	bh=LTlkgUizsMQL1lPcwY07BOshCEAfWAGXITSZRdgJ18Y=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=U8MNqZ8mf5L0spStrEE7iQY0RuMxUKvB84sWzOcJo1anv3dYh18lfpqHzgCTYGxpcBbLdE4M5/r205dF702wqyRBybz4956m5/+1pkicZDuYDR1OXCLd589uPC0507qFOPSpGgAhbHOPX5Tn3kuhkkIoxfD0YRmf5a97RSXiAtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dtsfN9h/; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dtsfN9h/"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-52efd08e6d9so15154690e87.1
        for <git@vger.kernel.org>; Mon, 05 Aug 2024 04:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722857531; x=1723462331; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=oheA7KSBeiDcuGeLBtdYBV1lfwKLBDpTPiv9+zF+K2I=;
        b=dtsfN9h/zZUvdo4t6Q4tmW0XbXoYEJw+djtXjtUo4youwLv6gF7Os4jAseMs664awW
         TrR4rGZ55Y6dtMt+pvtKZUUWe5ohWOxAboZcG1Ew+k5qX2QSOZMEwISHQUqGYA4YecW4
         wf+Q7Z8i3564XnZ0gOnIYNulMl+kfh8ovlnMgwBmtdUVtN9lckHYckviLj8l8wnFYZWw
         6g9QE7MDqOjgH3CR3L29+/aYfY4+JUbwu3lIDYHlLoxP6CMP5rLyiwTNzNWUxc0pJjtw
         +V4/NEw0kknCDCVhxoY/4NF4Po1BrWOHJ4RvJr/fGylwPibX+KYpT2gPKoojTQhm86ei
         /YJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722857531; x=1723462331;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oheA7KSBeiDcuGeLBtdYBV1lfwKLBDpTPiv9+zF+K2I=;
        b=KKCKR4Hypwc1CrA6qNUMHQk6ue2K371UN+qW6b/X5nnlVLOuH9POWVSh0aucWAtUvQ
         VfwaGhe/7yEND6pUoiA/Me9jQ4r6SCHyfcHVB00H+CeEKg4hjzNByCs6QcbJ/iKDcENY
         ZGoctfb0qMiUO3VZqGo9sq5t7Kn+l0Ix5nsSIbcTb6qsHx2Z5T0Wlp9G9RDsISWDPb5Q
         Z+MCK/cl5jfL0qMum90sksDpeK1Yq5l1f1CIeDwsS4FfWsyGFHEg+lfHV+rRvN3Uyz06
         z51PhlBm75Yh+K7BzrAiQDlW9jskz+jgHj35WmJPEf/WwW1cPVr5pESXeJgBSQBjVSXB
         +Xzw==
X-Gm-Message-State: AOJu0YwkpdXq5N1895vuhDHOKMzGBh0Zi4wgtrEYz3gOZfs91MX9KSwo
	Dvtr/yBEoT7IzKcaa7kg1oZd1sgahdzf+eqW/I7BUskjej2sWNraoofNOflojLQ6pJiV/8j7OU/
	e4rzo+2Ni4XbPF4ujCrQzesdwH0Iu6u1fDzc=
X-Google-Smtp-Source: AGHT+IFR+9oco4Mt9APZ6UPeqrC0DRhiIfpVAcjgUYAnlf7DukAD1nmIYtJSSSQVmNEJQoEpqBmWDUzZvSRHTo7GJjE=
X-Received: by 2002:a05:6512:31d6:b0:52e:9619:e26a with SMTP id
 2adb3069b0e04-530bb3a1d03mr8477454e87.26.1722857530504; Mon, 05 Aug 2024
 04:32:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: =?UTF-8?B?SmVwcGUgw5hsYW5k?= <joland@gmail.com>
Date: Mon, 5 Aug 2024 13:31:59 +0200
Message-ID: <CA+osTZVApTAMogBDMaPDEVViJHrFT=BOer=Py4fjTvpsifzfKA@mail.gmail.com>
Subject: 2.46 submodule breakage
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi there,

I just upgraded from Git 2.45.2 to Git 2.46 (Git for Windows, but I
don't think this has anything to do with that), and it seems to have
broken some submodule stuff for me.

Specifically, when I do a recursive pull, I get the following error
from one of the submodules:
    fatal: Unable to find current revision in submodule path 'path/to/sub'

There are other submodules in the repo that work fine.
The only difference with this one is that it was added using the
--name option, so internally it's just known as "sub".

Looks like the problem happens in the final pull stage when it executes:
    git submodule--helper update --recursive --rebase --

A recursive clone with 2.46 works fine, but any subsequent recursive
pull gives the error.
So far I haven't been able to fix it, except by downgrading to 2.45.2.

Any ideas?

Regards,
-Jeppe
