From: Juergen Ruehle <j.ruehle@bmiag.de>
Subject: Re: [PATCH] Provide better feedback for the untracked only case in
	status output
Date: Wed, 10 Jan 2007 21:14:26 +0100
Message-ID: <17829.18722.194000.927872@lapjr.intranet.kiel.bmiag.de>
References: <7vps9pwa3e.fsf@assigned-by-dhcp.cox.net>
	<1168412892113-git-send-email-j.ruehle@bmiag.de>
	<1168452977.19643.57.camel@ibook.zvpunry.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 10 21:14:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H4jqR-00078O-CR
	for gcvg-git@gmane.org; Wed, 10 Jan 2007 21:14:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965048AbXAJUOo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 10 Jan 2007 15:14:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965083AbXAJUOo
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Jan 2007 15:14:44 -0500
Received: from meriadoc.bmiag.de ([62.154.210.133]:56972 "EHLO
	meriadoc.bmiag.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965048AbXAJUOn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Jan 2007 15:14:43 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by meriadoc.bmiag.de (Postfix) with ESMTP id 77C1D3AED2;
	Wed, 10 Jan 2007 21:14:42 +0100 (CET)
Received: from meriadoc.bmiag.de ([127.0.0.1])
	by localhost (meriadoc [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 18203-03; Wed, 10 Jan 2007 21:14:42 +0100 (CET)
Received: from eorl.intranet.kiel.bmiag.de (eorl.intranet.kiel.bmiag.de [10.131.2.1])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by meriadoc.bmiag.de (Postfix) with ESMTP id E04513AECB;
	Wed, 10 Jan 2007 21:14:37 +0100 (CET)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by eorl.intranet.kiel.bmiag.de (Postfix) with ESMTP id 32FD83ADC8;
	Wed, 10 Jan 2007 21:14:37 +0100 (CET)
Received: from eorl.intranet.kiel.bmiag.de ([127.0.0.1])
	by localhost (eorl [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 23329-03; Wed, 10 Jan 2007 21:14:32 +0100 (CET)
Received: from LAPJR (dialin5.galadriel.bmiag.de [192.168.251.5])
	by eorl.intranet.kiel.bmiag.de (Postfix) with ESMTP id 4F4693ADC6;
	Wed, 10 Jan 2007 21:14:28 +0100 (CET)
To: Michael Loeffler <zvpunry@zvpunry.de>
In-Reply-To: <1168452977.19643.57.camel@ibook.zvpunry.de>
X-Mailer: VM 7.19 under Emacs 22.0.92.1
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at eorl.intranet.kiel.bmiag.de
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at meriadoc.bmiag.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36528>

Michael Loeffler writes:
 > hi,
 > 
 > Am Mittwoch, den 10.01.2007, 08:08 +0100 schrieb Juergen Ruehle:
 > ...
 > > @@ -311,12 +312,14 @@ void wt_status_print(struct wt_status *s)
 > ...
 > > +		else if (s->is_initial)
 > > +			printf("nothing to commit (working directory is empty)\n");
 > Shouldn't the user know that there is nothing in his working directory?

:-)

Well this is the state directly after git-init, e.g. the very first
contact with git. Perhaps we should write:

nothing to commit (create files in the working directory and use git add)

 > > +		else
 > > +			printf("nothing to commit (working directory matches HEAD)\n");
 > How about s/matches HEAD/clean/

I like that.

 > There is another thing:
 > # Changed but not added:
 > #   (use "git add <file>..." to incrementally add content to commit)
 > #
 > #       deleted:    blah
 > 
 > How about adding some more hints (e.g.: git rm --cached <file>)
 > depending on the diff_queue in wt_status_print_changed_cb()?

Yes, there's always one more case to consider:-)
