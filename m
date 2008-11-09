From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git send-email: edit recipient addresses with the 
 --compose flag
Date: Sun, 09 Nov 2008 14:09:11 -0800
Message-ID: <7viqqwa6wo.fsf@gitster.siamese.dyndns.org>
References: <1226235588-2997-1-git-send-email-ian.hilt@gmx.com>
 <200811091513.55544.fg@one2team.com>
 <alpine.LFD.2.00.0811091344480.20499@sys-0.hiltweb.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Francis Galiegue <fg@one2team.com>,
	Git Mailing List <git@vger.kernel.org>,
	Pierre Habouzit <madcoder@debian.org>
To: Ian Hilt <ian.hilt@gmx.com>
X-From: git-owner@vger.kernel.org Sun Nov 09 23:12:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KzIWA-0005ER-Dm
	for gcvg-git-2@gmane.org; Sun, 09 Nov 2008 23:12:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755806AbYKIWJ4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 9 Nov 2008 17:09:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755875AbYKIWJ4
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Nov 2008 17:09:56 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:51775 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755747AbYKIWJz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 9 Nov 2008 17:09:55 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 1745B954BE;
	Sun,  9 Nov 2008 17:09:54 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 920B6954B9; Sun, 
 9 Nov 2008 17:09:14 -0500 (EST)
In-Reply-To: <alpine.LFD.2.00.0811091344480.20499@sys-0.hiltweb.site> (Ian
 Hilt's message of "Sun, 9 Nov 2008 15:09:21 -0500 (EST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 22FEDB74-AEAB-11DD-A952-4F5276724C3F-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100474>

Ian Hilt <ian.hilt@gmx.com> writes:

> On Sun, 9 Nov 2008, Francis Galiegue wrote:
>> Le Sunday 09 November 2008 13:59:48 Ian Hilt, vous avez =C3=A9crit=C2=
=A0:
>> > +	if ($c_file =3D~ /^To:\s*+(.+)\s*\nCc:/ism) {
>>=20
>> Greedy operators are only supported with perl 5.10 or more... I thin=
k it's a=20
>> bad idea to use them...
>
> The problem here was that a space should follow the field, but it may
> not.  The user may unwarily backup over it.  "\s*" would match this
> case.
>
> But if there is a space, it is included in the "(.+)".  So I tried
> "\s+", which did not include the space, but it won't include the firs=
t
> address if there isn't a space after the field.
>
> The quantified subpattern seemed to do the trick.  But, if it could
> result in a dependency issue, I would agree this would be a bad idea.

You expect something non-blank there anyway, so why not do:

	To:\s*(\S.*?)\s*\n....
