From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] gitweb: Add support to Link: tag
Date: Tue, 03 Jul 2012 13:15:05 -0700
Message-ID: <7vy5n0txdi.fsf@alter.siamese.dyndns.org>
References: <1341295377-22083-1-git-send-email-namhyung@kernel.org>
 <1341295377-22083-4-git-send-email-namhyung@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@ghostprotocols.net>
To: Namhyung Kim <namhyung@kernel.org>
X-From: git-owner@vger.kernel.org Tue Jul 03 22:15:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sm9VG-0000O6-6P
	for gcvg-git-2@plane.gmane.org; Tue, 03 Jul 2012 22:15:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753980Ab2GCUPK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jul 2012 16:15:10 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64802 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751256Ab2GCUPJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jul 2012 16:15:09 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 61398938B;
	Tue,  3 Jul 2012 16:15:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=PzRZCHyIMtB9O0HN7ju9YY6af4I=; b=hj/ZvH
	4IS3QqXRPdLXmWzPHFXTMoTC5m7oRtukpophS8iY9OF6uq2OJpx+7n8eVeqCQt4x
	ne1x/NQG6OIkk+AD6ERi7LFBBRHpNhrKNY68YQJrxOyh0nsYPHT3tyVFKGrE1oYI
	GXvcRjwPac50b82yBKuPXZyNuudunFdRXnJV0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=G1+gzMz+AjFKA8acv1nWXfElnUUd7Ryw
	/wdyfaQfnlPMr6VCCD1l+avGCWkervHlBmlqYGkbIZMYM6vnJe+Wv/gfTYcZY1Rj
	Sa/KopKZkW9oF3cx8sLuSs5KBRuO7zMM83Va1SXHKiu/0FW85fL6cz2VuQoh0Az+
	Pk2be+jNBVg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5758E938A;
	Tue,  3 Jul 2012 16:15:08 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CC3BB9388; Tue,  3 Jul 2012
 16:15:06 -0400 (EDT)
In-Reply-To: <1341295377-22083-4-git-send-email-namhyung@kernel.org>
 (Namhyung Kim's message of "Tue, 3 Jul 2012 15:02:57 +0900")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C81E46C0-C54B-11E1-BB76-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200941>

Namhyung Kim <namhyung@kernel.org> writes:

> The tip tree is the one of major subsystem tree in the
> Linux kernel project. On the tip tree, the Link: tag is
> used for tracking the original discussion or context.
> Since it's ususally in the s-o-b area, it'd be better
> using same style with others.
>
> Also as it tends to contain a message-id sent from git
> send-email, a part of the line which has more than 8
> (hex-)digit characters would set a wrong hyperlink
> like [1]. Fix it by not using format_log_line_html().
>
> [1] git.kernel.org/?p=linux/kernel/git/tip/tip.git;a=commit;h=08942f6d5d992e9486b07653fd87ea8182a22fa0
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  gitweb/gitweb.perl |    7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index e0701af..d07bcb7 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -4493,6 +4493,13 @@ sub git_print_log {
>  				print "<span class=\"signoff\">" . esc_html($line) . "</span><br/>\n";
>  			}
>  			next;
> +		} elsif ($line =~ m,^ *link[ :](http://[\w/~.@%&=?+-]*),i) {

Hrm, I am somewhat confused.  This catches "link:http://..." and
"link http://...", but not "link: http://...", which looks a lot
more natural looking at least to me.

Looking at a random sample:

http://git.kernel.org/?p=linux/kernel/git/tip/tip.git;a=commit;h=fe85227347738eb9b871bc163e7fb0db8b6cd2a0

I see a "Buglink: " which I think deserves to be handled by this patch
but would not.  Probably the pattern needs to be loosened
sufficiently, e.g.

	m,^\s*[a-z]*link: (https?://\S+),i

to catch it as well.  Note that I am rejecting space before ":" and
requiring a space after ":" in the above.

I also notice that "Reported-bisected-and-tested-by: " in that
example, which is the topic of your [PATCH 2/3].  Perhaps the logic
should catch everythinng that match "^[A-Z][-a-z]*[a-z]: ".

As to coding style, if you end the body of if () clause with 'next',
I tend to think it is easier to read if you structure it like this:

	if (condition 1) {
        	... action 1 ...
                next;
	}

        if (condition 2) {
		... action 2 ...
		next;
	}

instead of like this:

	if (condition 1) {
        	... action 1 ...
                next;
	} elsif (condition 2) {
		... action 2 ...
		next;
	}
