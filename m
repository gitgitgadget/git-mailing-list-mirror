From: Matt McCutchen <matt@mattmccutchen.net>
Subject: Re: [PATCH 1/2] gitweb: allow access to forks with strict_export
Date: Sat, 13 Dec 2008 20:51:15 -0500
Message-ID: <1229219475.3360.51.camel@mattlaptop2.local>
References: <1229203014.31181.7.camel@mattlaptop2.local>
	 <m3prjvg2st.fsf@localhost.localdomain>
	 <7vr64b4sib.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org,
	Petr Baudis <pasky@suse.cz>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Dec 14 02:52:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LBg9s-000839-1O
	for gcvg-git-2@gmane.org; Sun, 14 Dec 2008 02:52:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751633AbYLNBvS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Dec 2008 20:51:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751395AbYLNBvS
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Dec 2008 20:51:18 -0500
Received: from sd-green-bigip-202.dreamhost.com ([208.97.132.202]:57893 "EHLO
	jankymail-a3.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751087AbYLNBvR (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 13 Dec 2008 20:51:17 -0500
Received: from [129.2.207.232] (ml2.student.umd.edu [129.2.207.232])
	by jankymail-a3.g.dreamhost.com (Postfix) with ESMTP id BF95E64D44;
	Sat, 13 Dec 2008 17:51:16 -0800 (PST)
In-Reply-To: <7vr64b4sib.fsf@gitster.siamese.dyndns.org>
X-Mailer: Evolution 2.24.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103040>

On Sat, 2008-12-13 at 14:31 -0800, Junio C Hamano wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
> 
> > Matt McCutchen <matt@mattmccutchen.net> writes:
> >
> > CC-ed Petr Baudis, author of forks support in gitweb.
> >
> >> git_get_projects_list excludes forks in order to unclutter the main
> >> project list, but this caused the strict_export check, which also relies
> >> on git_get_project_list, to incorrectly fail for forks.  This patch adds
> >> an argument so git_get_projects_list knows when it is being called for a
> >> strict_export check (as opposed to a user-visible project list) and
> >> doesn't exclude the forks.
> >>
> >> Signed-off-by: Matt McCutchen <matt@mattmccutchen.net>
> >
> > Looks good for me.
> 
> That sounds like a broken API to me.
> 
> At least, please have the decency to not call the extra parameter "for
> strict export".  I would understand it if the extra parameter is called
> "toplevel_only" (or its negation, "include_forks").
> 
> IOW, don't name a parameter after the name of one caller that happens to
> want an unspecified special semantics, without saying what that special
> semantics is.  Instead, name it after the special semantics that the
> argument triggers.

I disagree.  The parameter is really "include forks (if there is such a
concept under the current config)", and with my second patch, it becomes
"include hidden projects" too.  That's really unwieldy.

In my view, the parameter makes the distinction between generating a
filtered list for user consumption and a list of everything for a
strict_export check.  The particular semantics it activates may evolve
as gitweb does (case in point: my second patch).  The current semantics
can be described in a comment on git_get_projects_list.

Granted, there may be a better name for the parameter than
$for_strict_export.  How about $include_all?

-- 
Matt
