Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DCAB1E32D3
	for <git@vger.kernel.org>; Wed,  8 Oct 2025 17:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759943414; cv=none; b=qhiC9TggKZpIgTK9XCUhzvxHZjM6jdoUi+/P9fZuXq/vCxO+Nv9+mmQoALFXiiZYXrgeIbWL9i5y/DSd0hWXMUhCs7J7prDf8SgL1NZCrv/ZPmemY5a9O0UNwt9NJIK4gtGWTwyEsclppmqNlMnIK6eLMT/JolMkoGhPLauPLuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759943414; c=relaxed/simple;
	bh=Z1iprDSpIb1UxkJEUIh40VJ98S9vYZy7x52k7aZshWY=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=iBWR49EEiPtYUnXIvdS4hbFj97TYqTzTFF5XToCX/rjt1VCVL/aO+Lj+x0Gl8cSrMf/ecsVihocLfoy/6jKOTIpbmIZrDS8XwNBOIt18X5Quyh2WD7oAQ/F5UKPjpfv86K61iIKmX47zcm6iAIrX61/WhX2AQliD10FPFWi2vqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crateandbarrel.com; spf=pass smtp.mailfrom=crateandbarrel.com; dkim=pass (2048-bit key) header.d=crateandbarrel.com header.i=@crateandbarrel.com header.b=hfL+DLzg; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crateandbarrel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crateandbarrel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crateandbarrel.com header.i=@crateandbarrel.com header.b="hfL+DLzg"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b551350adfaso1753a12.3
        for <git@vger.kernel.org>; Wed, 08 Oct 2025 10:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=crateandbarrel.com; s=google; t=1759943412; x=1760548212; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=G8Jq5Jk7k4H9xVWpfLjVY6T7/W8IDu7bnQcMeMPDnHQ=;
        b=hfL+DLzg5BFF5fNjpT4LdGMdDhEp7ZztctJxu8mKBRpTMUmbGjcIuMbsb+oh2JnNUo
         Pv0iKWzPRhVAsDcQBUkt/6u00qzQaaR4Ney1Zvwh5Y6HJhs55S4ArPvURah2x8HP7Scq
         MbyKcxW4xnngXPiBd54lDb3fPkn5Y0JE7hhQazpQWXgS7qfAidpfahYVFbW2O6CfzHjI
         RPS9hO6i1R7EVW6LW9SJBRK33VAyLXbqg+sL+zotYTacu3r8i2g/X7xFsAyEQ8Z/e/m2
         AgIgvMvCfjXVIGjreHUM6qvXUXn5ACwNJ+HqXYzCOKpzPAFiPEKZc0NClx3nUvqXu4oT
         dqUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759943412; x=1760548212;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=G8Jq5Jk7k4H9xVWpfLjVY6T7/W8IDu7bnQcMeMPDnHQ=;
        b=XgQWqQ8wTHTtSfY3xPKVJSMY70xRhSq4iLGbrzWlZSQlo+NqOq44YBjbp+zbva7i6L
         XsXDyr6MBoIOhPxpZcH7YkhbfoafLx5BB3AeXx3UwumwknpkHr0YM6X1ExppJgtn5vn+
         +4VzhZmJOEGaHsGvaqgxN4aMwMqHHixCQ2lyZQeAWgBZmBTihlii8wsjk6DYhcGs/aZ2
         +qjv+kM1U9TRjemT0koxszcnED7D6BI4aHjDq4n+H6GSsS6pRlty7I6sUyZRpMAhsbiY
         vz2Jmo95q6BqU4Li1onkxakHonf8ZMmOi0onotmlmP+2gU/BsIIbtfD4sUvFO25Ox2Ib
         ZTng==
X-Gm-Message-State: AOJu0YwU5NkCgkj6Z03eC7bkIu8Qn85PnyUZueSjtwTFevGbcnyUk+B9
	ybBf0H0oIlsuOvKEJIJbtYMHxn6SbjPaZx2KUIRkPeEpMjQ0ertQQ59W5QgAYbBpMAnxroLkCo8
	7K/z4QRh4SHJPvW20p52FrsA5UtMDG6PMauXSmsETU5M9gC+/8F9tOg==
X-Gm-Gg: ASbGncsYoqcak2vO5rGCgp8v/Q2SQbWe5kfvhHhvxnywn7UFL53Hl6Dy2yjwUtXFYcZ
	OO6FrVregSyB1srAfMq5SAgfiZC6O3orDl5J0lvK1cqHFS2JGyC+tIHdohw0N00U27FT10aEp9Y
	TCnRorUgtOrOGQQtCd8dURKXbdGlJqc+mJDZg5RvzRztyFAQiVambI60JV9tiMXqVrJzS9JugIT
	jTe4WqIL83u7e9WSXwr0nWOs6arj/o=
X-Google-Smtp-Source: AGHT+IFpC703l/7GlacpPW5BwED8eI+Kna6CyT9sDoSOGWWNWenO2Vq76/kO1wP1UWWSfX66AnfSBWXE4eaEwuHA5Mg=
X-Received: by 2002:a17:902:f60c:b0:25d:1640:1d59 with SMTP id
 d9443c01a7336-290273564d2mr49847845ad.8.1759943411832; Wed, 08 Oct 2025
 10:10:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Patton, Timothy" <tpatton@crateandbarrel.com>
Date: Wed, 8 Oct 2025 12:10:00 -0500
X-Gm-Features: AS18NWBFCD349D8S0GgPFjVwjweQD0LXcsbtoFia7jmGp2DDo_ikiU442xrfK7A
Message-ID: <CAMnRnOWm8iV+JNcVReczh79pNX2zwsPcJm2z4a+8Uj3E1xcq5Q@mail.gmail.com>
Subject: Jenkins Git Plugin
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

I recently started seeing the following in build console output when
pulling global shared libraries from Git.  I need to see the change
history part of the build being performed.  How can I restore the
previous behavior of retrieving the changelog when the shared
libraries are pulled from Git?

Commit message: "updated getChangeset to include 5 history entries"
 > D:\git\bin\git.exe rev-list --no-walk
d30fad4563120956426e48bdfe1cbdb450bf932d # timeout=10
'git whatchanged' is nominated for removal.
If you still use this command, please add an extra
option, '--i-still-use-this', on the command line
and let us know you still use it by sending an e-mail
to <git@vger.kernel.org>.  Thanks.
fatal: refusing to run without --i-still-use-this
ERROR: Unable to retrieve changeset
hudson.plugins.git.GitException: Error: D:\git\bin\git.exe whatchanged
--no-abbrev -M "--format=commit %H%ntree %T%nparent %P%nauthor %aN
<%aE> %ai%ncommitter %cN <%cE> %ci%n%n%w(0,4,4)%B" -n 1024
