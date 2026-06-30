Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57DC43BFE3B
	for <git@vger.kernel.org>; Tue, 30 Jun 2026 15:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782833361; cv=none; b=UYLhfqF2KkTux8XnfWQ52WY4I6tJJRyx0pB3ZK+ETnLofaMPVQtpKwzhKHTGCVowM4bnkTzurjZMPNbt3AdIXvd+D1/Zt2BbMPwi18wuUkU9WoAGuEs0VFbOyqfjE5wb3Xbp5LsSm46OcrU3KZuqsqS+otDLmM8EEicytlKlekM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782833361; c=relaxed/simple;
	bh=BoYoKxDptZHzwFc9atfDzusSkrvzomKEXrJ/JC0CBzA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EovaP4BF6hWt+PQwerUStDLyPz0aSyBpQZaqfMlO7tOWXSbwIYgL4ZC787v9f03T+LoKSjbTmKO7FI6ReM0iHrmHSgiEgs5E+43Sb7uH+2LizLAVh7gE7kEYv7YB39uzpZmapEE1Ldk7uztaISCy5BxldtmrIsp3fSUhwsD5nhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mRHhBGR8; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mRHhBGR8"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4926f8e02e8so28726935e9.0
        for <git@vger.kernel.org>; Tue, 30 Jun 2026 08:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782833355; x=1783438155; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=n6Neyhmp3W7rdulRwfkV3qvC/vhdWLnUNZSoP/dS41A=;
        b=mRHhBGR8PQh4IIpP/KDIxeR57T6tbbYkJSpswwZiatk8VZz5tMxo2EH+ttml+eHsvE
         T6d5xIIww2s29AmSo4ucMx1wfJ8pOcy2WP3UmRiXkyNwPSGLTCQpisqMX34ZJpl/DIVy
         Y1jzM8RDgSCRV376nFe47WzA1MCZ8umdG43NhoSXboKsQu6RWczexozPnULxbVlf07RC
         I0Gbq/G8DDALoZirtBEFFZfTI5gCLTq6PkSbiO5WA2wGbYRmH7Dd47/tV/uFiHdHK2+D
         +yYuRWgdHPgnqsMsTWQC67BU21ctf7/tBgyjqkLQI6hhpSqp12RVYwINm2QHQnjLkmMX
         iTsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782833355; x=1783438155;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n6Neyhmp3W7rdulRwfkV3qvC/vhdWLnUNZSoP/dS41A=;
        b=B4t+X0Kx6v3RJhxWD6exN9sanw6A7MIxdpBhZwBUrfXPT+8mpuXyxne53GMj5er8Bv
         qU1vUBh9t+MoG/5i7u/3njRZ8FhdbN4y+bJ168rSvYv2v1RY6zeDXdhdyW0rhnQmKR7j
         WqwHwI0q5Y7Kq0nykRx0/T87poJqri5jEMGy9/qi/GTbSpuJFMsYQmXZDHVtc8ABJ/Ae
         En5lmDKpKpb3Z1Xp102E7di9KhQKxX5JA1Jpi5Xq3U47cYQnRHjVbtZ2otOM4ilQvgY3
         +rKSrdWApdnEO6nXUmiu4Gm7aYXar9I1N5y0HxOxPTGuKuBlV45h2WB38ScbBdsWCH9B
         ajPQ==
X-Gm-Message-State: AOJu0YzQ1hDhmYhH3sw9tf3UZr56qDHOHwspKgpSFF4RHe/OTbkIID5+
	lC9yrr2qJqYe8di08haN4HRZQY02qoqByaUj4uufjOat9+0P7QT3QfETX/i8tQ==
X-Gm-Gg: AfdE7cmTrlNmhpFqhjx73tRsIkgzL7moW05t+aaSjlKWF7Y2wrjPlgnJfzv7sGanTA6
	YDSbUgGJ2ieAn1rLfvX9eL/cVFhsDPRGPGbhu+YmngHsIuV+XO1ydv1aXe/5yi4quEK44XblFTf
	tHYqeHTHU0XMeFKuBrMS5DG461dXMDdVyeVivubq11aNpJ+66F9ivEwXOk5qjeju9RAP8PPXzMZ
	olWAJInqPUJqiMs+f+6Pg63DhGn5O0KwxMl5G55n6/Ke+yho2O3tpv1GwpwoB2dhfUzpkSs1d0H
	TDhCQ425/OOfnTAnN6mUcsxLSyQ7oP4KBB7wdKLZPrGzpBaAuxpLb+TVylII+bi48qDpXsWzvbK
	hr3jVDlYNv/TSc+MOYuKDqjNjpRF2MbUl6e4FyLln5ClTya7WxBIFt3GH6dgDcejxG+hTUE2tRA
	iI2pzWVj7jE/+eqauHeBx0JAyKVxM=
X-Received: by 2002:a05:600c:1c0a:b0:493:b03c:5650 with SMTP id 5b1f17b1804b1-493bda6fc65mr15943035e9.19.1782833354727;
        Tue, 30 Jun 2026 08:29:14 -0700 (PDT)
Received: from berwick ([2a0a:ef40:69a:b801:201a:26ab:8d41:fb43])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47567979eafsm8477378f8f.34.2026.06.30.08.29.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 08:29:13 -0700 (PDT)
From: Phillip Wood <phillip.wood123@gmail.com>
To: git@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH 00/11] sequencer: do not record dropped commits as rewritten
Date: Tue, 30 Jun 2026 16:28:50 +0100
Message-ID: <cover.1782833268.git.phillip.wood@dunelm.org.uk>
X-Mailer: git-send-email 2.54.0.200.gfd8d68259e3
In-Reply-To: <67dbfb5c-5f07-49b8-aa32-a4635c585028@gmail.com>
References: <67dbfb5c-5f07-49b8-aa32-a4635c585028@gmail.com>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 19/06/2026 11:13, Phillip Wood wrote:
> I'm happy to take this forward and try and fix at least some of the
> other bugs I've listed above. Uwe - if I don't cc you on some patches
> within the next couple of weeks please feel free to send a reminder.

Here is the first batch that fixes the same problem as Uwe's patch. I've
taken a slightly different approach that uses the return value from
do_pick_commit() to signal that a commit was dropped rather than
adding another function argument. That involves a number of preparatory
patches, but they are hopefully reasonably small and easy to follow.

If a commit gets dropped because its changes are already upstream
then we should not record it as rewritten. As well as confusing any
post-rewrite hooks this means we end up copying the notes from the
dropped commit to the commit that was picked immediately before the
one that was dropped.

This series is structured as follows:

Patch 1 restores some test coverage that was lost when the default
rebase backend was changed.

Patch 2 moves a function so it can be called without a forward
declaration in Patch 11.

Patches 3 & 4 fix the return value of do_pick_commit() when an external
command fails (this is in preparation for patch 10).

Patches 5-9 try and simplify the control flow in pick_one_commit()
in preparation for patch 10.

Patch 10 changes the return type of do_pick_commit() to an enum.

Patch 11 adds a new member to the enum from patch 10 for commits that
are dropped when they become empty and uses that to stop them from
being recorded as rewritten.

Base-Commit: 6c3d7b73556db708feb3b16232fab1efc4353428
Published-As: https://github.com/phillipwood/git/releases/tag/pw%2Frebase-drop-notes-with-commit%2Fv1
View-Changes-At: https://github.com/phillipwood/git/compare/6c3d7b735...26551f268
Fetch-It-Via: git fetch https://github.com/phillipwood/git pw/rebase-drop-notes-with-commit/v1


Phillip Wood (11):
  t3400: restore coverage for note copying with apply backend
  sequencer: move definition of is_final_fixup()
  sequencer: be more careful with external merge
  sequencer: never reschedule on failed commit
  sequencer: remove unnecessary "or" in pick_one_commit()
  sequencer: simplify handing of fixup with conflicts
  sequencer: remove unnecessary condition in pick_one_commit()
  sequencer: simplify pick_one_commit()
  sequencer: return early from pick_one_commit() on success
  sequencer: use an enum to represent result of picking a commit
  sequencer: do not record dropped commits as rewritten

 sequencer.c                   | 154 +++++++++++++++++++++++-----------
 t/t3400-rebase.sh             |  16 +++-
 t/t3404-rebase-interactive.sh |  11 +++
 t/t5407-post-rewrite-hook.sh  |  23 +++++
 4 files changed, 155 insertions(+), 49 deletions(-)

-- 
2.54.0.200.gfd8d68259e3

