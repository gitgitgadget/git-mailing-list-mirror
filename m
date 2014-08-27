From: Jeff King <peff@peff.net>
Subject: Re: Git Bug Report: bisect run failed to locate the right commit
Date: Wed, 27 Aug 2014 10:17:26 -0400
Message-ID: <20140827141725.GA31879@peff.net>
References: <C40A01C66E914D4EB90E1B40564B0E56CBFE1C82@MBOX2-4.ntu.internal>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: =?utf-8?B?5p2O56WQ5qOg?= <r01942008@ntu.edu.tw>
X-From: git-owner@vger.kernel.org Wed Aug 27 16:17:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XMe2V-0005XF-Ta
	for gcvg-git-2@plane.gmane.org; Wed, 27 Aug 2014 16:17:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934802AbaH0OR2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 27 Aug 2014 10:17:28 -0400
Received: from cloud.peff.net ([50.56.180.127]:60071 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S934408AbaH0OR2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Aug 2014 10:17:28 -0400
Received: (qmail 1462 invoked by uid 102); 27 Aug 2014 14:17:27 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 27 Aug 2014 09:17:27 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 27 Aug 2014 10:17:26 -0400
Content-Disposition: inline
In-Reply-To: <C40A01C66E914D4EB90E1B40564B0E56CBFE1C82@MBOX2-4.ntu.internal>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255995>

On Wed, Aug 27, 2014 at 01:42:45PM +0000, =E6=9D=8E=E7=A5=90=E6=A3=A0 w=
rote:

> Here is the manual test script I use is "manualscript.py":
>=20
> I use git bisect manually, search from 1.2.9(bad) to 1.2.8(good), I
> locate the commit that fixes this issue. The running log is attached
> in this file(manual).
>=20
> However if I use the automatic script git bisect run with the script
> "auto script":
>=20
> It will give a wrong answer, the log file is also attached(auto)

When you get to 300cd08225, your manual bisect shows this as bad:

  Bisecting: 0 revisions left to test after this (roughly 1 step)
  [300cd0822505a4bd308acd1520ff3ef0f20f8635] fixed issue #19
  $ ./manualscript.py=20
  False
  False
  $ git bisect bad

When you hit the same commit with your automatic test, the output from
your script is different:

  Bisecting: 0 revisions left to test after this (roughly 1 step)
  [300cd0822505a4bd308acd1520ff3ef0f20f8635] fixed issue #19
  running ./autoscript.py
  False
  True

which would yield "git bisect good" according to the simplified scripts
you sent. I suspect your problem is in the test script.

-Peff
