Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E4E612D761
	for <git@vger.kernel.org>; Tue,  6 Feb 2024 10:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707213779; cv=none; b=FNfKYI2ufXlTSmVA2YZXtK3hh8yhjoGHltaGG2P7VwHYAY5CZqPC37UJASBzCLqUhTZ15mHgKL3FkQ00N29JDYoqRwwm2eNwWwQA9VaDFn9/evHWuBd6b6UFofSNT0C1AVmGOPPGi2c35vDjcJKNkFZqV/Gb/qOBsK+fCrc0syE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707213779; c=relaxed/simple;
	bh=BCcW2FQiFuzpQVdDQ6yCoIcXff8Z0AClC+rgkvM1Ydg=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=DGIG/ibtAEYoUPrKS3msH0CML34fn/JVviRBqVaKYWWPJxQK6PXv7LBbsK6MxhXgLf5FdAj1HDRptihiuFNfunNDoPk6iS1z0gyruayRZ69509MxNX1E+o6aoUbnlRx7Z30uSxxMH2emg2FvRsTF02dWJwyXjRQciaPrIeuOdrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kBQZ/uCq; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kBQZ/uCq"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-55a8fd60af0so7053116a12.1
        for <git@vger.kernel.org>; Tue, 06 Feb 2024 02:02:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707213776; x=1707818576; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NzcTMehewYUkNBug803UpgpY53POROc6gOWvYWmgE48=;
        b=kBQZ/uCqmZsvPEUxH2fadSWI/7zJPkhbfijHNci0iRtMJzhQcTjqN++6gdM2RR2OlV
         pMz6qz18zXfGiabIJCavrBDViIfhKZRIe+keNj07dJ8mGBuRT3l7RNKOuiEjwJOjofr+
         cCgiBsPX2OGz2ikZp2hpQbH2z3gWhVypg/Xi7TVtSY2zH9NFTGY9CWbagDOuAQOgDz5g
         ybmGqOjOJzmO+sxbuwfbO/HB1AV69OcB7Ue6RgSvsqo6NCs1C9JreXy22fJCOc8knazy
         iKNJpHF2/LOey1b8GxXk/tWyZJt4jvDuWwV5D2/3TS6xund1MFKNscHwAYXOwEk0PM3t
         7SwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707213776; x=1707818576;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NzcTMehewYUkNBug803UpgpY53POROc6gOWvYWmgE48=;
        b=coMM/olyIUg4Tr1uIyav2+eLCRnX8LfEFL+bJGEH/GHjWvY1lVe0yE53uHD2JkgfvI
         L702Sj96zclGdCpddwKRNkOhdrSx5Z0CKxugtEQa2KDIwdOLEB3iW1TTw91RtDfJchss
         YnxHhq1Yk75uzSbBjzG6KqGHikqs7jUYhYflUSKK+Vvqot41fbC/171LQD3mmWUUeTIa
         Nr8nNOHBCyK/AnaLjozYvxoFddSCZj5nVEsfBV18V9Btu8KfiwJ2bXCjiR1bRYKMNPn1
         HPGPf3agFKGfwJhjFGLZ/sjuVoB/SukfcEy/e0FRXX8LMGARHJRGgmwX1W9W2dYARmcV
         q/SA==
X-Gm-Message-State: AOJu0YxjepHzjuhLcH5z7OGd4QElgIWivm5nsNYnLUSWK2mFOnm41bVh
	UIOPsn04VKXpmAddVKh4TIj+dQtZZ244AekT4SigEQ/mY6+6LkQBqG71MbpOtnpA12q+TRLe3J+
	L7HsgWGxm/gxJASo4YGWOGYA4TXJ1evrR7+M=
X-Google-Smtp-Source: AGHT+IFtpFCoZNBd9twqvM3Oe45FwzJR6G1ATYs3fLxTgxcj12ZgAmdSgiivCA2LX9NehiDZcLJYTLr7SHjU1xRnbkM=
X-Received: by 2002:a17:906:3498:b0:a38:25f0:aa35 with SMTP id
 g24-20020a170906349800b00a3825f0aa35mr992922ejb.41.1707213775656; Tue, 06 Feb
 2024 02:02:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Britton Kerin <britton.kerin@gmail.com>
Date: Tue, 6 Feb 2024 01:02:43 -0900
Message-ID: <CAC4O8c_oKT+a0hm+tqSOG7d1=AuJJKy5bsh72cJKVsWynvHw+w@mail.gmail.com>
Subject: is it a bug that git status show the in-progress 'edit' in an
 interactive rebase as 'done'?
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

If I do 'git rebase -i master' from a branch then set the action of
the first two commits of a branch being rebased to 'edit' and exit the
editor, an immediately subsequent 'git status' shows (for example):

git status
interactive rebase in progress; onto e79552d197
Last command done (1 command done):
   edit 71b73de914 message for first commit
Next commands to do (6 remaining commands):
   edit 3a478a7a08 message for second commit
   pick fab7159cf4 message for third commit
  (use "git rebase --edit-todo" to view and edit)
You are currently editing a commit while rebasing branch
'my_completion_updates' on 'e79552d197'.
  (use "git commit --amend" to amend the current commit)
  (use "git rebase --continue" once you are satisfied with your changes)

This seems wrong, because until git rebase --continue has been done
the edit operation for the first commit is *ongoing* and it would be
much clearer for the output of status to accurately say so.

The same applies to edit operations that don't happen to be the first.

Is this a bug or is there some reason it's like this that I'm not seeing?

Britton
