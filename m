From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] Document format of basic Git objects
Date: Wed, 15 Feb 2012 11:48:09 -0800
Message-ID: <7v4nur2806.fsf@alter.siamese.dyndns.org>
References: <1329312140-24089-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 15 20:48:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rxkpv-0003db-1z
	for gcvg-git-2@plane.gmane.org; Wed, 15 Feb 2012 20:48:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754664Ab2BOTsN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 15 Feb 2012 14:48:13 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62781 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751781Ab2BOTsM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 15 Feb 2012 14:48:12 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D7B347F4A;
	Wed, 15 Feb 2012 14:48:11 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=SvTWeWU84f3M
	Gvr5eFWTU4ygolI=; b=dNhaso1uuyxggHGXhxoQt+3twiEz2doj49fGXj2FP5yS
	Z+tbes4eJaNbYsBIya3V4cpfkehFsuAtfyynzTt5D2ch7SX3yvVKtQmrcsArqt6C
	EK2ULjLz9zigueTxX7Zv1PEcqz0VezKY+GuHRVObBDnweiWdH1YUtJPg/gWcqKI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=dOgmAu
	j+kMDpNESzicCZhihj5O3Gej8qsPE0vWl4GY0VYHgAfzQ515llx16LzjLZzKYCHO
	5cHVtNkX3soxlDmD9MoRQ/sgpGjOw62GEkXO26jJzxjLDTw3Yvd/6iSYVw2QWHrD
	pR8hAVM1SUNAWD7thMmMRX5XBkvQpB0k4Ftmo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CCFDB7F49;
	Wed, 15 Feb 2012 14:48:11 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 006E17F48; Wed, 15 Feb 2012
 14:48:10 -0500 (EST)
In-Reply-To: <1329312140-24089-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Wed, 15 Feb
 2012 20:22:20 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FD9627CE-580D-11E1-AC60-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190850>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> This is just a draft text with a bunch of fixmes. But I'd like to hea=
r
> from the community if this is a worthy effort. If so, then whether
> git-cat-file is a proper place for it. Or maybe we put relevant text
> in commit-tree, write-tree and mktag, then refer to them in cat-file
> because cat-file can show raw objects.
>
> So comments?

This _only_ describes the payload (i.e. without the 'blob <size>\n' hea=
der
used in loose object, in other words, what read_object() may return).
There should be a sentence to stress this.  As many Git intros (includi=
ng
my book) begin with the "a short header 'blob <size>\n' concatenated wi=
th
the contents is hashed to compute the object name" picture, it would be
confusing unless you explicitly say that you are only describing the
"contents" part.

It makes sense to mention that the cat-file subcommand is used to obtai=
n
this raw data somewhere in the documentation, but I would say the conte=
nt
of this patch belongs to Documentation/technical/ somewhere.

>  PS. This also makes me wonder if tag object supports "encoding".

I do not think so.

> +OBJECT FORMAT
> +-------------
> +
> +Tree object consists of a series of tree entries sorted in memcmp()
> +order by entry name. Each entry consists of:
> +
> +- POSIX file mode encoded in octal ascii

Add ", no 0 padding to the right" at the end, as I heard that every
imitation of Git gets this wrong in its first version.

> +- One space character
> +- Entry name terminated by one character NUL
> +- 20 byte SHA-1 of the entry

> +Tag object is ascii plain text in a format similar to email format
> +(RFC 822). ...

Do not mention "email format (RFC 822)" at all.  The differences are
significant enough that it only confuses the readers.

We do not have colon at the end of the header, we do not promise to par=
se
field names case insensitively, and the way continuation lines are pars=
ed
is totally different (a "similar" construct in RFC 2822 is "folded head=
er
lines", but it is signalled by "folding white space", it discards the
end-of-line from the previous line and makes the result a logical singl=
e
line. Our continuation lines are introduced by a single SP and the resu=
lt
of concatenation keeps the end-of-line from the previous lines, making =
the
result multiple lines).

Also we do not promise that the lines in the header part are always
<field,value> pairs.  So rephrase this while carefully distinguishing
between "a line in header" and "field".

    A commit or a tag object begins with the "header" that consists of =
one
    or more lines delimited by LF. The end of the header is signalled b=
y
    an empty line.

    A "continuation line" in the header begins with a SP.  The remainde=
r
    of the line, after removing that SP, is concatenated to the previou=
s
    line, while retaining the LF at the end of the previous line.

    When a line in the header begins with a letter other than SP, and h=
as
    at least one SP in it, it is called a "field".  A field consists of
    the "field name", which is the string before the first SP on the li=
ne,
    and its "value", which is everything after that SP.  When the value
    consists of multiple lines, continuation lines are used.

    More than one field with the same name can appear in the header of =
an
    object, and the order in which they appear is significant.

    In a commit object, the header begins with the following fields tha=
t
    have such and such meaning.

    In a tag object, the header begins with the following fields...

    After these defined fields, newer versions of git may add more line=
s
    in the header. Some of them may be fields, others might not be. The
    implementations to parse commit and tag objects must ignore lines i=
n
    the header that it does not understand without triggering an error.

>  ... It consists of a header and a body, separated by a blank
> +line. The header includes exactly four fields in the following order=
:
> +

If you hand-craft a tag-like object that has unknown field after these
four, how badly the current implementations behave?

> +1. "object" field, followed by SHA-1 in ascii of the tagged object
> +2. "type" field, followed by the type in ascii of the tagged object
> +   (either "commit", "tag", "blob" or "tree" without quotes,
> +   case-sensitive)
> +3. "tag" field, followed by the tag name
> +4. "tagger" field, followed by the <XXX, to be named>

> +The tag body contains the tag's message and possibly GPG signature.
> +
> +Commit object is in similar format to tag object. The commit body is

It is strange that you introduce tag and then commit.  I would think th=
at
readers expect to see them presented in the usual blob/tree/commit/tag
order.

> +in plain text of the chosen encoding (by default UTF-8). The commit
> +header has the following fields in listed order
> +
> +1. One "tree" field, followed by the commit's tree's SHA-1 in ascii
> +2. Zero, one or more "parent" field
> +3. One "author" field, in <XXX to be named> format
> +3. One "committer" field, in <XXX to be named> format
> +4. Optionally one "encoding" field, followed by the encoding used fo=
r
> +   commit body
> +5. GPG signature (fixme)
> +
> +More headers after these fields are allowed. Unrecognized header
> +fields must be kept untouched if the commit is rewritten.

Replace the first sentence with "New kinds of fields may be added in la=
ter
versions of git." and drop the second one entirely.  Depending on the
reason and nature of the "rewrite", we may or may not want to keep thes=
e
unknown header lines, so it is best to leave the behaviour unspecified.
=46or example, it makes sense to retain "mergetag" because it is about =
the
parent, not the resulting commit.  It does not make sense to keep "gpgs=
ig"
because it is about the commit you are rewriting to invalidate that old
signature.
