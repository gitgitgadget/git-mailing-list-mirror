From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] revision: add --grep-reflog to filter commits by
 reflog messages
Date: Fri, 28 Sep 2012 10:55:16 -0700
Message-ID: <7vr4pmm3qz.fsf@alter.siamese.dyndns.org>
References: <1348745786-27197-1-git-send-email-pclouds@gmail.com>
 <1348815682-18696-1-git-send-email-pclouds@gmail.com>
 <1348815682-18696-2-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 28 19:55:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1THemh-00037f-5o
	for gcvg-git-2@plane.gmane.org; Fri, 28 Sep 2012 19:55:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755000Ab2I1RzV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 28 Sep 2012 13:55:21 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59315 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752836Ab2I1RzU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 28 Sep 2012 13:55:20 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9022E8C63;
	Fri, 28 Sep 2012 13:55:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=fVA1NwqaKYjB
	qNJLgbbVOtuB/qI=; b=hRwHA7VKmR2tkJFHeiThwytoue/Omt0CxwS8/I/y/mPj
	2y/YAJu2srr4LIGr9fHCTQHIEe03d3wep77LMheSsfxfQz3IgwTt1SAwNsUrJfqc
	v1JT6Z95W6yXLk04s3F4QIb0ibz36cWrYsvhsG9Yb+SNVBiZKYWL1G2EbhQ6JAA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=R8A5Vt
	uv0hNf31zh7U+mdFBY2rfM6qNYDgRyYG14zEcW0EW3qYdx4pqM9+D1SZq/JMEh97
	A4ysBomic4U7q3kcm/hLZOwp+1QzCZxiNpJYx91n1QX3+ZR8Flwj0gkxFB9TCnhH
	MJ8ODDU0XK95SGyyX4Gb17XEfXLcbAbbfdfts=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7D9378C62;
	Fri, 28 Sep 2012 13:55:19 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CE8478C61; Fri, 28 Sep 2012
 13:55:17 -0400 (EDT)
In-Reply-To: <1348815682-18696-2-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Fri, 28 Sep
 2012 14:01:21 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A9D3C454-0995-11E2-91E4-18772E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206588>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com> writes:

> Similar to --author/--committer which filters commits by author and
> committer header fields. --grep-reflog adds a fake "reflog" header to
> commit and a grep filter to search on that line.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  On Fri, Sep 28, 2012 at 12:09 AM, Junio C Hamano <gitster@pobox.com>
>  wrote:
>  > I am debating myself if it is sane for this option to have no hint
>  > that it is about "limiting" in its name.  "--author/--committer"
>  > don't and it is clear from the context of the command that they ar=
e
>  > not about setting author/committer, so "--reflog-message" may be
>  > interpreted the same, perhaps.
>  >
>  > The entry in the context above talks about multiple occurrence of
>  > that option. Shouldn't this new one also say what happens when it
>  > is
>  > given twice?
>
>  Fixed.
>
>  > I think I wrote prep_header_patterns() and compile_grep_patterns()
>  > carefully enough not to assume the headers are only the author and
>  > committer names, so the various combinations i.e. all-match,
>  > author(s), committer(s), grep(s), and reflog-message(s), should
>  > work
>  > out of the box, but have you actually tested them?
>
>  I did not. I do now, tests are also added.

You seem to have skipped a lot more important comment from the
message that came immediately after the above part.  Did you take a
look at grep.c::match_one_pattern() that calls strip_timestamp() for
any and all GREP_PATTERN_HEAD items?

This is why I think that the [1/3] in this series shows a total lack
of design taste.  Each element in "headers", unlike "body", is a
structured field and its payload has meaning depending on what field
name is associated with it.  That is why we do not give a way to
users to willy-nilly add ad-hoc header fields.

The other side of this coin is that Git ought to be able to take
advantage of the meaning of each header.  Stripping the timestamp
part when doing a textual match against --author/--committer is one
example.  The code in match_one_pattern() to deal with the header
patterns need to be _extended_ to take into account the special
treatment each header, includign this new "reflog " fake header,
wants when doing a textual match, and when we add any other match
against header (either real or fake), we should be able to add
specific matching logic tailored to handle the particular meaning of
the header would have.

=46or that to happen, the code _must_ know what kind of headers we
would support; discarding the existing enum is going in a wrong
direction.

When we introduce "git log --header=3Dfrotz:xyzzy" option that looks
for a generic "frotz " header and tries to see if "xyzzy" textually
appears in the field, we may want to add a generic "this is not a
header that we have special treatment for" enum to the mix.  But for
known kinds of headers, we would need a list of what each header is
and what semantics it wants.

So please reconsider undoing [1/3], and rerolling [2/3] that depends
on it.
