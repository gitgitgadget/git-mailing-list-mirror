Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A6E1662F1
	for <git@vger.kernel.org>; Thu, 26 Sep 2024 19:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727377930; cv=none; b=gciNOYfyS1AMHrECJHoXsaHNq/D0pou7KZq4sTpF2ihpzCGIL7iYj2comboYvvTzc+7mKmudOFQWy7fKqJ/AAmbbIV2nC6U4AYXDEzTk7PMJTkd8lGe9kgKIGxiidMbGygoFf2AsV6GHJ2QmTfir5N/ROjWJl5lZMzQi/7LokMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727377930; c=relaxed/simple;
	bh=g2fOwqtFk8qot01fxj4PO2k5yBzjYsuF3G5jGWO4iSk=;
	h=From:To:Subject:References:cc:Date:Message-ID:MIME-Version:
	 Content-Type; b=NIw0AgZ1fGuoxBpjyUgChVzPzQ47jIH2GDR1I9x2KDyVb0ze2jAFQl2QVGaH6Fw3VzgxBAvYsNeFUQjmDL+8AAAKQOD3KihJZJWK1q+xW0XhpDL7DimgQCB20Jp18edQxySFwDFT+LYylGQJyygVUWFAh/Qh9M1aKnl+4f7h7DM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b5JJGniG; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b5JJGniG"
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-5d5f24d9df8so718161eaf.2
        for <git@vger.kernel.org>; Thu, 26 Sep 2024 12:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727377927; x=1727982727; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:cc:references:subject:to
         :from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=MxafKIJ5IJGIQAiEXnqXldOgHX7NjIe4gc3vdghGGvE=;
        b=b5JJGniGOOKlXN22no4mAsar6dtzbzOogsp4CmNwiPGsb3DA0nC7T65F8607pKJxCu
         j6VD5P3V/aK3kDZRUKHyI1tgGHPVdF+Slw+7qiqV3ds6fifV/Z0j4m3KXvmo/Cu3qGTS
         GAgGRQSTn8Y2ZYXlFN6prFcmi6paSwlmNgNSgYvzNp4UbtVeDhsUst47rvs5gN51URa3
         GpAyJtkSoBkAmSay1HjgT9FvxWSsnAlXNzWlPA4EXOyydAj2eo9m8XtzP0SOneM9oWgA
         fW0oLAUlMvqeWvCkHkk76dW6ThIo2AF3+Nbcza/srHhU1L5f+54ZWp0Z6cx36yrOoyRF
         fTdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727377927; x=1727982727;
        h=mime-version:user-agent:message-id:date:cc:references:subject:to
         :from:sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MxafKIJ5IJGIQAiEXnqXldOgHX7NjIe4gc3vdghGGvE=;
        b=vE+NvTPPrObwI81hT3QIZLjqIh9y6fgr9LIbh4eOKuM59WkEzExG7eYBLNn8rMDboS
         VPSYuRO4Bm7roPKY9biTAnMq4kpgupHDQ1OecmegwBjmNV2RQvZ9qxqywnXOMrGTRxkY
         aLcSnGc1bChBVZUwrhYvB7nOA+UX8h3PALKUF+zne4bQ20BU/EcZNkmQAL82Aj5gxwFw
         shsdjjOrxN5an5XMmtw34sskyRJ0Z2rYaqkJvK/TFTdle8iCe2kiKP3GTyPjYhzhAhIo
         PVhY4J4k+vy5SxSwc+Z+Dsq4pbVFjlH9U3nOTjBr+7I4HxiPvZtxAbB0I3DKnQTDon27
         iQyA==
X-Gm-Message-State: AOJu0Yx6SXKwaTm5CH556IaIK4EfXuPviBD6znCUCrIBvT3NWfrsNOvT
	h34jc5CvwW8A5qjgWs79BcaYnAbJoxUhYmeBL1PhLjtTCyDHmD2+dI14xQ==
X-Google-Smtp-Source: AGHT+IGfKi3mf0sl1eXDCAXDiW0FDRI/ZP69tciEBhuC0GkdFxtOSDq6g4kUGnUgG27w5oSnCIM2dw==
X-Received: by 2002:a05:6359:8488:b0:1b7:ed21:a29a with SMTP id e5c5f4694b2df-1becbb9705amr109644255d.15.1727377926996;
        Thu, 26 Sep 2024 12:12:06 -0700 (PDT)
Received: from localhost (217.108.125.34.bc.googleusercontent.com. [34.125.108.217])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7e6db292aafsm254262a12.14.2024.09.26.12.12.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2024 12:12:06 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH] howto-maintain-git: discarding inactive topics
References: <25050ad6-bdf8-4b1f-bbc8-cffe6ca15386@gmail.com>
 <xmqqy13ei819.fsf@gitster.g>
cc: Christian Couder <chriscool@tuxfamily.org>
Date: Thu, 26 Sep 2024 12:12:05 -0700
Message-ID: <xmqqikuii60q.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

When a patch series happened to look interesting to the maintainer
but is not ready for 'next', it is applied on a topic branch and
merged to the 'seen' branch to keep an eye on it.  In an ideal
world, the participants give reviews and the original author
responds to the reviews, and such iterations may produce newer
versions of the patch series, and at some point, a concensus is
formed that the latest round is good enough for 'next'.  Then the
topic is merged to 'next' for inclusion in a future release.

In a much less ideal world we live in, however, a topic sometimes
get stalled.  The original author may not respond to hanging review
comments, may promise an update will be sent but does not manage to
do so, nobody talks about the topic on the list and nobody builds
upon it, etc.

Following the recent trend to document and give more transparency to
the decision making process, let's set a deadline to keep a topic
still alive, and actively discard those that are inactive for a long
period of time.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/howto/maintain-git.txt | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git i/Documentation/howto/maintain-git.txt w/Documentation/howto/maintain-git.txt
index da31332f11..e797b32522 100644
--- i/Documentation/howto/maintain-git.txt
+++ w/Documentation/howto/maintain-git.txt
@@ -67,7 +67,22 @@ the mailing list after each feature release is made:
    before getting merged to 'master'.
 
  - 'seen' branch is used to publish other proposed changes that do
-   not yet pass the criteria set for 'next' (see above).
+   not yet pass the criteria set for 'next' (see above), but there
+   is no promise that 'seen' will contain everything.  A topic that
+   had no reviewer reaction may not be picked up.
+
+   - A new topic will first get merged to 'seen', unless it is
+     trivially correct and clearly urgent, in which case it may be
+     directly merged to 'next' or even to 'master'.
+
+   - If a topic that was picked up to 'seen' becomes and stays
+     inactive for 3 calendar weeks without having seen a clear
+     consensus that it is good enough to be moved to 'next', the
+     topic may be discarded from 'seen'.  Interested parties are
+     still free to revive the topic.  For the purpose of this
+     guideline, the definition of being "inactive" is that nobody
+     has discussed the topic, no new iteration of the topic was
+     posted, and no responses to the review comments were given.
 
  - The tips of 'master' and 'maint' branches will not be rewound to
    allow people to build their own customization on top of them.
