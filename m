Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 794183F0AAE
	for <git@vger.kernel.org>; Mon, 18 May 2026 11:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779103406; cv=none; b=thKXUQiex99EnCkxilDWjUW9d5d9a1PWFWsajPhEjpmdKMt+/PEyqHgLJ7haZVp8YDzGFozinhuAv0HRv0wAB8yFXoyvcpJvP0ruCXri1DxaP0CpDLHpLiuS356mqvWI13LeOhLrOZID85LmESKpsOIZ0S32DJgnzWoXa8yK/IQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779103406; c=relaxed/simple;
	bh=sJce4DW7AH8vK7VuGQp/7nUPIJ/HcP1i2PNXRd+XQyA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JCuDNGgh0WOpb6JVKXiY9ubAPZqZ4M/eH4Pm2TtRHmBNxuQaxVq5pJtxST3wBaLHA6LdvWPP/vf7GJjQd0kFMNMb3YcULitFhiN0Q1QLPej0Mia5glgH0jRuImMUCmRAzhs6hOlieLn93REr5u55R4rfGDjVQdkWAgTMf/y82Nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cervined.in; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J7IPMMOa; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cervined.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J7IPMMOa"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5a40502e63bso2322510e87.0
        for <git@vger.kernel.org>; Mon, 18 May 2026 04:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779103397; x=1779708197; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=gQaVGiKoDgv9lRck8JLTnCdH2TRb0LteY64yBUZ2+3g=;
        b=J7IPMMOaVuZP8/43Qabf+9lFyalpD+d0E4w45N4gVhG75HHddfQgTxC5kaiCgI+c3q
         YsAssOGkNyGJCz3LLogQOLf5Fwn7rhRwUgdbSMdckVBVDHYE7lQpEKun0Z+VtXhvSBSJ
         unwt1bhQiI0HklIx4SjRQxP+GzChEGVCqvDtbh6MD0MbEssvdQHcje4QubObIa3LgGmr
         0XsM5uj+K5PJlJ0uiQ4NJAY6cA84kHZkqBPTPd4d6Z2gSGwJCzKz1xWqBdvHoGiM7w64
         ubuan10Ujx+i6Hlti9KTS5t5xojylJy5AcJAmZ14OHG2HiZcbHhHfSq+zQUe9updK7zZ
         5WmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779103397; x=1779708197;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gQaVGiKoDgv9lRck8JLTnCdH2TRb0LteY64yBUZ2+3g=;
        b=dM3l1ziGB3U0/AJOUmXFMSbZ2FfU3gtruaRQ/UB5hPPMv1PnBZPUJVTgHmdZEOH7Wf
         e6ZZbFZevBzU2sOb/fJF0/afId1apiMueVgnMktOgO2qjyT2hxQF10Clrhd/Fj6wl1/m
         Lmz19AnmhmkB/6eL/7o8iHpBymYfGw5toC7im9GzKNEei5Dbe6rzHdFb0i6+rYKQrwC0
         ISgOK+A4jgBgJHHHWDgl+w53UtErNxNeQeTUzpg/baGYTKIJpkTspk3UQOq8PC4NAxuB
         CfAX2q9vJtAAPFYPHsNLla9JAcQ0JMOwosw5C1qLXEEMAE5TfvQNfkbDKeFjADi1SQrQ
         0OOQ==
X-Gm-Message-State: AOJu0Yy0yPDugAPK/ZNj0WtSlzinv+geSR+FDAlUNhIlq1+QEAWNDWGf
	+fOFmndhqkusYrDOItBb+crdrgx5PblvNqrhxOIUrZFYeWwAkhk45vtGAXcU0g==
X-Gm-Gg: Acq92OEOfqW6zDcS0hrMP81Vk/VRC+mgnB3ZJ2rXVvqEf0kg4P4D6NRX1L+FtQoFiLA
	o42KlgogAousscmQ5qDsKsHr+FzoOLbwf6yztjn8LjKQel4T/GzDTDZLMiIDox42m8dMsynE1n+
	e0PsRV1+mrdAo0YKBAVQpdYrvGvREC88bczAxtWn/P8BBgya3w80fZ9x4xIDpeRNtplFPDy7Cb/
	TGkaRYyb+fF5KhGOxG5TQFitMlxPNhRdPCW3Tnd710nqvGpf+ulqqun74St9TJrq29stN4yjC0e
	5qvCJaLfBr3oQC19iLhm64IM92VlEXASYz3Qgllfy9A806tBT4Uo0yLVVY+d7jW2+pqTS38/2VA
	zJu9zbcbswvWjDy3BJuztat5GFmf3vDL35wlfkknMC0iTJhjYyUd0SwpNMN5fCgyvJX1FiJoBlI
	BxCe2YZnxkpJlVDxzswQmwWkBpyOnWMDtLYq0MWtYpVlyXNsv7texp4BzLHcAmCKfIFErxdgGy6
	jbLHWLmaMVKBJ3B9gwX2djK+SM5BjoiW9Iua/Px/fzS67PmBuUoQVCJGNLHp5G4
X-Received: by 2002:a05:6512:10c2:b0:5a8:89ad:e172 with SMTP id 2adb3069b0e04-5aa0e742357mr3823633e87.37.1779103397058;
        Mon, 18 May 2026 04:23:17 -0700 (PDT)
Received: from localhost ([2001:2043:be0a:d700:1996:ae89:4512:3a7e])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-395882c7214sm12065881fa.14.2026.05.18.04.23.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 04:23:16 -0700 (PDT)
Sender: Erik <erik88@gmail.com>
From: erik@cervined.in
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	charvi077@gmail.com,
	Erik Cervin-Edin <erik@cervined.in>
Subject: [PATCH 0/1] commit: allow -m/-F with --fixup=amend: or reword:
Date: Mon, 18 May 2026 13:22:24 +0200
Message-ID: <20260518112225.73172-2-erik@cervined.in>
X-Mailer: git-send-email 2.54.0.772.g683d7313b1
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Erik Cervin-Edin <erik@cervined.in>

The commit --fixup=reword: (and --fixup:amend) options are powerful but
currently not well-suited for non-interactive workflows.

I often find myself hacking away on a branch and the last thing I do is
finalize and formulate the commit messages. One of the current ways of
doing this is running an interactive rebase and picking the commits in
your branch to reword. However, doing this requires you to linearly go
through the messages and edit them one by one. The other options which
allows more flexible editing is to generate linear patches -- but this
trades editing freedom for branch topology freedom and has its own
drawbacks.

The --fixup=reword: flag introduced in 494d314a05 (commit: add
amend suboption to --fixup to create amend! commit, 2021-03-15),
adds a third workflow which allows rewording commits without initiating
a rebase and from the comfort of the HEAD of the branch. However, doing
such editing is only possible using $EDITOR, which restricts its use in
some workflows.

When amend:/reword: were introduced in Charvi's series, -m support
for amend fixups was discussed but not pursued
(xmqqwnuvsw0d.fsf@gitster.g and xmqqczwmsjzl.fsf@gitster.g):

On Fri, 26 Feb 2021 11:32:30 -0800, Junio C Hamano wrote:
> >> > +                     if (have_option_m)
> >> > +                             die(_("cannot combine -m with --fixup:%s"), fixup_message);
> >> > +                     else
> >> > +                             prepare_amend_commit(commit, &sb, &ctx);
> >>
> >> Hmph, why is -m so special?  Should we allow --fixup=amend:<cmd>
> >> with -F (or -c/-C for that matter), or are these other options
> >> caught at a lot higher layer already and we do not have to check
> >> them here?
> >
> > yes, those options are caught earlier and give the error as below:
> > "Only one of -c/-C/-F/--fixup can be used."
> > and only `-m` is checked over here.
>
> And the reason why -m cannot be checked early is because we do not
> recognize which kind of "fixup" we are doing when "only one of
> -c/-C/-F/--fixup" check is made before this function is called?
>
> OK.  I wonder if we can tell which kind of fixup we are doing much
> earlier, though.  Then we could extend it to say "Only one of
> -c/-C/-F/-m/--fixup=amend:<commit> can be used", etc., and we do not
> have to have this "only -m is checked here, everything else is
> checked earlier" curiosity.  But I do not know if such a change is
> necessarily an improvement.  I guess a better "fix" would probably
> be to add a comment to this function where it only checks for "-m"
> and tell readers why -c/-C/-F do not have to be checked here.

This patch picks up that thread by allowing both -m and -F for
amend/reword fixups, bypassing the need for an interactive editor.
This makes it practical to, for example, write replacement messages in
files and batch-apply them as reword fixups without stepping through
each one interactively. It's also friendly to AI agents who have a hard time
editing text using a non-interactive $EDITOR.

Allowing -c/-C was also considered but left out of this patch -- it can
be added in a re-roll if reviewers think it's worthwhile. I could see it
being useful, for example if you want to use git notes as a re-write
commit message channel. Since this is my first patch I intentionally
thought it best to start small.

Erik Cervin-Edin (1):
  commit: allow -m/-F with --fixup=amend: or reword:

 Documentation/git-commit.adoc             | 13 +++--
 builtin/commit.c                          | 41 ++++++++++----
 t/t7500-commit-template-squash-signoff.sh | 67 +++++++++++++++++++----
 3 files changed, 92 insertions(+), 29 deletions(-)

-- 
2.54.0.772.g683d7313b1

