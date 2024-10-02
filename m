Received: from mail-ed1-f68.google.com (mail-ed1-f68.google.com [209.85.208.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3977B5C96
	for <git@vger.kernel.org>; Wed,  2 Oct 2024 04:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727843149; cv=none; b=sh5XnaZ0bMZQq1ByoFVuabuGFzyjQlD9PziVUk62vwzwXgsszaEEgaD6pdupidKsO1FPoBMJmkDwWPu7/ba4O6S2O/I7KgbP48E0Dynlj65XcwI1YGtsG6pkGYJzW14P/ckJw1xJe57jpO4fqzIh3CqnEqu2YXSWVMpGonmTCVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727843149; c=relaxed/simple;
	bh=xl600DXkpgLbmE6w8YPrzYoaj+QWkFws5GdQfbpkKJ4=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=bnNJJepsVyVrn75VkEAGwKSYR3NXMBsilpyAnhBXNx9sZHJGuHuP3zWXYRTVh1kaJRd1eND9GC5qGl/lLyKld8C34RUv4xgoPk0ebPuyULV5ZHYCsboibkMXj6S7F/YN6Sn71C6y/vhZG+qGaZbbQYkDSs0x4mWdYiC3f+YTwME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N3y6RN4T; arc=none smtp.client-ip=209.85.208.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N3y6RN4T"
Received: by mail-ed1-f68.google.com with SMTP id 4fb4d7f45d1cf-5c721803a89so8035502a12.1
        for <git@vger.kernel.org>; Tue, 01 Oct 2024 21:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727843146; x=1728447946; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xl600DXkpgLbmE6w8YPrzYoaj+QWkFws5GdQfbpkKJ4=;
        b=N3y6RN4TBR4NhPQa2cAhrM9syqt38A1xARemprwskz262Rpn7QvxRfAOuz/sOxljdI
         Ce4koUs4hfBSPFoH8nOmVR9mJcvtl5Jg6rb7TTi3sXv7W16AnK6q0ZE8oB6tt1R32jx2
         BfJ80Vq95IfPyJD9zDPTVWZjQsWhnQDE7a8d0xegRA2njgKnrRQpAu5RFC1ZqQYWotVE
         X52+M91M1JguV59vMh1GiBdUdrNz0vYXA/9mhfSA1jO7KRrNuQS2cJJnNwCtix5kfiUy
         qjWkMr3TWjYMslLoqM/tm3X4F1m558o4DG7cSbqMKdGKM4D5F5r85ePulcRHXkVvrx7s
         7WnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727843146; x=1728447946;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xl600DXkpgLbmE6w8YPrzYoaj+QWkFws5GdQfbpkKJ4=;
        b=w67Gul11X1JNrfAsnJtNtfINZFudRNhVsDok91KHKN0RoDkgpPzSF8W1sALBOslDT+
         1ulwDYUAo5f9ZhDzARqNLpLSPVw92V0Ve375a1xjokfMcCO60XOgOKjB0xSyOKBFgDi/
         UO6Hx5muyK+z0fZc+PdjHrl9cV1aVvOp/hy9vENfZiA2hNB+1jUtiBVSl3FhBpzvtEes
         347NSJCvflNQDUq/m0j3uktEzlONv+Ltpq5ZSOEn/NtKJLwhWb542Y42h6zGBRSFVidL
         mxo/cu0Dkgx7qHRIk1goltTVqgQEufCsP7yht7C76uuNdL8FRbKlCZbYZs5+ZbdqtKWg
         GkZg==
X-Gm-Message-State: AOJu0YzDYWzgyCZLHTXlQmhoEC1ZdhD3EH9oV6iQ+wNZ9R8/vzD8laJg
	hQUQyJ620CZfOvxoHoRLKNzAFNG6OPzHleN+NFEj7sfkW5ZO0N2+PWxCV/4PHikSbXOoA37/XN0
	1cGrTCVi08wmVukxTE69MoDjOKYvrhTCC6+jvf7Ih
X-Google-Smtp-Source: AGHT+IFbUPfR9VKoGaE7Z9yb/A1BzvQ50Lxn+hsDLpe1nEokpDPtSvLYHgt8/C9dz7xqp7SkReB/e68W2lDMwuHDqNg=
X-Received: by 2002:a05:6402:550c:b0:5c5:c059:63ba with SMTP id
 4fb4d7f45d1cf-5c8b1b832dfmr1284951a12.35.1727843146145; Tue, 01 Oct 2024
 21:25:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Ekikereabasi Nkereuwem <ekikereabasimachine@gmail.com>
Date: Wed, 2 Oct 2024 05:25:36 +0100
Message-ID: <CAK83d8rDpCFavE8XMye8ESbE+=pCWAv=9RWASW_ENs_RUzNeHg@mail.gmail.com>
Subject: Outreachy intern Dec 2024
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi, I'm Ekikereabasi and an Outreachy intern. I will like to the mail
address list for the project

Finish adding a os-version capability to Git protocol v2

. Also any other intern part of the project can connect with me. Thank you
