From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Open external merge tool with original file extensions for all three files
Date: Tue, 04 Dec 2007 23:24:27 -0800
Message-ID: <7vve7dzjro.fsf@gitster.siamese.dyndns.org>
References: <1196839153-31084-1-git-send-email-pinir@expand.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>
To: Pini Reznik <pinir@expand.com>
X-From: git-owner@vger.kernel.org Wed Dec 05 08:26:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IzoeK-0006BH-FK
	for gcvg-git-2@gmane.org; Wed, 05 Dec 2007 08:26:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751470AbXLEHYe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Dec 2007 02:24:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751458AbXLEHYe
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Dec 2007 02:24:34 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:59117 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751193AbXLEHYd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Dec 2007 02:24:33 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 464AE2EF;
	Wed,  5 Dec 2007 02:24:54 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id B8E049B225;
	Wed,  5 Dec 2007 02:24:50 -0500 (EST)
In-Reply-To: <1196839153-31084-1-git-send-email-pinir@expand.com> (Pini
	Reznik's message of "Wed, 5 Dec 2007 09:19:13 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67117>

Pini Reznik <pinir@expand.com> writes:

> Before this fix conflicted files were open in external merge tool with temporal extensions like REMOTE.$$ and LOCAL.$$.
> This way meld was unable to recognize these files and syntax highlighting feature was unusable.
>
>
> Signed-off-by: Pini Reznik <pinir@expand.com>

I have to wonder if it is fashionable to use overlooooong lines on this
list today...  Please linewrap commit log message.

Ted, you added meld from the beginning to git-mergetool.  Does the patch
look good?

> ---
>  git-mergetool.sh |    9 +++++----
>  1 files changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/git-mergetool.sh b/git-mergetool.sh
> index 5587c5e..2f31fa2 100755
> --- a/git-mergetool.sh
> +++ b/git-mergetool.sh
> @@ -152,10 +152,11 @@ merge_file () {
>  	exit 1
>      fi
>  
> -    BACKUP="$path.BACKUP.$$"
> -    LOCAL="$path.LOCAL.$$"
> -    REMOTE="$path.REMOTE.$$"
> -    BASE="$path.BASE.$$"
> +    ext="$$$(expr "$path" : '.*\(\.[^/]*\)$')"
> +    BACKUP="$path.BACKUP.$ext"
> +    LOCAL="$path.LOCAL.$ext"
> +    REMOTE="$path.REMOTE.$ext"
> +    BASE="$path.BASE.$ext"

I realize '.*\(\.[^./]*\)$' might have been better, as the above
expression as written will slurp ".b.c" as ext from "foo.b.c", but
probably for "merger knows the file type with file extension" purpose,
it does not make a difference.
