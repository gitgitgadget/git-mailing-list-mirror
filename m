Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64532802
	for <git@vger.kernel.org>; Thu,  4 Jul 2024 00:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720052279; cv=none; b=iB/4fdS8QpQSwTtpmX0rjqOCD8jan5cjxPQN+BK8+wPO/ejujfmN5vUEJQT7Jyb5RfbzHAtElzwCwJbDxMZ0pTCb3DH0i+cRCe7qIhixk4J/6tRKkArKOy1GckdQ3pmts6lsOYv0NIIiqETZ4xTzmHGefoEAFRIuIxC1RBDceLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720052279; c=relaxed/simple;
	bh=Vc2qlnnlzHrzB0lquBllUrryQ6bIVbuHIwBVwLluvtg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AfQOmqgAgnkrTqowK2X+AL8mI9qALSYglhnFCbyE+quPGaPvsyCbNQbFGF/Py3kwTeWSkH1zCVsUKu+XD0gd8L78hqt9+cW+m9O+QOZnjNaZPrfAy/GKUzTchnMUaWz/vXOGpctU5QyH6v0SsjdHapGc24yJuxI2FxLv8xFSYSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=scjaB3lz; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="scjaB3lz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1720052276;
	bh=Vc2qlnnlzHrzB0lquBllUrryQ6bIVbuHIwBVwLluvtg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
	 Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	 In-Reply-To:References:Content-Type:Content-Disposition;
	b=scjaB3lzTH63ajlljg7pG9WnDzI08wAchthG6a/Q36dzIYsx0TWzmBB28tSKu6b8z
	 umUyFO83qO9nomNpfBlUpvpII2IabJ+D5oW2t+mw43mLOTFvjR/NeV9IhwaMCw+7ws
	 9WH5CitqWi5w7XuUjBDUyDbbmB0iaULP1g5ixWCfXuxAoGLlbnsd3tJr/+uN8i9Iyo
	 igGqTCOxC6Dvelt7vt7g48oajXwo2Zj+RtI7ImzFk60UE5d6jtZWgXXx2+fRTLQp29
	 +HlgtbmkOwy2eCLzpYqZqwCP/G+MqA06ZAGZExk4q4bwGjCsXNJwl6EabXOSIYwjgM
	 vz1aTFLHV3cF7zMlHj4icT3LnQU0Lfz/au4o1tR/bFArRn1ucIU84KpLCg9q9i775E
	 19d0Q89897FtM7WV44EHA1wl993C+2W5UrPilz1a49w6IioWKMOOvuSuWVRbgvX16M
	 gdnWDlcRh7yM32Nj6EzPBlHlTgwjbgdI927dRnquseslCBN14MZ
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 4735C20993;
	Thu,  4 Jul 2024 00:17:56 +0000 (UTC)
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 0/1] Proactive authentication over HTTP
Date: Thu,  4 Jul 2024 00:17:47 +0000
Message-ID: <20240704001748.746429-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.45.2.753.g447d99e1c3b
In-Reply-To: <20240628002742.3421311-1-sandals@crustytoothpaste.net>
References: <20240628002742.3421311-1-sandals@crustytoothpaste.net>
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

Changes since v1:
* Add a `none` option to explicitly reset the value.
* Improve explanation of `auto`.
* Improve commit message to explain tricky edge case.
* Note that TLS should always be used.

brian m. carlson (1):
  http: allow authenticating proactively

 Documentation/config/http.txt |  20 ++++++
 http.c                        |  60 ++++++++++++++++--
 t/t5563-simple-http-auth.sh   | 116 ++++++++++++++++++++++++++++++++++
 3 files changed, 190 insertions(+), 6 deletions(-)

