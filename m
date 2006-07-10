From: Matthias Lederhofer <matled@gmx.net>
Subject: problems GIT_TRACE
Date: Mon, 10 Jul 2006 13:05:35 +0200
Message-ID: <E1Fzta3-00066Z-8B@moooo.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Mon Jul 10 13:06:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FztaS-000483-66
	for gcvg-git@gmane.org; Mon, 10 Jul 2006 13:06:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964786AbWGJLFi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 10 Jul 2006 07:05:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964863AbWGJLFi
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Jul 2006 07:05:38 -0400
Received: from moooo.ath.cx ([85.116.203.178]:58324 "EHLO moooo.ath.cx")
	by vger.kernel.org with ESMTP id S964786AbWGJLFi (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Jul 2006 07:05:38 -0400
To: git@vger.kernel.org
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23607>

I just discovered a problem with GIT_TRACE.  Some scripts redirect
stderr to stdout and the trace messages go with it.  For example from
git-repack:
> name=$(git-rev-list --objects --all $rev_list 2>&1 |
>         git-pack-objects --non-empty $pack_objects .tmp-pack) ||
>         exit 1
Then for example git-pack-objects complains:
> fatal: expected sha1, got garbage:
>  trace: built-in: git 'rev-list' '--objects' '--all'
git-grep '2>&' shows a few other places that do this too, I'll take a
closer look at this later.  Is there any reason to redirect stderr to
stdout?  I think this will always fail with such a strange error
message when something is written to stderr.
