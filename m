Received: from mail-0301.mail-europe.com (mail-0301.mail-europe.com [188.165.51.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3034A2E7180
	for <git@vger.kernel.org>; Mon, 30 Jun 2025 18:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.165.51.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751306823; cv=none; b=gVuaPjvOSInCMF71yDMHATeYcvFlGhCnDok4h9HkESuhd8XrNP8SZ3SJWk5NAT2HTPNax4h/nIv8ylkMfAcqJ7ZAj2wR9usdH93CP3lK0rhGvF4rx+Cf6cTSa92iRzs/lsakyDRejkWQlDPkG3LWpgifuGcrHetSojNxB6PM9gQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751306823; c=relaxed/simple;
	bh=raBzJk69LZmEK7hlY434CriUUZaCw16DqhBf/zVlO7w=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Dcacti27Jl4+FroC9IHsoaR+ZhqS854DI8i9oeuf8PTZQ0GmJrDEpePb/HonW68HqwBAveB27yagXxb3UMuWUQ8DaEKyd2EYuu4NIsqRxYt8SWD2h2QF62JiPPdLXpEz1vcVRJS3K4ZR8ej6BVkTi93Z7nBGe5pfv0MxjpmxnOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=K3SWVqAZ; arc=none smtp.client-ip=188.165.51.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="K3SWVqAZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1751306811; x=1751566011;
	bh=oASMoDoNwDNh+WxSDpvlagJh5PfDLP1HG3Iehp18ekg=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=K3SWVqAZnKn80bBof+38Xbab0G2zhZ3khaqMnnZMG9ZMgD62XgDadZUAUY4eWZvI9
	 DI5Jx+ZcA8QPzyNaS3S/QKcYAf+Rbr96QHHmJhNEUYftZWf0tLnpQmQimwqU463qhq
	 pZFmpJRLkJCvVkDMkdrt4+uKhW/25ZXhSciu1H6dQxPGOuLvJHCU129JlLn7qCJhw+
	 ZXdunkN1QpI8dI6JGq6WZlO9jBCdWAsVcZXzh7Mxeemc7cCOM8Zhf2pZQHFv9CETU/
	 BdMjffnVBbbd4rrK4/TrJm/x1s9q+43sFPYX7ke37bXD4Fcw3yInyYTeDi+VZus82H
	 0aherOBsTQZDQ==
Date: Mon, 30 Jun 2025 18:06:46 +0000
To: Junio C Hamano <gitster@pobox.com>, "git@vger.kernel.org" <git@vger.kernel.org>
From: Aditya Garg <gargaditya08@proton.me>
Cc: Eric Sunshine <sunshine@sunshineco.com>, Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, Ben Knoble <ben.knoble@gmail.com>, "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH 4/5] docs: add a paragraph explaining the `sendmailCmd` option of sendemail
Message-ID: <20250630180511.499-5-gargaditya08@proton.me>
In-Reply-To: <20250630180511.499-1-gargaditya08@proton.me>
References: <20250630180511.499-1-gargaditya08@proton.me>
Feedback-ID: 145777226:user:proton
X-Pm-Message-ID: 4edb76c127a52a2ebc17b2271c4479e7c5c3473e
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

From: Aditya Garg <gargaditya08@live.com>

`sendmailCmd` is a configuration option in `git-send-email` that allows
users to send emails using an external application that supports
sendmail-like commands. This ability has been very useful to support
proprietary email APIs without modifying the `git-send-email` codebase.
It is also useful for users who prefer to use another SMTP client
instead of the SMTP perl library used by `git-send-email`.
This commit adds a paragraph to the documentation explaining this
option.

Signed-off-by: Aditya Garg <gargaditya08@live.com>
---
 Documentation/git-send-email.adoc | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/Documentation/git-send-email.adoc b/Documentation/git-send-ema=
il.adoc
index b31145901c..6556f949a1 100644
--- a/Documentation/git-send-email.adoc
+++ b/Documentation/git-send-email.adoc
@@ -619,6 +619,35 @@ These additional Perl modules are also required:
 https://metacpan.org/pod/Authen::SASL[Authen::SASL] and
 https://metacpan.org/pod/Mail::Address[Mail::Address].
=20
+Exploiting the `sendmailCmd` option of `git send-email`
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+Apart from sending emails via an SMTP server, `git send-email` can also se=
nd
+emails through any application that supports sendmail-like commands. You c=
an
+read documentation of `--sendmail-cmd=3D<command>` above for more informat=
ion.
+This ability can be very useful if you want to use another application as =
an
+SMTP client for `git send-email`, or if your email provider uses proprieta=
ry
+APIs instead of SMTP to send emails.
+
+As an example, lets see how to configure https://marlam.de/msmtp/[msmtp], =
a
+popular SMTP client found in many Linux distributions. Edit `~/.gitconfig`
+to instruct `git-send-email` to use it for sending emails.
+
+----
+[sendemail]
+=09sendmailCmd =3D /usr/bin/msmtp # Change this to the path where msmtp is=
 installed
+----
+
+Links of a few such community maintained helpers are:
+
+=09- https://marlam.de/msmtp/[msmtp]
+=09  (popular SMTP client with many features, available for Linux and macO=
S)
+
+=09- https://github.com/AdityaGarg8/git-credential-email[git-protonmail]
+=09  (cross platform client that can send emails using the ProtonMail API)
+
+=09- https://github.com/AdityaGarg8/git-credential-email[git-msgraph]
+=09  (cross platform client that can send emails using the Microsoft Graph=
 API)
=20
 SEE ALSO
 --------
--=20
2.50.0.windows.1


