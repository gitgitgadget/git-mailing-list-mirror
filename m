From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Bizarre missing changes (git bug?)
Date: Wed, 30 Jul 2008 17:15:23 -0700
Message-ID: <7vabfy52p0.fsf@gitster.siamese.dyndns.org>
References: <8502DF7C-5303-49E8-8C67-F837343E2F0C@gmail.com>
 <200807260512.40088.zippel@linux-m68k.org>
 <alpine.LFD.1.10.0807261249430.4188@nehalem.linux-foundation.org>
 <Pine.LNX.4.64.0807270049290.6791@localhost.localdomain>
 <alpine.LFD.1.10.0807271144520.3486@nehalem.linux-foundation.org>
 <Pine.LNX.4.64.0807272101470.6791@localhost.localdomain>
 <alpine.LFD.1.10.0807271613440.3486@nehalem.linux-foundation.org>
 <Pine.LNX.4.64.0807280141140.6791@localhost.localdomain>
 <alpine.LFD.1.10.0807272148030.3486@nehalem.linux-foundation.org>
 <Pine.LNX.4.64.0807281241180.6791@localhost.localdomain>
 <46a038f90807282015m7ce3da10h71dfee221c960332@mail.gmail.com>
 <Pine.LNX.4.64.0807291433430.6791@localhost.localdomain>
 <alpine.LFD.1.10.0807291716060.3334@nehalem.linux-foundation.org>
 <alpine.LFD.1.10.0807291738280.3334@nehalem.linux-foundation.org>
 <7vej5b3ozz.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Roman Zippel <zippel@linux-m68k.org>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Tim Harper <timcharper@gmail.com>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Jul 31 02:17:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOLqq-0007CD-2L
	for gcvg-git-2@gmane.org; Thu, 31 Jul 2008 02:17:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762885AbYGaAPg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jul 2008 20:15:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762879AbYGaAPf
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Jul 2008 20:15:35 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:40555 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762739AbYGaAPd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jul 2008 20:15:33 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id D473D438B2;
	Wed, 30 Jul 2008 20:15:31 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 6F26B438B1; Wed, 30 Jul 2008 20:15:25 -0400 (EDT)
In-Reply-To: <7vej5b3ozz.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Wed, 30 Jul 2008 16:56:32 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: C9BB1D8A-5E95-11DD-B1B0-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90884>

Junio C Hamano <gitster@pobox.com> writes:

> The idea is to compute, for each commit in the "full history" result set,
> the commit that should replace it in the simplified history.  This
> replacement commit is defined as follows:
>
>  * In any case, we first figure out the replacement commits of parents of
>    the commit we are looking at.  The commit we are looking at is
>    rewritten as if its parents are replacement commits of its original
>    parents.
>
>  * If the commit is marked as TREESAME (i.e. it modifies the paths we are
>    interested in), then the replacement commit is itself.  IOW, the commit
>    is not dropped from the final result.

A typo here.  This comment should have said !TREESAME (the code is correct).
