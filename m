From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCHv4] gitweb: parse project/action/hash_base:filename
	PATH_INFO
Date: Thu, 2 Oct 2008 22:56:03 +0200
Message-ID: <20081002205603.GW10360@machine.or.cz>
References: <1222906234-8182-1-git-send-email-giuseppe.bilotta@gmail.com> <1222906234-8182-2-git-send-email-giuseppe.bilotta@gmail.com> <20081002153403.GQ10360@machine.or.cz> <cb7bb73a0810021230u2ec512c0l577b3146cffccb3e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 02 22:57:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KlVEb-0005iD-Gg
	for gcvg-git-2@gmane.org; Thu, 02 Oct 2008 22:57:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754152AbYJBU4H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Oct 2008 16:56:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754121AbYJBU4G
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Oct 2008 16:56:06 -0400
Received: from w241.dkm.cz ([62.24.88.241]:38169 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753827AbYJBU4F (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Oct 2008 16:56:05 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id 55D703939B47; Thu,  2 Oct 2008 22:56:03 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <cb7bb73a0810021230u2ec512c0l577b3146cffccb3e@mail.gmail.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97373>

On Thu, Oct 02, 2008 at 09:30:42PM +0200, Giuseppe Bilotta wrote:
> On Thu, Oct 2, 2008 at 5:34 PM, Petr Baudis <pasky@suse.cz> wrote:
> 
> > Just nits...
> >> +     }
> >> +
> >>       my ($refname, $pathname) = split(/:/, $path_info, 2);
> >>       if (defined $pathname) {
> >> -             # we got "project.git/branch:filename" or "project.git/branch:dir/"
> >> +             # we got "project.git/action/branch:filename" or "project.git/action/branch:dir/"
> >>               # we could use git_get_type(branch:pathname), but it needs $git_dir
> >>               $pathname =~ s,^/+,,;
> >>               if (!$pathname || substr($pathname, -1) eq "/") {
> >
> > But the old variant is still possible, maybe the comments should
> > indicate that the action/ part is optional.
> 
> I put the action/ part in square brackets. (e.g.
> project.git/[action/]branch:filename). Is this good enough?

That's perfect.

> >> @@ -534,8 +575,9 @@ sub evaluate_path_info {
> >>               $file_name ||= validate_pathname($pathname);
> >>       } elsif (defined $refname) {
> >>               # we got "project.git/branch"
> >> -             $action ||= "shortlog";
> >> -             $hash   ||= validate_refname($refname);
> >> +             $action    ||= "shortlog";
> >> +             $hash      ||= validate_refname($refname);
> >> +             $hash_base ||= validate_refname($refname);
> >>       }
> >>  }
> >>  evaluate_path_info();
> >
> > What is this good for?
> 
> The purpose of what? setting both $hash and $hash_base was something
> that I found was needed in some extreme cases, as discussed with
> Jakub. Proposals for recommended cleaner but equally fast way to
> handle it. If you're referring to the whitespace, I was just lining up
> the entries. Should I do it in a separate patch?

I refer to the setting of $hash_base (I'm not huge fan of the whitespace
aligning, but I don't really care). What extreme cases are these?
I think you should describe that in the code since it's not really
obvious. Maybe I could find it in older threads but I should understand
the code just from reading it. :-)

-- 
				Petr "Pasky" Baudis
People who take cold baths never have rheumatism, but they have
cold baths.
