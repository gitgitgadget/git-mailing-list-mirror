From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] builtin/checkout: DWIM with -f -b
Date: Sun, 20 Jun 2010 22:15:39 -0700
Message-ID: <7vpqzlrmo4.fsf@alter.siamese.dyndns.org>
References: <1277051592-4552-1-git-send-email-rctay89@gmail.com>
 <1277051592-4552-2-git-send-email-rctay89@gmail.com>
 <1277051592-4552-3-git-send-email-rctay89@gmail.com>
 <1277051592-4552-4-git-send-email-rctay89@gmail.com>
 <7vvd9dtt54.fsf@alter.siamese.dyndns.org>
 <20100620201137.GA8502@coredump.intra.peff.net>
 <7vpqzltnp3.fsf@alter.siamese.dyndns.org>
 <20100620211605.GA2559@sigill.intra.peff.net>
 <7vfx0htfer.fsf@alter.siamese.dyndns.org>
 <AANLkTik3QZBpOjwZHGwIXphXnaHLaBV4pUSb1OVAau9V@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 21 07:15:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OQZMT-0001bo-LO
	for gcvg-git-2@lo.gmane.org; Mon, 21 Jun 2010 07:15:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752434Ab0FUFPw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 21 Jun 2010 01:15:52 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:41693 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752350Ab0FUFPv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 Jun 2010 01:15:51 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 7993DBDBC9;
	Mon, 21 Jun 2010 01:15:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=+evXwv4UabwZ
	jLMn6d0hTzzIkZg=; b=xPUsrhL2HGyn/GuajoQ9XRFL/nBMcpxKqI9ftHZuZPLg
	xnjjTqxr0IpN0L4E/3U6qB3/XT0m/+oTOGXMm/TVbosSL5rs+piwHZCxbOOCphvV
	yrsY0KfhSy6zPHr3Gki3NKRxiTwJ7LffTzzvKAA+QMPd/h09WCplwUE5CThvric=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=yI4QBn
	8QcZNnAsVrU/hcK3wSgg4FPIXm690h/qbq8MxY4WZkWbhvGYRc0jbq/2QCGsJUWg
	IcIozbOCBNYYabK0soz15z/DDkSPHSCMRkZMJ79VruCpzi15akjn/zXdsNOQ7/bV
	0RrC8Mrk2I3e4U5G2QO60YEC74u6n5J/6hWGc=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 44A27BDBC7;
	Mon, 21 Jun 2010 01:15:45 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 29B20BDBC4; Mon, 21 Jun
 2010 01:15:40 -0400 (EDT)
In-Reply-To: <AANLkTik3QZBpOjwZHGwIXphXnaHLaBV4pUSb1OVAau9V@mail.gmail.com>
 (Tay Ray Chuan's message of "Mon\, 21 Jun 2010 09\:08\:27 +0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 0B941292-7CF4-11DF-83F3-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149415>

Tay Ray Chuan <rctay89@gmail.com> writes:

>> Yes; I thought the implication of "-f" to be destructive would be a
>> justification enough, but I agree with you that conflating the two m=
ay be
>> a bad idea. =C2=A0When a user says "git checkout -f -b jch" after se=
eing the
>> command without "-f" fail due to existing "jch", it is quite clear t=
hat
>> the user wants to clobber the history of existing "jch" branch (why =
else
>> would he giving "-f"), but it is not a justification to clobber loca=
l
>> changes he has in the index and the work tree.
>
> How about doing
>
>   git checkout -f -f -b <branch>

That is not the problem I want you to solve.  What your patch does solv=
es
only half of my issue as Peff pointed out (it lets me reuse the name of
the existing branch for an unrelated history, but it loses the local
changes I may have in my working tree).  IOW, I want to start <branch>
from scratch, based on an half-done work I started from my current bran=
ch
in my work tree.

That is what "git checkout -b <branch>" usually gives us, if the name
<branch> is not in use.

I think you were suggesting not to nuke local change with a single -f
only when -b is also in use, but I think that makes things even more
confusing to the users.  Sometimes a single -f discards local changes, =
but
some other times you would need double -f.  That will lead to insanity.

Perhaps we would want another option that is similar to -b but lets us
discard the named branch if it exists.  Let's call it tentatively -B.

 * git checkout -b <branch> [<start-point>]

   - starts a new branch <branch> at <start-point> commit;

   - attempts three-way merge to keep the local change forward while do=
ing
     so, but aborts if it needs a real file-level merge;

   - complains and aborts if <branch> already exists.

   When -f is used, instead of attempting three-way merge to keep the l=
ocal
   changes, it discards them.

   When -m is used, instead of failing when it needs a real file-level =
merge,
   it will attempt CVS/SVN "update" style merge (and can cause conflict=
s).

   When -B is used instead of -b, it does the three-way merge and the u=
sual
   rejection upon a file-level merge unless -m is given.  If it can go =
ahead,
   but <branch> already exists, then the existing <branch> is discarded=
 and
   replaced with the <start-point> commit.

Something like that would reduce the confusion factor and would help th=
e
"recreate an existing branch from scratch" (or "reuse the name of an
existing branch") workflow a bit.
