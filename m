From: SZEDER =?utf-8?b?R8OhYm9y?= <szeder@ira.uka.de>
Subject: Re: [PATCH] git-completion.bash: always swallow error output of
 for-each-ref
Date: Sat, 13 Feb 2016 00:43:00 +0100
Message-ID: <20160213004300.Horde.fMBUV1thpmh_xekWw-EOFAA@webmail.informatik.kit.edu>
References: <56B32953.2010908@gmail.com>
 <20160204111307.GA30495@sigill.intra.peff.net>
 <alpine.DEB.2.20.1602041216240.2964@virtualbox>
 <20160213002122.Horde.mxoPmZIuCikpV2PO97l11AI@webmail.informatik.kit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed	DelSp=Yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>,
	Sebastian Schuberth <sschuberth@gmail.com>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	tr@thomasrast.ch
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Feb 13 00:43:33 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aUNN6-00033z-Kt
	for gcvg-git-2@plane.gmane.org; Sat, 13 Feb 2016 00:43:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751748AbcBLXn3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 12 Feb 2016 18:43:29 -0500
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:32846 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751082AbcBLXn2 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Feb 2016 18:43:28 -0500
Received: from irawebmail.ira.uni-karlsruhe.de ([141.3.10.230] helo=webmail.ira.uka.de)
	by iramx2.ira.uni-karlsruhe.de with esmtps port 25 
	iface 141.3.10.81 id 1aUNN0-0002Kh-Jv; Sat, 13 Feb 2016 00:43:26 +0100
Received: from apache by webmail.ira.uka.de with local (Exim 4.72)
	(envelope-from <szeder@ira.uka.de>)
	id 1aUNMa-0005ie-B1; Sat, 13 Feb 2016 00:43:00 +0100
Received: from x590d742f.dyn.telefonica.de (x590d742f.dyn.telefonica.de
 [89.13.116.47]) by webmail.informatik.kit.edu (Horde Framework) with HTTP;
 Sat, 13 Feb 2016 00:43:00 +0100
In-Reply-To: <20160213002122.Horde.mxoPmZIuCikpV2PO97l11AI@webmail.informatik.kit.edu>
User-Agent: Horde Application Framework 5
Content-Disposition: inline
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de 1455320606.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286096>


Quoting SZEDER G=C3=A1bor <szeder@ira.uka.de>:

> Now, if 'git for-each-ref' could understand '**' globbing, not just
> fnmatch...

Oh, look, though the manpage says:

   <pattern>...
       If one or more patterns are given, only refs are shown that matc=
h
       against at least one pattern, either using fnmatch(3) or literal=
ly,

'git for-each-ref' does in fact understand double asterisks:

   $ git for-each-ref --format=3D'%(refname)' '**/master'
   refs/heads/master
   refs/remotes/github/master
   refs/remotes/origin/master
   $ git for-each-ref --format=3D'%(refname)' 'refs/heads/b/**'
   refs/heads/b/r/a/n/c/h

Great, this combined with refname:strip=3D2 and 3 might open up some
more optimization possibilities...
