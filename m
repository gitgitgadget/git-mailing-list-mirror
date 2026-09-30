Received: from mail-wr2-f35.google.com (mail-wr2-f35.google.com [74.125.225.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 401EA3E16B9
	for <git@vger.kernel.org>; Wed, 30 Sep 2026 09:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790761749; cv=none; b=Sl5WZjFAAYOSe8hNRHu+IZyzId1zuCBn1ICmnawDa4mZWjzZN1SOUX0SrRBHkl60RlyzXxTPvvuZos0DZmXIBCO6wyiS1K4iVRVdt1eSCrqCxAMZE6xwuZqKJYt+LwnnGNm/RWG5GRH1x6DdqZ4YJIWBR98IuKX0NGEWuTRv5Dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790761749; c=relaxed/simple;
	bh=GWl2okeZwLyXQCEAP6+J8o8RECa6yyaNxxpHeUDAkLg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RZW7cR7s6rlLw2VVxV2vBveAnfORqjKK9VX/+kgXZkf+y23tjyD80Dg/f4qi5HtxvDSAoTiAvdQjU76TIfVNGFfiSm5q66ZWlQfHcvfSQUa8iK39OLxHmio3J4Z3udVXOQz+806r/ULiY0yHH/IZ6Ggt6MoxmxUGmGbkq/uHv/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c5I4N65p; arc=none smtp.client-ip=74.125.225.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c5I4N65p"
Received: by mail-wr2-f35.google.com with SMTP id ffacd0b85a97d-4887840c529so1817608f8f.1
        for <git@vger.kernel.org>; Wed, 30 Sep 2026 02:49:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790761745; x=1791366545; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=a6FKah8nMihBZCTrMBHxODzTWG2X8MgdcDH2pDd2++8=;
        b=c5I4N65pzAKXZibFg84uko7kW1Exeke2mcNfEpX3ZtcaYbLMDKNPOM8YCe7CnkHA9l
         JI1EFKRC0+o/7XYS7MzE2BkLxR2KCnZOf2eAJ3UJImGknLsd0a6PD4eJAUsw5vygzZe9
         vLu7O3OJy2mscGA8DqCh7omH6u+qdPdYXLucy7row3m8OzGDDv0puEiRpo5Pt6G/NYed
         KeX75atNN81qfUiY8lyre+oVnktVSwTbkIgvpMe41yfNS0jFzGxjNlZe3VHs5DJ2doAB
         8CUKYRhA9FQr9mT+bQXAGsFhUoK6v7O+13FcZlGmSivSm35LjEIqP15iq0aq6bYrhsD1
         dX3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790761745; x=1791366545;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=a6FKah8nMihBZCTrMBHxODzTWG2X8MgdcDH2pDd2++8=;
        b=DY4RfRQ3YYbI8Uf0x1xn7jkGBGaglGUv+o2fcAIo3D1+CQdMYJJKVaUfj0wwIwxKpR
         NiYlZJVcCgYmMa9OFPbql8jsaBz811xNTbCyM0imx25RfeSugqU9JhvBKWFlV935eVZW
         ydmGaUBKpGxO0/3i7Sq3as/iE5JSiuKz1nsaSnv6pGsdRcD8YZuMofFIBFnysRwVn10+
         o5VvkcZu2NiYk20thOPthQpJpg0+8tvuzXaGqpNR58O8nY5WZ55QOErsBm8c0AEouiM9
         +uvRMbKodfn3hhQWo6qxXt4KLx7X7e2Y+2sgivmA43gOI3DtrzAJsMyFbLKAKwd4TzAq
         5HKQ==
X-Gm-Message-State: AFuF++l3GfUxxpzEhhI+qgMIfeuy+4BhAtrBrv0Lq6+kNUinnTG2JK80
	UdEn5+OQa23MqxnVNvslu+ISl30R1LgEbx6yYDDBB8L3QqpYg0x1woc0KjTO2gpy
X-Gm-Gg: AYBFou2aM6uDVynKsZXNcJ/i+EqquRlL+91i1J3Bs+AtLiQfAhML74UWJYYYVUeOoXN
	HRgnLeTeW9wdkiz7r5w62S08AP36bk8SxC+zX3hfghpIfKkTB22M4iGJcI7RnLZdUWsMN0TDywU
	oEoGBTovkzn9yzvhjxOat2LOD1aPhjQzH+R4sqa/M6qDSQc2oQ6JQW+oFVFByqASG6g4ZfbRP8J
	MTkxvuEvJ1G7kNKh67DB+Clycw10kAWHkqiV1YZZqn41euQY36++3ta+4dK7POm/Tm6+SEiMfyY
	dWfxDY1yY16fgOnhXEgN/sG3DXRsRrxioyKQwOuyiM+pBjXiT51gZpCj66yNHtDjRUnZ+yZFOfx
	qeCu1k+z+hHvmuoDW+E6FhhZOXLkE9Y0ZaRmVYoDqh6UzHbn1lHzHH6jbirm2KiU1Xc9BHrzNb+
	LasYJ5uEWM5xkmvO4Iryjf9Pr6bNDX8EdNUwPLNIPcEXX8K4jR0EQzXNglhcaqduQj/z664XTgl
	VA=
X-Received: by 2002:a05:600c:5391:b0:4a0:34a:588c with SMTP id 5b1f17b1804b1-4a01b1ba781mr11880785e9.14.1790761745182;
        Wed, 30 Sep 2026 02:49:05 -0700 (PDT)
Received: from berwick ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a0174e165fsm47632845e9.6.2026.09.30.02.49.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 02:49:04 -0700 (PDT)
From: Phillip Wood <phillip.wood123@gmail.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH 0/2] checkout -m: recreate conflict labels
Date: Wed, 30 Sep 2026 10:48:47 +0100
Message-ID: <cover.1790761727.git.phillip.wood@dunelm.org.uk>
X-Mailer: git-send-email 2.56.0.rc0.210.gaf8b4f0d381
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When "git checkout -m <path>" recreates a merge conflict, it uses
the labels "base", "ours", "theirs", rather than the labels used by
the original merge. This short series teaches the ort machinery to
write the labels to ".git/MERGE_LABELS" when it switches to a merge
result containing conflicts, so that "git checkout -m" can then read
that file and use the same labels.

As "git checkout -m" is recreating the original conflict I wonder
if we should remember the conflict style as well so that

    git -c merge.conflictStyle=diff3 git merge topic
    git checkout -m <unmerged-path>

would recreate diff3 style conflicts, instead of using the default
config. I cannot decide if that would be convenient or confusing and
am interested to hear what others think.

base-commit: 3bc0341126508f78f5869cbfc0005e987efdf0c7
Published-As: https://github.com/phillipwood/git/releases/tag/pw%2Fconflict-labels%2Fv1
View-Changes-At: https://github.com/phillipwood/git/compare/3bc034112...fdaf3da99
Fetch-It-Via: git fetch https://github.com/phillipwood/git pw/conflict-labels/v1


Phillip Wood (2):
  remove_branch_state: convert boolean argument to flags
  merge: remember conflict labels

 branch.c           | 17 +++++++++----
 branch.h           |  4 ++-
 builtin/checkout.c | 30 ++++++++++++++++++----
 builtin/commit.c   |  1 +
 merge-ort.c        | 19 ++++++++++++++
 merge.c            | 63 ++++++++++++++++++++++++++++++++++++++++++++++
 merge.h            |  4 +++
 path.c             |  1 +
 path.h             |  1 +
 repository.c       |  1 +
 repository.h       |  1 +
 sequencer.c        |  1 +
 t/t7201-co.sh      | 21 ++++++++++++++++
 13 files changed, 153 insertions(+), 11 deletions(-)

-- 
2.56.0.rc2.84.gaf8b4f0d381

