From: Junio C Hamano <gitster@pobox.com>
Subject: Re: If you would write git from scratch now, what would you change?
Date: Mon, 26 Nov 2007 13:24:22 -0800
Message-ID: <7vhcj8g0op.fsf@gitster.siamese.dyndns.org>
References: <200711252248.27904.jnareb@gmail.com>
	<858x4l2apc.fsf@lola.goethe.zz>
	<alpine.LFD.0.99999.0711261417580.9605@xanadu.home>
	<854pf8243i.fsf@lola.goethe.zz>
	<20071126195750.GD25784@efreet.light.src>
	<AA5ECB69-3F77-483E-AD19-04A5515779B3@wincent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jan Hudec <bulb@ucw.cz>, David Kastrup <dak@gnu.org>,
	Nicolas Pitre <nico@cam.org>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Mon Nov 26 22:25:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IwlRq-0004pX-Uw
	for gcvg-git-2@gmane.org; Mon, 26 Nov 2007 22:24:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754319AbXKZVYd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Nov 2007 16:24:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754721AbXKZVYd
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Nov 2007 16:24:33 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:36633 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754353AbXKZVYc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Nov 2007 16:24:32 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 09C6F2F0;
	Mon, 26 Nov 2007 16:24:53 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 3EFF4990D3;
	Mon, 26 Nov 2007 16:24:46 -0500 (EST)
In-Reply-To: <AA5ECB69-3F77-483E-AD19-04A5515779B3@wincent.com> (Wincent
	Colaiuta's message of "Mon, 26 Nov 2007 21:45:16 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66127>

Wincent Colaiuta <win@wincent.com> writes:

> For the benefit of newcomers, I just wish the plumbing was kept a  
> little bit out of sight. You know, porcelain in /usr/bin and plumbing  
> in /usr/libexec or other such place.
>
> It's fine once you've learnt your workflows and know the 10 or 15 Git  
> tools that you'll be using day-to-day; but for people who are just  
> starting off this can be a little bit intimidating:
>
> $ git-<tab>
> Display all 146 possibilities? (y or n)

I'd agree to that but I've always considered this an issue for distros.
We've supported an ability for them to specify a gitexecdir separate
from /usr/bin in our Makefile for almost two years.

The tab completion for bash and zsh would also help you here, but I see
there are quite a few commands that should not be there, and it's time
to clean it up.

	$ git <tab>
        add                   fetch                 push
        am                    filter-branch         rebase
        annotate              format-patch          rebase--interactive
        apply                 fsck                  relink
        archive               gc                    remote
        bisect                get-tar-commit-id     repack
        blame                 grep                  request-pull
        branch                gui                   reset
        bundle                imap-send             resolve
        checkout              init                  revert
        checkout-index        instaweb              rm
        cherry                less                  send-email
        cherry-pick           lg                    shortlog
        citool                log                   show
        clean                 lost-found            show-branch
        clone                 ls-files              show-ref
        co                    ls-remote             stash
        commit                ls-tree               status
        config                merge                 submodule
        convert-objects       mergetool             svnimport
        count-objects         mv                    tag
        describe              name-rev              var
        diff                  pickaxe               verify-pack
        diff-stages           pull                  whatchanged

Perhaps this list can be a starting point...

 contrib/completion/git-completion.bash |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index cad842a..1bba68b 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -359,6 +359,15 @@ __git_commands ()
 		upload-pack)      : plumbing;;
 		write-tree)       : plumbing;;
 		verify-tag)       : plumbing;;
+		annotate)         : use blame;;
+		checkout-index)   : plumbing;;
+		diff-stages)      : plumbing;;
+		get-tar-commit-id) : plumbing;;
+		lost-found)       : deprecated;;
+		rebase--interactive) : plumbing;;
+		relink)           : obsolete;;
+		whatchanged)      : plumbing;;
+		verify-pack)      : plumbing;;
 		*) echo $i;;
 		esac
 	done
