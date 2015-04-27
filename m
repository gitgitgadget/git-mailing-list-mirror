From: Stepan Kasal <kasal@ucw.cz>
Subject: Re: [PATCH/RFC] blame: CRLF in the working tree and LF in the repo
Date: Mon, 27 Apr 2015 08:11:16 +0200
Organization: <)><
Message-ID: <20150427061115.GB2766@camelia.ucw.cz>
References: <553CD3DA.9090700@web.de> <xmqqzj5uxhls.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	sandals@crustytoothpaste.net
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 27 08:11:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YmcGS-0003gV-Qe
	for gcvg-git-2@plane.gmane.org; Mon, 27 Apr 2015 08:11:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752498AbbD0GLU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Apr 2015 02:11:20 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:33378 "EHLO
	jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752431AbbD0GLT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Apr 2015 02:11:19 -0400
Received: from 49-117-207-85.strcechy.adsl-llu.static.bluetone.cz (82-73-239-109.cust.centrio.cz [109.239.73.82])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	(Authenticated sender: kasal)
	by jabberwock.ucw.cz (Postfix) with ESMTPSA id 00EE91C00F9;
	Mon, 27 Apr 2015 08:11:16 +0200 (CEST)
Received: from camelia.ucw.cz (camelia.ucw.cz [127.0.0.1])
	by 49-117-207-85.strcechy.adsl-llu.static.bluetone.cz (8.14.3/8.14.3) with ESMTP id t3R6BGm2002860;
	Mon, 27 Apr 2015 08:11:16 +0200
Received: (from kasal@localhost)
	by camelia.ucw.cz (8.14.3/8.14.3/Submit) id t3R6BGxc002859;
	Mon, 27 Apr 2015 08:11:16 +0200
Content-Disposition: inline
In-Reply-To: <xmqqzj5uxhls.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267847>

Hello,

On Sun, Apr 26, 2015 at 10:31:11PM -0700, Junio C Hamano wrote:
> [...] the commit you are proposing to revert [4d4813a5]
> was a misguided attempt to "fix" a non issue, [...]

yes, it was this.  So I propose to remove the whole commit,
including the test case and add two new test cases.

Details:

Git does not support CRLF as the internal line separator.
If you commit file in binary mode with CRLF, you are on your own.

If you then recode the file in the working tree to use LF, no wonder
things break.

If you do it indirectly, by setting the file mode to "text", things
break exactly the same way.

And that is the case that 4d4813a5 wanted to fix, cf the test case
in it.

OTOH, the commit has broken the most recommended scenario for Windows:
LF in the repo, CRLF in the work tree.

Thanks,
	Stepan
