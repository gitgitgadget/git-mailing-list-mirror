From: Nemina Amarasinghe <neminaa@gmail.com>
Subject: Re: [PATCH] simplified the chain if() statements of =?utf-8?b?aW5zdGFsbF9icmFuY2hfY29uZmlnKCk=?= function in branch.c
Date: Tue, 11 Mar 2014 06:30:04 +0000 (UTC)
Message-ID: <loom.20140311T072612-596@post.gmane.org>
References: <loom.20140310T083649-236@post.gmane.org> <loom.20140310T085652-521@post.gmane.org> <CAPig+cRAqEQ8320Gq2Njoioq5UU=d+W+hzF+YZAZ7Po9XjMq0g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 11 07:30:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WNGD0-00063y-2q
	for gcvg-git-2@plane.gmane.org; Tue, 11 Mar 2014 07:30:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753309AbaCKGae (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Mar 2014 02:30:34 -0400
Received: from plane.gmane.org ([80.91.229.3]:54278 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752382AbaCKGad (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Mar 2014 02:30:33 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1WNGCq-0005y7-QI
	for git@vger.kernel.org; Tue, 11 Mar 2014 07:30:31 +0100
Received: from 61.245.168.21 ([61.245.168.21])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 11 Mar 2014 07:30:28 +0100
Received: from neminaa by 61.245.168.21 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 11 Mar 2014 07:30:28 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 61.245.168.21 (Mozilla/5.0 (Windows NT 6.3; WOW64; rv:27.0) Gecko/20100101 Firefox/27.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243844>

Eric Sunshine <sunshine <at> sunshineco.com> writes:

> 
> On Mon, Mar 10, 2014 at 3:58 AM, Nemina Amarasinghe <neminaa <at>
gmail.com> wrote:
> > Nemina Amarasinghe <neminaa <at> gmail.com> writes:
> >
> > Sorry for the first patch. Something went wrong. This is the correct one
> 
> In addition to the tautological issue pointed out by Matthieu, please
> note that this version of the patch is not the correct one. It won't
> apply to the git code. At a guess, it appears that this patch is
> against some other modification you made to the git code before this
> change, or perhaps you committed it incorrectly. In any event, when
> you resubmit, please be sure that the new version can be applied to
> commit.c as it exists in git.git itself.
> 

Thank you very much for your comments Eric. I will resubmit the patch.

Just a quick question

in this code

if (flag & BRANCH_CONFIG_VERBOSE) {
        if (remote_is_branch && origin)
            printf_ln(rebasing ?
                  _("Branch %s set up to track remote branch %s from %s by
rebasing.") :
                  _("Branch %s set up to track remote branch %s from %s."),
                  local, shortname, origin);
        else if (remote_is_branch && !origin)
            printf_ln(rebasing ?
                  _("Branch %s set up to track local branch %s by rebasing.") :
                  _("Branch %s set up to track local branch %s."),
                  local, shortname);
        else if (!remote_is_branch && origin)
            printf_ln(rebasing ?
                  _("Branch %s set up to track remote ref %s by rebasing.") :
                  _("Branch %s set up to track remote ref %s."),
                  local, remote);
        else if (!remote_is_branch && !origin)
            printf_ln(rebasing ?
                  _("Branch %s set up to track remote ref %s by rebasing.") :
                  _("Branch %s set up to track remote ref %s."),
                  local, remote);
        else
            die("BUG: impossible combination of %d and %p",
                remote_is_branch, origin);
    }

These "local" and "remote" variables are independent from the "origin" right?
So, If that the case couldn't we just use the bellow function


else if (!remote_is_branch)
            printf_ln(rebasing ?
                  _("Branch %s set up to track remote ref %s by rebasing.") :
                  _("Branch %s set up to track remote ref %s."),
                  local, remote);

instead of

else if (!remote_is_branch && origin)
            printf_ln(rebasing ?
                  _("Branch %s set up to track remote ref %s by rebasing.") :
                  _("Branch %s set up to track remote ref %s."),
                  local, remote);
        else if (!remote_is_branch && !origin)
            printf_ln(rebasing ?
                  _("Branch %s set up to track remote ref %s by rebasing.") :
                  _("Branch %s set up to track remote ref %s."),
                  local, remote);

Thanks
Nemina  
