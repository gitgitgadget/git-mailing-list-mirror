From: Junio C Hamano <junkio@cox.net>
Subject: Re: FW: Git pulls failing on ia64 test tree?
Date: Wed, 14 Sep 2005 10:47:35 -0700
Message-ID: <7vfys7lex4.fsf@assigned-by-dhcp.cox.net>
References: <B8E391BBE9FE384DAA4C5C003888BE6F046279C5@scsmsx401.amr.corp.intel.com>
	<7vbr2vob6w.fsf@assigned-by-dhcp.cox.net>
	<7vk6hjlfxw.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 14 19:49:24 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EFbMC-0006WA-MI
	for gcvg-git@gmane.org; Wed, 14 Sep 2005 19:47:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030296AbVINRri (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Sep 2005 13:47:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030297AbVINRri
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Sep 2005 13:47:38 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:4282 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S1030296AbVINRrh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Sep 2005 13:47:37 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050914174737.XVJV8185.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 14 Sep 2005 13:47:37 -0400
To: "Luck, Tony" <tony.luck@intel.com>
In-Reply-To: <7vk6hjlfxw.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Wed, 14 Sep 2005 10:25:31 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8544>

Junio C Hamano <junkio@cox.net> writes:

> As a workaround, please do this:
>
>     cd /pub/scm/linux/kernel/git/aegl/linux-2.6.git/
>     ln ../../torvalds/linux-2.6.git/objects/pack/* objects/pack/.
>     mv objects/info/alternates objects/info/alternates+
>     GIT_DIR=. git fetch ../../torvalds/linux-2.6.git/
>     GIT_DIR=. git fsck-objects
>     mv objects/info/alternates+ objects/info/alternates

Actually, please chuck the last step to re-enable alternates.
Otherwise everytime Linus updates his repository you will be out
of sync and will get hit by the same problem.

> The 'git fetch' step would complain about a couple of commits
> you have but there is no need to worry -- we are deliberately
> "corrupting" your repository by temporarily moving alternates
> away so that it can fetch missing objects from Linus repository.
> The fsck-objects should then report no missing objects.
>
> Sorry for this very unpleasant experience git has caused you
> X-<.
