Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F002B145B10
	for <git@vger.kernel.org>; Mon, 11 Nov 2024 09:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731316403; cv=none; b=AMqRZliQ2Y8IKx79shm3qMqZVd3wfTRThvKoJqRWLs8wlvPBjc1KWQhq80PpzXvJVdoSNkZv8sQKqFzfLTmr0z+pklVE9tuGjQirWs1Nus+NyXN8KL2MJNFKhaUwdLl3jBtcvsn66FJlEIkWMvxd5DCjqvlCAr4A2VYS/DrTKE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731316403; c=relaxed/simple;
	bh=RdrTBf9kMm3JbyE15j9ljh2Ivnz2Md+mnZ5+uxregNI=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=QQwX94DFGQ5j/jfLvlWTAPCxikpuU87W7bZB4aETQmOsBlAlNdh1yOC4pZa1MzdYdLDlMc1XWMPqmzEZCuV/iHQ/coIAbF5yis4Bm9bggs2ahzfDJy5Sqjwfs+xe6DM/h4H1drUa8S0MLyqVWrYUKb8ssN3A8oWIaFYv0sWpobg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OuL07LHA; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OuL07LHA"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-7f45ab88e7fso534860a12.1
        for <git@vger.kernel.org>; Mon, 11 Nov 2024 01:13:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731316401; x=1731921201; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=arbmEDmRutgDl5y7d5la4dZrQVnGoQlN5fmvixVEdd4=;
        b=OuL07LHAEaMC8GppGcQElGdabNnIVkS7ccNkarD0jaNaXdaeieM5X0XUgDh4AohHOx
         2isg9a16oI1sG4ttqNMJnNtKd7mmRj8qSMA63JmJWeRjRqxvijjYl42+3Z2toMNg8XT2
         KC7ZWgDDukrXSsNZfGwOz388A/CEMSoITTaOX+n8ULbNM1ACyBMI3VvaflXyJTjuVQuZ
         j/Y24DpoFBPvMZ9/52Wx3RF1Iehzi101/MggSbPk/9KX28lhEwLHJeSk/I+DWpLXngCg
         dMiOn7qlTcRKstcwl42rfm5N8sc2wnbz3aNhc5H8FjDu7Ha8D32nIhg4GgrWiavo9C6D
         kEdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731316401; x=1731921201;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=arbmEDmRutgDl5y7d5la4dZrQVnGoQlN5fmvixVEdd4=;
        b=BhXeowFsphg+fTgRaRrm/B5+QlPWmsOHv47ajnyZBGrM5Gg6Nv6xykL53XzJiJ/09X
         3+TEcRa70pWU1wAkV9INOjk3RyQZlc3CaGNptG0TDUje2NfEeYm5xsDvv/RFLjva6arb
         DH9P/7uim5hRRH7vEK086oeiw4s+cr066zigLZAe/wGKDV+W0eprEhdGoUciYfXrl4Wj
         Tdta9fOJIFdQnuCvcMq02NRSgHxzvgLRuOvo32T3Qtfou/3RsaX5gmbLrewQJBFqxRy+
         VTOoIYTJKUKFZbAZ0F6AiIk6a6AZnKIfv6zEICLv89i7DB+cgxoiK2Z5gJp2DghM/+Mx
         ro9w==
X-Gm-Message-State: AOJu0YzcZ6gPltEtNz5ES8Qh0i3D9IjFRfuxy7xhX4yvBFyDlb6IphU5
	Q5CT/ki9mwIHfjaTW0oq2tXMBy2JZmz6kkc4cKGI5nzz4a+BRE9yRLPI0NHFN9xhWLcIsmsgzFW
	f10Q+9tI2bXwVu4lGYfTesVzu7AIVjG5X
X-Google-Smtp-Source: AGHT+IEpW1Ydmw+eDMcgnOiHN3YM7/xJwJP04T5w2F+1wWg8iGROEHoaRQ7VrYfkHJhre9IHDpaa47Lm9Xkh3+z+ri0=
X-Received: by 2002:a05:6a20:7faa:b0:1d0:2531:b2b9 with SMTP id
 adf61e73a8af0-1dc22b00bd8mr17832702637.36.1731316400558; Mon, 11 Nov 2024
 01:13:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Oliver Kopp <kopp.dev@gmail.com>
Date: Mon, 11 Nov 2024 10:13:09 +0100
Message-ID: <CAA55TJo_AxC8NPbaXAi7fW+XfbxnXvVKT71x3TkyCt71+vQ-Vw@mail.gmail.com>
Subject: "git add -A" should respect "ignore = all" in ".gitmodules"
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

I have a repository with "ignore = all" set in ".gitmodules"

[submodule "abbrv.jabref.org"]
  path = buildres/abbrv.jabref.org
  url = https://github.com/JabRef/abbrv.jabref.org.git
  ignore = all
  shallow = true

"git status" reports no changes

Now, I do

1. "echo test >> CHANGELOG.md"
2. "git status"
3. See that only "CHANGELOG.md" has modifications
4. "git add -A"
5. See that "CHANGELOG.md" and "buildres/abbrv.jabref.org" has modifications.

This is consistent to the documentation:

A. "ignore = all" is instructing "git status" (and git diff family)
only (https://git-scm.com/docs/gitmodules/2.10.5#Documentation/gitmodules.txt-submoduleltnamegtignore)
B. "git add -A" adds "all files in the entire working tree"
(https://git-scm.com/docs/git-add#Documentation/git-add.txt--A)

However, I think this is not consistent in itself: The files output by
"git status" should match the files being handled by "git add -A".

I am aware of the workaround to use "git update-index
--assume-unchanged path/to/submodule" for each ignore sub module.

One can try out at git@github.com:JabRef/jabref.git.

StackOverflow question on this: https://stackoverflow.com/q/66773544/873282

My wish: "git add -A" should respect "ignore = all" in ".gitmodules"

WDYT?

Cheers,

Oliver
