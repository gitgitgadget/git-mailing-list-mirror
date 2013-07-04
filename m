From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v2 0/2] commit: improve UTF-8 validation
Date: Thu, 4 Jul 2013 17:17:36 +0000
Message-ID: <cover.1372957719.git.sandals@crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 04 19:17:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UunAE-0007Zl-Qc
	for gcvg-git-2@plane.gmane.org; Thu, 04 Jul 2013 19:17:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756762Ab3GDRRp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Jul 2013 13:17:45 -0400
Received: from qmta10.emeryville.ca.mail.comcast.net ([76.96.30.17]:34952 "EHLO
	qmta10.emeryville.ca.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756626Ab3GDRRo (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 Jul 2013 13:17:44 -0400
Received: from omta02.emeryville.ca.mail.comcast.net ([76.96.30.19])
	by qmta10.emeryville.ca.mail.comcast.net with comcast
	id wHFh1l0030QkzPwAAHHkuh; Thu, 04 Jul 2013 17:17:44 +0000
Received: from castro.crustytoothpaste.net ([173.11.243.49])
	by omta02.emeryville.ca.mail.comcast.net with comcast
	id wHHi1l00R14fh3h8NHHjQ9; Thu, 04 Jul 2013 17:17:44 +0000
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:6680:99ff:fe4f:73a0])
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 91A7828074;
	Thu,  4 Jul 2013 17:17:41 +0000 (UTC)
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=q20121106; t=1372958264;
	bh=/uwUuBLKGUHMOlSLpmdsyQSzKKoFkHdYuMUWitOn2Ac=;
	h=Received:Received:Received:Date:From:To:Subject:Message-ID:
	 MIME-Version:Content-Type;
	b=ESTS5f+8OdiFohhVriEpIHKxAHQ0Rkfw/pCMHH1xNLQdDJrTh5IYvpFuzjzLuo38C
	 nPBqHFcZ2T8JyU4QVoxgw2yBj2Thf6A+Lnc1OyZF4211fiDlqM6M2JTGaCUtfcT4kL
	 XbszYBRFyP6/i/nbZBZU5LH4vDzZKFlh1CEfVKKvgAToQgr+69ZOOBVwJ18qrfcXsj
	 tCK1TGH04LMx0dH4rdCoqNC0BEdGCaHuwpcrS3qU8PQRFxTvFAD+3a6dpRKevDw6xE
	 NKjLptHsqzpEkncSP3+8zy+dtBpvgvBuRhP/F7OSB6vlZvdoTsyzmHCpDtZR6EAeB2
	 pRua7da4h3VBw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229597>

This series contains a pair of patches that improve the validation of
the UTF-8 used in commit messages.  Invalid codepoints, such as
surrogates and guaranteed non-characters, are rejected, along with
overlong UTF-8 sequences.

Changes from v1:

* Improved comments to aid those less familiar with Unicode.
* Generated test files using printf as part of the test.
* Removed FIXME comments for things that have been fixed.
* Use a shorter form for detecting surrogate pairs.

brian m. carlson (2):
  commit: reject invalid UTF-8 codepoints
  commit: reject overlong UTF-8 sequences

 commit.c               | 34 ++++++++++++++++++++++++++++------
 t/t3900-i18n-commit.sh | 23 +++++++++++++++++++++++
 2 files changed, 51 insertions(+), 6 deletions(-)

-- 
1.8.3.1
