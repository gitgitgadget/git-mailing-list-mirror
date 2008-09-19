From: Petr Baudis <pasky@suse.cz>
Subject: Default exclude rules for Git
Date: Fri, 19 Sep 2008 16:22:11 +0200
Message-ID: <20080919142211.GE10360@machine.or.cz>
References: <1221755370-6817-1-git-send-email-kirr@landau.phys.spbu.ru> <1221755370-6817-2-git-send-email-kirr@landau.phys.spbu.ru> <36ca99e90809181038o74c73121j59849b3f24fe6469@mail.gmail.com> <alpine.LNX.1.00.0809181526190.19665@iabervon.org> <20080919050612.GA4423@roro3>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Bert Wesarg <bert.wesarg@googlemail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Kirill Smelkov <kirr@landau.phys.spbu.ru>
X-From: git-owner@vger.kernel.org Fri Sep 19 16:24:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KggtM-0001qZ-7w
	for gcvg-git-2@gmane.org; Fri, 19 Sep 2008 16:23:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751164AbYISOWR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Sep 2008 10:22:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750927AbYISOWR
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Sep 2008 10:22:17 -0400
Received: from w241.dkm.cz ([62.24.88.241]:54355 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750722AbYISOWR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Sep 2008 10:22:17 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id 98BA1393A370; Fri, 19 Sep 2008 16:22:11 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080919050612.GA4423@roro3>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96289>

On Fri, Sep 19, 2008 at 09:06:12AM +0400, Kirill Smelkov wrote:
> On Thu, Sep 18, 2008 at 03:30:35PM -0400, Daniel Barkalow wrote:
> > It's generally better to put a core.excludesfile entry in your 
> > ~/.gitconfig pointing to a ignore file with editor temporaries for the 
> > editor(s) you personally use. This will then apply to all git projects you 
> > work on.
> 
> Yes, this makes sense, thanks.
> 
> I've had to add the following to my ~/.gitconfig
> 
> [core]
>     excludesfile= /home/kirr/.gitignore-kirr
> 
> 
> because it does not work when '~' is used for $HOME
> 
> [core]
>     excludesfile= ~/.gitignore-kirr # does not work
> 
> 
> Is it intended?
> 
> 
> Still I think since a lot of people have to do the same operation, maybe
> it makes sense to put ignores for popular tools right into project's
> .gitignore.

I'm reluctant to put these universal rules to a project-specific
.gitignores, that doesn't feel like the proper solution to me.

I think it would actually make most sense to insert some conservative
default ignore rules to the Git's stock excludes template. (Or better,
have a single file with default Git's exclude rules. Tools newly
installed on the system could even add their entries there during
installation as Git's quest on world dominations progresses.) I'd
shamelessly propose Cogito's set of default excludes for starters:

	*.[ao]
	.*
	!.git*
	tags
	*~
	#*

(or omit the first line if that feels too C-specific - but I think it
should be extremely rare to find files you _want_ to track even in non-C
projects; and I'd argue anytime that by default ignoring hidden files
is absolutely the sanest thing to do.)

I'm not sure if there wouldn't be opposition from others to this,
though. Especially as Junio is extra-careful about backwards
compatibility now after 1.6.0. :-(

-- 
				Petr "Pasky" Baudis
The next generation of interesting software will be done
on the Macintosh, not the IBM PC.  -- Bill Gates
