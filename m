Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7AB11D1308
	for <git@vger.kernel.org>; Wed, 30 Oct 2024 20:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730319116; cv=none; b=ARRJYusAQTh/8aExjwEGY9ZGFneNVRMI8sAfdbiDbLtu/CCsciHeoEbOthGPVE1cVifenQEQs+wLp029rNYZWMeQfKLb177heYRN79Siq9pmujjbjrsJdj9dYwk2WfU/rdsUKU/5VHlBOQoda0HxeBnqLhnm14QKna7x2Nz0xko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730319116; c=relaxed/simple;
	bh=+EkGG+J860F2nuK3TCQB9ladgcQyBKLY7/6QMIjPO0g=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=q9An83ECfaleUGIEe5UbicBoPbwx2fDWL2JIPT8bElPv7KOQwSyMkeFbvmeMMuniNtoe4KesbGTQP2IPiflwik0/rNYt5sgadPGSax1BJl0kdyheccvgnDJ93IUcnZR2lcEazULhExTVShR1X4kvXgAsUioB7qVyUrySBmE9/aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q1Kd/ILn; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q1Kd/ILn"
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2fb5a9c7420so1712961fa.3
        for <git@vger.kernel.org>; Wed, 30 Oct 2024 13:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730319111; x=1730923911; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hI7WRB1CRyZ+OBubS5jZRPyuNFsjPqKWXdFe6AcBmnQ=;
        b=Q1Kd/ILnhvxjkjNJcGwW/iSknmbH72ZwhmLqe49Pfu7Mut8kYpIHs0sijVyMXHW6ul
         sBH20uIgXegYoFOnO1YU2TPPd6fXsCOeeWFf2MqcQ9kIftMCCZjWvK21iD+tnBitTHE2
         6hojDRWt0pkuuzeiuw+kigu8X/h8+7fjwwxmbmjXcvvMbOtXaeCntR+X1EbC/o3EWPPn
         ZH6Zk/eqYOfg2F6sU/4Ys79jLWpNcLTHwaSp8eC3fL/cXUXwejds0pLrDXxJl21WiWfp
         sQtWyqYnoyzVBbevbfsqsq+3sHS7mWwf9quP3bc3I+AnuL04GyC99H1Ftxnd7inJOsoB
         cMlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730319111; x=1730923911;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hI7WRB1CRyZ+OBubS5jZRPyuNFsjPqKWXdFe6AcBmnQ=;
        b=DrtQm9x0kCxzoagOIjcOOZQA11QdFzqooJbZDNuCjJpbu8Ku5S/duNkf3UKaQtQvkm
         dzWxM9yBRMawQjS4eJMdSo/dQXj1k7yuuWLt9gAocpRt4flIDVz8fiQVnOXYDmiwuWpi
         n83OYv+d+Lby0k6M1Whivg0Q8GgCcGaevnCwJGFRyS32eR9iSiw8MRIyCTtEyfWT+bTB
         qs7Fw/Ia1gyiiY+WdDhAznsurCEgWu9mdxDAMj1U2nszMXo/Mj/aq+reqO8QD36Qkeut
         LxHKgIqo2s+AiAp7OoM2Cjv1Dz3m6bnDnX5tAD1xI9ryrhhEDEQGyLqvg7DJ2bQaG7RS
         UwhA==
X-Gm-Message-State: AOJu0Yzmek99/jyZsrPs8KR+C3pWFAfM+LKuPtCLFAB7wuasOVT1m+Zy
	C8PXmnOVQepyqRwaPumrEqMXg/9naj0Tm9h5EZn0/snVyLTy8Au2PFQXKvk6bdoc/WI7JwhKTUu
	My2+/G+zkAAO5vjlueGNBw+fvmQ8pUyJR
X-Google-Smtp-Source: AGHT+IH57dIoqqF59KOU47JQOZAbTkw5ytrvbOD+PCQSOJ5zSi4nJJ5UoJZt9AKTmJU2+2ADrt/oUqI9wPxQX4R/62E=
X-Received: by 2002:a2e:a7c1:0:b0:2fb:8df3:2291 with SMTP id
 38308e7fff4ca-2fcbdfa73f4mr84402961fa.16.1730319111095; Wed, 30 Oct 2024
 13:11:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Christian Couder <christian.couder@gmail.com>
Date: Wed, 30 Oct 2024 21:11:38 +0100
Message-ID: <CAP8UFD0jeG=8qEcvyQUDOLTh0Ab7W=icOTsQPAfUPJ92dZjxNQ@mail.gmail.com>
Subject: Draft of Git Rev News edition 116
To: git <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jakub Narebski <jnareb@gmail.com>, 
	Markus Jansen <mja@jansen-preisler.de>, Kaartic Sivaraam <kaartic.sivaraam@gmail.com>, 
	=?UTF-8?B?xaB0xJtww6FuIE7Em21lYw==?= <stepnem@gmail.com>, 
	Taylor Blau <me@ttaylorr.com>, Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>, 
	Eric Sunshine <sunshine@sunshineco.com>, Matt Liberty <mliberty@precisioninno.com>, 
	Phillip Wood <phillip.wood@dunelm.org.uk>, Chandra Pratap <chandrapratap3519@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Hi everyone,

A draft of a new Git Rev News edition is available here:

  https://github.com/git/git.github.io/blob/master/rev_news/drafts/edition-116.md

Everyone is welcome to contribute in any section either by editing the
above page on GitHub and sending a pull request, or by commenting on
this GitHub issue:

  https://github.com/git/git.github.io/issues/732

You can also reply to this email.

In general all kinds of contributions, for example proofreading,
suggestions for articles or links, help on the issues in GitHub,
volunteering for being interviewed and so on, are very much
appreciated.

I tried to Cc everyone who appears in this edition, but maybe I missed
some people, sorry about that.

Jakub, Markus, Kaartic and I plan to publish this edition on
Friday November 1st, 2024.

Thanks,
Christian.
