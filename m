From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/7] i18n: rebase: mark strings for translation
Date: Sun, 22 Jul 2012 12:04:07 -0700
Message-ID: <7vhaszr31r.fsf@alter.siamese.dyndns.org>
References: <cover.1342920089.git.worldhello.net@gmail.com>
 <e488b5e8f40859a842f80855a3dd4861a4ced6d0.1342920089.git.worldhello.net@gmail.com> <cover.1342920089.git.worldhello.net@gmail.com> <724ca3989123159c9970b3276b4764dcbd5fd56e.1342920089.git.worldhello.net@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Stefano Lattarini <stefano.lattarini@gmail.com>
To: Jiang Xin <worldhello.net@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 22 21:47:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1St27s-0006AH-86
	for gcvg-git-2@plane.gmane.org; Sun, 22 Jul 2012 21:47:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752578Ab2GVTrb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Jul 2012 15:47:31 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58164 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752429Ab2GVTra (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Jul 2012 15:47:30 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1A1B48AF2;
	Sun, 22 Jul 2012 15:47:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 s=sasl; bh=JQ7Z/wfTUrU196iDJ2FyUC9mzzs=; b=u8Tq7TJMqUtkiSmErtcJ
	4cgUHq2TyZ5XuP9Af4B7FhCe+fXCpwQZo1MpxGXHadaUeZjU0jlP7UQmPMMKuXeu
	j5GFQyHKF+E5LOySXvIfjdAKqQm4FvMWsPPw1jCKhCuq9H4ju1pyKEwkmpYgeN2I
	Xa+Khl6UybFumGP6uLc3QN8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=PafpOnf3V3JzTFv5oz4lJS/quZf/dRLlRR23u6uy81LBtb
	/+yKjK1tMGarXhz0btykzvArGXC1B9nqSYBGtuagbcGJR+vyXl6QFqVUP3yyo7Jy
	o+fA4yl7wCqPz8QID3lZ0Y1EfwbcyRejagGHKUZVVXMYp6YizkqM3tRortq4Q=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 060AB8AF1;
	Sun, 22 Jul 2012 15:47:30 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7F2AA8AEF; Sun, 22 Jul 2012
 15:47:29 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1220ACF6-D436-11E1-898B-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201859>

Jiang Xin <worldhello.net@gmail.com> writes:

> -resolvemsg="
> +resolvemsg="$(gettext "
>  When you have resolved this problem run \"git rebase --continue\".
>  If you would prefer to skip this patch, instead run \"git rebase --skip\".
>  To check out the original branch and stop rebasing run \"git rebase --abort\".
> -"
> +")"

Two micronits:

 - A="B" assignment can lose the outermost dq-pair around it
   (i.e. A=B), which might make the above easier to read.

 - The original message had to backslash-quote only because the
   outermost quote was done with a dq-pair, but it does not use any
   substitutions, so turning it into a sq-pair might make the above
   easier to read.

With "might", I am not saying the above should be _fixed_; I am
merely saying we may want to consider these points to see if some
changes to your patch are improvements.

    resolvemsg=$(gettext '
    When you have resolved this problem run "git rebase --continue".
    If you would prefer to skip this patch, instead run "git rebase --skip".
    To check out the original branch and stop rebasing run "git rebase --abort".
    ')

> @@ -316,12 +317,12 @@ test $# -gt 2 && usage
>  if test -n "$cmd" &&
>     test "$interactive_rebase" != explicit
>  then
> -	die "--exec option must be used with --interactive option"
> +	die "$(gettext -- "--exec option must be used with --interactive option")"

This is a related tangent, but have we resolved that issue with
xgettext and "--"?

Ahh, I see you did something in [3/7] ;-)

Thanks.
