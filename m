Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D1A21FECC8
	for <git@vger.kernel.org>; Wed, 27 Nov 2024 14:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732717077; cv=none; b=ss/ICXHOMoeNmfXOGmzSZAdS3hr0juM8V0sxPD6nqHvZo7sRowvH55AgCoFwQ4h1fOTJ0R8tJTCBWCLXORdrQoqWnkREC4URLNoXhuOVA3fxmHBKBclNySoqaENEmoIIvQybSSL2n9oUvI9W+uDJ/LuPIC4KO96XUzoKfWkC+B8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732717077; c=relaxed/simple;
	bh=Lv875v8v9yfon7vLpA7csVYfQgXAJWZb8L9W3y/KeKM=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=Dga1O/bpOSfe/hZHnd70uRZK3bH466fB3uAK4w30eMUevxJLRlVZXbxmf+nf7bvX/0c4L1Np2DFbibeLFHR73DfCFHcfIoJbrXf9zDgAPmj1ORV5ucsapM3iYP+DnmE+zmfh5dOe4l7Pptq5Gfmhbsc/91w/suTaxkXmz6udVeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PaT64TWy; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PaT64TWy"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-53de92be287so3751537e87.1
        for <git@vger.kernel.org>; Wed, 27 Nov 2024 06:17:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732717074; x=1733321874; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Lv875v8v9yfon7vLpA7csVYfQgXAJWZb8L9W3y/KeKM=;
        b=PaT64TWyNwpkjXpadMixvluGkJIirA/wcVasX1gosqxP2cficZ4J/vVTA+AOTFaokD
         n4Rc6Qx9kfLEdrc1wWXswnLVPRrHQxYdwpjQ5Y7DvjanKg7ikTl5YMdL/P8xpUxsV/Ha
         aMm2odpPp4Y0kEvokv5cTxfubodvyHqIwgzT8Um6ltVqimkS/hUhsK0xnqrOY82ZAhE9
         sDRQKgwxMpzl9KhdpDj33M8PMVNyMCHmeNwMswUIQ+0ud8TE2TkdK0USxVnyCPzetQm3
         WQqAGNhDN00ReeEWO/zEws6apH2q9DlUJlp2vPJZyuwgTrvaHkO9jQc2r4UTz8YR9kez
         Zxmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732717074; x=1733321874;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Lv875v8v9yfon7vLpA7csVYfQgXAJWZb8L9W3y/KeKM=;
        b=FgpjKR8sG5irjswkPS26g62NGRIvOKPn/g5HyZWSkFeCJMmK58XyozPL5jH5TdjYT5
         Faf/zOiFvMumavxtZqT4EekVDokMSPBDUyeGxYwhs1M16r/77Z5sJU3Hr68VDmX+GWlQ
         ucuwa60mboRZf4/7DSs/2/MjrFj/G0djzv1wVrNP4JeHvw5SXp0tt/RoV2pmXDV6Cd+x
         R1heQpyqN2YTNRnS23pfrIcUocDDCuJQW0fGVsAhbmD83FnPbTsaJYiyf7kmUcviS+8+
         ae3XPXI0N/FDkC3D/6e/PLvaWJdhgqEL+WEKFSi+txfFWHpUt03eaQvUceFppDPy3iL0
         XCcQ==
X-Gm-Message-State: AOJu0YwMY6qlQBcmL7IJCrb2aUqWIFsncuiRKnrbwF+1Ko+J8QnbtpwJ
	vxOCE8xhGPbM4gqOyyIreB5mwPlnzArCPCFVJ4vrYruMoLggDaPpbnlDAawPj+6iGUxi8ygFmcK
	4N62xkvigbc+5j1b6b1BfAzv8QF8ELjBVEVM=
X-Gm-Gg: ASbGncvijZiUKA2Msnkj5MxBukkVCbGCpm6BAfA9GuXZ3IwFZhfoZYokIv+6K2FZnj1
	x33jk0YctijxyCTw/mVSaYhrhuhsF/g==
X-Google-Smtp-Source: AGHT+IGKIKqr7CF2uDS96bgA+JT/fisMYsHuTBf+s2HgnwRwXvcBv/kSNkRRahsmv4TUHCzLSRy7HjLJCYtbv7ECH8g=
X-Received: by 2002:a05:6512:3d19:b0:53d:ed8d:9a0b with SMTP id
 2adb3069b0e04-53df00a974emr2680138e87.10.1732717073891; Wed, 27 Nov 2024
 06:17:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Henrik Ahlm <henrik.ahlm@gmail.com>
Date: Wed, 27 Nov 2024 15:17:42 +0100
Message-ID: <CABJpytygYtdAT7z1V44h12sLzzo5Ozf3Vc-=fE7XBQnP1G6HSg@mail.gmail.com>
Subject: Bug: git config order affects outcome for recurseSubmodules settings
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

What did you do before the bug happened? (Steps to reproduce your issue)
Setting configs in this order will result in fetch on-demand and push
check not being respected:
git config --global fetch.recurseSubmodules on-demand
git config --global push.recurseSubmodules check
git config --global submodule.recurse true

It can be seen if you have a repo with at least one submodule. Just
call pull on a repo with no updated submodule(s) commits, and it will
still fetch from the submodule(s). Similar approach to push with
check.


What did you expect to happen? (Expected behavior)
I expected the explicit fetch/push settings to be respected, instead
of having them receive the default value from submodule.recurse.

If submodule.recurse is set before the fetch/push settings, it works
as expected.


What happened instead? (Actual behavior)
The default values were used instead of the configured setting for fetch/push.


Anything else you want to add:
The order of these settings shouldn't matter, and if
push/fetch.recurseSubmodules have received a setting, it should not
pick up a "stale" default value.

This has been tested on Ubuntu 24.04 using:
Git version 2.43.0
Git build from source from the next branch


Thank you
Henrik
