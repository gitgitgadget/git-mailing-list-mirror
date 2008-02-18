From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] opening files in remote.c should ensure it is opening a
 file
Date: Mon, 18 Feb 2008 01:30:39 -0800
Message-ID: <7v3arqr4qo.fsf@gitster.siamese.dyndns.org>
References: <20080208174654.2e9e679c@pc09.procura.nl>
 <e2b179460802080925s61270036q81896010c76236ae@mail.gmail.com>
 <20080208210447.289022b6@pc09.procura.nl>
 <20080218101026.6098667f@pc09.procura.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Mike Ralphson" <mike.ralphson@gmail.com>, git@vger.kernel.org
To: "H.Merijn Brand" <h.m.brand@xs4all.nl>
X-From: git-owner@vger.kernel.org Mon Feb 18 10:31:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JR2LU-0004IZ-W1
	for gcvg-git-2@gmane.org; Mon, 18 Feb 2008 10:31:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751652AbYBRJa4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Feb 2008 04:30:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751494AbYBRJa4
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Feb 2008 04:30:56 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:63785 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751339AbYBRJaz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Feb 2008 04:30:55 -0500
Received: from a-sasl-quonix.pobox.com (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id C1237419C;
	Mon, 18 Feb 2008 04:30:53 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.pobox.com (Postfix) with ESMTP id
 03FD3419A; Mon, 18 Feb 2008 04:30:47 -0500 (EST)
In-Reply-To: <20080218101026.6098667f@pc09.procura.nl> (H. Merijn Brand's
 message of "Mon, 18 Feb 2008 10:10:26 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74253>

"H.Merijn Brand" <h.m.brand@xs4all.nl> writes:

> Most bizarre workaround found for clone (the first 4 failures):
> --8<---
> diff -pur /a5/pro/3gl/LINUX/git-1.5.4/git-clone.sh git-clone.sh
> --- a/git-1.5.4/git-clone.sh  2008-02-02 05:09:01 +0100
> +++ b/git-1.5.4/git-clone.sh  2008-02-18 10:03:26 +0100
> @@ -368,7 +368,8 @@ yes)
>                 '') git-fetch-pack --all -k $quiet $depth $no_progress "$repo";;
>                 *) git-fetch-pack --all -k $quiet "$upload_pack" $depth $no_progress "$repo" ;;
>                 esac >"$GIT_DIR/CLONE_HEAD" ||
> -                       die "fetch-pack from '$repo' failed."
> +                       exit 1
> +                       # die "fetch-pack from '$repo' failed."
>                 ;;
>         esac
>         ;;

That sounds *very* broken.

Is your /bin/sh really a variant of Bourne?

If HP-UX is broken in a similar way as Solaris is, in that it
installs a non-POSIX shell under /bin/sh and offers a Korn in
/bin/ksh, "make SHELL_PATH=/bin/ksh" may help.
