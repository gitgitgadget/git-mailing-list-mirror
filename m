Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42218482FA
	for <git@vger.kernel.org>; Sun, 30 Jun 2024 21:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719783241; cv=pass; b=qH4x19c7GNxroVjuNcFi9rdBLk02yMlCYeEkz8nTyaApOJlX/AXo2l+SYPuCHwUwjT5DkwUuSyCIzL9QX0O/bfZxq1F7ngAfHOCm7ELeVP3AwgvAn+Mxn4MUKvb7YFYjY8ubpEM5050TTP1iqz3j9/Df5VTgn3FXutwFW/XsK7A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719783241; c=relaxed/simple;
	bh=18cszPzPkbdyniCUq0eeoyla2waQUwJgSgJ55Uoq1AU=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=Uj53ARVr8eJDnRiiJXXPVqCHej1XFttEHez2nRvUFZHTCK5AiHUHQqiJLyxsqnBjBlERDrzihHkpu70+dfUvjf+PNEd8EzT538v7UBt7p0BBQ8SCB14BaFO+knb1oSvlJYYJMhqEY2X+s086hD84uZBAUSTv47HHECaPIqfrXcM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=kATeR7B2; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="kATeR7B2"
Received: from localhost.localdomain (unknown [IPv6:2001:1ba8:120c:f201:e842:876:cf00:268])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: mikko.koivunalho)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4WC2VN1TsxzyPQ;
	Mon,  1 Jul 2024 00:33:47 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1719783230;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=gx/KIZaNm3noTJUi8bRftlyo7ypgh5YosF/6R+y6MIw=;
	b=kATeR7B2q8gkMcZsuC77AnaIHaEftN6QDXvoqmS1ADkkyTco+ZfTc6zRW0BMABUWm2S3Hy
	8O8C/m5UucpBJUFC5Q9bjj3Yh+NXKnxvmTaHo+dxciKJd8q/RWG/nVOWlPKVUyUN3gQss2
	5h7mS3pQeOECDHsRrxb5FgNryQBoiVI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1719783230;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=gx/KIZaNm3noTJUi8bRftlyo7ypgh5YosF/6R+y6MIw=;
	b=FzjF4BOg8Bft1PnSZvkvfzNnj7PzIo+Q55ITqFCmF4FFy5Ojt64i3ftJ4i2X1y8LphckQY
	FQWMCuvuKJ3aShUKhXlouqpiMJ1S1VOCbCNML/4gzVylgxVYs3rPBY8bJYa8nbXJ/2zJgE
	U9EWOEMFN4BqnzGKD8FjNlKlfie6v8w=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=mikko.koivunalho smtp.mailfrom=mikko.koivunalho@iki.fi
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1719783230; a=rsa-sha256; cv=none;
	b=PIom+Gnxd1fnDNGHeFF6lQ6Tnic54ajfwjH9TvYxxly0oVZ1p1mokFKEPM/Io01Bhki/uy
	Aw1O1eXAuJf6NPm5kQOg8VKYI9PYVKpPluU87dLhkGWGVoK2CPeTRCNLWsiDsX9lt4MpMY
	PoQk+G6WOjrpOQSk0HrtqUHIEPfRkRg=
From: Mikko Johannes Koivunalho <mikko.koivunalho@iki.fi>
To: git@vger.kernel.org,
	Mikko Johannes Koivunalho <mikko.koivunalho@iki.fi>,
	Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>,
	Roland Hieber <rhi@pengutronix.de>,
	=?UTF-8?q?Rub=C3=A9n=20Justo?= <rjusto@gmail.com>,
	Beat Bolli <dev+git@drbeat.li>
Subject: [PATCH 0/3] Add a Hook To git commit --message Bash Completion
Date: Sun, 30 Jun 2024 23:33:33 +0200
Message-Id: <20240630213336.2212166-1-mikko.koivunalho@iki.fi>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I want to create part or all of the `git commit -m *` command's
message with a script. I work for one Jira ticket at a time and I
need to create many commits which all start with "TKT-123: "
(any Jira ticket number/identifier). To make the commits faster,
I run `git commit --message="TKT-123: add new file"` on the command
line.

I want the Bash completion mechanism to propose the message for
me. I would fetch the newest ticket number and place it on the command
line when I type `git commit --message=<TAB>`.

Example:
# Doing commit:
git commit --message=<TAB>
# you would get (also without the closing double quote):
git commit --message="ABC-1234


Mikko Johannes Koivunalho (3):
  completion: Add hook in Bash completion for commit message
  completion: Add hook in Bash completion for commit message; docs
  completion: Add hook in Bash completion for commit message; tests

 Documentation/config/completion.txt    | 11 +++++
 contrib/completion/git-completion.bash | 40 +++++++++++++++
 t/t9902-completion.sh                  | 68 ++++++++++++++++++++++++++
 3 files changed, 119 insertions(+)


base-commit: 790a17fb19d6eadd16c52e5d284a5c6921744766
-- 
2.30.2

