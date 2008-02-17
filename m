From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] start_command(), if .in/.out > 0, closes file
 descriptors, not the callers
Date: Sun, 17 Feb 2008 00:07:34 -0800
Message-ID: <7vodag2egp.fsf@gitster.siamese.dyndns.org>
References: <7v1w7dhnov.fsf@gitster.siamese.dyndns.org>
 <1203183399-4813-1-git-send-email-johannes.sixt@telecom.at>
 <1203183399-4813-2-git-send-email-johannes.sixt@telecom.at>
 <7vmyq07bqe.fsf@gitster.siamese.dyndns.org>
 <20080217074252.GO24004@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <johannes.sixt@telecom.at>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sun Feb 17 09:08:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQeZY-0000jz-Pr
	for gcvg-git-2@gmane.org; Sun, 17 Feb 2008 09:08:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753201AbYBQIHz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Feb 2008 03:07:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753146AbYBQIHz
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Feb 2008 03:07:55 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:48257 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753191AbYBQIHy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Feb 2008 03:07:54 -0500
Received: from a-sasl-quonix.pobox.com (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 173DE412E;
	Sun, 17 Feb 2008 03:07:53 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.pobox.com (Postfix) with ESMTP id
 3C8FB4125; Sun, 17 Feb 2008 03:07:46 -0500 (EST)
In-Reply-To: <20080217074252.GO24004@spearce.org> (Shawn O. Pearce's message
 of "Sun, 17 Feb 2008 02:42:52 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74103>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> Of course the same argument can be said for fd 0; if the parent does
> close(0) before some other open/socket/pipe call then its obviously
> possible for the parent to get a fd that it wants the child to take
> over and close.
>
> We're basically assuming that the parent will always keep its
> own stdin open if it will be spawning children.  We all know what
> happens when we assume (we double close file descriptors) but I
> think its a reasonable safe assumption to be making.

Ok, that unwritten assumption was what confused me.  We
definitely need Documentation/technical/api-*.txt before any
more code, don't you agree?
