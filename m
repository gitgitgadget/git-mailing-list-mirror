From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] rerere: Separate libgit and builtin functions
Date: Wed, 09 Jul 2008 11:25:12 -0700
Message-ID: <7v4p6ylxtj.fsf@gitster.siamese.dyndns.org>
References: <alpine.DEB.1.00.0807090230560.5277@eeepc-johanness>
 <1215598683-9685-1-git-send-email-s-beyer@gmx.net>
 <alpine.DEB.1.00.0807091356050.5277@eeepc-johanness>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stephan Beyer <s-beyer@gmx.net>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jul 09 20:26:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KGeMz-0006uo-Fo
	for gcvg-git-2@gmane.org; Wed, 09 Jul 2008 20:26:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752887AbYGISZ2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jul 2008 14:25:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752841AbYGISZ1
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Jul 2008 14:25:27 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:63529 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752839AbYGISZ1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jul 2008 14:25:27 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id B06452A2E9;
	Wed,  9 Jul 2008 14:25:24 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id E8C822A2E6; Wed,  9 Jul 2008 14:25:19 -0400 (EDT)
In-Reply-To: <alpine.DEB.1.00.0807091356050.5277@eeepc-johanness> (Johannes
 Schindelin's message of "Wed, 9 Jul 2008 14:03:53 +0200 (CEST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 65D17830-4DE4-11DD-BAFF-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87903>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Wed, 9 Jul 2008, Stephan Beyer wrote:
>
>>  Makefile                     |    2 +
>>  builtin-rerere.c             |  324 +++---------------------------------------
>>  builtin-rerere.c => rerere.c |  133 +-----------------
>>  rerere.h                     |    9 ++
>>  4 files changed, 32 insertions(+), 436 deletions(-)
>
> Heh, that sounds nice!  Deleting way more lines than adding!  :-)
>
>>  copy builtin-rerere.c => rerere.c (66%)
>
> Oh, well :-)

We may want to fix this, though.  I haven't verified by looking at the
diffstat summary code, but what I think is happening is that the bogus 436
is the result of counting the lines removed from builtin-rerere.c (that
lost many of its lines to rerere.c), and also counting the lines that were
remove from rerere.c pretending as if rerere.c had full contents of
builtin-rerere.c initially (i.e., counting the lines that were _not_ moved
to rerere.c).

It may just be the matter of subtracting the size of the preimage of
copied files (in this case, builtin-rerere.c that was used to initialize
rerere.c) from the grand total of deleted lines.  I dunno.
