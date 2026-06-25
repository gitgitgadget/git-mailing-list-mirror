Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 049F826B08F
	for <git@vger.kernel.org>; Thu, 25 Jun 2026 16:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782404344; cv=none; b=eZYV51k2YuGPg26Z77qj414Ffjl3D2ULnrWPnDaz3+P/ShUgZ/BwZ9fx/qvpWFZWO+9pk27KKEcQ8FgP5hFjBBox796jyMYDlMzx1I1NxDeBRtdXooiuYCD20IlryU+tkRWynLmjJFpsq4g34SmZa4NDv4SFxJ9PcRsI+pZBCbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782404344; c=relaxed/simple;
	bh=5wYxoxwClM7bqSnv55xItUzQ2kPawXBCvBBnjW8BgvU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=m3Svl888jhT1hrQ3KKisptgYP+Orc83FEyA2NlG7ZPp8qdoQ9ec7n/a/2i2qTROMesSnR7lYGJ/Y+sLnh0e7HjwlxW60+bro8/rwERnSdqA/nAecEIAo4gm+zy3uKXobIianIM8qiCmyy32WQQw0yCbaT4TYO94AgzTFQprSOYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev; spf=pass smtp.mailfrom=malon.dev; dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b=b1Otferv; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=Vk1tTS8W; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=malon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b="b1Otferv";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="Vk1tTS8W"
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=b1Otferv04PPOGr7lhmURbISSkjRDIXyazJtD4r4sg6XIdBcfF9TlVnqVybwNG8O+A5iAke2n2WAzcsc83JKVRtFIObDZRnr9ZgcJ619IG+hXf3xGm5naloAp/DUx4eQAcc+338ZeSBBJUNyHPG3aOdREwjTJZ/f23BlEuV2N9Di9s15vEpV2UYYkuiecU12lZf56XHWe/3MZeOoOTRQjZdV3A5fjTmbkQqxwDcrxYPz7nd6SwXv63k9iSG3a5pCoBs14wJtHr3FsSunVWdl1AzOxbNM3JzAErnwfmHIOOQ53JMQ9D0ydh4asXb9dJHec0zNXLdNCmbiTziXHwNtRg==; s=purelymail2; d=malon.dev; v=1; bh=5wYxoxwClM7bqSnv55xItUzQ2kPawXBCvBBnjW8BgvU=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=Vk1tTS8W2nOpGbCda5uZAjrdsMOJFfgObJDNJ7UakGEcDDgZIVVbefg3e3BTwzX78gqcIEogM63r9PmNud40Kz2ihu4t+aLgGM6SuS6iFumUCBzhQoPoLojqZHgT5MukYHVqU3uK0LGmV2pkvScte7I00Z6V6SN7wRKvrXw1+o4iZGOBcoeJm9fJyxZivVxvlsVw0RJsoKYVW3nbeaHF2NVNMxEX2pJt8JuADqs/SZCSl9XvAje4gAd83U4H4+JpQKe90wdK5xjwZdBFo22QIBJOcMGWKKltNYntu9kQMYugpDOx0muzNr+JYdC0J3BfpZpX7GOHuelgHrvR/EbIlw==; s=purelymail2; d=purelymail.com; v=1; bh=5wYxoxwClM7bqSnv55xItUzQ2kPawXBCvBBnjW8BgvU=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 599969:32685:null:purelymail
X-Pm-Original-To: git@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -612697585;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Thu, 25 Jun 2026 16:18:55 +0000 (UTC)
From: Tian Yuchen <cat@malon.dev>
To: git@vger.kernel.org
Cc: cirnovskyv@gmail.com,
	Tian Yuchen <cat@malon.dev>,
	Christian Couder <christian.couder@gmail.com>,
	Ayush Chandekar <ayu.chandekar@gmail.com>,
	Olamide Caleb Bello <belkid98@gmail.com>
Subject: [PATCH v1 0/2] environment: move excludes_file into repo_config_values
Date: Fri, 26 Jun 2026 00:18:43 +0800
Message-ID: <20260625161845.7543-1-cat@malon.dev>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail
Content-Type: text/plain; charset=UTF-8

This series continues the libification effort by migrating the global
string variable 'excludes_file' into 'struct repo_config_values'. Since
this is a dynamically allocated variable, the migration requires proper
heap memory management.

The series is structured in two commits:

 - Abstract the XDG fallback lazy-loading logic out of dir.c into a proper
getter.

 - Move the variable into the struct and introducs 'repo_config_values_clea=
r()'.

Note on Submodules: A temporary shield 'if (repo !=3D the_repository)' is
included in both the getter and the clear function. This prevents
uninitialized submodules from triggering the BUG() assertion.
(Inspiration: [1])

Thanks.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Ayush Chandekar <ayu.chandekar@gmail.com>
Mentored-by: Olamide Caleb Bello <belkid98@gmail.com>
Signed-off-by: Tian Yuchen <cat@malon.dev>

[1] https://lore.kernel.org/git/c95a7730-7b14-4be0-a4e4-861b2f5430ea@gmail.=
com/

Tian Yuchen (2):
  dir: encapsulate excludes_file lazy-load
  environment: move excludes_file into repo_config_values

 dir.c         |  4 ++--
 environment.c | 29 ++++++++++++++++++++++++++---
 environment.h | 14 +++++++++++++-
 repository.c  |  1 +
 4 files changed, 42 insertions(+), 6 deletions(-)

--=20
2.43.0

