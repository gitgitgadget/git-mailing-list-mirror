From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] hooks/update: Add a hooks.denyunsignedtags option
Date: Mon, 21 Dec 2015 10:52:00 -0800
Message-ID: <xmqqpoxzfxdb.fsf@gitster.mtv.corp.google.com>
References: <1450719124-10558-1-git-send-email-jak@debian.org>
	<xmqq37uvhdpw.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Julian Andres Klode <jak@debian.org>
X-From: git-owner@vger.kernel.org Mon Dec 21 19:52:10 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aB5Z4-0003ps-0S
	for gcvg-git-2@plane.gmane.org; Mon, 21 Dec 2015 19:52:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751322AbbLUSwF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Dec 2015 13:52:05 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:61586 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750914AbbLUSwD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Dec 2015 13:52:03 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9CFDB3279A;
	Mon, 21 Dec 2015 13:52:02 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6vDICg3e715jUfmqrFydAf+MNEE=; b=KNRR3M
	mBqoZsWPBn9W+RrNkVMaYZcINnHKtC1KJhx9Q/niQtBmMzHk+vEDVAHV2HXL3uxW
	y5OWgcv/YOUlVOLoknM37y3rjVfTyHda4LAH4uLi60ksLw3oON0zjlr8pnqF/5hP
	AtVsBZ5JkGcVysRzcxJOsKyOo8I04jT1XonyE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=H3dNoa1Olkyi1l5r2cQ/F0dh4N2Zc2tl
	tCeA167AnHWq311GjcVjjmzgwtEsYsl1LiCKgRoHOC2zUEA/yQ25GYM8lsDqkC7t
	GRJsTb/cria5abptBxtv6jlJB9tdHu3aGbB6j2TNP31yberUPJ384GsWFliFwras
	DkcBn2ZYE1U=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9554032799;
	Mon, 21 Dec 2015 13:52:02 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 0ABF932797;
	Mon, 21 Dec 2015 13:52:01 -0500 (EST)
In-Reply-To: <xmqq37uvhdpw.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Mon, 21 Dec 2015 10:13:31 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: EBEBC45C-A813-11E5-97A5-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282809>

Junio C Hamano <gitster@pobox.com> writes:

> Use of "cat-file -p" is a bad manner in scripts, as we reserve the
> right to change what "-p" output looks like purely on human
> usability.  "cat-file tag", perhaps?
>
> Also,
>
> 	$ git grep ' PGP '
>
> in our source tells me that we use a bit tighter pattern even when
> we are casually trying to see if the thing looks like a PGP signed
> payload.
>
> 	if test "$allowunsigned" = "true" ||
>            git cat-file "$newrev" |
>            grep -q '^-----BEGIN PGP SIGNATURE-----$'
> 	then
> 		...
>
> or something?

I think an intelligent reader would have understood what I meant,
but the 'cat-file' in the above needs to say what type of thing
it is asking to dump, i.e.

 	if test "$allowunsigned" = "true" ||
            git cat-file tag "$newrev" |
            grep -q '^-----BEGIN PGP SIGNATURE-----$'
 	then

Sorry for the noise.
