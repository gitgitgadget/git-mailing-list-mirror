Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A944871744
	for <git@vger.kernel.org>; Thu, 22 Feb 2024 23:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708643952; cv=none; b=PE5M6ekBpKmMGzaYKycQWWN+3e/PaRm0zIN+dw3IsvrAwI0wPiWhaPRptv02JTtuG1smWKaetWBEHgoxT7dySaO7MOCctrxfOpvcK09nuEPgLYKTrQUazrVT6xOhwgozx6oo7jLq3+Zrh0c3tCarCMap7y3BNcULQFzHvzs5j3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708643952; c=relaxed/simple;
	bh=EDPe1bdRg8eEdukjr6FC+yG0CRcV/UtvjQxo7t9mzVk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=Y9CSVYmuVGrYvVhU+5xiXGxcOSuR8OS+zJF3QPP6TwVTXLbxVbF8pE8YawE9meoSFa4ZcHlKOoxmj4g4lp6N3jYCSgvSwXKU7xLLajjYG1B2mMw7qsvQzZy+qWt711IaT5UHm+xJnI7RYqqyLECiWQz0SNnYCJBUkFdGWQKQWW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--steadmon.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=V0ZDdNy1; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--steadmon.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="V0ZDdNy1"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-607e8e8c2f1so5585867b3.3
        for <git@vger.kernel.org>; Thu, 22 Feb 2024 15:19:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708643949; x=1709248749; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=oTlV3ipA4ehlrDZ+pHlltHlqs7e8WqSycQtUuDBqr0I=;
        b=V0ZDdNy1cjiOoNgxDeaYANVlnHQwgpr+oq/RV+qC4mMcud+sVzxgBJ766D3nDsOjPV
         pxbadads7us+Mu0CeCSXiwqHA18s/FXN/kOXkPWAT/67a1bh7QB+xxNHTKGIMcJPV+uR
         mlDw0WGhT9qsGhlnTPXbokXziOBUma75BAIezjW4LKtCt0KMIbgEXYIXSE8W/wstVe8H
         ELzyJv2M5r+Q8RIQg6uu8z6d/cUvDTzdvigFbO5bqdwKAr0e/doqnpv8gzxa2sh9l1jX
         znOrT2WZDhmjvwTUgz/IYjUVDt4NbglC2392xTY1/mlygOds9RrbomA7tIR/XgTFo1oH
         dpQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708643949; x=1709248749;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oTlV3ipA4ehlrDZ+pHlltHlqs7e8WqSycQtUuDBqr0I=;
        b=c2RBjHBteVyy7nuATh/zvOK2MPWo9Wcz8JEC58lp4kASuiBV50h3RR/hEPu9d3DE7p
         IGq6nZFnjVdyQMxI8Wu0JI8JBMnuW0kcH01ZgyTY3U/plGkXy/EDz6otf78EN9qbSefa
         jhqbNLmmBnGol0v4eFY6ZinsGj9BFSn/ULJyacoZkRQRK99zdJP7OzJyVZxM6iaRzsF8
         oTsQ+XbI7AwSAqUHRXTqYiMqzxo36kxUgExfjHFU9ieppsi9lG1da3t11lcm2fWcvMWr
         UqIFP4iLjt2osW5KSNkUOeHnYbbjtKIo3oWSRCaIiAa4N1EkCB4UXHH1LG1pPxQAlSzh
         1Rjw==
X-Gm-Message-State: AOJu0Ywo15p40GxmZzNhzKMsg66FEIUKPk2kJxQPST4Xv27EVFDoaEbp
	y1zlje3m3UfZhUChAfnHjWYwpby343fbbQ5elnbRPzyrGtMBtf/3ZOtaisk8lef440pQ4lChHmW
	U2LJ4lDZ6L8rYtodrXIqTp8Wo3drDY+W6RuAiY3D4JNVTIV5CygLGB25EAojmc6x7rjZ6E49IYU
	IE0Ljmh2rAzJ5nzoTQJvL5blRZaf38t/Jm6OidEOY=
X-Google-Smtp-Source: AGHT+IFxXdcj5KAnX2SzYi0neoJactH6slxvMo7+LbhSvn2LXMSkMdGa7KJwrt/Y86z9jhHifbSaA0ITcG8YFg==
X-Received: from lunarfall.svl.corp.google.com ([2620:15c:2d3:204:4ac4:71c0:92c1:4c83])
 (user=steadmon job=sendgmr) by 2002:a81:9256:0:b0:608:b3c1:9ee9 with SMTP id
 j83-20020a819256000000b00608b3c19ee9mr112276ywg.9.1708643949680; Thu, 22 Feb
 2024 15:19:09 -0800 (PST)
Date: Thu, 22 Feb 2024 15:19:05 -0800
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Message-ID: <cover.1708643825.git.steadmon@google.com>
Subject: [PATCH 0/2] commit-graph: suggest deleting corrupt graphs
From: Josh Steadmon <steadmon@google.com>
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

At $WORK, we've had a few occasions where someone's commit-graph becomes
corrupt, and hits various BUG()s that block their day-to-day work. When
this happens, we advise the user to either disable the commit graph, or
to delete it and let it be regenerated.

It would be a nicer user experience if we can make this a self-serve
procedure. To do this, let's add a new `git commit-graph clear`
subcommand so that users don't need to manually delete files under their
.git directories. And to make it self-documenting, update various BUG(),
die(), and error() messages to suggest removing the commit graph to
recover from the corruption.

This approach was suggested in [1] and generally positively received
[2], but was never implemented.

[1] https://lore.kernel.org/git/YBoBBie2t1EhcLAN@google.com/
[2] https://lore.kernel.org/git/xmqqk0rpc7uj.fsf@gitster.c.googlers.com/

Open questions for reviewers:
* Should we turn this into an advice setting instead?
* Should we also suggest running `commit-graph write` after clearing
  the graph? I lean towards no; everything will still function as normal
  without a commit graph.
* Does it make sense to add the suggestion in all of these corruption
  error messages? There are many other error()s in commit-graph.c,
  should we add this for all of them, or just the ones that specifically
  mention corruption? Or maybe just the fatal BUG()s and die()s?
* Any other places this suggestion should be added that I've missed?


Josh Steadmon (2):
  commit-graph: add `git commit-graph clear` subcommand
  commit-graph: suggest removing corrupt graphs

 Documentation/git-commit-graph.txt |  5 ++++
 builtin/commit-graph.c             | 40 +++++++++++++++++++++++++++
 commit-graph.c                     | 43 +++++++++++++++++++++++++++---
 commit-graph.h                     |  1 +
 commit-reach.c                     |  4 ++-
 t/t5318-commit-graph.sh            | 17 ++++++++++--
 t/t5324-split-commit-graph.sh      | 26 ++++++++++++------
 7 files changed, 122 insertions(+), 14 deletions(-)


base-commit: 3e0d3cd5c7def4808247caf168e17f2bbf47892b
-- 
2.44.0.rc0.258.g7320e95886-goog

