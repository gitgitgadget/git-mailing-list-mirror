Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EA242566
	for <git@vger.kernel.org>; Wed, 10 Jul 2024 00:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720569721; cv=none; b=gafIknjPRoPI2wW6vdrMovwSbU8qHSaK3Yx38oP2/+SBz9lMzuRVJx1vsUXbsKzBkPMKlCarGIyEXmQ/WDLkcVPIrfefGgzsFjOG9mOIW6unD9ZyPYbL46Jw2wq+dGOel3PnuxBR9ChypE7Tz6cfCDvUN6OOVrLUtmSSa5B8LI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720569721; c=relaxed/simple;
	bh=msqfI6k/QpwkFYB1QEpUwjH47KqYbwMhRl2Yz0sQa94=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WiFdO6RNI8RVpvekXIMyhLp0taK7kcdkJvgjCjbpxls5fIIWKlByR9Mws4btKGkbJYEeTOQQyYknm+JEyHWHnHAE+NkkyoMCk6i0D+0B+Tg1eaBbCv+7tscWXaJlo/bwAdV/HalkjqY9H85N+rMo2HO1ndfugndLDzNir7g/jkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=iK9cMP0Y; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="iK9cMP0Y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1720569718;
	bh=msqfI6k/QpwkFYB1QEpUwjH47KqYbwMhRl2Yz0sQa94=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
	 Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	 In-Reply-To:References:Content-Type:Content-Disposition;
	b=iK9cMP0Y3ORFir59l0rjNlMVgKQ2511cGezaNCPRFRML/Efy+ybriegFsGAYz2sAc
	 EUb8OLxo3M1g4Lqyo3FtvZ6s6KeV/4ldikZOu5l2qdQqaVnr3rWAONaBkvRpFYukR9
	 pmAZLNAPirQOIH1snVAvir3XHQph38QVCExHxgT4P5S0TbFBpdeqBjMK4aCWYOyBDd
	 QWeCFsaFDa3AeJH7/VWHycgA8bF1WPgt47/dcA1GhdxzIQOqfiZZebR06UvQUEwjln
	 O0rJu0S+YlcS0Thf34K575bM1VUg00f4j/ENMIgqJEEFREULJ03WiZ1AmtFN98uVLe
	 d0/94T7vtPBzDjxlJ+RaJMJV5prZJ36m7vVjYaKpENOzmTunEwubSfgIClaGsqbaj6
	 JOuUYy/QuqBKi26LUlf/bwsInRZuAlYnGY2sXPDaVNiXPrJ3bUN2PfxqhCk/+axDhy
	 D1gX5Q/jeeJua+eNDYaMEE1F2uCyCt7Dc3AmBzNXQPbAtxLjzhd
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 3E7EE20991;
	Wed, 10 Jul 2024 00:01:58 +0000 (UTC)
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 0/1] Proactive authentication over HTTP
Date: Wed, 10 Jul 2024 00:01:54 +0000
Message-ID: <20240710000155.947377-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.45.2.753.g447d99e1c3b
In-Reply-To: <20240704001748.746429-1-sandals@crustytoothpaste.net>
References: <20240704001748.746429-1-sandals@crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently Git only sends authentication over HTTP once it's received a
401 response from the server.  This series allows users to indicate that
they (or the credential helper) know what kind of authentication is to
be performed and avoid the extra round trip.

Changes since v2:
* Improve parsing of configuration options as suggested by Junio.

Changes since v1:
* Add a `none` option to explicitly reset the value.
* Improve explanation of `auto`.
* Improve commit message to explain tricky edge case.
* Note that TLS should always be used.

brian m. carlson (1):
  http: allow authenticating proactively

 Documentation/config/http.txt |  20 ++++++
 http.c                        |  62 ++++++++++++++++--
 t/t5563-simple-http-auth.sh   | 116 ++++++++++++++++++++++++++++++++++
 3 files changed, 192 insertions(+), 6 deletions(-)

