From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git-daemon extra paranoia
Date: Tue, 18 Oct 2005 18:18:42 -0700
Message-ID: <7v3bmyl2x9.fsf@assigned-by-dhcp.cox.net>
References: <435560F7.4080006@zytor.com>
	<Pine.LNX.4.64.0510181517280.3369@g5.osdl.org>
	<435591A3.7030708@zytor.com>
	<Pine.LNX.4.64.0510181728490.3369@g5.osdl.org>
	<435596CB.6070401@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed Oct 19 03:19:46 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ES2bP-0005Lw-Lr
	for gcvg-git@gmane.org; Wed, 19 Oct 2005 03:18:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932425AbVJSBSp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 18 Oct 2005 21:18:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932412AbVJSBSp
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Oct 2005 21:18:45 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:44459 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S932425AbVJSBSo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Oct 2005 21:18:44 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051019011820.WKZX29333.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 18 Oct 2005 21:18:20 -0400
To: git@vger.kernel.org
In-Reply-To: <435596CB.6070401@zytor.com> (H. Peter Anvin's message of "Tue,
	18 Oct 2005 17:43:55 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10255>

"H. Peter Anvin" <hpa@zytor.com> writes:

> Consider the whitelist/blacklist scenario I described in the previous 
> email.  You have:
>
> whitelist:	/pub/scm
> blacklist:	/pub/scm/foo/bar.git
>
> If you can bypass the blacklist by using the pathname /pub/scm/foo/bar, 
> that's bad.

I like the simplicity of the check Linus suggested.  Given
/pub/scm/fora/../foo/bar/, you would end up chdir() to
/pub/scm/foo/bar.git and getcwd() would hit the blacklist
entry.  Which almost means that you do not even need path_ok()
;-).
