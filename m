From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-shortlog hangs on bare repo without --bare option
Date: Wed, 27 Aug 2008 15:19:03 -0700
Message-ID: <7vvdxmm78o.fsf@gitster.siamese.dyndns.org>
References: <20080827195233.GA2477@garry-thinkpad.arpnetworks.com>
 <48B5C9E4.4030807@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Garry Dolley <gdolley@arpnetworks.com>, git@vger.kernel.org
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Thu Aug 28 00:20:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYTNQ-0003SP-Fr
	for gcvg-git-2@gmane.org; Thu, 28 Aug 2008 00:20:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753518AbYH0WTM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 27 Aug 2008 18:19:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753498AbYH0WTM
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Aug 2008 18:19:12 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:38541 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753154AbYH0WTL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Aug 2008 18:19:11 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 259056A258;
	Wed, 27 Aug 2008 18:19:10 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 2BA276A253; Wed, 27 Aug 2008 18:19:05 -0400 (EDT)
In-Reply-To: <48B5C9E4.4030807@lsrfire.ath.cx> (=?utf-8?Q?Ren=C3=A9?=
 Scharfe's message of "Wed, 27 Aug 2008 23:40:52 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 2BDEBF98-7486-11DD-9DC6-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93968>

Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:

> Garry Dolley schrieb:
>> I didn't see this happen with git 1.5.x, but if you do git-shortlog =
on a bare=20
>> repo, without specifying --bare, the command will seemingly hang ind=
efinitely.
>
> FWIW, I tried git 1.5.0 and it hangs, too.  Which exact version did w=
ork
> for you?  Could you, based on it, bisect the commit that introduced t=
his
> behaviour?
>
> As a workaround, you can use "git log | git shortlog".

It is not a workaround.  Shortlog can work as a filter to "git log", bu=
t
if you give revs to work on, e.g. "git shortlog -s -n v1.5.6.5.." or "g=
it
shortlog HEAD", it can generate the log and feed to itself.

Somehow it (perhaps incorrectly, I did not look at the command line inp=
ut)
judging that your command line is telling it not to do the log generati=
on
itself but instead you will feed the log from its standard input, which
happens to be your terminal.  So another workaround would be to type th=
e
series of log messages ;-)
