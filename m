Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F9DE5DF09
	for <git@vger.kernel.org>; Sat, 10 Feb 2024 19:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707594771; cv=none; b=TQF3ZKDOwGej/exMDb7mruE/zADgK6jJJvM5E+xVIjLLFQtcRF0y3DWh5heZ16Wqjg2413GP50FLBHrCBwgI77YBordPBidwfRf6JvEb4sX5pa6hOz/DF4hRv0FRHjFiXbSk5ydDPQwhd7IHrEBEZvp7LSDLZzRkACGTsJfRXBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707594771; c=relaxed/simple;
	bh=t5+7M2IPOzfED7lgHNyK19lsNyulaxvupyKqxHHEzNI=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=AnzC48licGs2V5MGwqyQ5mmUBNuR881cnN0RT53TsXwxZKU2n5pZ0EWGG5Vtqkd4ceUuV6nNWJufc4rqnRo2oPhQX/Py5MVnnEKSOW3BijJqUoj/NmdM3IZ+XUxSyQo6YQZsLXj1epuA8A406d5Aq8m5GqYySP+gNYUj8j0BxHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TiTxgXUh; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TiTxgXUh"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-55fe4534e9bso2604628a12.0
        for <git@vger.kernel.org>; Sat, 10 Feb 2024 11:52:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707594768; x=1708199568; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t5+7M2IPOzfED7lgHNyK19lsNyulaxvupyKqxHHEzNI=;
        b=TiTxgXUhF6Z8gJaimSDPOp3VV8AOtmJSWVNzv27CSsEVVMXvyNiR5WLXEDE3VBmCh4
         bWPckYWn3m6T20Ca6/LgBxvrlwbhCevtpAL4gLvcNI+bdcVJXfTiffcgvSN5MxK7zK0q
         JwqFzfO6dd+BmDgFSwz56SnokbpScHMMr/WnFC5BrAjSq5iYWkM36NFSSJEt80kc5oa7
         vGHPJZc56f5KBJ2xiLR1Yk4xqJedPnT4PF4Y8DVVJFLRVIyZuZusiCfDxQ8onkRK8DOd
         Qt60svwr8aRhUpsLUGEJ6TNHLY4G1Wzhwz1k6FswfK5pm9IU4oQHPnJG3iceVKQdnvOP
         AMkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707594768; x=1708199568;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t5+7M2IPOzfED7lgHNyK19lsNyulaxvupyKqxHHEzNI=;
        b=hLWbAnvMozHXcHST1fk7ZKBwTzf39zGU0UAdJb7rw4bnZzXeFIIprkLbF9c7xMIdOY
         3uMswwE6TYf/c9cYbQmEXyfki9AP5SA1zOAd4VSr3rxKG5Hgp+0clmILnulhCcqGET+4
         CMxLqLMVJihT5q9BjeFEbLstIp151xcBwR5eCAa8xtkPhnZ9tE0gcNV9GGi2dL209Bx3
         uk482Z3JvLDrqQMXKtwis+HSH8MyrrcWCPRcMvUMxt1FWECpH7NFAX0EaCslaDGHhbV7
         jY7VO//uzZ1G3ya4TU7hJPAo55wE8FEGXGbktkCfy9GLS4mjfEYYhzVGtij+OW9B3sLd
         Yqcg==
X-Gm-Message-State: AOJu0YyOz7bGq8iljkm4KKLYFuacxzMc15J7lxbfKz40Q9vjXl7/a0HM
	Xn4NtL2HwDGQeaI46VdiB3p2pCS1gsOJZ7HGxrfmaMQfcWTEuWoWUceHjM/fSztQQqiES6VLWRV
	5NqmBFNIfr1TqVmXfP+bR+PRfpAGfv/KtZ/o=
X-Google-Smtp-Source: AGHT+IFFl2CqeelYh85/SdmQKw0NENH8z6lHZ2XiNCPVp1l7rNTfCqn4zq9/YnoxR4U2FFPZ4eOTaOoUeaTk5hGVpr0=
X-Received: by 2002:aa7:d951:0:b0:561:aa3:f9e6 with SMTP id
 l17-20020aa7d951000000b005610aa3f9e6mr1750789eds.15.1707594768231; Sat, 10
 Feb 2024 11:52:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Sender: kenneth.vaev@gmail.com
X-Google-Sender-Delegation: kenneth.vaev@gmail.com
From: K_V <zinen2@gmail.com>
Date: Sat, 10 Feb 2024 20:52:22 +0100
X-Google-Sender-Auth: t7FeeoJvX5kuthEskDKkeHicCqQ
Message-ID: <CABkRduQNdgdF8WhZadP5hyYvpEWgP_AE8=qzxNiRNA71bdJcYQ@mail.gmail.com>
Subject: git gc changes ownerships of files linux
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi team git

Running 'git -C /srv/mssioncontrol/.git gc' on linux from a user which
has access to another users files will occasionally change the
ownership of the file 'packed-refs'. I believe git actually overwrites
the file with a new one at the end af the gc command. But details
about this is not writen in the help text. Could it be a bug?

Use case: I'm using ansible to cleanup .git directories across
multible servers and this issue is starting to cause problems.

My solution is to make a variable containing the user and group id
before running gc command and then reapply it afterwards:
current_owner_uid_gid=$(stat -c "%u:%g" /srv/mssioncontrol/.git)
git -C /srv/mssioncontrol/.git gc
chown -R $current_owner_uid_gid "/srv/mssioncontrol/.git"

Details:
Debian GNU/Linux 12 (bookworm)
git version 2.39.2

Best:
zinen
