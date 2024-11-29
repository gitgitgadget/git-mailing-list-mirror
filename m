Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 034DF33C5
	for <git@vger.kernel.org>; Fri, 29 Nov 2024 11:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732880821; cv=none; b=dibsceeRxCH7CGHIoS58PVuqPFxKVzyJ4JKrnBgkrN7+XZKB8CG9kreNmq7B9VfwfN/ez0SCkTJFJ2y8DCGkHLRy7a0o4PWN0SgJcCjbIqHXGwrdbZqoB82naHWjMYlL05xowrApkU5K5GXVdHJS7S4b6AYTVhEZxQ0dTXvsA4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732880821; c=relaxed/simple;
	bh=FsGsgnn5skJqIBj5WJlgiQbXG06WzKajUTDJGxSv7do=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=VWKEhbnNpfeQIAcmwmSm/pdKSS7axvKLe7nHr6T2REIDVwYdkDu6BUTLC9dORxzEGoIg9fzTzoH40VeuC3BfaC4UCjZbI7fanZr7k1O/G4arnOTs6f1PIun4GOCWBz9oXrGIee1eetm0DS3ASwd35edxnp9VfHrtiUUhkl+1wv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OFrjBzku; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OFrjBzku"
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e387fdd1ec4so1276223276.0
        for <git@vger.kernel.org>; Fri, 29 Nov 2024 03:46:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732880819; x=1733485619; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZGo7WO83pX2bRmlg6eQZCvsEkq6mVHwjhfaSlBScK+Q=;
        b=OFrjBzkujSaickwGkD05pPsLkYhtuNEfLfyDTh6HhLKlyDHmdUzXmkKkTIuGKDrXNg
         JSVO2KuAtmFA4nlgiIs5zNYJDf9nbmg7CH43iyO8NzjHDk2AKiTSNvkyei4Oovf+bWxt
         eu+9Q0JrIhIpsZRXmtD4wgydGlMPEHw7Jmcry6Kb9sl4o3mbzYRgMeMVJTc5Xw56kPOb
         dgqQPHMiZkXqMw6ZJSZhqcEj+3yEDmTx4C8q9Mm6OpFcb3aGIhywaJrdjK+kZhH92Zth
         6oM32DImUH4Bs+9LNE2B75/nu0CJsa14MZ0L9l71p7kWNpoUMWBAqXQLLs8+atMOcZ9c
         yUfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732880819; x=1733485619;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZGo7WO83pX2bRmlg6eQZCvsEkq6mVHwjhfaSlBScK+Q=;
        b=l2u9IW41uanjeBzaLOD45sb9gAkMgxG51FaSjcR+95RrXXW8Fm20tU0O1vaYQKjZP4
         7pl3Iiwb0dhNILSfkWJCkQE5DDbSlS1VKneBs9QDT3tGbwL4vZlBaguKadOVfDAnmkjW
         IoFLEdmM5gp3xWYRNDuNa2ucmCI0lC+OBGyJaoTMR9h9atC+W2eNO660Uwx07h3V5v8M
         zqtbtUxPfflkkYjm1zumwMU0NS+UMf6nCcAzYChh0TRMovLsUzWmWfpKX5pj+j+QdUIo
         tRC0argt4aq5c2ux2KYkIpQ0khlYDGmt3V4io2e+NDpTYVqB785ex12eTP+Vhkd36GWE
         RuBg==
X-Gm-Message-State: AOJu0YwnaS7cXu6fKTkAlRkWzPymDl1oZVBXl50js4bi8bM5QKMuU781
	HnA8TAGpX2Tq0Eg3bg0kRHgJFeFAkZOhiNjY8NOfhCyrcdCbfynP7NgYIvF/JqsWEOFWrJIDhRE
	er3zYCr1QaOKrXhXGF+6y3VMhmH28B1MU8lHkcw==
X-Gm-Gg: ASbGncvFGC01coftOzIEXuFG9QL165i22hH9thrkjhhsOuXIH07u9ZBJPlHk8NN9sCo
	OE25d7vbJz97zuowcdO5VBCLRRedsCcwjZVjcLC2u4TdJ6vfo01ZQsQboVuD7ZjyVjw==
X-Google-Smtp-Source: AGHT+IFUVXk5wtjtbAIc/q5eNisVbjgSwB1X+RA7TotAldmOtVDkhO8ClwLNJ9yjJWVnZ/3o28/7HbOCcGZo6Q+I85A=
X-Received: by 2002:a05:6902:2ec5:b0:e38:bf0:dab0 with SMTP id
 3f1490d57ef6-e395b8d1875mr8155588276.24.1732880818811; Fri, 29 Nov 2024
 03:46:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Tamas Dina <dinatamaspal.throwaway1@gmail.com>
Date: Fri, 29 Nov 2024 12:46:48 +0100
Message-ID: <CAMZfs4Vfi4OfuO3=7yT=ge7MHXf1iPhZjeJSzgnr=9oQFiRKjg@mail.gmail.com>
Subject: [bug] incorrect pathspec handling in git stash error message
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

=====
===== What did you do before the bug happened? (Steps to reproduce your issue)
=====
Here is how to reproduce the issue from scratch:
1. mkdir testrepo
2. cd testrepo
3. git init
4. touch testfile
5. git stash push testfile

=====
===== What did you expect to happen? (Expected behavior)
=====
Because 'testfile' is untracked, I expected an error message similar to this:
    testrepo $ git checkout testfile
    error: pathspec 'testfile' did not match any file(s) known to git

=====
===== What happened instead? (Actual behavior)
=====
This is what happens instead:
    testrepo $ git stash push testfile
    error: pathspec ':(prefix:0)testfile' did not match any file(s) known to git
    Did you forget to 'git add'?

=====
===== What's different between what you expected and what actually happened?
=====
Looks like the magic prefix is handled incorrectly in git stash error messages.

=========================
=========================
[System Info]
git version:
git version 2.47.1
cpu: arm64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
feature: fsmonitor--daemon
libcurl: 8.6.0
zlib: 1.2.12
uname: Darwin 23.6.0 Darwin Kernel Version 23.6.0: Thu Sep 12 23:34:49 PDT 2024
compiler info: clang: 16.0.0 (clang-1600.0.26.4)
libc info: no libc information available
$SHELL (typically, interactive shell): /bin/zsh
=========================
=========================
