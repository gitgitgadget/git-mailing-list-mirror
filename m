From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-contacts: do not fail parsing of good diffs
Date: Tue, 18 Feb 2014 15:14:12 -0800
Message-ID: <xmqqppmkau9n.fsf@gitster.dls.corp.google.com>
References: <m3wqgw2srh.fsf@black.gullik.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: larsbj@gullik.org (Lars Gullik =?utf-8?Q?Bj=C3=B8nnes?=)
X-From: git-owner@vger.kernel.org Wed Feb 19 00:14:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WFtrt-0006Je-RL
	for gcvg-git-2@plane.gmane.org; Wed, 19 Feb 2014 00:14:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754276AbaBRXOU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 18 Feb 2014 18:14:20 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59987 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753339AbaBRXOS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 18 Feb 2014 18:14:18 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AC3B26D1F6;
	Tue, 18 Feb 2014 18:14:17 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=oha94pmZIbma
	p1mnQpKAkkSRdCM=; b=J2n1jngRp6C+8oQJ3PM3XxIclyJKlmdi0aVhB1+J0D/K
	QOer3+D0yMvtmtFRKxNP6CMEeHgdv2VjY7ghq3GQuQTWJCBdxVzCqiX69vUQnvj+
	/m5YJNTgyiDpnk4cuyyTYmpT69cw8TrJfMos7alsW+mG9HZ5ttNKO25G88Gtf2U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=TeAoXV
	X4Tw4eaoifNLO7begTUttxH5JhsKNgaWWRc4kYNJbQR0LrZgGynWfSga3wfJda8X
	uEC6QQjobhOmVlNGHMDzIQ9AhhGUwcEw0svCX3SQHrFH0w3S4QA6JcQkam+wgRZl
	2CEHnPcb8H/dWJOdn4i2etXQmYUPaI8ZA8rps=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E39086D1F5;
	Tue, 18 Feb 2014 18:14:16 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A26736D1EA;
	Tue, 18 Feb 2014 18:14:14 -0500 (EST)
In-Reply-To: <m3wqgw2srh.fsf@black.gullik.net> ("Lars Gullik =?utf-8?Q?Bj?=
 =?utf-8?Q?=C3=B8nnes=22's?=
	message of "Sat, 15 Feb 2014 18:24:50 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 621C2190-98F2-11E3-8B33-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242374>

larsbj@gullik.org (Lars Gullik Bj=C3=B8nnes) writes:

> If a line in a patch starts with "--- " it will be deemed
> malformed unless it also contains the proper diff header
> format. This situation can happen with a valid patch if
> it has a line starting with "-- " and that line is removed.
>
> This patch just removes the check in git-contacts.
>
> Signed-off-by: Lars Gullik Bj=C3=B8nnes <larsbj@gullik.org>
> ---

If the script wanted to be "more correct", it should be paying
attention to the $len it already parses out of the hunk headers to
make sure it does not mistake removal of a line that begins with "--
" as the beginning of a patch to a different path, but as the
original does not seem to aim to be so careful anyway, this change
should be OK, I would say.

The patch was whitespace damaged, by the way.  It was easy to hand
tweak so there is no need to resend this particular patch, but if
you are planning to send more patches, please check your MUA and
tell it not to.

Thanks.

>  contrib/contacts/git-contacts | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/contrib/contacts/git-contacts b/contrib/contacts/git-con=
tacts
> index 428cc1a..dbe2abf 100755
> --- a/contrib/contacts/git-contacts
> +++ b/contrib/contacts/git-contacts
> @@ -96,8 +96,6 @@ sub scan_patches {
>                 next unless $id;
>                 if (m{^--- (?:a/(.+)|/dev/null)$}) {
>                         $source =3D $1;
> -               } elsif (/^--- /) {
> -                       die "Cannot parse hunk source: $_\n";
>                 } elsif (/^@@ -(\d+)(?:,(\d+))?/ && $source) {
>                         my $len =3D defined($2) ? $2 : 1;
>                         push @{$sources->{$source}{$id}}, [$1, $len] =
if $len;
> --=20
> 1.9.0
