Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CF03376F7
	for <git@vger.kernel.org>; Fri, 15 Mar 2024 13:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710508942; cv=none; b=ln6i0sPoS1yREmjQMipNLC+oikp8zIwPu3xiK+f9FsX4O1tu/S0W4yLW55a73TKtxXN3lcRbP1Fk/Mh+vCyJUPd7xfTGa5IHztKdZzIwpdznq5F3OB0JdTnfaX0vKEZTShR0t6IGr7Hw7zdySW0xnflafQnoad19MXp7JjCdvw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710508942; c=relaxed/simple;
	bh=zdq+OshAI5kAJZauZUfeIV9rHAueaksWjkTEuOD4hbA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UXyGz7sBjr5MYvyG2V3dfbJwrIwff/WvYUGvAu0V9SRe/P6QXSgCUI6G1JDaZuPyKlsEoSMgwB3VuaWvJHPj2nqnyqjcHI/ziTGjHHEuLgeXzQf04Cn/j3GRANRDGp5YUa2GEIoZrT2RFOIBves0JdJwn6oilvPO2pN/UP9VKpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=tIvRE4Dz; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="tIvRE4Dz"
From: Dragan Simic <dsimic@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1710508934;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=FVM9bqzlKUWVncASgc2Q4OvBwkMb2/gdm04cLShESsU=;
	b=tIvRE4DzrTU13wUESIcwvo/9dVqcnZyxJ18c28xBAl9ZtgFRxpicqmwxuk3luudrAZ0QpL
	a9tb0j0gIXXbSgFLrcFfVAsxHVL7U4JLErj6h3GDSE6pRj33JSXyVHk+fVpAUklT0ObAuY
	B/DGCzBktyQPbrMn0DZVqkOKm/2SAmOYeIiEFBNAoNIdhoBw8HgRBTgtWLf4T7fqT6Eoeb
	hqC6uW5huws7gexvw93g8t/0+/EntVC0eRoeykx9oynVccFxanKg4n6+SnQGoS4fu99dP7
	AxxQMoQoVW2jSKD5/TRypN6DvGZifc0wza3F19HjOwXoJ1HfXSVZcbnbeNWnsQ==
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	rsbecker@nexbridge.com,
	github@seichter.de
Subject: [PATCH 0/4] Fix a bug in configuration parsing, and improve tests and documentation
Date: Fri, 15 Mar 2024 14:22:06 +0100
Message-Id: <cover.1710508691.git.dsimic@manjaro.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

This series is an evolvement from another recent series, [1] as a result
of a decision to fix a longstanding bug in the parsing of configuration
option values, instead of documenting the status quo. [2][3]

The bufgix introduced in this series _should_ have no hidden negative
effects.  All of the configuration-related tests, both the old and the
new ones, pass with the patches applied.

[1] https://lore.kernel.org/git/cover.1710258538.git.dsimic@manjaro.org/T/#u
[2] https://lore.kernel.org/git/ff7b0a2ead90ad9a9456141da5e4df4a@manjaro.org/
[3] https://lore.kernel.org/git/11be11f231f3bf41d0245c780c20693f@manjaro.org/

Dragan Simic (4):
  config: minor addition of whitespace
  config: really keep value-internal whitespace verbatim
  t1300: add more tests for whitespace and inline comments
  config.txt: describe handling of whitespace further

 Documentation/config.txt |  19 +++++---
 config.c                 |  15 ++++--
 t/t1300-config.sh        | 102 ++++++++++++++++++++++++++++++++++++++-
 3 files changed, 122 insertions(+), 14 deletions(-)

