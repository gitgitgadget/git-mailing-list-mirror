Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59AE11E1C32
	for <git@vger.kernel.org>; Mon, 20 Jan 2025 14:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737383923; cv=none; b=NFFR0eyZRVsQbZ6oXwReC34W3TbZoYYMU0Ep3Dm2Vm5BbQDTNK7LS98sBFO3x+mLwSfE1uMg2I/gQ/PZJNopwwqMIPl9Rn9EE+nPXKuYA2cMs9nBAUENakTQz8Aw0PYd5FQDVuFQF8x2QfHq6gkhJXlSCVSyMaIj1YU7La1QgKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737383923; c=relaxed/simple;
	bh=CHGBQOGC2XpV0Mx+o4cqkrOh1a5NJXxVx7B2PKfxWwc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OS5ar9Go5zsGLymQlkWVj+HOCmRLN/MC4P8j2m6ezQvSrIB4MNacs5NjjsW4hQcesyaDffqnrdNo4KXJ644GE4X+r5A6gjpnk9dRE6vYnMfsH6yRF+0iXaoLqrCSyJAdp39DV0AH6ikX0JG6o7Py32TSH7oUUNaLvUnqxuaPnI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T2MU1SiV; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T2MU1SiV"
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e3983426f80so6860785276.1
        for <git@vger.kernel.org>; Mon, 20 Jan 2025 06:38:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737383921; x=1737988721; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5anRzXWOhlT0/y1yD7QlOon7nuKY1I++rU4Nn7lSWww=;
        b=T2MU1SiV/iNRe1vIDjtuwrwnvg/pw5u/E3pfZVGUnu05XGGJp3OgDDZD5PEsWmV6LS
         KTErxKegKWQiU33z5hwAq9M/hA/PORZt1GL9wiQomBG2zNtpUOgtRpNpEn8k+FEN2FsH
         UsEWvdIJjkw1LdfvYXDc6JKVU46qNb12wQP+aioucEUmn+mToxKTe826wd/KbiiLahX/
         d8RLi+ndz9NuaseAVkgoBZ87Cci54bWG9ioOjgK5JDYCCpGvuksHt+BDCF2wF67zfw+H
         OgHLwWv4Ax0W10TySCNPQ3zep/pQ3Uj7qLB3IY0AVx8Iw0L/nkDQplozvzfqgQqauqRH
         yApQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737383921; x=1737988721;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5anRzXWOhlT0/y1yD7QlOon7nuKY1I++rU4Nn7lSWww=;
        b=QXCupXoFMwWsB5yeSPzri1fb+1CmYsrVXM9zkgR18ZPzmVDXknmtqMozDjD4Ho5gz+
         M+6staf9CcHnJL7quQAciddk9SdWaysxhJBZ+/ctIMajBypSC6G2hd+vghLF8fMB22Hn
         R0eXiLURKJDGKZ6Gm0SIpWzU7yx00WMAAAlxsdQlc7R8pGqQCKPUJt7jST/EgUA6DsKC
         7yt4HCe6G0bbOAOA9/K1WIy8Q1b2ReDQVk8xC12/tB/Dfhtm34xK53ZmHmIJWnwfFWNr
         e7sbRm5VPfEZwhfWEYrMgjVZ1sjHY0WUh/NU7QTuaQACQw5cvD+koUjB75TW+YsFQhKW
         bgeA==
X-Gm-Message-State: AOJu0YyaCnrtFdhD8LWRP6IkspQGSqe7thCYgQ0Ksz55dYJPIDhkU0xC
	T52eAvKmE5eqISwC4t9ZX6CtH/jwUikyHVdkie3AzynWg1OIp626vzGqHuSZgZuQyCmvFV/kgwf
	f7vJ3T5lFg4RLTMiTkL7bgnrDnawWGqHECKxi1w==
X-Gm-Gg: ASbGncsQCy94zF3+SX5S7UZ8k4BRUu/8vPxEovgWfEoJ53+Tu6D8o5j2bZFWklJH2Ka
	EIWH7+J77ZEGtzCre7bZ0xdIisR1YasmoAxWWOLk+2P0hgeR0Zz8=
X-Google-Smtp-Source: AGHT+IF9MxYebC/i8S0gUJcf3q5niJ5UrtCTRNLZ6DzEUNYNZFGizVjUGrr7bBNTj3K4xO6JO67W6joAQZSx44YOocs=
X-Received: by 2002:a05:690c:9c11:b0:6f6:d405:7010 with SMTP id
 00721157ae682-6f6eb908d30mr94656177b3.29.1737383921029; Mon, 20 Jan 2025
 06:38:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGedMtcSSkmQ2u9yYvKMiWnprWR2VZrbuoT9EX+U6nuxOWiEHw@mail.gmail.com>
 <CAGedMtd0-m54075w97Z4pQ0wqAjgPRA8+HX5iar0POyuC6-GCA@mail.gmail.com> <CAGedMteK9=wYwCoPMGZ5t+FN_ZHOcSGxDenq8fkVM64oGpc4sQ@mail.gmail.com>
In-Reply-To: <CAGedMteK9=wYwCoPMGZ5t+FN_ZHOcSGxDenq8fkVM64oGpc4sQ@mail.gmail.com>
From: Seyi Chamber <kuforiji98@gmail.com>
Date: Mon, 20 Jan 2025 15:38:26 +0100
X-Gm-Features: AbW1kvYRKMmBK9knoBoYl0mc0IrohAfrHnn6h8LPAotkPp_5ChrGDMNn6N0Vuu8
Message-ID: <CAGedMtfiAttLUgPNyU9nNrvOjNrJ0NsCayjyTevCoAurwMDwzg@mail.gmail.com>
Subject: Re: [Outreachy] Blog: Introducing myself as an intern working to
 convert unit test to use clar
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Type: text/plain; charset="UTF-8"

Hello everyone,
I published a new blog post on modifying my expectations and the next
batch of test scripts to be converted. I would love for you to check
it out and share your thoughts!  Find the link here:
https://seyi-kuforiji-902b48.gitlab.io/posts/modifying-expectations
