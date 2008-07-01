From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Make default expiration period of reflog used for stash
 infinite
Date: Tue, 01 Jul 2008 00:28:06 -0700
Message-ID: <7vskuuoygp.fsf@gitster.siamese.dyndns.org>
References: <7vlk4snpj3.fsf@gitster.siamese.dyndns.org>
 <7vwsnjl21c.fsf@gitster.siamese.dyndns.org>
 <7vhcehzdeg.fsf@gitster.siamese.dyndns.org>
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
 <7v3amweiaz.fsf@gitster.siamese.dyndns.org> <4869700C.6060803@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Olivier Marin <dkr+ml.git@free.fr>
X-From: git-owner@vger.kernel.org Tue Jul 01 09:29:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KDaIe-0000Wh-RX
	for gcvg-git-2@gmane.org; Tue, 01 Jul 2008 09:29:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753956AbYGAH2R convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 1 Jul 2008 03:28:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753930AbYGAH2R
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Jul 2008 03:28:17 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:56463 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753734AbYGAH2Q convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 Jul 2008 03:28:16 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 98C811BF9F;
	Tue,  1 Jul 2008 03:28:13 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id CB3DA1BF9D; Tue,  1 Jul 2008 03:28:10 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 43BF987C-473F-11DD-8C6A-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87006>

Olivier Marin <dkr+ml.git@free.fr> writes:

> Junio C Hamano a =C3=A9crit :
>> This makes the default expiration period for the reflog that impleme=
nts
>> stash infinite.
>
> I did not read the whole thread so maybe I missed something but I tho=
ugh you
> wanted to apply Nanako's patch before?
>
> The patch: http://article.gmane.org/gmane.comp.version-control.git/85=
055

Thanks for reminding, but I am of two minds about the change.

 (1) The change would untie the base tree of the stash from the history
     behind it and allow previously rewound tips of branches that these
     stashes were built on top of.  Without the patch, these otherwise
     unreachable commits will never be reclaimed.

 (2) Today, you can say "git log stash" (note the lack of "-g" option) =
to
     view the history behind the stash through two artificial commits t=
hat
     stash creates.  This will become impossible with the patch.

Probably I am worrying too much; I do not personally think the second
point matters in the real life.  If "git log stash" _were_ any useful,
it means the history behind the stash entries are not useless at all, b=
ut
in that case the user would be using regular branches to store them
anyway.
