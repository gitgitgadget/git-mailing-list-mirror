From: Thomas Rast <tr@thomasrast.ch>
Subject: Re: [PATCH] Add a scrollbar for commit history in gitk
Date: Wed, 30 Oct 2013 07:35:01 +0100
Message-ID: <87fvrjgtbe.fsf@linux-k42r.v.cablecom.net>
References: <CAMXp-VN=CMRdXwJ3+LRZegm-bwiDmJd66-YnZb65BNpqyHQCLA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, gitster@pobox.com
To: Nicolas Cornu <ncornu@aldebaran-robotics.com>
X-From: git-owner@vger.kernel.org Wed Oct 30 07:35:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VbPN2-0001Vd-TX
	for gcvg-git-2@plane.gmane.org; Wed, 30 Oct 2013 07:35:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751741Ab3J3GfG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Oct 2013 02:35:06 -0400
Received: from psi.thgersdorf.net ([176.9.98.78]:58547 "EHLO mail.psioc.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751552Ab3J3GfF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Oct 2013 02:35:05 -0400
Received: from localhost (localhost [127.0.0.1])
	by localhost.psioc.net (Postfix) with ESMTP id 6840F4D6516;
	Wed, 30 Oct 2013 07:35:03 +0100 (CET)
X-Virus-Scanned: amavisd-new at psioc.net
Received: from mail.psioc.net ([127.0.0.1])
	by localhost (mail.psioc.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id B2ymaVCGxIyU; Wed, 30 Oct 2013 07:35:01 +0100 (CET)
Received: from linux-k42r.v.cablecom.net.thomasrast.ch (vpn-global-dhcp2-62.ethz.ch [129.132.209.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by mail.psioc.net (Postfix) with ESMTPSA id ACA7A4D6414;
	Wed, 30 Oct 2013 07:35:01 +0100 (CET)
In-Reply-To: <CAMXp-VN=CMRdXwJ3+LRZegm-bwiDmJd66-YnZb65BNpqyHQCLA@mail.gmail.com>
	(Nicolas Cornu's message of "Tue, 29 Oct 2013 14:53:23 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236985>

Hi Nicolas,

Thanks for your patch.

You should Cc Paul Mackerras <paulus@samba.org> on gitk patches.

Nicolas Cornu <ncornu@aldebaran-robotics.com> writes:

> From b3570290bd761a1bf952ea491fa62b123231fe61 Mon Sep 17 00:00:00 2001
> From: Nicolas Cornu <ncornu@aldebaran-robotics.com>
> Date: Tue, 29 Oct 2013 14:51:29 +0100
> Subject: [PATCH] Add a scrollbar for commit history in gitk

You don't need these headers, they'll be taken from the email.  You only
need to put them if they don't agree (e.g., you are sending someone
else's patch).

Can you describe your patch in more detail, and spin a commit message
from it?  My first reaction to "Add a scrollbar for commit history in
gitk" is "there *is* a scrollbar".

The code hints that the scrollbar may be horizontal?  Is this worth the
vertical space it spends?  Should it be optional?  The commit message
should address these questions.

> ---
>  gitk-git/gitk | 8 +++++++-

You should eventually base your patch against the gitk.git repository,
which does not have the toplevel gitk-git/ prefix.

>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/gitk-git/gitk b/gitk-git/gitk
> index d6f5e07..e517253 100755
> --- a/gitk-git/gitk
> +++ b/gitk-git/gitk
> @@ -2124,11 +2124,17 @@ proc makewindow {} {
>      # create three canvases
>      set cscroll .tf.histframe.csb
>      set canv .tf.histframe.pwclist.canv
> +    set cscrollhl .tf.histframe.pwclist.canv.csb
>      canvas $canv \
>      -selectbackground $selectbgcolor \
>      -background $bgcolor -bd 0 \
> -    -yscrollincr $linespc -yscrollcommand "scrollcanv $cscroll"
> +    -yscrollincr $linespc -yscrollcommand "scrollcanv $cscroll" \
> +    -xscrollcommand "scrollcanv $cscrollhl"
>      .tf.histframe.pwclist add $canv
> +    ${NS}::scrollbar $cscrollhl -command {$canv xview} -orient horizontal
> +    if {!$use_ttk} {$cscrollhl configure -highlightthickness 0}
> +    pack $cscrollhl -fill x -side bottom
> +
>      set canv2 .tf.histframe.pwclist.canv2
>      canvas $canv2 \
>      -selectbackground $selectbgcolor \

-- 
Thomas Rast
tr@thomasrast.ch
