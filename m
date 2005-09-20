From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] Fix git-init-db creating crap directories (zeroth try)
Date: Tue, 20 Sep 2005 03:51:54 +0200
Message-ID: <20050920015154.GA25115@pasky.or.cz>
References: <200509172141.31591.dtor_core@ameritech.net> <432F0D1B.60303@zytor.com> <20050919194445.GD18320@pasky.or.cz> <432F46BE.5000406@zytor.com> <20050919234030.GI18320@pasky.or.cz> <432F50BC.5000304@zytor.com> <20050920000731.GJ18320@pasky.or.cz> <432F5345.3020303@zytor.com> <20050920001949.GL18320@pasky.or.cz> <432F5B07.2060803@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>,
	Dmitry Torokhov <dtor_core@ameritech.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 20 03:53:10 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EHXIp-00008Z-6q
	for gcvg-git@gmane.org; Tue, 20 Sep 2005 03:52:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964818AbVITBv5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Sep 2005 21:51:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964825AbVITBv5
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Sep 2005 21:51:57 -0400
Received: from w241.dkm.cz ([62.24.88.241]:17116 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S964818AbVITBv4 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 Sep 2005 21:51:56 -0400
Received: (qmail 1837 invoked by uid 2001); 20 Sep 2005 03:51:54 +0200
To: "H. Peter Anvin" <hpa@zytor.com>
Content-Disposition: inline
In-Reply-To: <432F5B07.2060803@zytor.com>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8945>

Dear diary, on Tue, Sep 20, 2005 at 02:42:47AM CEST, I got a letter
where "H. Peter Anvin" <hpa@zytor.com> told me that...
> Petr Baudis wrote:
> >>>
> >>>-	memcpy(path, git_dir, len);
> >>>+	memcpy(path, git_dir, len-1);
> >>>+	path[len] = 0;
> >>>	copy_templates_1(path, len,
> >>
> >>Wrong!  You're not initializing path[len-1]!
> >
> >
> >Oops, sorry. That's what you get when you want to make things marginally
> >better. ;-) We indeed want to pass copy_templates_1() the trailing slash
> >as well.
> >
> >Let's just settle with the original patch then.
> >
> 
> But if len is the index of the '/', then you're not.

But fortunately len is not the index of the '/', len-1 is. len is the length
of the leading path fragment including the trailing slash.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
