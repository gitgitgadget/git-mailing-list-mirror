Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A91BD23FC54
	for <git@vger.kernel.org>; Fri, 19 Sep 2025 21:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758318887; cv=none; b=lZlDbGzpPxkRLiIhJwEBFn2pYLPjhxvZfZBNG4NTifDHjfewQ3uEznb1ts1L2E4oc53O7xZy14Zbsl4pxszo8dfNandW45PguSQJ94+6BJyW0XPeNTZe++5dnziR2NCD7E1ivAiXpvDb70jZ/oovrFKekpt7FRADy4gi+ej87xE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758318887; c=relaxed/simple;
	bh=hdqPUFZ0sCq1sE5SJSdBjNRTSCd8l/8sSsfFslL+egk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lFTylsdexOshVEFgI7/TZQT9ceAwLeOyzEpYIs6hxDHuIIC0oa7Yb3+BkXuJVoAJIysGiO5A/YTIoJ6rQNA4j5DrEZx2aFW0lgHZRyvloLxCnBhlmAFcIHRqXluLTcM5+8slL4lx3dhMH9/z/CEV1qfc7Mbi/CmuLEVD+bd2HHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CJlzX01g; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CJlzX01g"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5797c8612b4so2189899e87.2
        for <git@vger.kernel.org>; Fri, 19 Sep 2025 14:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758318884; x=1758923684; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hdqPUFZ0sCq1sE5SJSdBjNRTSCd8l/8sSsfFslL+egk=;
        b=CJlzX01gS4yL6jorhQbftZVew7xolyBmyV3RkeMbWpddP384nC0RziR3937hzrmKWM
         LBy8Mg9HvDlTTCtMFLc+WVMojLt/68ZjD+0eRad/L3jY4n7ZgutQ1LznelV1KWDNPlA1
         dldKO6cNxLnH959UjzHWjRaNFBqiNYE5MUzMtYCw8x1Ggu1TdsAD0e76SZlOmlj+j7wG
         Q8C+hQFA8OqdJUUUGK0sEYTQgam5uxagOFawXUxJUkxMJH/Rl5XuoGZo3yFEx4wlkaxq
         d91Zj8ZkRMiZt8OGC+ZeV2CiEwSxdpZ9rrixUSKqEX6LjSIuOyTLhyCdU9kmrpG0UoyF
         Mm/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758318884; x=1758923684;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hdqPUFZ0sCq1sE5SJSdBjNRTSCd8l/8sSsfFslL+egk=;
        b=L7kNSlsY/a4jBDMLED/FOQP3wmyM7WJPFxCba6erbX/tUVgjuKM8jiN9jIIuLEU9d9
         wIQLK/agqmr7iQKVFWLvWSgRBqpR91YTIMuizM8bN9LWfq5c6H0iblCNTUNRn5s0hfKT
         JJHJQtJ6DcsJbVTIDLRzezB+kRKKjkR4nGSXOK2ysVf5M7xqlnxzrUDZvytWXR1sbWKj
         UVM6rRlIE92cLV9ABCTWAPK8a9V5DQJKwbTtxTC2FYpPAqxc80SlTVeYKSTER6Qve1he
         c5po/LQ14sNgVq3gqLNEgDj52NRDP/P3lqXlFPdpldBX80mFn6IvDF5KXWgEOsp5KN75
         /8hQ==
X-Forwarded-Encrypted: i=1; AJvYcCUb9RZjth2IBb2OiKvea67LDQhVPQJ7Ayf1wl4Kcy60J9QYb4KDLPFW4o+Jz/JEa5bV6IY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxtlg738uiulHSaqcgenS44GKyxibNOk9MZTEIox6ssSuhPvKGb
	QTtsWRYDMFSIUnkbBwF1tcRGheo3tApS86DTMYgrIYWr+STC8lv1xe204/X92VlJgkeMN4Lzjbc
	hSkafn3SSzvPbhL0wSwOxJlIOIAOFdYyP+w6h
X-Gm-Gg: ASbGncsCRsA3pfW7U8hiAsjNlQDOs3W4oAes8I32gGkCwI9iuEMveaNtK0QNSIzU0LK
	UQ4DAyFlKig7+jsGdrno1lu2+lBu6MFStoySc5QQrdDF2vTWMShrsWOwrFPBhnkIjwEAHe1yE9M
	i1b6McZ5m1iG0Uigok6o2X31ZkqNMe8cApNlr18stCZEZZ9K9p6hS1cC3akmccALko+GxMEdt0+
	o/4zMpn
X-Google-Smtp-Source: AGHT+IElAAhD25F8TIbgj0mLQo84A9T6TgBPnMPJRT0UMUZvmCoZZryh95I3t+RJjOytSpxL7FoHr32qgg/6IqsEfgg=
X-Received: by 2002:ac2:5689:0:b0:55f:391b:54df with SMTP id
 2adb3069b0e04-579e356df49mr1800731e87.47.1758318883716; Fri, 19 Sep 2025
 14:54:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2043.git.git.1756496539.gitgitgadget@gmail.com>
 <pull.2043.v2.git.git.1758071798.gitgitgadget@gmail.com> <17143ced6feea5927b66c0578f1c2fbb07378504.1758071798.git.gitgitgadget@gmail.com>
 <CAH=ZcbBf65E6aNN-cCp_0Nupk9GD3apjKRWrfi_JfJcwWi_mCg@mail.gmail.com> <CAPig+cR19fUmzCyH2yaHjom4ifGNi8tBz8eDJwe8dfpJVQXyCg@mail.gmail.com>
In-Reply-To: <CAPig+cR19fUmzCyH2yaHjom4ifGNi8tBz8eDJwe8dfpJVQXyCg@mail.gmail.com>
From: Ezekiel Newren <ezekielnewren@gmail.com>
Date: Fri, 19 Sep 2025 15:54:31 -0600
X-Gm-Features: AS18NWABQ5Z95rYaP7E1gt9nfphCOsIopYQAtl9USRKueepITpMEJywCmUq7Uo8
Message-ID: <CAH=ZcbCpX-QZ8mEWE8RaNwF-vOuw0o8V128otknNdLp=XmQrjA@mail.gmail.com>
Subject: Re: [PATCH v2 16/18] build: new crate, misc
To: Eric Sunshine <ericsunshine@gmail.com>
Cc: Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 19, 2025 at 2:50=E2=80=AFPM Eric Sunshine <ericsunshine@gmail.c=
om> wrote:
> Would the name `gitcore` or `git-core` be suitable?

The only other name I could think of was `util`, but I think I prefer
`gitcore`. Does anybody else have any name suggestions?
