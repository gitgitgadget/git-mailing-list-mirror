From: Fredrik Kuivinen <freku045@student.liu.se>
Subject: Re: [PATCH] Make sure the diff machinery outputs "\ No newline ..." in english
Date: Mon, 5 Sep 2005 08:01:49 +0200
Message-ID: <20050905060149.GB1875@c165.ib.student.liu.se>
References: <20050904181724.GA23525@c165.ib.student.liu.se> <7vd5nohdp3.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Fredrik Kuivinen <freku045@student.liu.se>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 05 08:03:29 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ECA3J-00048q-W6
	for gcvg-git@gmane.org; Mon, 05 Sep 2005 08:01:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932226AbVIEGBz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Sep 2005 02:01:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932228AbVIEGBz
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Sep 2005 02:01:55 -0400
Received: from [85.8.31.11] ([85.8.31.11]:3024 "EHLO mail6.wasadata.com")
	by vger.kernel.org with ESMTP id S932226AbVIEGBy (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 5 Sep 2005 02:01:54 -0400
Received: from c165 (unknown [85.8.2.189])
	by mail6.wasadata.com (Postfix) with ESMTP
	id 78A3E411C; Mon,  5 Sep 2005 08:06:23 +0200 (CEST)
Received: from ksorim by c165 with local (Exim 3.36 #1 (Debian))
	id 1ECA3B-0000uN-00; Mon, 05 Sep 2005 08:01:49 +0200
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vd5nohdp3.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.6+20040907i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8089>

On Sun, Sep 04, 2005 at 11:48:08AM -0700, Junio C Hamano wrote:
> Fredrik Kuivinen <freku045@student.liu.se> writes:
> 
> > In non-english locales diff(1) do sometimes output "\ No newline at end of
> > file" in some other language. Set LC_ALL to C before execing diff to avoid
> > this behaviour.
> >
> > Signed-off-by: Fredrik Kuivinen <freku045@student.liu.se>
> 
> I was thinking about this when I was examining your other patch.
> 
> What else, other than the incomplete line marker (and timestamp
> output it uses by default, which we disable by passing explicit
> -L flags), are affected by locale in diff output?

After a quick look through the diff source I didn't find anything
else. It's quite possible that I haved missed something though. Most
of the translated messages are related to error reporting, which I
guess might be nice to have in the user specified language.

> Especially, if the diff output is more readable for human
> consumers (i.e. reviewers) without making it harder to use to
> machine consumers (i.e. patch or git-apply) when generated under
> a locale that is 'native' to the data, this patch robs from
> users the possibility of doing so.
> 
> IOW, in a Swedes-only project that tracks a document in Swedish,
> it _might_ be friendlier and more useful to the users if allowed
> generating diffs under sv_SE locale, as long as such a diff does
> not make the processing by patch and git-apply more difficult
> (which your other patch already solved for git-apply).

I agree that it's kind of evil to remove the option of generating the
output in some other language.

Another possibility is to set LC_MESSAGES to C instead. If we go this
way the user can override it by setting LC_ALL. The difference is that
in most configurations the user has to make an active choice to get
the 'native' language output and english will be the default.

- Fredrik
