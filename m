From: Johan Herland <johan@herland.net>
Subject: Re: Q. about usage of notes
Date: Tue, 31 Aug 2010 17:53:37 +0200
Message-ID: <201008311753.37433.johan@herland.net>
References: <4C7CB8AF.5080008@atlas-elektronik.com> <201008311107.32278.johan@herland.net> <4C7CD5B8.20602@atlas-elektronik.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Stefan Naewe <stefan.naewe@atlas-elektronik.com>
X-From: git-owner@vger.kernel.org Tue Aug 31 17:53:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OqT9g-0005xe-Vw
	for gcvg-git-2@lo.gmane.org; Tue, 31 Aug 2010 17:53:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932486Ab0HaPxm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Aug 2010 11:53:42 -0400
Received: from smtp.opera.com ([213.236.208.81]:48959 "EHLO smtp.opera.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932422Ab0HaPxm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Aug 2010 11:53:42 -0400
Received: from johanh.eng.oslo.osa (pat-tdc.opera.com [213.236.208.22])
	(authenticated bits=0)
	by smtp.opera.com (8.14.3/8.14.3/Debian-5+lenny1) with ESMTP id o7VFrbOT021660
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 31 Aug 2010 15:53:37 GMT
User-Agent: KMail/1.9.9
In-Reply-To: <4C7CD5B8.20602@atlas-elektronik.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154921>

On Tuesday 31 August 2010, Stefan Naewe wrote:
> On 8/31/2010 11:07 AM, Johan Herland wrote:
> > On Tuesday 31 August 2010, Stefan Naewe wrote:
> >> And why does 'git remove' do that repetetively (is that even a
> >> word...?), i.e. 'git add -m"Note" ; git remove; git remove; git
> >> remove; git remove' creates 5 commit objects under
> >> 'refs/notes/commits' Is that the intended behaviour ?
> >
> > Yes, this is the intended behaviour. Otherwise you would need a
> > separate notes index where you could stage notes changes (with git
> > notes add/remove), and then later commit those notes changes with
> > (the imaginary) git notes commit. This was deemed too
> > cumbersome/complicated, and we settled for the current approach
> > instead.
>
> But if I do:
>
> $ touch file ; git add file ; git commit -m"add file"
>
> and then
>
> $ for n in 1 2 3; do git rm file; git commit -m"rm file"; done
>
> I get:
>
> rm 'file'
> [master 5b24511] rm file
>  0 files changed, 0 insertions(+), 0 deletions(-)
>  delete mode 100644 file
> fatal: pathspec 'file' did not match any files
> # On branch master
> nothing to commit (working directory clean)
> fatal: pathspec 'file' did not match any files
> # On branch master
> nothing to commit (working directory clean)
>
> I don't get 4 commits. That's the part I don't understand :-(
> 
> Just to be clear:
> 
> Of course I do understand why I don't get 4 commits here - I just
> don't understand why I get a commit for every 'git notes remove' even
> if there's nothing to remove.

Ah, that would be a bug in 'git notes remove'. Patch coming soon.

> And to delete the 'notes branch' I can only use 'git update-ref' ?!

Yes, 'git update-ref -d refs/notes/foo' will delete the "foo" notes 
branch.


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
