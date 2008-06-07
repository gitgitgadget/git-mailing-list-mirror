From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG?] "git rebase --interactive" forces me to edit message.
Date: Fri, 06 Jun 2008 23:53:20 -0700
Message-ID: <7vabhxpwgv.fsf@gitster.siamese.dyndns.org>
References: <alpine.DEB.1.00.0806050536380.21190@racer>
 <200806050358.m553wgK9013230@mi0.bluebottle.com>
 <200806062147.m56LlCOe030269@mi0.bluebottle.com>
 <alpine.DEB.1.00.0806070556030.1783@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?iso-2022-jp?B?GyRCJDckaSQkJDckSiRKJDMbKEI=?= 
	<nanako3@bluebottle.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Jun 07 08:54:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4sJt-00017C-QR
	for gcvg-git-2@gmane.org; Sat, 07 Jun 2008 08:54:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753603AbYFGGxl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Jun 2008 02:53:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753269AbYFGGxl
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Jun 2008 02:53:41 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:36534 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752859AbYFGGxl (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Jun 2008 02:53:41 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 8FF781903;
	Sat,  7 Jun 2008 02:53:40 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id BB7ED1902; Sat,  7 Jun 2008 02:53:36 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 76359A20-345E-11DD-AE06-F9737025C2AA-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84177>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> But I started wondering (especially after read Junio's example) if you 
>> might have to stop and force edit the message even for commits you 
>> "pick", once you have a conflict.  The patch might not conflict, but 
>> with your logic shouldn't you be given a chance to amend messages, now 
>> it was discovered that the upstream did change that overlaps what you 
>> did?
>
> You do.  With a conflict, it stops.  If you do not commit, but only 
> resolve the conflicts and add them to the index, then continue the rebase 
> -i, it will ask you to commit.  Interactively.  (IOW an editor is fired 
> up.)

I might be misreading it, but my understanding of the scenario is:

 - you have pick A, pick B and pick C;
 - you reordered them to pick C, pick B and pick A;
 - the first one, pick C failed, and "add -u && rebase --continue" does
   ask for that pick C.

However, if neither pick B and pick A after that step has textual
conflicts, the command does not stop for them, and does not give you a
chance to adjust their potentially stale commit log messages.

I've already stated my position on this issue earlier in the thread.
