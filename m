Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFF732063CC
	for <git@vger.kernel.org>; Mon, 16 Dec 2024 16:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734367663; cv=none; b=ohK3Z8mgW/z/kF/RDayyhxwETQz+IEjlz5SmsER9zlIc42dwnRhUD0QYRJhS/AvzCXjh2xXFliFzlBa6HBk92rOJruVC2pJ3dLL3CO9P3cI/NJNxGniug8gmfatZF0jVF26Sb7731p+mrBu5rAqY/zvvPviOvseqv9sl3qYkRrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734367663; c=relaxed/simple;
	bh=O+Tr3q8anLr5JxvvS4bFA/ytI+GC9QRpjQTpCbAndp8=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=khcT4G/n/Pf0cN4ZUsmwyyGQONHMCaBlo5fWvtIJNd2sCYs3+yaIMcyF5GVMC8ShqQ5ZwUhkZP47wMF/FwoXvkaBX4IXACbAeVnNB171+Ny98SCP+CosUN0XQoGb+xy8fQnCEQJU7z7da6XFWkv0CoCC5+G2Gguachovl8OroAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VZKP6SXW; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VZKP6SXW"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5cecbddb574so7379193a12.1
        for <git@vger.kernel.org>; Mon, 16 Dec 2024 08:47:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734367659; x=1734972459; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KEg6m0jLAIuND2ziGtJylt5i/VSYNuebu6W4JRxNKic=;
        b=VZKP6SXWgBlv8nwzEvtFH7PcOXRTKkYFcwehgt4KZKmSbur7j/QgfYOFRAeisQPxVJ
         eR7PeHILK9/dAVORNnO2ZbzlqQ/cNS/0/xFZJ8VN7LzQcpOyCJguHqlH47rKMReF2TS8
         ZW6R4DNn9PHEhcv7ckm+xvkv5X1GOWSnpRdJ5EB8FSF1o4N8al6939eYYgCPBjOkrCWw
         J6IZi+aiuV9vHd7QwhVwOYbRO2bVuWet+HX8kUmBHjYNT8piT1CI8j502WhbBIB9bkwY
         Fqpsh+N4oUC9MYgGDJrGruaBZAPZ/9hLxSyQU8dvyWFic8hyJKsLSJDeVoZDSKVbvFHy
         7/5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734367659; x=1734972459;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KEg6m0jLAIuND2ziGtJylt5i/VSYNuebu6W4JRxNKic=;
        b=HqTSokc+idvZXGWnMRgAr9hT4Pp+OPTzkHt8mBZJzkyS25ofbXbhWPhMI/0czGrCc4
         IfIocOzP6saHAsg9vo2/p9QWiwvRf+8kBEbkYoFTwj87x9khmYntewLcDQZd7NGi+7Mc
         4+NKsisvgRFBr6W4zr2asV/hZmEyUPFavL65CwPIhls1qhp7TPhn2M3CxK03EwB2jRuK
         RSeyMnDjKw1RyqiwaJ4LaOGAZz86J7jKdgE3Nao/CaqAnwOF25GAts+PeuUUcVhj3hhn
         b6JZ/CgUEpMZF8E1lMlNeJ0pVjnKCGxLtO7b4rbd1LpWVrSoADRmIUFVyiScfSaJkoQW
         PT4w==
X-Gm-Message-State: AOJu0YyPXkKX4sA71uGk41i88bIek+PDf5BuTTMurqmrsbFjtiIxqgRk
	rXpl9F9HwIYzGruwCqRBhBTppMxsJTwUApIqKRgU555gqgANR8h2kCYXQf6etP+irHat5sy1gw+
	+52KCLHd+Nde9gyDcXtQRfhcQ739RYtMhwA==
X-Gm-Gg: ASbGnctOm4cR0qW2arcy882jQrrXlIlCCsE4B4gUGm1midPUIxUzuuR3p0qZv+/xF4J
	GNOMqiEYzEODIoGUdL9EwcTejPpWBBEJGQKpX
X-Google-Smtp-Source: AGHT+IEpsC1W0Ex4xYL+U6BIE/6ZHkAoZjhaj5mQCCrdhYa6Oafmq1O4f59/KYRiVQhQ5af/DxroB4610YayWjhGhMY=
X-Received: by 2002:a05:6402:1e89:b0:5d4:4143:c07a with SMTP id
 4fb4d7f45d1cf-5d63c2f8decmr8967266a12.1.1734367659443; Mon, 16 Dec 2024
 08:47:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Yuri Kanivetsky <yuri.kanivetsky@gmail.com>
Date: Mon, 16 Dec 2024 18:47:28 +0200
Message-ID: <CAMhVC3b+1TWLkKGYVb6VyBRyQjsDpbKRQQNT8SUXSmrWHfPnEQ@mail.gmail.com>
Subject: remote.<name>.push without dst doesn't behave as documented
To: Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

> If git push [<repository>] without any <refspec> argument is set to updat=
e some ref at the destination with <src> with remote.<repository>.push conf=
iguration variable, :<dst> part can be omitted=E2=80=94such a push will upd=
ate a ref that <src> normally updates without any <refspec> on the command =
line. Otherwise, missing :<dst> means to update the same ref as the <src>.

https://git-scm.com/docs/git-push#Documentation/git-push.txt-ltrefspecgt823=
08203

The only case I can think of where refspec is not passed via command
line and it updates a non-matching branch is when push.default =3D
upstream. But with remote.<repository>.push without dst it starts
updating a matching branch. Either I don't understand what's meant, or
it doesn't behave as documented.

The second test fails:

@test "normally a non-matching ref updates" {
    start_cloned_repo
    git config push.default upstream
    git checkout -b bb
    git branch -u origin/ba
    git commit --allow-empty -m b

    git push

    assert_equal_refs origin/ba bb
}

@test "with remote.<name>.push without dst happens what happens normally" {
    start_cloned_repo
    git config push.default upstream
    git config remote.origin.push 'refs/heads/*'
    git checkout -b bb
    git branch -u origin/ba
    git commit --allow-empty -m b

    git push

    assert_equal_refs origin/ba bb
}

start_cloned_repo() {
    (mkrepo)
    cd "$BATS_TEST_TMPDIR"
    git clone --bare a a.git
    git clone a.git b
    cd b
    git config push.default upstream
    git config user.email you@example.com
    git config user.name "Your Name"
}

mkrepo() {
    cd "$BATS_TEST_TMPDIR"
    mkdir a
    (cd a
    git init
    git branch -m ba
    git config user.email you@example.com
    git config user.name "Your Name"
    git commit --allow-empty -m a)
}

More details in a gist:
https://gist.github.com/x-yuri/943fd13704b38551da36c8363d7852e1

Regards,
Yuri
