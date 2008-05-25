From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] log --graph: draw '>' and '<' with --left-right
Date: Sat, 24 May 2008 22:27:12 -0700
Message-ID: <7v63t3j6mn.fsf@gitster.siamese.dyndns.org>
References: <alpine.DEB.1.00.0805221235430.30431@racer>
 <alpine.DEB.1.00.0805221344360.30431@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Adam Simpkins <adam@adamsimpkins.net>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun May 25 07:28:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K08mm-0008Hz-Th
	for gcvg-git-2@gmane.org; Sun, 25 May 2008 07:28:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752341AbYEYF1a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 May 2008 01:27:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752347AbYEYF1a
	(ORCPT <rfc822;git-outgoing>); Sun, 25 May 2008 01:27:30 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:42633 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752260AbYEYF13 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 May 2008 01:27:29 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 4996F4E79;
	Sun, 25 May 2008 01:27:24 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 6F42B4E75; Sun, 25 May 2008 01:27:20 -0400 (EDT)
In-Reply-To: <alpine.DEB.1.00.0805221344360.30431@racer> (Johannes
 Schindelin's message of "Thu, 22 May 2008 13:47:23 +0100 (BST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 4187D268-2A1B-11DD-A981-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82852>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> When calling "git log --left-right <branch1>...<branch2>", a single "<" or 
> ">" is shown in front of the commit line, to indicate which branch1 this 
> commit comes from, branch1 or branch2.
>
> However, it is easy to miss in the output of "git log --graph ...", since 
> the graph still has "*" for regular commits and "M" for merge commits.  So 
> imitate gitk, and show the "<" and ">" characters in the graph, too, 
> instead of "*" (or "M").

This certainly makes it more visible which one is left and which one is
right:

    < commit <205ffa9...
    | Author: Gustaf Hendeby <hendeby@isy.liu.se>
    |
    |     Make git add -n and git -u -n output consistent
    |
    < commit <38ed1d8...
    | Author: Junio C Hamano <gitster@pobox.com>
    |
    |     "git-add -n -u" should not add but just report
    ...

than

    * commit <205ffa9...
    | Author: Gustaf Hendeby <hendeby@isy.liu.se>
    |
    |     Make git add -n and git -u -n output consistent
    |
    * commit <38ed1d8...
    | Author: Junio C Hamano <gitster@pobox.com>
    |
    |     "git-add -n -u" should not add but just report
    |
    ...

But is it just me who now finds the original marker redundant and ugly?
IOW, I wonder if it is better to show this:

    < commit 205ffa9...
    | Author: Gustaf Hendeby <hendeby@isy.liu.se>
    |
    |     Make git add -n and git -u -n output consistent
    |
    < commit 38ed1d8...
    | Author: Junio C Hamano <gitster@pobox.com>
    |
    |     "git-add -n -u" should not add but just report
    ...

This is with --pretty=short, --pretty=oneline makes the issue even more
obvious.

Adam?
