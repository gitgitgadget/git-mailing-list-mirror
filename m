From: Marcus Comstedt <marcus@mc.pp.se>
Subject: PATCH: Improved support for ISO 8601 timezones
Date: Mon, 17 May 2010 21:07:09 +0200
Message-ID: <1274123231-18482-1-git-send-email-marcus@mc.pp.se>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 17 21:15:24 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OE5md-00033s-Qh
	for gcvg-git-2@lo.gmane.org; Mon, 17 May 2010 21:15:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755778Ab0EQTPP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 May 2010 15:15:15 -0400
Received: from ua-85-227-1-6.cust.bredbandsbolaget.se ([85.227.1.6]:55327 "EHLO
	bahamut.mc.pp.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755717Ab0EQTPN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 May 2010 15:15:13 -0400
Received: from chiyo.mc.pp.se (chiyo [192.168.42.32])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by bahamut.mc.pp.se (Postfix) with ESMTPS id 33B97DD05
	for <git@vger.kernel.org>; Mon, 17 May 2010 21:07:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mc.pp.se; s=hedgehog;
	t=1274123245; bh=Xc/HDiE9awppUVb34XWA/BBP9TzHoSM4uzIK3Ht2XWw=;
	h=From:To:Subject:Date:Message-Id; b=XZZPeLRQQGKCiNS3w7PqUmni+RVBIV
	vTYanq8Kn3K34Tf+YyyW7hPWLOzRqFa/fz6a1mTj8pLGl45gjMBWEUHGYXgLgi1jkC2
	Gy2L+8Mlt7yDXUtLlA7DDRzgTuqcp1poB4Fz/IAgqbXLacr/WDZ8KVSkQomqAPBgwNj
	9cRDoZQ=
Received: from marcus by chiyo.mc.pp.se with local (Exim 4.71)
	(envelope-from <marcus@chiyo>)
	id 1OE5eu-0004oi-Ap
	for git@vger.kernel.org; Mon, 17 May 2010 21:07:24 +0200
X-Mailer: git-send-email 1.7.0.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147253>

Hi.

I discovered that git's date parser does not understand "Z" to mean
the "UTC" timezone.  This is unfortunate, because the use of "Z" is
prescribed by ISO 8601.

I made a small patch to add "Z" as an alias for "UTC", which enables
standard ISO 8601 timestamps to be parsed correctly.  Also, it fixes
a bug that at least three characters of the timezone name had to match,
which is of course impossible when the name of the timezone is shorter
than three characters.  There was already such a timezone before ("NT")
which could not be selected due to the bug.

The second patch, which is perhaps less essential, adds support for
the remaining numerical timezone indicators defined by ISO 8601 not
already supported by git (only +-hhmm was supported, but ISO 8601
also specifies that +-hh:mm and +-hh are ok as well).

Thanks


  // Marcus
