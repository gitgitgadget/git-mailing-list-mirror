From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] revision.c: add --format option for 'git log'
Date: Sun, 22 Feb 2009 09:53:54 -0800
Message-ID: <7v63j2z7bh.fsf@gitster.siamese.dyndns.org>
References: <1235230015-17641-1-git-send-email-felipe.contreras@gmail.com>
 <7vtz6m1knv.fsf@gitster.siamese.dyndns.org>
 <94a0d4530902220918oc6f8ab9vc1fd0b55cad014a2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 22 18:55:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LbIY7-0008En-DN
	for gcvg-git-2@gmane.org; Sun, 22 Feb 2009 18:55:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751472AbZBVRyB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 22 Feb 2009 12:54:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751344AbZBVRyB
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Feb 2009 12:54:01 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:64662 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750755AbZBVRyA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 22 Feb 2009 12:54:00 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 973CA2BB2F;
	Sun, 22 Feb 2009 12:53:59 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id CA43B2BB22; Sun,
 22 Feb 2009 12:53:56 -0500 (EST)
In-Reply-To: <94a0d4530902220918oc6f8ab9vc1fd0b55cad014a2@mail.gmail.com>
 (Felipe Contreras's message of "Sun, 22 Feb 2009 19:18:12 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: C8642230-0109-11DE-B217-6F7C8D1D4FD0-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111030>

=46elipe Contreras <felipe.contreras@gmail.com> writes:

> On Sun, Feb 22, 2009 at 6:49 PM, Junio C Hamano <gitster@pobox.com> w=
rote:
>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>>
>>> --format=3D:foo is a shorthand for --pretty=3Dtformat:foo, otherwis=
e this
>>> new option acts just like --pretty=3Dfoo, except it's more intuitiv=
e for
>>> users of 'git log'.
>>
>> It's been quite a long time since the earlier discussion, but I wond=
er why
>> you need the colon before "foo" for this new shorthand. =C2=A0I *thi=
nk* you are
>> also introducing "--format=3Dshort" as a synonym to "--pretty=3Dshor=
t", but
>> I do not think it is necessary.
>
> Well, my hope was to replace --pretty=3Dshort with --format=3Dshort, =
but
> you said that would break other scripts.

It is not just scripts you break.  You also break people's trained
fingers.

You can specify the kind of canned pretty printing with --pretty=3Dshor=
t,
and it is not any longer to type than --format.  For use in scripts tha=
t
you write once and forget, there is no need to even apply this patch.

The only reason why new --format=3D<fmt> could be an useful addition is
because --pretty=3Dformat:<fmt> may be too long to type interactively.

>>> As discussed in the mailing list, this is implemented as an undocum=
ented
>>> option.
>>
>> Maybe somebody wants to document it.
>
> Ah, I would gladly add the documentation, shall I write that it's an
> 'alternative' option similar to --pretty?

I do not think we want to introduce a new way to say the same thing for
the canned short options; "alternative" is not a good word for it.

Putting it in another way...

The output format is controlled by --pretty, which knows a set of canne=
d
output formats.  You can specify --format=3D<fmt> if you want something
different from any of the canned format.  If your git does not support
this new notation, you can say --pretty=3Dtformat:<fmt> to get the same
effect.  The old --pretty=3Dtformat:<fmt> (and --pretty=3Dformat:<fmt>)=
 is not
deprecated in any way.
