Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DAAE18396C
	for <git@vger.kernel.org>; Thu, 30 May 2024 09:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717062151; cv=none; b=CQq/mXMVUnicYAd0n+Uu0Ue8+vfoj4Qf+T0MBKPYAoqMvDcNY5Nk9CJBpDuEIq0+ZcKagU/hA/eWU3l/2SpIcUXzbcEigmidhuMdh4TJqJzGI+472PXxYHSxHxLrrz2F6mQXf5Kp3Tq4TAcd0SnS+oaccXVOqLaq+/c8yMyW8BA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717062151; c=relaxed/simple;
	bh=AdeDF6uNww6iJ7SOnffBJFiMFhgmvC0jHXcG9PMIOWQ=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=nP7tCvEsUGLYCsbMoPz5mUrZo8UPTu5t6GX4q4zbEFfQxhN+uDlAHV2yHVo/2Qk3U+TWsEe2Y0hvyPls7We7CQlokJh8MLfCyTv5xnnxWZJdLejZz2sT8xKUEy24uuFLDfsZ2RoIi7tCMLuyDpxQuGWgqoV3QBnf/oT8REjwWwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DzURHJzt; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DzURHJzt"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-57a1fe63a96so339954a12.0
        for <git@vger.kernel.org>; Thu, 30 May 2024 02:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717062147; x=1717666947; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RpQUbM0nINgsI23vuKLLpCQMUHNEIMHT5cniLoedTU8=;
        b=DzURHJztwvdJyUORAdZqx2WuE/YkPPwEB56eui9H8518zi7xvm4IOiQv8IQiBoNTuY
         5rEzNnbTbVmgm/JrIjPkuDMRgmarH68vO5ULstWdMnnDHVPFFMdUGYGPCU70pSiCNt9X
         hdlNXgERXk/BtE7GP7O3+KdZsDwpkYCHlOdZdRpfbaQ9LMBNvIQx3Ai/hUDFpXc/wo2V
         2rzfD3ILtaAW4icca8/E5pK8AhdWelXi9i/SzCk8hqyMJn3ZDj2kC4JYngn0ZnyH4j78
         mOo1nJKq+mcpiwDS6w+I3uAeHqOITdiC0kbvKTsFAzjLXfpjjexE/hEaGhQ70ehIRTq/
         +hcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717062147; x=1717666947;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RpQUbM0nINgsI23vuKLLpCQMUHNEIMHT5cniLoedTU8=;
        b=r/ic8rnR55II2z2t2dJ6F/iEQC6G5ozkIsxlBS4dWIKb8a4a0DP3WEMtzutHI/hmAa
         j1EPPJOjMWZe6pz9yAkC9MEKsQNrMG2hrgFgVtxCvfowxzpC1vbMNzFMnxIdXnj7MZ0r
         ksgsrZdTKHg5ooAUSxuCMiUFeC9X8NDzvJ1qvr9ZFevX5QnmhUUQmrviCNwMJyYd6r0N
         7GqlSgI/ZSUKG63TgjKT/mPBaXHj4+y3hl83wdmfA1IYFP5RcBQ+E2Ci4e9RR2hoLdCq
         FsHvA4bpGfZ7CYI8GwOtTMI6V8s2P0iBCnMNZydBNjBhAZdHXDF7zonSZYLLh1SxZFmw
         KIUQ==
X-Gm-Message-State: AOJu0Yy1C/QZtZpnvRkfrsMu3r4ZM7pYCziJgDeu+kYgMMNDlt2f1GiF
	pgGWnUiUFi5CyfwaZ6gMNGlabCnUAS2LjnN6blHSljrT1uX379JDqr8GS1gacS7lbAOXWYWS7Oz
	j4Zig0xkICAPKnbuSQOSaO36D0MfeTrtu
X-Google-Smtp-Source: AGHT+IH/FPdVAW16/aB330+MK6jIN09GU7kj72+YwsxkkpuhrL4ro8HHZwOEpHPaAE629FbV1/+4vkOGQsRymlH8sx8=
X-Received: by 2002:a17:906:4ec5:b0:a59:efd0:e884 with SMTP id
 a640c23a62f3a-a65e8e5c3c9mr109757566b.27.1717062146921; Thu, 30 May 2024
 02:42:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Christian Couder <christian.couder@gmail.com>
Date: Thu, 30 May 2024 11:42:14 +0200
Message-ID: <CAP8UFD3p=fomy9sJOmG_ByLugJbVTuowwVON4z0p-=oFLTKsQg@mail.gmail.com>
Subject: Draft of Git Rev News edition 111
To: git <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jakub Narebski <jnareb@gmail.com>, 
	Markus Jansen <mja@jansen-preisler.de>, Kaartic Sivaraam <kaartic.sivaraam@gmail.com>, 
	=?UTF-8?B?xaB0xJtww6FuIE7Em21lYw==?= <stepnem@gmail.com>, 
	Taylor Blau <me@ttaylorr.com>, Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>, 
	Beat Bolli <dev+git@drbeat.li>, Jeff King <peff@peff.net>, 
	Chandra Pratap <chandrapratap3519@gmail.com>, Ghanshyam Thakkar <shyamthakkar001@gmail.com>, 
	Jialuo She <shejialuo@gmail.com>, Patrick Steinhardt <ps@pks.im>, karthik nayak <karthik.188@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Hi everyone,

A draft of a new Git Rev News edition is available here:

  https://github.com/git/git.github.io/blob/master/rev_news/drafts/edition-111.md

Everyone is welcome to contribute in any section either by editing the
above page on GitHub and sending a pull request, or by commenting on
this GitHub issue:

  https://github.com/git/git.github.io/issues/709

You can also reply to this email.

In general all kinds of contributions, for example proofreading,
suggestions for articles or links, help on the issues in GitHub,
volunteering for being interviewed and so on, are very much
appreciated.

I tried to Cc everyone who appears in this edition, but maybe I missed
some people, sorry about that.

Jakub, Markus, Kaartic and I plan to publish this edition on
Saturday June 1st, 2024.

Thanks,
Christian.
