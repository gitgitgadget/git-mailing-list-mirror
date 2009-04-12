From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH RFC 3/6] send-email: Handle "GIT:" rather than "GIT: " 
 during --compose
Date: Sat, 11 Apr 2009 17:59:20 -0700
Message-ID: <7v3aced6vr.fsf@gitster.siamese.dyndns.org>
References: <1239139522-24118-1-git-send-email-mfwitten@gmail.com>
 <1239139522-24118-2-git-send-email-mfwitten@gmail.com>
 <1239139522-24118-3-git-send-email-mfwitten@gmail.com>
 <7vprfjf11h.fsf@gitster.siamese.dyndns.org>
 <b4087cc50904111345v4787f38al9d7d234de8a6d24e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Michael Witten <mfwitten@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 12 03:01:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lso4H-0001Mt-RH
	for gcvg-git-2@gmane.org; Sun, 12 Apr 2009 03:01:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754574AbZDLA7a convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 11 Apr 2009 20:59:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754135AbZDLA73
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Apr 2009 20:59:29 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:57934 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754083AbZDLA72 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 11 Apr 2009 20:59:28 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 60DDBEDD8;
	Sat, 11 Apr 2009 20:59:27 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id AC3A8EDD7; Sat,
 11 Apr 2009 20:59:24 -0400 (EDT)
In-Reply-To: <b4087cc50904111345v4787f38al9d7d234de8a6d24e@mail.gmail.com>
 (Michael Witten's message of "Sat, 11 Apr 2009 15:45:53 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 2BF245A2-26FD-11DE-95AE-DC76898A30C1-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116361>

Michael Witten <mfwitten@gmail.com> writes:

>> Because "while (<>)" does not localize $_, you are clobbering it in =
the
>> caller's context. =C2=A0I do not know if any of the the existing cal=
lers cares,
>> but it is a change in behaviour.
>
> How about:
>
>     while (local $_ =3D <$fh>)
>
> Or, in our case, this:
>
>     while (my $_ =3D <$fh>)

Special variables like $_ cannot be made into lexicals, unless you know
you will only run with a very recent version of Perl (5.9.1, I think).

If you do not want to worry about portability, typically it is easiest =
to
say "local ($_)" upfront in the beginning of a sub.

I do not understand why you want to change the original

	while (my $line =3D <$fh>) {
        	...
	}

though.
