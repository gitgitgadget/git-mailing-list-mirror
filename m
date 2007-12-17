From: Wincent Colaiuta <win@wincent.com>
Subject: Re: git.c option parsing
Date: Mon, 17 Dec 2007 10:01:56 +0100
Message-ID: <25018761-80E8-410C-BB18-DD799F58308A@wincent.com>
References: <1197631424-52586-1-git-send-email-win@wincent.com> <1197631424-52586-2-git-send-email-win@wincent.com> <7vejdml92c.fsf@gitster.siamese.dyndns.org> <F6F3247E-4E71-4977-9626-F0571278E1E6@wincent.com> <7vsl21aeqw.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 17 10:02:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4Bs1-0004Ui-Lc
	for gcvg-git-2@gmane.org; Mon, 17 Dec 2007 10:02:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757301AbXLQJCQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 17 Dec 2007 04:02:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753888AbXLQJCP
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Dec 2007 04:02:15 -0500
Received: from wincent.com ([72.3.236.74]:57633 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750794AbXLQJCN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 17 Dec 2007 04:02:13 -0500
Received: from cuzco.lan (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id lBH91vBK015686;
	Mon, 17 Dec 2007 03:01:58 -0600
In-Reply-To: <7vsl21aeqw.fsf@gitster.siamese.dyndns.org>
X-Mailer: Apple Mail (2.915)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68524>

El 17/12/2007, a las 9:48, Junio C Hamano escribi=F3:

> Wincent Colaiuta <win@wincent.com> writes:
>
>> Of course, the above plan will only work for builtins, not for
>> scripts. An additional step would be needed to enable scripts to
>> handle these options; perhaps teaching "git rev-parse" something...
>
> As long as special options stay special and we make a rule not to =20
> allow
> any subcommand to assign its own meaning to them, the git wrapper can
> lookahead and reorder, when seeing a command line:
>
> 	git scripted-command --special
>
> into
>
> 	git --special scripted-command
>
> And that approach would work well for built-ins as well, I would
> imagine.

Yes, and it would be simpler to implement also. The only downside is =20
that without all the other proposed changes things like "git-dashed --=20
special" wouldn't work; only teaching the builtins to actually handle =20
the special options would work in that case. And in the interests of =20
consistency I think it's pretty important that "git subcommand --=20
special" and "git-subcommand --special" both work the same as the user =
=20
would (reasonably) expect them to...

> There is one minor detail, though.  There could be an option-paramete=
r
> that is literally --special.  E.g.
>
> 	git grep -e --no-paginate
>
> should not be reordered to
>
> 	git --no-paginate grep -e


Yes, that's definitely one that would need to be treated as a special =20
case.

Cheers,
Wincent
