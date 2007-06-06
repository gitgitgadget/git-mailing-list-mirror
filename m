From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Accept dates before 2000/01/01 when specified as seconds since the epoch
Date: Wed, 06 Jun 2007 01:29:28 -0700
Message-ID: <7vtztl5vvb.fsf@assigned-by-dhcp.cox.net>
References: <11811175153355-git-send-email-johannes.sixt@telecom.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Sixt <johannes.sixt@telecom.at>
X-From: git-owner@vger.kernel.org Wed Jun 06 10:29:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hvqtc-0002HD-Nh
	for gcvg-git@gmane.org; Wed, 06 Jun 2007 10:29:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752197AbXFFI3a (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 6 Jun 2007 04:29:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752651AbXFFI3a
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Jun 2007 04:29:30 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:42955 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752197AbXFFI33 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jun 2007 04:29:29 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070606082929.QMMU1540.fed1rmmtao106.cox.net@fed1rmimpo02.cox.net>;
          Wed, 6 Jun 2007 04:29:29 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 88VU1X00B1kojtg0000000; Wed, 06 Jun 2007 04:29:28 -0400
In-Reply-To: <11811175153355-git-send-email-johannes.sixt@telecom.at>
	(Johannes Sixt's message of "Wed, 6 Jun 2007 10:11:55 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49266>

I vaguely recall hitting the same issue soon after date.c was
done, and sending in a patch in the same spirit but with
different implementation (I essentially duplicated that "seconds
since epoch" without any cutoff as the last ditch fallback) long
time ago (this was before I took git over; the patch was rejected).

It almost makes me wonder if it is better to introduce a special
syntax to denote "seconds since epoch plus timezone offset" for
our Porcelain use, instead of keeping this arbitrary cut-off
date which nobody can agree on and which forces us to roll back
from time to time.  For one thing, such a syntax would allow us
to talk about a timestamp before the epoch.

Perhaps

	"epoch" [-+] [0-9]+ " " [-+][0-9][0-9][0-9][0-9]

?
