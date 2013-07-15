From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 00/46] "struct pathspec" conversion and :(glob) and :(icase)
Date: Mon, 15 Jul 2013 14:43:36 -0700
Message-ID: <7va9lna48n.fsf@alter.siamese.dyndns.org>
References: <1373790969-13000-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Jul 15 23:43:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UyqYb-00027o-2S
	for gcvg-git-2@plane.gmane.org; Mon, 15 Jul 2013 23:43:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755343Ab3GOVnk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 15 Jul 2013 17:43:40 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36488 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755239Ab3GOVnj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 15 Jul 2013 17:43:39 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C2CB431FD9;
	Mon, 15 Jul 2013 21:43:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=YROioB5okT1w
	ht0kUMh3sT7sTEw=; b=q3LXQC1JqgVcqa9X/pu4WtPq1Gn8520wj5Gz/WMlT+b9
	l9T8B3cUCx+OPMn/xta/FJlsC9VY1NTkPu5QgjVjSehacqPxt+HnFYUDq+m8OdBs
	FC4KlODtXPOYOe0nPv2pM1Etxx5TDkj7k1lGBPloKfk032UUdvKEb+IOyBJ0XbU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=YDkDZ8
	F2/ZsktnAaWBEhXd+3UVy1/W3KEJkJB3DJm+sTm/LuutuOgJXuZDwBrP7Z5DfUt8
	wcnfHTv1fwnpsYzFK3NQ16NlqHeyshJ6NXQgkksS/rhUamIdaYUr9F5pEIDn/RiH
	5uqyVjGgfS2A0uoyOMsoWEongDOfwGqUrGdJo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B91A431FD8;
	Mon, 15 Jul 2013 21:43:38 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0BC4731FD7;
	Mon, 15 Jul 2013 21:43:37 +0000 (UTC)
In-Reply-To: <1373790969-13000-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Sun, 14
 Jul 2013 15:35:23 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9B949D32-ED97-11E2-A9DE-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230524>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> Compared to the last round [1] this series mainly fixes comments and
> commit messages suggested by Eric and Junio. It also fixes a conflict
> with cb/log-follow-with-combined (in master) and introduces :(icase)
> mentioned in the last round.
>
> [1] http://thread.gmane.org/gmane.comp.version-control.git/226892
>
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (46):
>   clean: remove unused variable "seen"
>   ...
>   parse_pathspec: accept :(icase)path syntax

This was a good exercise for git-imerge.  I merged it just below the
"2.0 migration topic" that is kept outside the 'next' first by hand,
and then used imerge.  Interested parties may try to do this, after
fetching from me:


	$ git checkout cb5d2fc
	$ git branch nd/magic-pathspec 93d93537
	$ git imerge start --first-parent --name bogo nd/magic-pathspec

	... imerge thinks and then will stop, asking you to resolve
	... and commit, repeatedly.  Do the next two steps until it
        ... stops.

	$ edit
        $ git commit -a --no-edit && git imerge continue

	... and then
        $ git imerge finish

The imerge program was a bit under-help (yet), and also it was a bit
cumbersome at times having to resolve trivial and obvious two
conflicts in the same file (e.g. the series adds description for
GIT_*_PATHSPECS environment variables to Documentation/git.txt in
two separate patches, and the resolution is obvious for a single
merge, but imerge wants me to resolve them in two steps), but in the
end, after "imerge finish", it produced identical result as my hand
merge, so at least it seems to be doing something right ;-)

A few things I noticed:

 - It was not immediately clear from "git imerge -h" text what the
   simplest "hello world" workflow was.

 - It was not clear what it wanted for --name parameter (it becomes
   the name of the temporary and final branch that stores the
   result).

 - The final step "imerge finish" gave me this ugliness:

     Merge commit 93d9353... into commit cb5d2fc7

   Perhaps you can at least use the initial branch name
   "nd/magic-pathspec" I gave you, and use "git fmt-merge-msg"?

A bigger test will be to try merging jn/add-2.0-u-A-sans-pathspec
and jc/add-2.0-ignore-removal topics on top of the merge result
(2857023 in today's pushout).  These two merges, especially the
latter one, have to involve some "evil merges", so it would be
interesting to see how well it fares.

In any case, thanks for a fun tool.
