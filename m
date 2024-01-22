Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45159405C1
	for <git@vger.kernel.org>; Mon, 22 Jan 2024 20:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705956386; cv=none; b=loJ7gwcvSbcGuLFSPAyWC+87DrEy9kSWUuYstgZI4/F/Ec9r8NdA4d99IFC7aZueRTNZz/+sIIE8SWmqq+JMg9VTpy0ol/YFaFsO1RamyXb0rNOWayRmw9IrAqjv2dm2SAbL/H0MsmCc8xEtUWhsZ1F03zoAhStzn6MIXVJTUfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705956386; c=relaxed/simple;
	bh=QaJ6i3+3je7q7wdeApOBUhziYkNpxUtAaoc0hFagRT4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=AKsplDtWn8v3e+DG7ieQvpzsLN2ptBllbmZ4g9mo3dacfifpKfGXdFCINxdw6s/FA6aQS6/I7Fm+TVbTUofFdveZkXkGQApCwsMpQTHiOP7mvIpVX3ddbVuTv2iuaZkZ8Cd09wfvE+fFbheOk9bTo10eg85jMGcoNJLpmdWcyjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ncg0+ba4; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ncg0+ba4"
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-dc226bad48cso2185147276.3
        for <git@vger.kernel.org>; Mon, 22 Jan 2024 12:46:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705956384; x=1706561184; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QaJ6i3+3je7q7wdeApOBUhziYkNpxUtAaoc0hFagRT4=;
        b=Ncg0+ba4+/s++VZAnhCqvb8a9fRHvaeee3rh2AMvVS6IQOS8xFElc+G2Aitq1U1WfR
         bfz/V1HuZ/eq7LjFaY+Ym40LgNYP0EWoRnwS3DAoRhqyNwkBcFtL6SjzPT0wKsfQCSmt
         Lrnbt+CVNccgWLArld2m9QR1DVyAW/AZyfFXCFLpxNhkDc2dzSgklBF3HzDz1hO8RtaG
         aKt/uWjD2lZs3RalGzcis+FUvyqqvrSmyPRpj/thQDhNep4FKrHToa11PWn6H0zvW/9w
         ygKUT3EanwVLBcPaNhbbN5OyyBSkr2SA4PtplUTlBP8kpDWYUndoW4qBmV+W50/puskX
         PEjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705956384; x=1706561184;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QaJ6i3+3je7q7wdeApOBUhziYkNpxUtAaoc0hFagRT4=;
        b=BzGXW6LMk4GTmcMQnqLs8d0OOZgzYpLQeW6xmOBIlpR3K8qZgTfie2OBjDRl419sRo
         9F5U7EMuVI/EHSs/4Mz725D3aMiH7qMww1ckcAZqlNnMkA7nvPA16OICfp9gkEHnzk5y
         XGco22mP4h+/zySCDGhNUW5SJavvS834pphXckWGgSaumdERpWGdOGMZbMCDvu1U23MU
         DwbXGVWt2a2lM7ULif7kesDAQHWCWWhlKGvHvVSxT6SMYrW1CwsfiOnZKdaI2emTu/bX
         ML1Y87SYiKXbQjP5m7PZwbzVd8nn5KWEvxXHvbd8DEd99VeT9gESsBD50p9kiK3/U1WY
         1IoA==
X-Gm-Message-State: AOJu0Yz6lgIjbvI5X3Gix/pohw6CcfL07TTiu6Hxeu8zS7GNzP1ouck5
	VdfHKKdpeJP+lRtnwLLgqyYP7FaoLCMo0ms3/tlxW04U1oQDwickMFeCGCXJ7Vw2pc9F6gQO1B6
	FpN2Wu9FTuOGtBXqIdZ/NvF6WsNHZML20
X-Google-Smtp-Source: AGHT+IEcpUgKvmXsvGeD/7g6pouEgdJCW7+2zvz6tkl9Odk7AhDv1QcgqU1qQZGkzG2a+iFFgNsV38pHeTI2SJ79Uzo=
X-Received: by 2002:a25:8708:0:b0:dc2:195c:9c8d with SMTP id
 a8-20020a258708000000b00dc2195c9c8dmr1866273ybl.78.1705956383738; Mon, 22 Jan
 2024 12:46:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGF1KhWNaO_TUuCPo2L_HzNnR+FnB1Q4H6_xQ2owoH+SnynzEg@mail.gmail.com>
In-Reply-To: <CAGF1KhWNaO_TUuCPo2L_HzNnR+FnB1Q4H6_xQ2owoH+SnynzEg@mail.gmail.com>
From: =?UTF-8?B?UmHDumwgTsO6w7FleiBkZSBBcmVuYXMgQ29yb25hZG8=?= <raulnac@gmail.com>
Date: Mon, 22 Jan 2024 21:45:46 +0100
Message-ID: <CAGF1KhWiYX=3R01Odj2yCNgvx=f5+HRCjRJogWf5eBikuATCcg@mail.gmail.com>
Subject: Fwd: Unexpected behavior of ls-files command when using --others
 --exclude-from, and a .gitignore file which resides in a subdirectory
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi there!

I'm not subscribed to the list, sorry, so I would be more than
grateful if I'm CC'd, but I'll check the mailing list archive from
time to time for replies. Thanks in advance.

It is a common practice for Python virtual environments, pytest and
other tools (not always Python related) to add a '.gitignore' file in
directories these tools create on a repository that should NOT be
committed or tracked. By adding a .gitignore file containing a single
"*", the entire directory is ignored by git. So far, so good.

But when using 'git ls-files --others --exclude-from=3D<file>', when
<file> is one of those .gitignore files present in a subdir, makes the
command use the patterns in that .gitgnore (in this case, the "*")
against ALL files that would otherwise be listed by using '--others'.

In short: using 'git ls-files --others
--exclude-from=3Dsubdir/.gitignore' results in an empty listing if
subdir/.gitignore contains '*". IMHO that pattern should be applied to
the subdir contents and not to the contents of the current directory.
That would be consistent with how git uses .gitignore files in
subfolders.

The obvious solution is to use --exclude-per-directory but it is
deprecated in favor of --exclude-standard and --exclude-standard shows
the same behaviour of --exclude-from=3Dsubdir/.gitignore!!!

Is there any way, not using --exclude-per-directory, of listing all
untracked files in the current repository, but ignoring those matching
.gitignore files with the patterns matching the corresponding
subdirectory?

Is this a bug or intended behaviour?

Thanks a lot in advance :)

--=20
Ra=C3=BAl N=C3=BA=C3=B1ez de Arenas Coronado
.
