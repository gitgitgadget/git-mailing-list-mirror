From: Alexander Duytschaever <Alexander.Duytschaever@UGent.be>
Subject: rename a remote does not update pushdefault (v1.9.5)
Date: Mon, 30 Mar 2015 11:28:30 +0200
Message-ID: <B2C5B27F9C4A45469123297E3F6BCF0C55DA0AEA07@XMAIL08.UGent.be>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Mar 30 11:28:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YcW01-0007R9-5r
	for gcvg-git-2@plane.gmane.org; Mon, 30 Mar 2015 11:28:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752209AbbC3J2o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Mar 2015 05:28:44 -0400
Received: from smtp2.ugent.be ([157.193.49.126]:44547 "EHLO smtp2.ugent.be"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751259AbbC3J2n convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 Mar 2015 05:28:43 -0400
Received: from localhost (mcheck3.ugent.be [157.193.71.89])
	by smtp2.ugent.be (Postfix) with ESMTP id 3F93D12C209
	for <git@vger.kernel.org>; Mon, 30 Mar 2015 11:28:42 +0200 (CEST)
X-Virus-Scanned: by UGent DICT
Received: from smtp2.ugent.be ([IPv6:::ffff:157.193.49.126])
	by localhost (mcheck3.UGent.be [::ffff:157.193.43.11]) (amavisd-new, port 10024)
	with ESMTP id OhNmajbV3fgN for <git@vger.kernel.org>;
	Mon, 30 Mar 2015 11:28:42 +0200 (CEST)
Received: from xhubt2.UGent.be (xhubt2.ugent.be [157.193.71.143])
	by smtp2.ugent.be (Postfix) with ESMTP id BFB6E12C3E5
	for <git@vger.kernel.org>; Mon, 30 Mar 2015 11:28:40 +0200 (CEST)
Received: from xmail08.UGent.be
 ([fe80:0000:0000:0000:714e:6bfc:201.106.217.0]) by xhubt2.UGent.be
 ([157.193.71.143]) with mapi; Mon, 30 Mar 2015 11:28:31 +0200
Thread-Topic: rename a remote does not update pushdefault (v1.9.5)
Thread-Index: AdBqwWcizuiKTzuRRnyIAHsYf4FwMwAClWcw
Accept-Language: en-US, nl-BE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
acceptlanguage: en-US, nl-BE
X-Miltered: at jchkm3 with ID 5519173F.004 by Joe's j-chkmail (http://helpdesk.ugent.be/email/)!
X-j-chkmail-Enveloppe: 5519173F.004 from xhubt2.ugent.be/xhubt2.ugent.be/157.193.71.143/xhubt2.UGent.be/<Alexander.Duytschaever@UGent.be>
X-j-chkmail-Score: MSGID : 5519173F.004 on smtp2.ugent.be : j-chkmail score : . : R=. U=. O=. B=0.000 -> S=0.000
X-j-chkmail-Status: Ham
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266449>

When defining pushdefault and renaming the associated remote, the pushdefault setting becomes invalid. Instead, it should follow the renamed remote if that was designated as pushdefault.

Test procedure:

1. Create/cd empty directory
2. `git init .`
3. `git remote add abc def`
4. Observe that `git remote` now shows 'abc'
5. `git config default.pushdefault abc`
6. Observe that `git config --list` shows default.pushdefault=abc
7. `git remote rename abc xyz`

BUG: observe that pushdefault still refers to 'abc', while it should now refer to 'xyz'.

Rgds

(Initially (wrongly) filed as TGit bug: https://code.google.com/p/tortoisegit/issues/detail?id=2438)
