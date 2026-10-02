Received: from mail-qk2-f38.google.com (mail-qk2-f38.google.com [74.125.230.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4107E3E49D8
	for <git@vger.kernel.org>; Fri,  2 Oct 2026 17:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.230
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790962928; cv=none; b=rWqSXSehBGrwMcjl3uT5HcI5IzVvjsfTecCtd0FRnEdweh/8kBRy4WItO2TduHFL1UBTX55uSQYYaFgPFUIhgjbuQLH3UKaOVQS3SKpqKHQEwUW5NrLbNX1rXcU7cWxTLHQ8ZgEI6QaGYxGR5w4kodrSEVXXfm1yyo3SJGPBvx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790962928; c=relaxed/simple;
	bh=K0UEmakZutRUldcO9Opa9r0sa6ycTAz22J/5ZvBWUhU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tZm9nv+kbr+63NQieASvvWXLbKlEBgz5QWh0Fxl+Oa1RVbzfa1c2HXH4SjqTqCp7LMBpS3nx0jt9RrDuQi35QCXwwSDvCNrRbZkyMegG0rhiFz07ytGKTCw3izvqQ9vXBOhvZxUn/kHYEvO6KdmO+BUqXLA9bTYzujECmzOMwxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ITUCyHuG; arc=none smtp.client-ip=74.125.230.230
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ITUCyHuG"
Received: by mail-qk2-f38.google.com with SMTP id d75a77b69052e-533984bfe2bso12928021cf.3
        for <git@vger.kernel.org>; Fri, 02 Oct 2026 10:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790962900; x=1791567700; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=o0fBoM3ii8vy8iFp4orDPto+Djqk5gUfEzwCX/HIep4=;
        b=ITUCyHuGd9CwbykKGFjWEmUa9yKl6UPrJHzZtLUQbegmXcdWDi96zbxCuECFLbml2Z
         3ft5hyYE9YroXTXi2cVmLxOiCMS1PgSrY2iFFwC5F4jsCdszzq3lir6OAL8M0OcHvGW4
         skCd4m1+eXTJBB+db4giVgS0+HTQa8ajm1gI2Z0HJff2QoaHAvMbS9+Bt9arI5/JwIx+
         i37sXJQ2WepVsIIURq8Ec/irq4d2pRTdOaeoN/CVtG1+RsjYFoKXf8V4lf3FcGQE/ZVk
         IGPlR9svo9ISPuNVNUtpzDw6fyIIUMsrdUBmQpwB9lB5mN5VQ6HNbTacyUplJtbS7QOg
         P2Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790962900; x=1791567700;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=o0fBoM3ii8vy8iFp4orDPto+Djqk5gUfEzwCX/HIep4=;
        b=SsyXnOdUkt8icxhVvGczFD3jgIQ1mI77Ue7yd1HaZo1a15OuTMe4ShGFtCzWqEQkYm
         6ot4JZBdXHOkYXOPp8o7HLlbHTT4dzqFGQnchLG5j5Hhi58cZP5dB4tNZJzaRelyS1mU
         puGOiIodmF8EedRPxVdxusqTWnQHPUJo+IWyohBIKJhPRemkkWEpv3JIGplvrX49wRIo
         7MA/awlCrLrRGIbAjoji2CDBRvLwwzP9DIBcjqTpaIaI4oPD1PlLQjwV92n9/a8IP5gV
         FZ97P0msqXk05cXBcWzux5rJX4hsAVgpJJHmAThT8wcUyLv0UvuLcipizWuUwVsbN8MV
         grkQ==
X-Gm-Message-State: AFuF++kZ3VyQitmLjdljbEWlTjGt8LT/tBKkeMuraNODmx73I1SKYB77
	GAEUFiIgGilcIfcM4/TBABKgHvl0aTQBsLkedI4SJBF/DO5AphGgI9L+
X-Gm-Gg: AYBFou1XOwPJ02fdYG691sVdofELyzRtvyk7koNPuIgMqSOjOgJxeOz+w7NmpigAsem
	PSSK/xVS6d6YOPbjp2B/SsRUuwzUkv0Eoh4sDJbAvqNZyWHYiCXj7l6BLzYtG7f/zg7jzPl4Xdt
	m+u0augcuQVr4OcArdDJLHZQVHPHKg9s6xzFGwzi7LxoCmg0g4a8Or4GNF0v38HOIdJX3Yw7H7p
	nZ4NaV3nFHjtu8VHOB7aSbHHwa99maIV/3hDPEb+IjKlZnK6zdsr2ze9evy3mNdThgN0iBEak9y
	fHj4XichiFYErBcRv/aothBl/dUp8rnDv8goPpir3wBUqNaeYkzk5n2rCmnYBiO0YU//Uurg6IY
	+aAMNb9d47IO6VSM9fvLHOlWv9o+9YAcvR0qNC41YdEWPnQb9cfcXEMLafrElGOQJB1MiAAG35A
	Yoc+O2RvJFCkIhdctqC0aguix20Ql+SLKhahadDnYLfCakTH+6vUsqger77g1/tO+KMRcmoa8tO
	Hb+Z9GF2SoSRgGODAY42lEVOYArDJpMVJSrISvBgM1eOtiHU0QByauESvZaVNQ6Fe6YxGJM6BC/
	LSTtMCf49mrCgeKYzuXarBoryHJSnKtmyBFyn4uYkJXS
X-Received: by 2002:a05:622a:d10:b0:535:80b:9900 with SMTP id d75a77b69052e-535080ba122mr29505191cf.44.1790962900163;
        Fri, 02 Oct 2026 10:41:40 -0700 (PDT)
Received: from localhost.localdomain ([38.105.193.82])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-53398d20c89sm31375401cf.26.2026.10.02.10.41.39
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 02 Oct 2026 10:41:39 -0700 (PDT)
From: Andrew Pleeter <andrewpleeter@gmail.com>
To: Phillip Wood <phillip.wood@dunelm.org.uk>
Cc: git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Ben Knoble <ben.knoble@gmail.com>,
	Jeff King <peff@peff.net>,
	"brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v9 0/4] var: -z output, multiple variables, and broken-out idents
Date: Fri,  2 Oct 2026 13:41:38 -0400
Message-ID: <20261002174138.39096-1-andrewpleeter@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <33f24834-8e73-4230-bf0a-6809a85d9a86@gmail.com>
References: <xmqq33va1lcg.fsf@gitster.g> <20260926162048.30853-1-andrewpleeter@gmail.com> <33f24834-8e73-4230-bf0a-6809a85d9a86@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Phillip,

Thanks for the review, and for the test_env pointer. Both nits are fair,
and both of those tests are newer than the rest of the series:

  - 3/4: "GIT_CONFIG_GLOBAL= git var ..." and "env GIT_CONFIG_GLOBAL=
    test_expect_code 1 git var ..." are clearly better than dragging a
    subshell in. I will use that style from here on.

  - 4/4: the per-component tests collapse into "get several identity
    components at once", which already covers the same ground.

I will fold both in if anything else prompts a v10. If the series goes in
as it stands, I can send them afterwards as a cleanup instead, whichever
Junio prefers.

Thanks also for the GIT_SIGNING_KEY questions. Dropping it was the right
call, and I would not have got there if you had not asked three times.

Thanks,
Andrew
