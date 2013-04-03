From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-tag(1): we tag HEAD by default
Date: Wed, 03 Apr 2013 11:20:57 -0700
Message-ID: <7v7gkj5vcm.fsf@alter.siamese.dyndns.org>
References: <137ebfa428b16497287c55e552372df1087f1588.1364999181.git.trast@inf.ethz.ch>
 <7vzjxf64gn.fsf@alter.siamese.dyndns.org>
 <877gkjvecg.fsf@linux-k42r.v.cablecom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Wed Apr 03 20:21:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UNSJO-0006Yr-WA
	for gcvg-git-2@plane.gmane.org; Wed, 03 Apr 2013 20:21:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762895Ab3DCSVB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Apr 2013 14:21:01 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63019 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762864Ab3DCSVA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Apr 2013 14:21:00 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8E30D121F5;
	Wed,  3 Apr 2013 18:20:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ekBHAglaKYstoJfYzXrtADn3U9Y=; b=drFN4+
	zUwnGrBuCR94Q1/q8z0ClfcOpIpu9ezku9Y5SVjn9gkF6WTCZynRf975fBwqN8Mw
	j3GG+w80Epx/uUHGDeUYu8jSxTbEF62gRKTxDGYU2NuMGC0YaGmgh12v7TcQY45G
	vwOT+gRhrse0RhP1V2G1NEx1TzM9jF0WjY6Uw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kAY78b1MCMyIgT5+7SKL+b7duHhK3aYS
	Ds5Do5szgXNiiVW33Wi87nFLCquLFLg5wjsX3G+xD0RAppxpGTlOLV92Zf4yLBiS
	hR+mkHKv8F33GxAej5Kf3NGCIBrySs7WjcjG2YusblZynb1mcRCAHAg7pL9AtR9K
	JmOQ0Q4bKoE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 82A82121F4;
	Wed,  3 Apr 2013 18:20:59 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C6547121F0; Wed,  3 Apr
 2013 18:20:58 +0000 (UTC)
In-Reply-To: <877gkjvecg.fsf@linux-k42r.v.cablecom.net> (Thomas Rast's
 message of "Wed, 3 Apr 2013 17:11:27 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3B8F996C-9C8B-11E2-9A8C-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219958>

Thomas Rast <trast@inf.ethz.ch> writes:

> There are some instances with the comma style:
>
>   $ git grep ',.*::$' Documentation/*.txt
>   Documentation/blame-options.txt:-L <start>,<end>, -L :<regex>::
>   Documentation/config.txt:gitcvs.dbuser, gitcvs.dbpass::
>   Documentation/config.txt:http.lowSpeedLimit, http.lowSpeedTime::
>   Documentation/git-add.txt:-e, \--edit::
>   Documentation/git-check-attr.txt:-a, --all::
>   Documentation/git-check-ignore.txt:-q, --quiet::
>   Documentation/git-check-ignore.txt:-v, --verbose::
>   Documentation/git-log.txt:-L <start>,<end>:<file>, -L :<regex>:<file>::
>   Documentation/git-p4.txt:--verbose, -v::
>   Documentation/git-p4.txt:--dry-run, -n::
>   Documentation/git-tag.txt:<commit>, <object>::

The above are clearly candidate for clean-ups (the last one is your
making I already killed in this thread, isn't it?).

These are false matches, I think.

>   Documentation/diff-options.txt:--stat[=<width>[,<name-width>[,<count>]]]::
>   Documentation/diff-options.txt:--dirstat[=<param1,param2,...>]::
>   Documentation/git-index-pack.txt:--index-version=<version>[,<offset>]::
>   Documentation/git-log.txt:git log -L '/int main/',/^}/:main.c::
>   Documentation/git-p4.txt:"//depot/my/project@1,6"::
>   Documentation/git-pack-objects.txt:--index-version=<version>[,<offset>]::
>   Documentation/git-remote-fd.txt:`git push fd::7,8 master (as URL)`::
>   Documentation/git-remote-fd.txt:`git push fd::7,8/bar master`::
>   Documentation/git-reset.txt:Undo a commit, making it a topic branch::
>   Documentation/git-shortlog.txt:-w[<width>[,<indent1>[,<indent2>]]]::
>   Documentation/git-show-branch.txt:--reflog[=<n>[,<base>]] [<ref>]::

I am not sure about these "A, e.g. B, C::" entries.  I tend to think
that they are all logically a single entry, that happen to have
commas in their entry heading, and fall into the same "false
matches" category as above.

>   Documentation/revisions.txt:'<sha1>', e.g. 'dae86e1950b1277e545cee180551750029cfe735', 'dae86e'::
>   Documentation/revisions.txt:'<describeOutput>', e.g. 'v1.7.4.2-679-g3bee7fb'::
>   Documentation/revisions.txt:'<refname>', e.g. 'master', 'heads/master', 'refs/heads/master'::
>   Documentation/revisions.txt:'<refname>@\{<date>\}', e.g. 'master@\{yesterday\}', 'HEAD@\{5 minutes ago\
>   Documentation/revisions.txt:'<refname>@\{<n>\}', e.g. 'master@\{1\}'::
>   Documentation/revisions.txt:'@\{<n>\}', e.g. '@\{1\}'::
>   Documentation/revisions.txt:'@\{-<n>\}', e.g. '@\{-1\}'::
>   Documentation/revisions.txt:'<branchname>@\{upstream\}', e.g. 'master@\{upstream\}', '@\{u\}'::
>   Documentation/revisions.txt:'<rev>{caret}', e.g. 'HEAD{caret}, v1.5.1{caret}0'::
>   Documentation/revisions.txt:'<rev>{tilde}<n>', e.g. 'master{tilde}3'::
>   Documentation/revisions.txt:'<rev>{caret}\{<type>\}', e.g. 'v0.99.8{caret}\{commit\}'::
>   Documentation/revisions.txt:'<rev>{caret}\{\}', e.g. 'v0.99.8{caret}\{\}'::
>   Documentation/revisions.txt:'<rev>{caret}\{/<text>\}', e.g. 'HEAD^{/fix nasty bug}'::
>   Documentation/revisions.txt:':/<text>', e.g. ':/fix nasty bug'::
>   Documentation/revisions.txt:'<rev>:<path>', e.g. 'HEAD:README', ':README', 'master:./README'::
>   Documentation/revisions.txt:':<n>:<path>', e.g. ':0:README', ':README'::
>   Documentation/revisions.txt:'<rev>{caret}@', e.g. 'HEAD{caret}@'::
>   Documentation/revisions.txt:'<rev>{caret}!', e.g. 'HEAD{caret}!'::
