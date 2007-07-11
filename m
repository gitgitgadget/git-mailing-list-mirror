From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Installation failure caused by CDPATH environment variable
Date: Wed, 11 Jul 2007 14:26:19 -0700
Message-ID: <7vejje3a4k.fsf@assigned-by-dhcp.cox.net>
References: <9693D8E9-6F11-4AA1-AFCA-7E8456FA6420@wincent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Wed Jul 11 23:27:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I8jiO-0007v9-7i
	for gcvg-git@gmane.org; Wed, 11 Jul 2007 23:27:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755676AbXGKV0t (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Jul 2007 17:26:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758200AbXGKV0t
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jul 2007 17:26:49 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:61288 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755676AbXGKV0r (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jul 2007 17:26:47 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070711212620.HHCV1399.fed1rmmtao105.cox.net@fed1rmimpo01.cox.net>;
          Wed, 11 Jul 2007 17:26:20 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id NMSK1X00Q1kojtg0000000; Wed, 11 Jul 2007 17:26:20 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52209>

Wincent Colaiuta <win@wincent.com> writes:

>  install: all
>         $(INSTALL) -d -m755 '$(DESTDIR_SQ)$(template_dir_SQ)'
> -       (cd blt && $(TAR) cf - .) | \
> +       cd blt && $(TAR) cf - . | \
>         (cd '$(DESTDIR_SQ)$(template_dir_SQ)' && $(TAR) xf -)
> +       cd -

Actually I suspect replacing the "cd blt" in the original with
"cd ./blt", without changing anything else, would squelch the
CDPATH problem.

We could write it as "$(TAR) Ccf blt - ." if we can rely on the
'C' option, but I suspect it is a GNU extension.  Does anybody
have POSIX.1 handy?
