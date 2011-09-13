From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH 1/3] make-static: master
Date: Tue, 13 Sep 2011 23:51:29 +0100
Message-ID: <4E6FDE71.9050606@ramsay1.demon.co.uk>
References: <4E6D0E3F.3090304@ramsay1.demon.co.uk> <7vhb4in4j7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Junio C Hamano <junio@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 14 01:26:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R3cMt-0006G0-Ty
	for gcvg-git-2@lo.gmane.org; Wed, 14 Sep 2011 01:26:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933053Ab1IMX0R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Sep 2011 19:26:17 -0400
Received: from lon1-post-2.mail.demon.net ([195.173.77.149]:49337 "EHLO
	lon1-post-2.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933030Ab1IMX0Q (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 13 Sep 2011 19:26:16 -0400
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by lon1-post-2.mail.demon.net with esmtp (Exim 4.69)
	id 1R3cMo-0001oS-cY; Tue, 13 Sep 2011 23:26:15 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
In-Reply-To: <7vhb4in4j7.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181323>

Junio C Hamano wrote:
> Many symbols that are exported to the global scope do not have to be.
> 
> Signed-off-by: Junio C Hamano <junio@pobox.com>
> ---
>  * To be applied on top of 3793ac5 (RelNotes/1.7.7: minor fixes, 2011-09-07)
> 
[snipped patch]

commit f34196da7b55cbf9f2651e095b6559430aff0baf (make-static: master, 11-09-2011)
in the next branch (at repo.or.cz), but *not* this patch, breaks the build on
cygwin.

The failure is caused by this part of the commit:

    diff --git a/environment.c b/environment.c
    index e96edcf..478f2afa 100644
    --- a/environment.c
    +++ b/environment.c
    @@ -147,11 +147,6 @@ int is_bare_repository(void)
            return is_bare_repository_cfg && !get_git_work_tree();
     }
    
    -int have_git_dir(void)
    -{
    -       return !!git_dir;
    -}
    -
     const char *get_git_dir(void)
     {
            if (!git_dir)

since have_git_dir() is used in compat/cygwin.c (line 117).

ATB,
Ramsay Jones
