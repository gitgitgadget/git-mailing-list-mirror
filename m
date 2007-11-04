From: Paul Mackerras <paulus@samba.org>
Subject: Re: [RFC PATCH] Make gitk use --early-output
Date: Sun, 4 Nov 2007 22:04:09 +1100
Message-ID: <18221.42793.38389.359621@cargo.ozlabs.ibm.com>
References: <18221.2285.259487.655684@cargo.ozlabs.ibm.com>
	<e5bfff550711040237s250bcec0iddf1ebdc616e0bbf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: "Linus Torvalds" <torvalds@linux-foundation.org>,
	git@vger.kernel.org
To: "Marco Costalba" <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 04 12:29:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IodfW-0005Hz-H7
	for gcvg-git-2@gmane.org; Sun, 04 Nov 2007 12:29:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755754AbXKDL3Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Nov 2007 06:29:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755905AbXKDL3Q
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Nov 2007 06:29:16 -0500
Received: from ozlabs.org ([203.10.76.45]:35866 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755754AbXKDL3P (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Nov 2007 06:29:15 -0500
Received: by ozlabs.org (Postfix, from userid 1003)
	id 24A5EDDE24; Sun,  4 Nov 2007 22:29:13 +1100 (EST)
In-Reply-To: <e5bfff550711040237s250bcec0iddf1ebdc616e0bbf@mail.gmail.com>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63381>

Marco Costalba writes:

> On 11/4/07, Paul Mackerras <paulus@samba.org> wrote:
> >
> >      set vnextroot($view) 0
> > -    set order "--topo-order"
> > +    set order "--early-output=50"
> 
> But --early-output does not imply --topo-order, I guess...

Look here in Linus' patch:

+			if (!prefixcmp(arg, "--early-output")) {
+				int count = 100;
+				switch (arg[14]) {
+				case '=':
+					count = atoi(arg+15);
+					/* Fallthrough */
+				case 0:
+					revs->topo_order = 1;
+					revs->early_output = count;
+					continue;
+				}
+			}

So yes, --early-output does imply --topo-order.

> P.S: Why did you choose not let git log (i.e. Linus) to handle the
> default number of commits?
> 
> "--early-output=50" instead of just "--early-output"

Because I was thinking of adding a control in the edit/preferences
window for it later on.

Paul.
