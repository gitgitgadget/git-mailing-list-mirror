From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-shortlog.txt: improve documentation about .mailmap
 files
Date: Sat, 27 Dec 2008 03:48:39 -0800
Message-ID: <7viqp5et48.fsf@gitster.siamese.dyndns.org>
References: <1230290283-6268-1-git-send-email-dato@net.com.org.es>
 <1230292553-7613-1-git-send-email-dato@net.com.org.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Adeodato =?utf-8?Q?Sim=C3=B3?= <dato@net.com.org.es>
X-From: git-owner@vger.kernel.org Sat Dec 27 12:52:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LGXiA-00070A-6d
	for gcvg-git-2@gmane.org; Sat, 27 Dec 2008 12:52:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753251AbYL0Lss convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 27 Dec 2008 06:48:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753213AbYL0Lss
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Dec 2008 06:48:48 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:32956 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753079AbYL0Lsr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 27 Dec 2008 06:48:47 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 060B91B30E;
	Sat, 27 Dec 2008 06:48:46 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 736E91B30C; Sat,
 27 Dec 2008 06:48:42 -0500 (EST)
In-Reply-To: <1230292553-7613-1-git-send-email-dato@net.com.org.es> (Adeodato
 =?utf-8?Q?Sim=C3=B3's?= message of "Fri, 26 Dec 2008 12:55:53 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 5152E07A-D40C-11DD-A337-F83E113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103997>

Adeodato Sim=C3=B3 <dato@net.com.org.es> writes:

> The previous .mailmap example made it seem like .mailmap files are on=
ly
> useful for commits with a wrong address for an author, when they are =
about
> fixing the real name. Explained this better in the text, and replaced=
 the
> existing example with a new one that hopefully makes things clearer.

Thanks.

> -If the file `.mailmap` exists, it will be used for mapping author
> -email addresses to a real author name. One mapping per line, first
> -the author name followed by the email address enclosed by
> -'<' and '>'. Use hash '#' for comments. Example:
> +If a file `.mailmap` exists in the toplevel directory of the reposit=
ory,
> +it will be used for mapping author email addresses to a canonical re=
al
> +name. This can be used to coalesce together commits by the same pers=
on
> +where their name was spelled differently (whether with the same emai=
l
> +address or not).

We didn't stress "the toplevel" earlier, partly because it is obvious t=
hat
the file cannot be anything but project-tree wide (as opposed to being =
per
subdirectory, similar to .gitignore and .gitattributes).  I guess it wo=
uld
not hurt to be explicit, even though it feels slightly silly.

"..., it is used to map author email addresses to..." would flow easier=
=2E

> +The format of the file is one mapping per line, first the desired au=
thor
> +name followed by the email address enclosed by '<' and '>'. Use hash=
 '#'
> +for comments.

You already introduced the term "a canonical real name" in the earlier
description.  It would be easier to read if you stick to it and say "Ea=
ch
line consists of the canonical real name of an author, whitespaces, and=
 an
email address, enclosed by '<' and '>', to map to the name".

Can a hash '#' character be anywhere on a line?  E.g. how is an entry l=
ike
this processed?

	Jane Doe <jane@desktop.(none)> # early mistake...

> +... For example, if your history contains commits by these
> +committers:

I think you meant "authors", not "committers".

> +------------
> +Author: Joe Developer <joe@random.com>
> +Author: Joe R. Developer <joe@random.com>
> +Author: Jane Doe <jane@the-does.name>
> +Author: Jane Doe <jane@laptop.(none)>
> +Author: Jane D. <jane@desktop.(none)>
> +------------

I'd suggest dropping "Author: ".  You said you are listing people.

Isn't random.com a real domain (the same goes for the-does.name)?  It
would be preferrable to use addresses from .example (or .xz) top-level
domain.

Clarify that there are actually two people in the list above, and expla=
in
that they are one Joe with two spellings who prefers to be referred to
with his middle initial, and one Jane with three spellings who prefers =
to
show the family name fully spelled out.  Do not force your readers gues=
s
which spelling is preferred for each person in the example.  It would m=
ake
it easier for them to understand the example you will give them next an=
d
to agree that the mailmap is "proper".

> +Then a proper `.mailmap` file would be:
>
>  ------------
> -# Keep alphabetized
> -Adam Morrow <adam@localhost.localdomain>
> -Eve Jones <eve@laptop.(none)>
> +# Note how we don't need an entry for <jane@laptop.(none)>, because =
the
> +# real name of that author is correct already, and coalesced directl=
y.
> +Jane Doe <jane@desktop.(none)>
> +Joe R. Developer <joe@random.com>
>  ------------
