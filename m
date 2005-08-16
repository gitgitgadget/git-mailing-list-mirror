From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Change git-branch to list branches
Date: Tue, 16 Aug 2005 14:08:07 -0700
Message-ID: <7vslx98ua0.fsf@assigned-by-dhcp.cox.net>
References: <20050815204430.GA77829@rossby.metr.ou.edu>
	<87hddplqdu.fsf@litku.valo.iki.fi>
	<87d5odlq6l.fsf_-_@litku.valo.iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Amos Waterland <apw@rossby.metr.ou.edu>, junkio@cox.net,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 16 23:08:46 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E58fg-0001nM-GX
	for gcvg-git@gmane.org; Tue, 16 Aug 2005 23:08:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932719AbVHPVIL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 16 Aug 2005 17:08:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932718AbVHPVIK
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Aug 2005 17:08:10 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:1513 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S932719AbVHPVIJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Aug 2005 17:08:09 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050816210807.FKOV550.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 16 Aug 2005 17:08:07 -0400
To: Kalle Valo <Kalle.Valo@iki.fi>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Kalle Valo <Kalle.Valo@iki.fi> writes:

> If no argument provided to `git branch`, show available branches and
> mark current branch with star.

I like the general direction, but this particular implementation
may be a bit troublesome.

> +if [ -z "$branchname" ]; then
> +    current=$(basename $(readlink $GIT_DIR/HEAD))
> +    cd $GIT_DIR/refs/heads &&
> +    ls | sed -e "s/^/  /" -e "s/  $current/* $current/"
> +    exit
> +fi

I do not think we have agreed to limit ourselves to a flat
namespace under refs/heads without subdirectories.  Something
like what git-show-branches-script does when $# == 0, perhaps?
