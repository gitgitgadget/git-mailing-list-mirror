From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (topics)
Date: Mon, 30 Jun 2008 15:15:22 -0700
Message-ID: <7vhcbavabp.fsf@gitster.siamese.dyndns.org>
References: <7vlk4snpj3.fsf@gitster.siamese.dyndns.org>
 <7vbq4j748l.fsf@gitster.siamese.dyndns.org>
 <7vr6d8apjx.fsf@gitster.siamese.dyndns.org>
 <7vhcdyfe9u.fsf@gitster.siamese.dyndns.org>
 <7vabjm1a0q.fsf@gitster.siamese.dyndns.org>
 <7vr6crj0jk.fsf@gitster.siamese.dyndns.org>
 <7vmyn4hr8f.fsf@gitster.siamese.dyndns.org>
 <7vmymsjz6x.fsf@gitster.siamese.dyndns.org>
 <7vabijxhk4.fsf@gitster.siamese.dyndns.org>
 <7vwslhg8qe.fsf@gitster.siamese.dyndns.org>
 <7vhccfiksy.fsf@gitster.siamese.dyndns.org>
 <7vod6k6zg4.fsf@gitster.siamese.dyndns.org>
 <7v4p7xwsfp.fsf@gitster.siamese.dyndns.org>
 <7v3anb19n7.fsf@gitster.siamese.dyndns.org>
 <7vwskjazql.fsf@gitster.siamese.dyndns.org>
 <7vk5ggipuw.fsf@gitster.siamese.dyndns.org>
 <7vej6l3lp7.fsf@gitster.siamese.dyndns.org>
 <7vod5kd3im.fsf@gitster.siamese.dyndns.org>
 <7v3amv1e8n.fsf@gitster.siamese.dyndns.org>
 <1214834970.3382.4.camel@gaara.bos.redhat.com>
 <m3myl2hq45.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Kristian =?utf-8?Q?H=C3=B8gsberg?= <krh@redhat.com>,
	git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 01 00:16:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KDRfp-0006h3-An
	for gcvg-git-2@gmane.org; Tue, 01 Jul 2008 00:16:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761864AbYF3WPk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 Jun 2008 18:15:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758702AbYF3WPk
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jun 2008 18:15:40 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:61036 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754331AbYF3WPk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 Jun 2008 18:15:40 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 383EE18920;
	Mon, 30 Jun 2008 18:15:35 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 043821891F; Mon, 30 Jun 2008 18:15:29 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 0FCE102C-46F2-11DD-9D26-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86945>

Jakub Narebski <jnareb@gmail.com> writes:

> Kristian H=C3=B8gsberg <krh@redhat.com> writes:
>
>>=20
>> A small detail I've suggested scheduling for 1.6 before is removing =
(or
>> rather, stop creating) the empty .git/branches directory.  How does =
that
>> sound?
>
> Perhaps also stop creating .git/description (remove
> 'templates/this--description' file), now that it is mentioned in
> gitweb/README and/or gitweb/INSTALL?
>
> (Do you want a patch?)

Not yet.  I would first like to see a justification that makes sense.

I do not see much connection between your mentioning the file in README
and the file's removal.  You currently say "By default it is set to ...=
"
and you would have to change it to "By default it does not exist so you
have to create one".  Does it have much difference?  Either way the use=
r
needs to open the file with the editor and edit it, and the current fil=
e
at least says "Please edit me".  I am not sure if removal is an
improvement.

The sample templates/hooks--update.sample seems to check if the content=
s
of the description file makes sense, without even checking if it exists=
=2E
That also needs to be updated.

Actually, the sample hook should be updated independent of this issue.
I'd suggest to simply remove the check from the sample hook.  Setting
description and installing the hook is part of the initial public
repository deployment task, and once the description is set, the hook d=
oes
not have to check it over and over again.  Allowing arrival of new comm=
its
while the description is not set won't hurt anything (somebody would
notice and tell "please set a better description" to the repository own=
er,
and doing so at that point will fix things without anybody having to re=
do
any old pushes), and forbidding push from the hook for lack of descript=
ion
does not make any sense.
