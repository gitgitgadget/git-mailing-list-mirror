Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 054161C5CD1
	for <git@vger.kernel.org>; Mon,  9 Dec 2024 13:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733749338; cv=none; b=FEDHElaOEppgb6HLGBYx4aaFaHEbTwETFheWO5zlNBYnMy7flilhTETWB3yLUDDX7qXICb7KCXyyIacXkIHZDaLHlrcnc4zPuOexD+f564HR8GXxDEpEL/CFGUfzLEUUyKMKCQHjFMJLyw8iGoENEsNC9BMxeqIZhjKaBYHi3gE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733749338; c=relaxed/simple;
	bh=d9ufI7W/YcZjXZZ0o2RwwcAWztCvt19r179W0FCUvVs=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=k4lEQM6ce8VBkP+Jr57wciuSJjw0agBiQ30gGW6nfqVV8dcFMi/L+S29wHRMiaj7MWZl2dFjKRwJaL6lxh4clpDrpNTwPj+yaJ9P3v8LKpoPLwr0rIo2RKVA55Gpadyue8/Jx2Yj9sb2rz3dtxG4iLbSPI1FUEcsVvufUgrXKqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CkqS5VUz; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CkqS5VUz"
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-71deb8054e1so536112a34.3
        for <git@vger.kernel.org>; Mon, 09 Dec 2024 05:02:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733749334; x=1734354134; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=d9ufI7W/YcZjXZZ0o2RwwcAWztCvt19r179W0FCUvVs=;
        b=CkqS5VUzxk6EPwLYYBwG+JKYa5uxWoJLw+OmnhJocREbXJz/H0DO3Fvm0CBkd4rYnw
         DF7ahtOFFJ2K1KQhaNK2SXvKbZkHPPJt9B9InMMe7tGnueJtPcYa9Ib3dvILrfZBFs5C
         XFsjr9tw3dMPXx8H4a/AaUVmohkZUKh6ncPvZbJpJTl8KEh5l/WuZLoMNbO2m2I6be1G
         sgp4jFPBHfB0+2zmjSKL5uw2s/IkHDgDIJYCEx4SibM5a4cG4dd0EpbGZJgmbQEdXsyE
         SHu6aqhJ/vbIpcnXrAY3A2JxmsWZQ4vs7x8XVOumlvOL8KlyK7/WHEtPoalP46AwCRQe
         mwxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733749334; x=1734354134;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d9ufI7W/YcZjXZZ0o2RwwcAWztCvt19r179W0FCUvVs=;
        b=LWAMAmwmc4mp8mhGfRg5E3oh0SJzbc7nPTho/jo/gocBO1T9qleuYyIGa8RXcXRgED
         SkQD9MapdqIKpd0YDIuwNu1vxDZtlUklc8ImUsX2Ubb7qPG+KGUSMcwTpVIzFTRCDw7O
         jOLLsr6VuBjOZKQNO09HZ+OdNtWR8EzHDiKpq+gKtjwlDKCtfrZbsdeOikWh0CSTDUoN
         GdUC+cRt4VvBse9M6AgPOanSbwaRrxt3+z9JxG4YZMR7Iw6Qnd9U7BcJ/zBfkZSp/yDf
         0jRCLClpDOTRQ/I11qkdE4wL5EtNMS6J2Lze4YsISycsG/n1emdGFbm2dmheviVQrkiV
         +VuA==
X-Gm-Message-State: AOJu0YxWnK0WgEcprv/wFowKH9t2FX5BD6Pm+7gSWw4tgW/1aQS23EBZ
	1nKtB0eGXzlFr5umk8IWrRQV6fPhPkfkf+rdRGag79Xj/e2MU3NoEGHX/YnHV8GDPKcbHGkeYiU
	ATTBUZJmPeWr1FDPefr5XEolXIws5Ng5c
X-Gm-Gg: ASbGnctPypaTrVTY8dyrJHzxy5Maur4XShylHpIeKoA5FM/zI9w4mURicbW25OFpxqT
	3GpKxZfXA9fA6drIkSI9iIgPezeWgJQ5aZYYLDLgnn1FQdj3JU8pc+495R5o=
X-Google-Smtp-Source: AGHT+IFJhju+qryNcDHObMUYPNFpNfX1NqSH6UKpK0lDjteerIxll6TC1JaeBRDpKd+vzs6UY463BjOjZ4PiOm/UNus=
X-Received: by 2002:a05:6358:7e11:b0:1cb:3802:cd98 with SMTP id
 e5c5f4694b2df-1cb3802d000mr475955d.3.1733749334415; Mon, 09 Dec 2024 05:02:14
 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: =?UTF-8?Q?Bj=C3=B6rn_Lindqvist?= <bjourne@gmail.com>
Date: Mon, 9 Dec 2024 14:02:03 +0100
Message-ID: <CALG+76eJL5dC3o+yq7zreoRDQan1MPgfNXB42k5f2iq2bZEbNw@mail.gmail.com>
Subject: git rebase --continue error message is misleading
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

$ LANG=3DC git rebase --continue
hint: Waiting for your editor to close the file... error: cannot run
vi: No such file or directory
error: unable to start editor 'vi'
Please supply the message using either -m or -F option.
error: could not commit staged changes.
$ git rebase --continue -m "done"
...
$ git rebase --continue -F "done ffs"
...

It should say: Please commit the staged changes using git commit -m
"commit message"


--=20
mvh/best regards Bj=C3=B6rn Lindqvist
