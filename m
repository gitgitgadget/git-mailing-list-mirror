From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Allow update hooks to update refs on their own
Date: Wed, 28 Nov 2007 11:00:55 -0800
Message-ID: <7vmysy5h5k.fsf@gitster.siamese.dyndns.org>
References: <20071127211730.GA11861@midwinter.com>
	<7v4pf7b20b.fsf@gitster.siamese.dyndns.org>
	<49EB8C6F-8100-48C1-BB2D-A8F6023BACAD@midwinter.com>
	<Pine.LNX.4.64.0711272143470.5349@iabervon.org>
	<20071128161033.GA20308@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Steven Grimm <koreth@midwinter.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Nov 28 20:01:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IxSA3-0007Yg-Bp
	for gcvg-git-2@gmane.org; Wed, 28 Nov 2007 20:01:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758455AbXK1TBH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Nov 2007 14:01:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758242AbXK1TBG
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Nov 2007 14:01:06 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:35745 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758126AbXK1TBE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Nov 2007 14:01:04 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 158582F9;
	Wed, 28 Nov 2007 14:01:25 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 803AF9AB32;
	Wed, 28 Nov 2007 14:01:20 -0500 (EST)
In-Reply-To: <20071128161033.GA20308@coredump.intra.peff.net> (Jeff King's
	message of "Wed, 28 Nov 2007 11:10:34 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66410>

Jeff King <peff@peff.net> writes:

>> Couldn't you do this with a status message? ("ok <refname> changed by 
>> hook" or something.)
>
> Having just touched this code, I believe the answer is yes. receive-pack
> has always sent just "ok <refname>\n", so we could start interpreting
> anything after the <refname> bit freely...

More importantly, no send-pack choked on "ok <refname>" followed by a SP
(old ones just checked "ok" and nothing else, the current one NULs out
the SP and lets you use the rest as a message), so such a change to
receive-pack does not have to break older send-pack.
