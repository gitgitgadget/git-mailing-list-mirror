Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB6131F1508
	for <git@vger.kernel.org>; Sat,  3 May 2025 16:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746288609; cv=none; b=LnUNHyerOcejF7AJ7R7ZoEB3sUkU1arXn3HrSpyVVeRo743a2rS1JYZYU4QXR4FmgDh4tMbtNqXN8iLBijiBWO3WzSYILEqaTbq882VV5MV/6GQU1qxtChM1tOxtNgapHL3K+82D9xk/iCtikCIt9loB5f07fxDWj+Fqyg5iW7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746288609; c=relaxed/simple;
	bh=8SM9v3EK+rDHzQPqdHT/a5ke2RmGlNMRpMsSfWNd36A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kl+/pAQy5XBm1gRT+d4zfwfoo2nwOfRApWLOzsI08P7VBBu8c44Y1K3WpTvNs4LqcXhXZSYBTUEv8Ryb5QgtdgtzKBOauj64kIENTEpFjFdRwVca7OnGoKGjvAu8HRj5CvY7YkL46vO5AxV4Q55hbCvuMxHpgmlaSUkERtzb6hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lazar.co.nz; spf=fail smtp.mailfrom=lazar.co.nz; dkim=pass (2048-bit key) header.d=lazar-co-nz.20230601.gappssmtp.com header.i=@lazar-co-nz.20230601.gappssmtp.com header.b=ABLXi+ox; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lazar.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=lazar.co.nz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lazar-co-nz.20230601.gappssmtp.com header.i=@lazar-co-nz.20230601.gappssmtp.com header.b="ABLXi+ox"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-39149bccb69so2250559f8f.2
        for <git@vger.kernel.org>; Sat, 03 May 2025 09:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lazar-co-nz.20230601.gappssmtp.com; s=20230601; t=1746288602; x=1746893402; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zUyWaHJoZAiC2gVwDTW7VMcWP7hhvG9h8q7/kPEvXmc=;
        b=ABLXi+oxSKnzfMvaS44vL1ot5mQlYGWBs5cfEyHUqLu0gxclk6n+vsGkqwqpY4lCvV
         Mj72FSiRVN1HrVpaAOrBHQ8FDAD1etBBygvJoLY71ceWuTBmWpnO4gioEudjX9uQzUkv
         I4FDvm0wsDF1iR8izDNaSsVH0rR0JdH7hF7ryGPiI04KQk2aeNxu6NLy4jFNn/gZwir6
         SIdvszdzTESJWEGqgehsxIDbrNCd9BZry69aP2fiVm4JIO8b0oMh/2lfbHxZRDZ6zgEE
         lm5c0urXnKsIY0MUEbtp7jqrRWcyk9lyqahz0MOyjJzX/XdRALW0e8t1yclgrp1qNrqu
         ndYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746288602; x=1746893402;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zUyWaHJoZAiC2gVwDTW7VMcWP7hhvG9h8q7/kPEvXmc=;
        b=YjAzVV6KC39Ro/AiqzT1NvzC6C/WX0FJTxtxKG+UoaRbDKqcAdDPO1p+mjCYHnUxyZ
         aJrFxSFbchCl8JAi1b89XOGD/Qa0vUUmFQauaXya9JGoDjOEvxMYM8h1TMoNoJ0zaDqx
         HEaggI3dKwPUvd8OwociFWR4hMGC+7XzgUjNesWtnHhNLdB/nNgSjHdPVdlojsiqaNtP
         fyQP+nL5Kp5jjHGFnpH8Wwbw2rI6ZGgktMjgEDCAtTmp3LrT54mIO1Vs8mm37OXTcSFy
         +L/wszXAPS7d8u1zKthBenSRyLJ7oBF0KfacI0WLJkGYE4e6k+7OHOKFPaqsCFA+vG4S
         qkmQ==
X-Gm-Message-State: AOJu0YzwtXrPPMu4sQt0r6c0k530XecaWc2hfc8Dm6HB60JB2qio2ZAz
	UT2xbEFhCXIlVgVXn+n2cNv9QW07WGjuauHAbjuAMJY8xlxPWg5buobBhe6mXsxZXYU1f+ErDa4
	JVSw=
X-Gm-Gg: ASbGncsyB9WSAPXAR5g9ZekdB1uDxwBXvDrBImwhASRw3zdNhYzMGW3bRVq7AlvdTTj
	OLzeo5p5inMgqskpT0cNw45EOcW4mi6TRiBb132eDEHhma1nu4OFGvAhORiXpVa6nhTMzBiAHPE
	RRrTEA1+mGDahtOQpNrZ8h7K0EjngWWcb7Q6mlnd9AkKh4htbwMpdFNS8cluymGKmRyc0aaPHAp
	uttiGDx8M7v62QwU3fYfTkx/I5Gsmh3+kVMI8bQBYX+thtDsn+5M4+w5sjAzpBebzvMY8fHdIzU
	42mm9ywPX9x6D2pBkscxLs50aLTpDTuzdvQ4P6PzGIvUDA+6OElUd3k=
X-Google-Smtp-Source: AGHT+IHjL5SeX3MwhYnI2B8R8LZbIthV9G27JlAHFAEQrWUh4rR8srrnCRGkDe/cVRwRRjdQusBMHw==
X-Received: by 2002:a05:6000:2289:b0:3a0:7fd4:2848 with SMTP id ffacd0b85a97d-3a09cf4e558mr2307871f8f.52.1746288602187;
        Sat, 03 May 2025 09:10:02 -0700 (PDT)
Received: from DESKTOP-H1V1TGM.mynet ([143.58.255.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a099ae8117sm5235754f8f.56.2025.05.03.09.10.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 May 2025 09:10:01 -0700 (PDT)
From: Lazar Sumar <sumar@lazar.co.nz>
X-Google-Original-From: Lazar Sumar <bugzilla@lazar.co.nz>
To: git@vger.kernel.org
Cc: Lazar Sumar <bugzilla@lazar.co.nz>
Subject: [PATCH 0/1] New remote groups subcommand
Date: Sat,  3 May 2025 17:09:51 +0100
Message-ID: <20250503160953.196329-1-bugzilla@lazar.co.nz>
X-Mailer: git-send-email 2.49.0.460.g0390bdefd0.dirty
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

First submission, any guidance is appreciated.

Having recently started using remote groups I have found the feature to
be missing:

  * bash completion
  * easy listing functionality
  * remote renames don't update group members with the rename (tricky)

This patch aims to fix the bash completion and simplify listing remote
groups by adding a `git remote group` subcommand.

Note: the bash completion can be solved without the subcommand, using
something like:

    `git config --get-regexp 'remotes\.' | awk ...

but if this feature is intended to be supported then giving it a subcommand
felt like the better approach.

Lastly, I wanted to at least add a test for the expected behavior of
remote grups when a remote is renamed but found the current behavior
surprising, i.e.

    $ git config --get-regexp 'remotes\.'
    file:.git/config        remotes.group1 upstream origin
    $ git remote rename origin fork
    Renaming remote references: 100% (8/8), done.
    $ git config --get-regexp 'remotes\.'
    file:.git/config        remotes.group1 upstream origin

The remote group is defined in the local config file and I would expect
the rename to rename the group member here. However, should the group
have been defined in the global `~/.gitconfig` the current behavior
makes perfect sense.

As this was unclear, I decided not to include it in this patch series
but considering that the area I am touching is the same, any comments
would be appreciated. If we reach a conclusion I'm happy to create a new
patch series to follow up on this.

Lazar Sumar (1):
  Add git remote group sub-command

 Documentation/git-remote.adoc          |  6 ++++
 builtin/remote.c                       | 47 ++++++++++++++++++++++++++
 contrib/completion/git-completion.bash | 21 ++++++++++--
 t/t5506-remote-groups.sh               | 31 +++++++++++++++++
 4 files changed, 103 insertions(+), 2 deletions(-)


base-commit: f65182a99e545d2f2bc22e6c1c2da192133b16a3
-- 
2.49.0.460.g0390bdefd0.dirty

