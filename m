Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89CD5BE4D
	for <git@vger.kernel.org>; Thu, 21 Dec 2023 06:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="YmwEHafK"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 5AFB4346C1;
	Thu, 21 Dec 2023 01:59:30 -0500 (EST)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-transfer-encoding;
	 s=sasl; bh=iD422RJHaG+zMRPpv32hwJeVWXB1acnnzQzSiBvuUl0=; b=YmwE
	HafKZxsynBqYBREg1zuru7MogYkwVkDI4HLKhWhhVFCPO1boxDxUXHl08gtEBT5s
	dKd4XYeDvBwmErrDsAf4gm+n2c99xVk7VHtgVeDiZ0HEgbPOH/nMmlGlbbLi38Du
	PAryGR+5tbcOkaDU9xs7+WFvryM3zjQwy2zdD4I=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 465AA346C0;
	Thu, 21 Dec 2023 01:59:30 -0500 (EST)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.193.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id D2862346BD;
	Thu, 21 Dec 2023 01:59:26 -0500 (EST)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH 0/3] sparse-checkout with --end-of-options
Date: Wed, 20 Dec 2023 22:59:22 -0800
Message-ID: <20231221065925.3234048-1-gitster@pobox.com>
X-Mailer: git-send-email 2.43.0-174-g055bb6e996
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Pobox-Relay-ID:
 7AE22092-9FCE-11EE-BF6B-A19503B9AAD1-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable

I only wanted to make sure=20

    git sparse-checkout set --end-of-options path

work fine, but it turns out that there were other sloppiness that
has nothing to do with the end-of-options handling that needs to be
adjusted to the new world order, so I ended up addressing that as
well.

Junio C Hamano (3):
  sparse-checkout: take care of "--end-of-options" in set/add
  sparse-checkout: allow default patterns for 'set' only !stdin
  sparse-checkout: tighten add_patterns_from_input()

 builtin/sparse-checkout.c          |  9 ++++++++-
 parse-options.c                    |  8 ++++++++
 parse-options.h                    |  2 ++
 t/t1090-sparse-checkout-scope.sh   |  8 ++++++++
 t/t1091-sparse-checkout-builtin.sh | 13 +++++++++++--
 5 files changed, 37 insertions(+), 3 deletions(-)

--=20
2.43.0-174-g055bb6e996

