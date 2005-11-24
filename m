From: Pavel Roskin <proski@gnu.org>
Subject: Re: [PATCH] gitk: UTF-8 support
Date: Wed, 23 Nov 2005 23:53:15 -0500
Message-ID: <20051123235315.oht0zjidc4ccg8gs@webmail.spamcop.net>
References: <1132719301.12227.5.camel@dv>
	<7v64qi50sw.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Paul Mackerras <paulus@samba.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 24 05:55:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ef97C-0001rG-SG
	for gcvg-git@gmane.org; Thu, 24 Nov 2005 05:53:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751342AbVKXExR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 23 Nov 2005 23:53:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751341AbVKXExR
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Nov 2005 23:53:17 -0500
Received: from mailgate.cesmail.net ([216.154.195.36]:44706 "HELO
	mailgate.cesmail.net") by vger.kernel.org with SMTP
	id S1751342AbVKXExQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Nov 2005 23:53:16 -0500
Received: (qmail 22655 invoked from network); 24 Nov 2005 04:53:15 -0000
Received: from unknown (HELO gamma.cesmail.net) (192.168.1.20)
  by mailgate.cesmail.net with SMTP; 24 Nov 2005 04:53:15 -0000
Received: (qmail 8151 invoked by uid 99); 24 Nov 2005 04:53:15 -0000
Received: from static-68-161-241-229.ny325.east.verizon.net
	(static-68-161-241-229.ny325.east.verizon.net [68.161.241.229]) by
	webmail.spamcop.net (Horde) with HTTP for <proski@spamcop.net@cesmail.net>;
	Wed, 23 Nov 2005 23:53:15 -0500
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v64qi50sw.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
User-Agent: Internet Messaging Program (IMP) 4.0-cvs
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12674>

Hello!

Quoting Junio C Hamano <junkio@cox.net>:

> Pavel Roskin <proski@gnu.org> writes:
>
> > Add gitencoding variable and set it to "utf-8".  Use it for converting
> > git-rev-list output.
>
> Sounds good, but is it necessary?  Unless I am grossly mistaken,
> I am opposed to this patch.
>
> When I run gitk with LANG and/or LC_CTYPE set to ja_JP.utf8 (I
> suspect *whatever*.utf8 would work the same way) on git.git
> repository, I see Lukas's name (originally in iso8859-1 but my
> commit objects have it in utf8) and Yoshifuji-san's name
> (iso2022 converted to utf8) just fine.

I see.  I always use C locale.

> And when I run gitk with LANG and/or LC_CTYPE set to ja_JP.ujis
> (that is another name for EUC-JP) on a toy repository I have
> commit log messages in EUC-JP (I am not recommending that, just
> pointing out a possibility), I can see them just fine.  In that
> test repository, setting locale to *.utf8 would not work.

Then what would you do to work with a repository using utf-8 if the current
locale is not utf-8?

> So I suspect your change breaks projects that use local
> encodings, without fixing or adding anything new.

I'll be away from any sane OS until Monday, but I assume my patch should help
those whose locale is set to an encoding other than utf-8 if they want to use a
repository using utf-8.

Anyway, I see your point.  Not ever git repository uses utf-8.  It is not
enforced by git.

So we have two solutions.  One is to enforce utf-8 locale in git and force all
"offenders" to convert.  That's probably too intrusive for now.

The other solution is to have a publicly available file under .git that would
keep the encoding name for the metadata (user names, logs etc).  gitk could use
that file now.  git could implement conversions a bit later.  Maybe git could
warn about mismatching encoding as the first step.

--
Regards,
Pavel Roskin
