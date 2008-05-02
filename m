From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/2] Show committer ident in some cases
Date: Fri, 02 May 2008 15:32:39 -0700
Message-ID: <7vbq3owd4o.fsf@gitster.siamese.dyndns.org>
References: <1209752541-19111-1-git-send-email-sbejar@gmail.com>
 <7vwsmcwfcn.fsf@gitster.siamese.dyndns.org>
 <8aa486160805021507s44d7946ejc48ac8a4af08e8cc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?Q?Santi_B=C3=A9jar?= <sbejar@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 03 00:33:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Js3p2-0003P3-50
	for gcvg-git-2@gmane.org; Sat, 03 May 2008 00:33:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764538AbYEBWct convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 2 May 2008 18:32:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764046AbYEBWct
	(ORCPT <rfc822;git-outgoing>); Fri, 2 May 2008 18:32:49 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:53997 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763973AbYEBWcs convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 2 May 2008 18:32:48 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 1517E224C;
	Fri,  2 May 2008 18:32:47 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 54B621602; Fri,  2 May 2008 18:32:43 -0400 (EDT)
In-Reply-To: <8aa486160805021507s44d7946ejc48ac8a4af08e8cc@mail.gmail.com>
 (Santi =?utf-8?Q?B=C3=A9jar's?= message of "Sat, 3 May 2008 00:07:44 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: B0779E78-1897-11DD-A38D-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81041>

"Santi B=C3=A9jar" <sbejar@gmail.com> writes:

> On Fri, May 2, 2008 at 11:44 PM, Junio C Hamano <gitster@pobox.com> w=
rote:
>> Santi B=C3=A9jar <sbejar@gmail.com> writes:
>>
>>  > The definition of "wrong committer" could be:
>>  >
>>  > 1) user.{name,email} or GIT_COMMITTER_{NAME,EMAIL} is not a wrong=
 committer.
>>  > 2) automatic without a domain name (user@hostname.(none)) is a wr=
ong committer.
>>  >    (not handled with this patch series)
>>  > 3) automatic or partially set ident:
>>  >    a) wrong committer for some users
>>  >    b) right committer for others
>>
>>  Define "partially set".
>
> one of user.{name,email} is not set.

Hmmm.  Then perhaps the list can be simplified as follows?

 * Both name and email are explicitly given (i.e. user.* or
   GIT_COMMITTER_* specifies them) --- no complaints.

 * For email, ending with ".(none)" and "@" followed by something witho=
ut
   a dot is wrong but everything else are Ok.

 * Everything else falls into (3)

There is no "partially" then.

By the way, wasn't it you who wanted to refuse use of user.name _and_
user.email that come from ~/.gitconfig, so that you can be sure you use
different pseudonym for each project?
