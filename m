Received: from mail-0301.mail-europe.com (mail-0301.mail-europe.com [188.165.51.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EC992571BA
	for <git@vger.kernel.org>; Mon, 30 Jun 2025 18:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.165.51.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751306791; cv=none; b=LFMtmIULk4IJ1IRsM5xItddxCrKDLkmqnds41ZmoONX6INmckhqQ3bS6CUPvlV3TXWnDtJAccq0UzsdXvdMKeSL8GgXrd2HwUVRB4vb3RtWT8ELNxq4nvitFPD38Ty8tMgiuLQjUlZUwW+xvarWLqeoSHo8gKZeLi0HXntSsoVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751306791; c=relaxed/simple;
	bh=Df2i6syLKBTDbHzohIPchXKjrGKxxOtJ4k/X0u5AHeo=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=LLlGKNg5ronVCD4Y1oSRyatsXn4oo4nTLjIfaY8fDRv8YJvyDlLMlWLjMDzyBvRe4mw8gmzF1DV4BqogETZ2lyhV8wASq7DV2e4SSFDBSHQKjeTAmxYPsJ9FyD88gvokTKUreBn2MW9ZNtb1pJOKQUDf4qJFXXP4628sCYtQu8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=bHVQ4/3W; arc=none smtp.client-ip=188.165.51.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="bHVQ4/3W"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=l5zce4276vcezfs6gu7kdfahme.protonmail; t=1751306774; x=1751565974;
	bh=sK7sDS0PIcVlru2ZJaVD1JA76LAvAH8hB+bXHO0nj6U=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=bHVQ4/3WknRmloK7T5I/j+RcmF+oUXWXw0/GM9mBFgNYmaiS3mWe5fBCWvXLhc7QR
	 +6GOgRvW5SV3qy9AsDj45DMVwyRr2rD0YQBhFH2WcjI1IHCE3tOdzpgLnZTDAtvkME
	 tWKVYEPJ4yUAEOWLGAHBG4XueN+YVCsNH3WKtVavg30lkwHQxJXqA4h03NyCkhR8U7
	 3rRUySb+11QQm+JhOUIreuMoOmsc43N7I877NDfcPndWXyxz+86Mn+yh/a26ia+7Ti
	 HN3dZeIvN0RGqXw5r40k+47N+lNdGzDyzoSn9hMLr2V9D0G2hJMU9R/w2/zQMO7w6+
	 BmHjmEMn/12eg==
Date: Mon, 30 Jun 2025 18:05:59 +0000
To: Junio C Hamano <gitster@pobox.com>, "git@vger.kernel.org" <git@vger.kernel.org>
From: Aditya Garg <gargaditya08@proton.me>
Cc: Eric Sunshine <sunshine@sunshineco.com>, Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, Ben Knoble <ben.knoble@gmail.com>, "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH 0/5] docs: more improvements to sendemail documentation
Message-ID: <20250630180511.499-1-gargaditya08@proton.me>
Feedback-ID: 145777226:user:proton
X-Pm-Message-ID: fa3cfb8634ca3169c7af536a0763a2e0ca9b6873
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

From: Aditya Garg <gargaditya08@live.com>

Hi all

This patch series adds more improvements to the sendemail documentation.

The first patch links the OpenSSL's `verify(1)` manual page to the
documentation of `-CAfile` and `-CApath` options, mentioned in a very
confusing way in the documentation. The changes are similar to what
Junio suggested in https://lore.kernel.org/all/xmqqbjraf29c.fsf@gitster.g/

The second patch adds the `sendemail.outlookidfix` config option to the
documentation, which corresponds to the `--outlook-id-fix` command line
option. The documentation of the same was left by mistake before.

The third patch adds an OAuth2.0 credential helper link for AOL accounts
to the documentation.

The fourth patch adds a paragraph explaining the `sendmailCmd` option of
git send-email, and giving users an idea of how it can be used to support
proprietary APIs like Proton Mail API.

The last patch adds a paragraph explaining the options available for
Proton Mail, which has been increasing in popularity recently.

P.S. all the patches are being sent using `git-protonmail`, linked in
the fourth and fifth patch!

Aditya Garg (5):
  docs: link OpenSSL's verify(1) manual page to know about -CAfile and
    -CApath options
  docs: add outlookidfix config option to sendemail documentation
  docs: add an OAuth2.0 credential helper for AOL accounts
  docs: add a paragraph explaining the `sendmailCmd` option of sendemail
  docs: mention possible options for Proton Mail users

 Documentation/config/sendemail.adoc |  9 +++--
 Documentation/git-send-email.adoc   | 54 +++++++++++++++++++++++++----
 2 files changed, 55 insertions(+), 8 deletions(-)

--=20
2.50.0.windows.1


