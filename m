Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9FC1C8D2
	for <git@vger.kernel.org>; Mon, 30 Oct 2023 16:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="f1TfF7GP"
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [IPv6:2600:3c04::f03c:92ff:fe9e:c6d8])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D205100
	for <git@vger.kernel.org>; Mon, 30 Oct 2023 09:27:01 -0700 (PDT)
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:5e4a:89fa:93b9:2058])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (3072 bits) server-digest SHA256)
	(No client certificate requested)
	by ring.crustytoothpaste.net (Postfix) with ESMTPSA id C5DCE5B0B8;
	Mon, 30 Oct 2023 16:26:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1698683219;
	bh=Gxp2HDhG1SoNgNjEs41kZ6Tg4kd9WzZQYPx4v3uWBdw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
	 Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	 In-Reply-To:References:Content-Type:Content-Disposition;
	b=f1TfF7GPokmQWbgHjt8tTHtqskOq4/lDh8FSo3bcd8abSglmMKnc/PpoMTBKNdb1h
	 3GwEkBmBTOk8VhdXF/P/LHeMYG63Sq9yPncPOYB7+2blivtD8AyXSy17bMN4hvewUP
	 3wiwwB7EMkb8YyrVsR+5JrvjQU6GfmBseEdCHW+DkXyEhM3aPT5GlXoHw63nPZSfGP
	 U2nDaTUYaX34KU6wqeFFy5Yp1qX0mZzWwcjmdx+tGKFX2fKBdUY1haDVaZwBJcEIpX
	 ksezrVNs0Hv0yOuBFg6G5PVIrujuQVeNKFeUDxrArYdrQKML8LNv7ncg9IvnxY2oF4
	 gWErOVGjGrXeAjs7SqlNo5eCpjHWLRHUu2GkigwzroF2YmTiRVNucKKnTDxrhTe0O2
	 jPYzSu3nU24hIJOur9/ZUssqN9LKNvKrFMcEHwtfeFBThTFC2wQJkzbP1gH3AMHXBT
	 KNYdNpNALDuIYsWiZ1Rzk6Eebantji8HXd0MKiAj87x+sfg0n9J
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Taylor Blau <me@ttaylorr.com>
Subject: [PATCH v2 0/1] Object ID support for git merge-file
Date: Mon, 30 Oct 2023 16:26:57 +0000
Message-ID: <20231030162658.567523-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231024195655.2413191-1-sandals@crustytoothpaste.net>
References: <20231024195655.2413191-1-sandals@crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: *

This series introduces an --object-id option to git merge-file such
that, instead of reading and writing from files on the system, it reads
from and writes to the object store using blobs.

Changes from v1:
* Improve error handling
* Re-add `-p` argument for documentation

brian m. carlson (1):
  merge-file: add an option to process object IDs

 Documentation/git-merge-file.txt | 20 +++++++++++
 builtin/merge-file.c             | 62 +++++++++++++++++++++++---------
 t/t6403-merge-file.sh            | 58 ++++++++++++++++++++++++++++++
 3 files changed, 124 insertions(+), 16 deletions(-)

