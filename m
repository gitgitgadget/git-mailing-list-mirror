From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Recovering from repository corruption
Date: Tue, 10 Jun 2008 15:52:46 -0700
Message-ID: <7v63sgdhs1.fsf@gitster.siamese.dyndns.org>
References: <6dbd4d000806101026m458513ecqa8141f509bad7602@mail.gmail.com>
 <m3abhtp42o.fsf@localhost.localdomain>
 <6dbd4d000806101238v2bb975abqd39916e45d4bf866@mail.gmail.com>
 <200806102159.02875.jnareb@gmail.com>
 <6dbd4d000806101303j4b2032ajc6e004e0a82e4db5@mail.gmail.com>
 <alpine.LFD.1.10.0806101317100.3101@woody.linux-foundation.org>
 <6dbd4d000806101328k1fc913f2ia55c3e44273ec5ad@mail.gmail.com>
 <alpine.LFD.1.10.0806101403080.3101@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Denis Bueno <dbueno@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Jun 11 00:54:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6Cj3-0000d5-6u
	for gcvg-git-2@gmane.org; Wed, 11 Jun 2008 00:54:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756346AbYFJWwz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jun 2008 18:52:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755961AbYFJWwz
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jun 2008 18:52:55 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:45841 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754375AbYFJWwy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jun 2008 18:52:54 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id A81CC101C;
	Tue, 10 Jun 2008 18:52:52 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id EEC4D1019; Tue, 10 Jun 2008 18:52:48 -0400 (EDT)
In-Reply-To: <alpine.LFD.1.10.0806101403080.3101@woody.linux-foundation.org>
 (Linus Torvalds's message of "Tue, 10 Jun 2008 14:09:42 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: F52C20A4-373F-11DD-80EE-F9737025C2AA-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84558>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> Ahh, ok. Yes, we should probably re-think our 'grafts' file thing, or at 
> least not document it, because it's actually a wondeful way to just cause 
> more corruption by hiding things (ie if you clone a repo with a grafts 
> file, the result will now have neither the grafts file _nor_ the state 
> that was hidden by it, so the result is guaranteed to be corrupt).

"Graft and then clone" will not make the copied repository Ok.  You need
to propagate the graft in some other way.

However, "Graft and then filter-branch" is a way to hide and get rid of
the the broken thing in history etched in the objects.  After that the
repository itself and a clone from it will not need the graft.  So I'd
rather argue we should document it _differently_ (or just _better_) than
not document it.
