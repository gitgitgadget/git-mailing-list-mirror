From: linux@horizon.com
Subject: Re: Revised PPC assembly implementation
Date: 26 Apr 2005 02:14:55 -0000
Message-ID: <20050426021455.21115.qmail@science.horizon.com>
References: <20050425161746.7d943e62.davem@davemloft.net>
Cc: git@vger.kernel.org, linux@horizon.com
X-From: git-owner@vger.kernel.org Tue Apr 26 04:10:08 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQFWT-00060q-PU
	for gcvg-git@gmane.org; Tue, 26 Apr 2005 04:10:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261265AbVDZCO6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Apr 2005 22:14:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261273AbVDZCO6
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Apr 2005 22:14:58 -0400
Received: from science.horizon.com ([192.35.100.1]:45108 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S261265AbVDZCO4
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Apr 2005 22:14:56 -0400
Received: (qmail 21116 invoked by uid 1000); 26 Apr 2005 02:14:55 -0000
To: davem@davemloft.net, paulus@samba.org
In-Reply-To: <20050425161746.7d943e62.davem@davemloft.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>From davem@davemloft.net Mon Apr 25 23:26:06 2005
Date: Mon, 25 Apr 2005 16:17:46 -0700
From: "David S. Miller" <davem@davemloft.net>
To: Paul Mackerras <paulus@samba.org>
Cc: linux@horizon.com, git@vger.kernel.org
Subject: Re: Revised PPC assembly implementation
In-Reply-To: <17005.30365.995256.963911@cargo.ozlabs.ibm.com>
References: <17004.47876.414.756912@cargo.ozlabs.ibm.com>
	<20050425173430.11031.qmail@science.horizon.com>
	<17005.30365.995256.963911@cargo.ozlabs.ibm.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

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


