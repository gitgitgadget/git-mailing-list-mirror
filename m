From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Octopus merge: unique (?) to git, but is it useful?
Date: Tue, 03 Jun 2008 18:02:45 -0700
Message-ID: <7v7id6107e.fsf@gitster.siamese.dyndns.org>
References: <200806030314.03252.jnareb@gmail.com>
 <alpine.LFD.1.10.0806021845210.3473@woody.linux-foundation.org>
 <7v3anv5fy3.fsf@gitster.siamese.dyndns.org>
 <7vskvv3xmx.fsf@gitster.siamese.dyndns.org> <20080603104009.GA559@neumann>
 <7vabi22u5h.fsf@gitster.siamese.dyndns.org> <20080603203924.GA6588@neumann>
 <7vk5h6189b.fsf@gitster.siamese.dyndns.org> <20080603231020.GB6588@neumann>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Linus Torvalds <torvalds@linux-foundation.org>, git@vger.kernel.org
To: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Wed Jun 04 03:04:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3hQE-00053z-SB
	for gcvg-git-2@gmane.org; Wed, 04 Jun 2008 03:04:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751714AbYFDBCz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 Jun 2008 21:02:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751753AbYFDBCz
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Jun 2008 21:02:55 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:45112 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750905AbYFDBCy convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 Jun 2008 21:02:54 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 8CAF02B7F;
	Tue,  3 Jun 2008 21:02:53 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id A2CD62B7D; Tue,  3 Jun 2008 21:02:48 -0400 (EDT)
In-Reply-To: <20080603231020.GB6588@neumann> (SZEDER =?utf-8?Q?G=C3=A1bor'?=
 =?utf-8?Q?s?= message of "Wed, 4 Jun 2008 01:10:20 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: F5F8C67C-31D1-11DD-8393-F9737025C2AA-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83739>

SZEDER G=C3=A1bor <szeder@ira.uka.de> writes:

> On Tue, Jun 03, 2008 at 03:08:48PM -0700, Junio C Hamano wrote:
>> Here is a potential fix.
>>=20
>> The first hunk is the more relevant one; although the second one is =
also a
>> fix, it is independent.  It is a fix to unnecessarily loosely writte=
n test
>> that was done in early February.
> Yes, the first hunk fixes the problem (and the second one does not
> introduce any new breakage on my system ;)
>
> However, I don't really see why the new test failed only at me...

Perhaps it is because your GECOS setting leads to this error:

	fatal: empty ident  <szeder@neumann.(none)> not allowed

The reason the first hunk is a fix is because that particular test trie=
s
to see what happens when the committer identity comes from the default
places (i.e. hostname, ident and GECOS) by removing the environment
variable.  For all the other tests, however, we explicitly set committe=
r
and author identities by setting necessary environment variables so tha=
t
the tests will be repeatable for everybody.  That test, however, remove=
d
the environment variable for all the later tests, which made them
unreliable (works for some people, not work for others).
