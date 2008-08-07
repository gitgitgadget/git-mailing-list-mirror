From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git blame and cherry-picking
Date: Thu, 07 Aug 2008 11:49:07 -0700
Message-ID: <7vsktgirto.fsf@gitster.siamese.dyndns.org>
References: <91A979F0-1329-4CA6-AADC-6CF55872B57A@midwinter.com>
 <20080807060940.GA15405@blimp.local>
 <20080807182256.GF11314@sigill.intra.peff.net>
 <AA6BDC98-8800-4031-8C8F-A4BD326BEC1E@midwinter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Alex Riesen <raa.lkml@gmail.com>,
	git@vger.kernel.org
To: Steven Grimm <koreth@midwinter.com>
X-From: git-owner@vger.kernel.org Thu Aug 07 20:50:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KRAZ3-0006sX-1q
	for gcvg-git-2@gmane.org; Thu, 07 Aug 2008 20:50:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755120AbYHGStS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Aug 2008 14:49:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754871AbYHGStR
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Aug 2008 14:49:17 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:45358 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754290AbYHGStQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Aug 2008 14:49:16 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 788FF4F274;
	Thu,  7 Aug 2008 14:49:15 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 71D9D4F271; Thu,  7 Aug 2008 14:49:09 -0400 (EDT)
In-Reply-To: <AA6BDC98-8800-4031-8C8F-A4BD326BEC1E@midwinter.com> (Steven
 Grimm's message of "Thu, 7 Aug 2008 11:37:02 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 8899EA6C-64B1-11DD-950B-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91596>

Steven Grimm <koreth@midwinter.com> writes:

> On Aug 7, 2008, at 11:22 AM, Jeff King wrote:
>> You could potentially have git-blame incorporate that information
>> (again, if the referenced commit is even still available), but I'm not
>> sure exactly what difference it would make. I don't think you would
>> want
>> to start blaming up the original commits line of parentage.
>
> No, of course not. But one might want to show the original commit's
> author instead of the name of the person who did the cherry pick.

"cherry-pick" lets you say "-n" so that you can use the change as if you
are creating (think of it as a typesaver).  You can ask commit to record
the result under the original authorship.

Perhaps a workflow sequence would go like this:

    ... Ah, I like that change by Joe; let's see if that really works ...
    $ git cherry-pick -n joe/experimental~4
    $ test test test

    ... Hmm, not quite, let's fix up ...
    $ edit test edit test

    ... Now it works and I like the result, but I'll edit the comment to
    ... describe the change I made on top of what he did to make it work.
    $ git commit -a -c joe/experimental~4
