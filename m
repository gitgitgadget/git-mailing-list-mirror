Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2382339A8
	for <git@vger.kernel.org>; Fri,  5 Apr 2024 23:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712358493; cv=none; b=BKLaGnWJc2w1NLeAesRc+2xVkPa6KUriItpmC8/L36MHCZjMnIMP7O9qF4GOhyukc3TR6FXg5R+ag8zJAVfXFV8itUNPK3jq5lfj7W3T6aHif0CPvCL3Zj8RPye8qRhAYYDC795fRIS+VVYE7gJHF0OlbqA2qCtvslHbgeueYD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712358493; c=relaxed/simple;
	bh=geCjL0QPHZMVfc8sTn7KX5Rb66T55LXppSrfSJkhbPc=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=iPERqu4me1FdfSrYtjp7n9fbBzmbhxwb35HvssbY9sXxALnedJK65QtiHBp+dG8kDGxFjz+A0M023kqb1GXdP2xDQGOqBuprU4m92GirsGDkUhQQMqDZ/8s+YWDjr/XyOIzJHm/kiPH4Wrvu3fQWJd96vXoTPXIkgEodqj0hiRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IW7Bem9l; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IW7Bem9l"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3416a975840so1987122f8f.0
        for <git@vger.kernel.org>; Fri, 05 Apr 2024 16:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712358490; x=1712963290; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=geCjL0QPHZMVfc8sTn7KX5Rb66T55LXppSrfSJkhbPc=;
        b=IW7Bem9ljo7balj3+GIag7ASyzyBq6AKPC5A5HZt4Y8Y6++UNNIeMj67Oc5pvIEUgX
         +98wQbcbVr1NVDhp2qof55NsXdYVvHntx/spjIpf+3UeUurMnQPlbIXGk2Ype91mOzCC
         +C9XVoH87OaOCvg2B/srXZHtXRNiirN2uVP+FG/s4X4iupGniE7oAPuWJFYi0CYbzwOX
         sA3tL4qL4y6Z+uJ7x7VkbPIh41ExVz98tokIPXGMIo5Qnv9C/TZE9nCIx3WZv+Yq/+BQ
         tfm2yFCiMqTGaHreGhiLmkaFmcBl5g0se/S672ZxUdgv8WoPxGFa8qUiPpMPae6Mb8Es
         rusg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712358490; x=1712963290;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=geCjL0QPHZMVfc8sTn7KX5Rb66T55LXppSrfSJkhbPc=;
        b=aAkQfB/eT6P0yhVkPSeAiegN4HCJ1NvwUiLglgu4ueuRZ0T96YpxCcC6k+O/rMX2jJ
         B49r8TV27aB5v6KynAhvpqtkvJCiJLm1dSo5oKniD5rmZGYUioKhhh2pkshTMtoA+iq6
         GzPf5PEQeti7Vnp3cFSg3XhJ0MGvzoySFjr816QrHQlrJjDzU74zJib9/ZHeuGXm94z0
         Ij/fgbz05q101U5L9AaterR/t32PuMUaMt2q2zhoKAqwXO45MctEsT+CrFkIOvTNhZM0
         911zHHEyPMLhYsBZaZmrDWIx47nlE5rxDTTPVlMKEEg0Nq0p4PIdnG2XhOQulXJhc5sx
         47Yg==
X-Gm-Message-State: AOJu0Yy/h6g+/oDXHbbEKnrZ77R/rZ8IKimfncTkAermJldcpN0luX4h
	OG7zNgXQUmQNeXSP6rpniRz+UvKTiPQMkCDBLH1s4UR3KH3VDuOFOi1NJU89iAA0bgqSeq0dazz
	pV+oX7bQeU1mAAUXlzI3aD/LbafzjEsBZVdo=
X-Google-Smtp-Source: AGHT+IHQs3dM2fY3scaqxSoeJedqK4gQ+duUxWC/HIJr4B0gvjdwGjaQzIlDN9y3gL+STEXMAO/uZRY2vBW6YRAkmsA=
X-Received: by 2002:a5d:4007:0:b0:343:78a6:ff with SMTP id n7-20020a5d4007000000b0034378a600ffmr2193168wrp.48.1712358489745;
 Fri, 05 Apr 2024 16:08:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Aleks Todorov <aleks.todorov.1337@gmail.com>
Date: Sat, 6 Apr 2024 00:07:58 +0100
Message-ID: <CAO0eup=KqHe68OkHqYWtDgsTx0cAwg5Y5HSqK4s_BNbZhr8hVw@mail.gmail.com>
Subject: Add Commit Summary in blame?
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi folks,

Would people be interested in seeing a patch that adds an option to
see the commit message summary line in the git blame output? I imagine
I'm not the first person to come up with this, is there a reason why
it wasn't already implemented? The porcelain already has it, so the
change is trivial.

Thanks
