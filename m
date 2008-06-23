From: Ingo Molnar <mingo@elte.hu>
Subject: Re: linux-x86-tip: pilot error?
Date: Mon, 23 Jun 2008 17:31:59 +0200
Message-ID: <20080623153159.GC28394@elte.hu>
References: <20080622123620.GA9328@linux.vnet.ibm.com> <237967ef0806220548t3fd73211v354071efe2db22e4@mail.gmail.com> <20080622132105.GD22569@linux.vnet.ibm.com> <20080623071441.GA28887@elte.hu> <20080623151257.GC20902@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
	Mikael Magnusson <mikachu@gmail.com>, git@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jun 23 17:33:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KAo2w-0000zH-Fb
	for gcvg-git-2@gmane.org; Mon, 23 Jun 2008 17:33:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754279AbYFWPca (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jun 2008 11:32:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755454AbYFWPc3
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jun 2008 11:32:29 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:58654 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753637AbYFWPc3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jun 2008 11:32:29 -0400
Received: from elvis.elte.hu ([157.181.1.14])
	by mx3.mail.elte.hu with esmtp (Exim)
	id 1KAo1R-0005dT-TY
	from <mingo@elte.hu>; Mon, 23 Jun 2008 17:32:11 +0200
Received: by elvis.elte.hu (Postfix, from userid 1004)
	id 8F5323E21DD; Mon, 23 Jun 2008 17:32:00 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080623151257.GC20902@sigill.intra.peff.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
Received-SPF: neutral (mx3: 157.181.1.14 is neither permitted nor denied by domain of elte.hu) client-ip=157.181.1.14; envelope-from=mingo@elte.hu; helo=elvis.elte.hu;
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -1.5
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-1.5 required=5.9 tests=BAYES_00 autolearn=no SpamAssassin version=3.2.3
	-1.5 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85873>


* Jeff King <peff@peff.net> wrote:

> On Mon, Jun 23, 2008 at 09:14:41AM +0200, Ingo Molnar wrote:
> 
> > Is there a Git way of finding the common ancestor of a topic branch, 
> > when compared to upstream?
> 
> Try:
> 
>   git merge-base topic upstream

turns out we already use that as a fallback:

    if [ -z "$TREF" ]
    then
        echo "No topic reference found. Using git-merge-base"
        MBASE=`git-merge-base linus HEAD`
        TD=`get_date_for_tag`
        TB=`echo $B | sed "s@/@-@"`
        git-tag "tip-"$TB"-"$TD $MBASE
        TREF="tip-"$TB"-"$TD
    [...]

i guess we could use that unconditionally.

	Ingo
