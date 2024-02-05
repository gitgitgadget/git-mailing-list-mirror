Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0561112FF88
	for <git@vger.kernel.org>; Mon,  5 Feb 2024 20:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707163934; cv=none; b=otorfvtErqQDHyRRPKjH3nj1BOYzIOXQD9gqAMFanHzjfNPRUZJPGp/KcPTywsD/5v1dodqRoXMWgG8UqsJmPI46EMQhif4RqGIuK2GFHrXakJ7p9Y9+ggtzTjayYEplxgW/EQNFAOf3iZwHkbur6umg7BMaCP8F1SZ5dVk3fYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707163934; c=relaxed/simple;
	bh=4/+vyZ2dFN05s6ibikwpVypk+oQ4Ie2DgUzqq7djOaw=;
	h=Message-ID:Subject:From:To:Date:Content-Type:MIME-Version; b=jucvXfBjKXzzZiGzxvlj2tP1sqUMPyvWTRtwJNQA9SM1c/gSjjZJMlAinPVUN6WEUqP+/hWhHw5Jr5asaH1LuR/D5mKU3xNMrU5lxjiVc/rIyyJNgDCD7T7orNtM+TecMTB8zGCSfwwYmBfIx84WsC+YwGVsD9HoVH73Q/Bjq3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=M+JVE+QG; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="M+JVE+QG"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a34c5ca2537so667448966b.0
        for <git@vger.kernel.org>; Mon, 05 Feb 2024 12:12:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1707163931; x=1707768731; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:date:to:from
         :subject:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=4/+vyZ2dFN05s6ibikwpVypk+oQ4Ie2DgUzqq7djOaw=;
        b=M+JVE+QGRVXnaXtu6S5i5ms9dM4MNjf+tPDUp95QEXpGvSxgvot1Gxa0hVkqRXqS1e
         gxYdeVaYoJC3jmDBP7zW5y5UBQgVpcMziezWGuBd+afFVTqHSdXehn92l8m2+d7rL6x8
         cqIhSJUFNH/g6PSfz7Q75aXhIXxyZXPrv6+CVFuZUNLW/XoQiByyMT28dyfeTv3FPcBs
         nT3ybMKc14VIuiBov8Yd2Scb4ky6VSDNiXQpXEejD5bPNrQP4zGd35e3yt+DuF8c25pj
         AVo4WJ0tiCYYTzIZE3FH2uQbkbBnpdaOO9OoEbr3j2/F6pldBV+dwjTkb81vO3KEBUya
         IYSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707163931; x=1707768731;
        h=mime-version:user-agent:content-transfer-encoding:date:to:from
         :subject:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4/+vyZ2dFN05s6ibikwpVypk+oQ4Ie2DgUzqq7djOaw=;
        b=Tkw0OIqR6Rilr1Er8wAAnFN20RF/TxDwHRsD29YeyzuCrFg3Yo0R2o1pgkRvJrquvB
         hcRJ1lTGfXBr0dm7+pIOtwbct/0C3zyDWd97lCMYa0Ug7RbGDhVa/QM/N4FoXqduCgAC
         uAWjmBx9TbZD/CAnlnAGbvrzjRRcbaDBYnwZhlzl6DlVcEdx6jsynHByDmGd6+cWjMSP
         2clSaM2QrMdB8wEm5Ypla3ThuMjIPT8/KH4Ojut44yCKARjLO/Jz5zbuKM85aHc8+vty
         rWKTxEPIWlpLk8VrRpBrRch+1UC3dXk1bjR8BA1Ao3Po5mcFFEspSDZcXGJUAG/2zj1H
         8ewg==
X-Gm-Message-State: AOJu0YyJpX5koQVtXLpO+YYAdSGcu8WjyNrBuS0IQTTsZ9xSYJd8FEXU
	9d5REJkLPV9pTF/QwJZcjXe8k1uEobcq+cVAJSqgjXYKrL4eSYg=
X-Google-Smtp-Source: AGHT+IED/tyQ3rhARx+LRaRvbnyDWSN8Lw8qDX0wqRdTEahheBfFCKnWZnOcSaCMsmD6iOa8yLuRsA==
X-Received: by 2002:a17:906:3757:b0:a38:b94:48c1 with SMTP id e23-20020a170906375700b00a380b9448c1mr202700ejc.16.1707163930907;
        Mon, 05 Feb 2024 12:12:10 -0800 (PST)
Received: from ?IPv6:2a01:c22:8ca1:9d00:8429:a4b6:daf6:f86? (dynamic-2a01-0c22-8ca1-9d00-8429-a4b6-daf6-0f86.c22.pool.telefonica.de. [2a01:c22:8ca1:9d00:8429:a4b6:daf6:f86])
        by smtp.gmail.com with ESMTPSA id a13-20020a1709066d4d00b00a36f314daa6sm213723ejt.46.2024.02.05.12.12.10
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 12:12:10 -0800 (PST)
Message-ID: <beeab03c564e94861ab339d26c4e135b879a1ccd.camel@googlemail.com>
Subject: git-gui desktop launcher
From: Tobias Boesch <tobias.boesch@googlemail.com>
To: git@vger.kernel.org
Date: Mon, 05 Feb 2024 21:12:10 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hello everyone,

quoting from downstream issue:
https://gitlab.archlinux.org/archlinux/packaging/packages/git/-/issues/5

-------------------------

"As far as I can see git gui cannot easily be used by me on arch.
A .desktop entry is missing for me.
I created one that opens git gui.
It also adds an entry in the "Open With..." menu of file managers (I
tested only with Nautilus). Opeing git gui with this entry git gui is
opened in the folder where the menu was opened.
If it is a git repository git gui open it. If it is no git repository
git gui opens just as if it was called from the desktop launcher.
Since it took a while to create it and adds value for me I would like
to share it to be added to the git package by default.
It is far from being perfect. It's a first working version. For me
personally it is enough.
Before tweaking it further to fit the packaging standards I would like
to ask if is desired to be added.

.desktop file proposal

[Desktop Entry]
Name=3Dgit gui
Comment=3DA portable graphical interface to Git
Exec=3D/bin/bash -c 'if [[ "$0" =3D "/bin/bash" ]]; then git gui; else cd
"$0" && git gui; fi' %F
Icon=3D/usr/share/git-gui/lib/git-gui.ico
Type=3DApplication
Terminal=3Dfalse
Categories=3DDevelopment;


I think upstream has any interest to add this. Therefore I ask here."

-------------------------

The arch package maintainer proposed to try to to add this to upstream
before just putting it into the arch package.
Here I am asking if it could be added to git.

If it's worth to add it, I would take the time to improve it if there
are suggestions or comments on the current version.

Best wishes and thanks for developing git.
Tobias
