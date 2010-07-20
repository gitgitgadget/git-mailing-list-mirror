From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH v3 05/13] parse the -L options
Date: Tue, 20 Jul 2010 09:51:55 +0200
Message-ID: <201007200951.56218.trast@student.ethz.ch>
References: <1278829141-11900-1-git-send-email-struggleyb.nku@gmail.com> <201007200048.18284.trast@student.ethz.ch> <7veiezni4m.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Bo Yang <struggleyb.nku@gmail.com>, <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 20 09:52:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ob7cn-0000Jf-Ii
	for gcvg-git-2@lo.gmane.org; Tue, 20 Jul 2010 09:52:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754640Ab0GTHwU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Jul 2010 03:52:20 -0400
Received: from gwse.ethz.ch ([129.132.178.238]:46409 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754043Ab0GTHwT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Jul 2010 03:52:19 -0400
Received: from CAS11.d.ethz.ch (172.31.38.211) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.2.254.0; Tue, 20 Jul
 2010 09:52:17 +0200
Received: from thomas.localnet (129.132.153.233) by CAS11.d.ethz.ch
 (172.31.38.211) with Microsoft SMTP Server (TLS) id 14.0.702.0; Tue, 20 Jul
 2010 09:51:56 +0200
User-Agent: KMail/1.13.5 (Linux/2.6.31.12-0.2-desktop; KDE/4.4.5; x86_64; ; )
In-Reply-To: <7veiezni4m.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151308>

Junio C Hamano wrote:
> Thomas Rast <trast@student.ethz.ch> writes:
> > I think that would just needlessly break the analogy to git-blame.[0]
> > With the current code,
> >
> >   git blame -L 2,3 <path>
> >   git log -L 2,3 <path>
> >
> > work the same.
> 
> I like the general direction, but I am not sure how far we want to take
> that analogue with blame, though.
> 
> For example, Bo's "log -L" thing also works on more than one path, no?  I
> suspect it might be be reasonable to teach "blame" to annotate more than
> one path (with ranges) the same way.  There is no technical limitation in
> the underlying scoreboard mechanism to prevent it from happening.
> 
> Very similar to "blame" but quite differently from any normal "log"
> operation, "log -L" allows only one positive commit (starting point).

AFAICT this is not a conceptual requirement, only one of the current
implementation/option parsing.  [Bo, how hard would it be to remove
this requirement?]

'git log --follow', if it were ever unbroken, would have much the same
problem that while technically allowing more than one starting point,
using that is only possible if the starting filename happens to agree
on all of them.

> Perhaps these argue that this new feature shouldn't be a new option of
> "log" at the UI level after all; rather, I wonder if this should be better
> presented as a new mode of "blame" (e.g. "blame --log", unlike showing
> "cvs annotate" like output, shows history like "git log" does).

Then you suddenly have a mode of git-blame that takes the normal
options, and another that takes all the git-log arguments that pertain
to commit formatting.

(Ok, you can't reasonably give it any of the diff-formatting options,
but e.g. --graph and --pretty are supposed to work.)

What's more, we (well, I do anyway) absolutely want gitk to display
the same output eventually.  So that would also suddenly give you an
example where gitk isn't so equivalent to git-log-in-a-fancy-window
any more.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
