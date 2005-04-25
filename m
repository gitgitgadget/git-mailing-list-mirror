From: "David S. Miller" <davem@davemloft.net>
Subject: Re: Revised PPC assembly implementation
Date: Mon, 25 Apr 2005 16:17:46 -0700
Message-ID: <20050425161746.7d943e62.davem@davemloft.net>
References: <17004.47876.414.756912@cargo.ozlabs.ibm.com>
	<20050425173430.11031.qmail@science.horizon.com>
	<17005.30365.995256.963911@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: linux@horizon.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 26 01:22:18 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQCtE-0000hv-EP
	for gcvg-git@gmane.org; Tue, 26 Apr 2005 01:21:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261225AbVDYX0S (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Apr 2005 19:26:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261227AbVDYX0R
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Apr 2005 19:26:17 -0400
Received: from dsl027-180-174.sfo1.dsl.speakeasy.net ([216.27.180.174]:37528
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S261225AbVDYX0H (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Apr 2005 19:26:07 -0400
Received: from localhost
	([127.0.0.1] helo=cheetah.davemloft.net ident=davem)
	by cheetah.davemloft.net with smtp (Exim 3.36 #1 (Debian))
	id 1DQCpm-0000Pe-00; Mon, 25 Apr 2005 16:17:46 -0700
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <17005.30365.995256.963911@cargo.ozlabs.ibm.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Tue, 26 Apr 2005 09:00:45 +1000
Paul Mackerras <paulus@samba.org> wrote:

> The main loop seems to be taking about 560 cycles (assuming that
> essentially all the time spent in my little test program is spent in
> the main loop).  It contains about 1000 integer instructions, which
> will take at least 500 cycles, as we have 2 ALUs.  So we are already
> within about 10% of the theoretical optimum.

Time to bust out the altivec perhaps :)

Do a block with the integer ALUs in parallel with a block done using
Altivec :-)  There should be enough spare insn slots so that the loads
are absorbed properly.

Unlike UltraSPARC's VIS, with altivec you can reasonably do shifts and
rotates, which is the only reason I'm suggesting this.

