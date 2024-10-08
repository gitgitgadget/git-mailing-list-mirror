Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18B5D2CA8
	for <git@vger.kernel.org>; Tue,  8 Oct 2024 10:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728384659; cv=none; b=bRJzWIz6y03W1w+7oZm8p7RH+kfZicf9ztGCanPScqPxef/ea1MAhvl2US3++w5rgYa+zBPwmKHZoVCoWRwdcn8hKbjH7K4HHV1g7JtazCEaCLEGcYy4FTJmPezJWOLC9bsJzaBKCujci32Z2RMnxGCEGBXU/aXErDTT+QUWJzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728384659; c=relaxed/simple;
	bh=33VxCB3W9AndthF0gE1zwc2WenGCdcoy/n8wOvOel4Q=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=A2FkXPITJ25Oaf+BPQEEFEewa4iXObxW0+8J55/BIMuvMxrnPxKwCXGC9whQYIpyK+zsXcwURjgpEcXNfcuQ5iRJYLL02jbHRiCspw9irB5bAnSnt4UKD2IgFtiC/TznKalj6gN5X+a4MmP3UWyp0hDnIGYqY55JdrveFKHVB3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cf2NgUI7; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cf2NgUI7"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-20b1335e4e4so54318445ad.0
        for <git@vger.kernel.org>; Tue, 08 Oct 2024 03:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728384656; x=1728989456; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=33VxCB3W9AndthF0gE1zwc2WenGCdcoy/n8wOvOel4Q=;
        b=Cf2NgUI7IZu2xH93VZudIg0QBv5gnmbi97wgz+bbNLbxbbCROPpqOuoeZAomn3IyYK
         G0qpz1EVh1ZlZzAKnDxz+M5cMT9/0m7APRjJGrVKQJ2EISYyD2OP4gu5RivML2fWQ10x
         5y2SrKt1N7KqJig1+INiNmSrx9EWo/LiNHh4Uy+ltCmjEgsB35YDOuqPeixupOmN6D7c
         EAdp7iWTX5T3GJLWgTny7KKxPeaVY9cLVS1ortEpmXoaiOmyKTsYtZRgrv/tcAu9DsW2
         kPc0yQOi5rk4ZjxH4D8CWymLtPL/GNZKebyROGy9olbf4U7MTPo76nKXQAwgdetpFuIP
         vu6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728384656; x=1728989456;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=33VxCB3W9AndthF0gE1zwc2WenGCdcoy/n8wOvOel4Q=;
        b=GzZJHSHy4dR0vI1SAkqT1RTmB/Zxl9DW5diDbrb9znmetPx65B+fU4XreHFaIQYYTD
         pYbOR3i9tRbuThtShZ8CW/H5yzTQcpfus1vib6Xeu0c49nJPr/+Aq02sUTykwSNREvVD
         UKFlopdVcErawzzK9AZIO9+OfdsxUj6GKdp15ox94GAO29ou7T7qFoc50CERkHAf261S
         0wDz6j4ChYa4dc5gSkl4v/1pLghjlaLbkaHk9K8i+Z7bRD1BJx7b6t4YE/mA1+CzyHv+
         sQ0Ypl/lakd4sS1PC27YvaznPhKxS0dWlSBlQO3xvWDRjLh/0bll1/qTB0aYsuDZK4H6
         2v7g==
X-Gm-Message-State: AOJu0YzjITjrEaCXo1Q8BHy1FafKMyDvY7p94zXCXOLA8t9zv6thDaac
	OZj0M6cZVgjskadkzSWR+csJO1FimsyWMgWONp7F+92f9gfjQO7Jbf328eVnqwvywK9U0T2Efvy
	axuuQwLm4xiddn81sLY9PMoYFSMgEV6DYwAQ=
X-Google-Smtp-Source: AGHT+IHp/WQAjeTr72MjVpDFCimChapYhJ9zTRxcXOhcxSru3SeBIS4VDOXwS6moJg10o6HrbUASC7nuaTPRnXQnPTU=
X-Received: by 2002:a17:902:f68d:b0:20c:5c37:e2c6 with SMTP id
 d9443c01a7336-20c5c37e5bfmr5998765ad.11.1728384656450; Tue, 08 Oct 2024
 03:50:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Shubham Kanodia <shubham.kanodia10@gmail.com>
Date: Tue, 8 Oct 2024 16:20:19 +0530
Message-ID: <CAG=Um+0mJW-oAH+YLC3dWEU64JwS-zMkkTiFWYBe4g6HMbe-iA@mail.gmail.com>
Subject: Bug: `git maintenance start` is likely broken in 2.47
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, ajithsakharia@gmail.com, Gautham R <18.gautham@gmail.com>
Content-Type: text/plain; charset="UTF-8"

In the most recent release of git (2.47.0), running `git maintenance
start` results in a segmentation fault error both on mac & ubuntu.

`b6c3f8e12c` seems to be the first bad commit.
