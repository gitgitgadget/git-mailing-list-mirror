From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH 0/2] commit: improve UTF-8 validation
Date: Sat, 29 Jun 2013 17:39:40 +0000
Message-ID: <20130629173940.GA226907@vauxhall.crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 29 19:47:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UszEm-0001Cg-Tg
	for gcvg-git-2@plane.gmane.org; Sat, 29 Jun 2013 19:47:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753128Ab3F2RrA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Jun 2013 13:47:00 -0400
Received: from qmta03.emeryville.ca.mail.comcast.net ([76.96.30.32]:44168 "EHLO
	qmta03.emeryville.ca.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752886Ab3F2Rq5 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 29 Jun 2013 13:46:57 -0400
X-Greylist: delayed 426 seconds by postgrey-1.27 at vger.kernel.org; Sat, 29 Jun 2013 13:46:57 EDT
Received: from omta21.emeryville.ca.mail.comcast.net ([76.96.30.88])
	by qmta03.emeryville.ca.mail.comcast.net with comcast
	id uHb81l0051u4NiLA3HfrdH; Sat, 29 Jun 2013 17:39:51 +0000
Received: from castro.crustytoothpaste.net ([IPv6:2001:470:1f04:79::2])
	by omta21.emeryville.ca.mail.comcast.net with comcast
	id uHfp1l00N25wmie8hHfql6; Sat, 29 Jun 2013 17:39:51 +0000
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:6680:99ff:fe4f:73a0])
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 5C32928063;
	Sat, 29 Jun 2013 17:39:45 +0000 (UTC)
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=q20121106; t=1372527591;
	bh=CuHvjUA0uxFhx9/1z0DwILhTvsdqbKcXISzMUcGZxio=;
	h=Received:Received:Received:Date:From:To:Subject:Message-ID:
	 MIME-Version:Content-Type;
	b=YB0p6hx5pPO9YIvX79pCVSJeJlEJndDHLmSSvSpyljY4TE/w3hayQOpfXwC7LNfwB
	 5kS/86s5D7SVlMxctDcVIwLCNSA7fpNYmScOmL+Kz3oGm98M9Ls3IROQ7xzAwBIWX8
	 fXGW8y+ZZgiReqYStjwAu5gmOfIWU8zmmRdv7BAw/GyKHN5DGycLM0RHUMDbKgYG6r
	 +P/cimjIt6pHFi3FDrFll/nN9TJW41rW1pJPEt3lM2W31D5FCFtSbnbwY84z/CIQN5
	 PzAR8CfK0dxjLeMaVFAxmXppHErf7zWpxm+qoylM9tCDXdI3nOcJwJeJVZGvzg5d6x
	 sQgOUAjtleD/w==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229255>

This series contains a pair of patches that improve the validation of
the UTF-8 used in commit messages.  Invalid codepoints, such as
surrogates and guaranteed non-characters, are rejected, along with
overlong UTF-8 sequences.

brian m. carlson (2):
  commit: reject invalid UTF-8 codepoints
  commit: reject overlong UTF-8 sequences

 commit.c                   | 28 +++++++++++++++++++++++++---
 t/t3900-i18n-commit.sh     | 17 +++++++++++++++++
 t/t3900/UTF-8-invalid.txt  |  3 +++
 t/t3900/UTF-8-overlong.txt |  3 +++
 4 files changed, 48 insertions(+), 3 deletions(-)
 create mode 100644 t/t3900/UTF-8-invalid.txt
 create mode 100644 t/t3900/UTF-8-overlong.txt

-- 
1.8.3.1
