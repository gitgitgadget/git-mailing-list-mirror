From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] bisect: error out when given any good rev that is not an
 ancestor of the bad rev
Date: Mon, 30 Jun 2008 16:32:00 -0700
Message-ID: <7vprpyts7j.fsf@gitster.siamese.dyndns.org>
References: <20080701004211.ba9b89c9.chriscool@tuxfamily.org>
 <7v3amuv8yg.fsf@gitster.siamese.dyndns.org>
 <200807010116.30214.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jeff King <peff@peff.net>, git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Tue Jul 01 01:33:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KDSrs-0000HZ-Uk
	for gcvg-git-2@gmane.org; Tue, 01 Jul 2008 01:33:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753548AbYF3XcM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 Jun 2008 19:32:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753616AbYF3XcM
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jun 2008 19:32:12 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:42649 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752966AbYF3XcL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 Jun 2008 19:32:11 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id B19ED190E2;
	Mon, 30 Jun 2008 19:32:09 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id DF252190DE; Mon, 30 Jun 2008 19:32:02 -0400 (EDT)
In-Reply-To: <200807010116.30214.chriscool@tuxfamily.org> (Christian Couder's
 message of "Tue, 1 Jul 2008 01:16:30 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: C2568738-46FC-11DD-92AA-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86966>

Christian Couder <chriscool@tuxfamily.org> writes:

> Le mardi 1 juillet 2008, Junio C Hamano a =C3=A9crit :
>> Christian Couder <chriscool@tuxfamily.org> writes:
>> > Before this patch "git bisect" doesn't really work when it is give=
n
>> > some good revs that are siblings of the bad rev.
>> >
>> > For example if there is the following history:
>> >
>> > A-B-C-D
>> >    \E-F
>> >
>> > and we launch "git bisect start D F" then only C and D will be
>> > considered as possible first bad commit.
>
> I am assuming the first bad commit in the graph is A and it is fixed =
by F.

Ah, I see your confusion here.  bisect is about finding regressions.
"Older ones were good, and now there is a breakage.  Who broke it?"

If F fixed it, that is already outside the bisection's scope.  The user
needs to know that by saying F is good, he is saying he knows everythin=
g
that leads to F is good.
