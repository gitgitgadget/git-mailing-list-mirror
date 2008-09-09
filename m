From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git merge vs git commit
Date: Tue, 09 Sep 2008 12:11:34 -0700
Message-ID: <7vd4jd6snt.fsf@gitster.siamese.dyndns.org>
References: <20080909165236.GA8850@flint.arm.linux.org.uk>
 <7vhc8p6x59.fsf@gitster.siamese.dyndns.org>
 <20080909185418.GI4829@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Russell King <rmk@arm.linux.org.uk>, git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Tue Sep 09 21:12:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kd8dw-0006lX-C6
	for gcvg-git-2@gmane.org; Tue, 09 Sep 2008 21:12:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753409AbYIITLp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Sep 2008 15:11:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753782AbYIITLp
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Sep 2008 15:11:45 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:58902 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751742AbYIITLo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Sep 2008 15:11:44 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 3EAD2566B3;
	Tue,  9 Sep 2008 15:11:43 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id D9B2E566B2; Tue,  9 Sep 2008 15:11:38 -0400 (EDT)
In-Reply-To: <20080909185418.GI4829@genesis.frugalware.org> (Miklos Vajna's
 message of "Tue, 9 Sep 2008 20:54:18 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 2390CC6A-7EA3-11DD-933F-D0CFFE4BC1C1-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95417>

Miklos Vajna <vmiklos@frugalware.org> writes:

> On Tue, Sep 09, 2008 at 10:34:42AM -0700, Junio C Hamano <gitster@pobox.com> wrote:
>> I think some changes went into 1.6.0 around this area to (r)eject parents
>> that are redundant.
>
> Yes, it was your 98cf9c3 (Introduce reduce_heads(), 2008-06-27).

That does not necessarily mean git-merge (or git-merge-octopus) uses that
C function when coming up with the set of commits to record as parents.

As to what the correct behaviour is, I personally do not have a strong
preference either way.

 - If you specify a fast-foward on the command line to merge into your
   HEAD, that is your choice and you may deserve the extra parent, even if
   it is redundant.  

 - On the other hand, if you try to merge a single fast-forward, we do not
   even create a merge commit, so in the same spirit it may be better if
   we dropped the original HEAD from the merged result (i.e. Russell's
   "cleanly merged" case).

I dunno.
