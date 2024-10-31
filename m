Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9119319C564
	for <git@vger.kernel.org>; Thu, 31 Oct 2024 23:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730418943; cv=none; b=I19jxaBMyuR5yV+cXj6Z8Uu4dcHys5mOKZEXRoKjW2J8/N7tcZpzde8h1cKmxYrx8pMNkqwnUBrg5BLUs+J6pIOedD6IAwSp7/I9mCaQ4n8R8wtKC3NLGQCK3nZU7h2Ue3GdV7Kl00e3E+fqkbXviRY99yaTMxAUzLO1j1+NIC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730418943; c=relaxed/simple;
	bh=eB/I9g6irW5KzO5MUgaDeyhrNHTw2kp9TMPFC2AvEks=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ku6LjKegzY8xP90GLflD6pNcdLbuYUZvZHigldSn2c6pv9jJH7PaaZWRFhFEs6AnNJY0+cBb+hJLHf36FWDy2nPabH8dbt8/82o9Nfvt1Oazl6ETP84Yb+2Q7UYUruB3Fg9LSjnahnWXx1DbOh0kD2/vVgPwLaj/+YoGX/zGbxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=1NeA48/j; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="1NeA48/j"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1730418579;
	bh=eB/I9g6irW5KzO5MUgaDeyhrNHTw2kp9TMPFC2AvEks=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
	 Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	 In-Reply-To:References:Content-Type:Content-Disposition;
	b=1NeA48/jR2ngOFZVcYgdu9mxiIpMYILyUaDL8iSGFmdvSX3PLjWx4/df+O3/frzyW
	 lxZfW8fBchbeZvVvSe0NxdR42MaeeZ55Kv/MGpwx1VEWaAZQcbwc3wNncn7A1sehkC
	 8UGfW05OVi6bUXU7D2dylkU1fHdJF0ub5h74HcG3R9FpWeJjjEFzNRUdIaztoFS6NG
	 yncg6iqvBPRnKD/HoZXi3gRoLbXrVvpDXDtWQrmMvnaiBywXfI7XyIB1ohOJrBxd7T
	 2vvqpZUxfrtSA9tdn3ZMqONJN3kQTKuWV+AWEYHfGa/2xTcVM7nKgS0/o5cDWe+1Sa
	 mKJWLvqBtKSlE6O0VRfdeXBHIuR5uGkCwl1uVOPSl1K78hKpnYOYNJY6Nlfdw7dUeG
	 IOH4uwaiEi+rCA2BasfxOyitCuFFXlqMRteGz5al1qXt4Fv5RHoDnQWLKQjC8dXwMy
	 yaTPXo9XwlrEpz8QRnTO+YP34ucqtmnirQ8KWDIXZUul+NknL0d
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id E30FB200C1;
	Thu, 31 Oct 2024 23:49:39 +0000 (UTC)
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Taylor Blau <me@ttaylorr.com>,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 1/3] gitlab-ci: switch from Ubuntu 16.04 to 20.04
Date: Thu, 31 Oct 2024 23:49:32 +0000
Message-ID: <20241031234934.3451390-2-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.45.2.753.g447d99e1c3b
In-Reply-To: <20241031234934.3451390-1-sandals@crustytoothpaste.net>
References: <20241031234934.3451390-1-sandals@crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Ubuntu 16.04 is past its normal LTS lifespan, so let's switch to Ubuntu
20.04 instead, which is the latest regular LTS version.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 .gitlab-ci.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 526ecfe030..a1bc92893f 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -35,7 +35,7 @@ test:linux:
   parallel:
     matrix:
       - jobname: linux-old
-        image: ubuntu:16.04
+        image: ubuntu:20.04
         CC: gcc
       - jobname: linux-sha256
         image: ubuntu:latest
