From: Tim Chase <git@tim.thechases.com>
Subject: Re: Splitting a commit with rebase -i and keeping a commit message
Date: Tue, 16 Apr 2013 22:04:07 -0500
Message-ID: <20130416220407.105b354e@bigbox.christie.dr>
References: <20130416203825.3701d98b@bigbox.christie.dr>
	<CAJDDKr64KpF-DP5Axj+vhxRQ1rrig=pm25T3Angp8GaKK_CHMA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 17 05:02:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USIe4-0001Rj-Tt
	for gcvg-git-2@plane.gmane.org; Wed, 17 Apr 2013 05:02:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965696Ab3DQDCf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Apr 2013 23:02:35 -0400
Received: from boston.accountservergroup.com ([50.22.11.22]:57455 "EHLO
	boston.accountservergroup.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S965690Ab3DQDCc (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Apr 2013 23:02:32 -0400
Received: from 172-0-250-128.lightspeed.rcsntx.sbcglobal.net ([172.0.250.128]:60482 helo=bigbox.christie.dr)
	by boston.accountservergroup.com with esmtpsa (TLSv1:DHE-RSA-AES128-SHA:128)
	(Exim 4.80)
	(envelope-from <git@tim.thechases.com>)
	id 1USIdj-000CVs-GC; Tue, 16 Apr 2013 22:02:31 -0500
In-Reply-To: <CAJDDKr64KpF-DP5Axj+vhxRQ1rrig=pm25T3Angp8GaKK_CHMA@mail.gmail.com>
X-Mailer: Claws Mail 3.7.6 (GTK+ 2.20.1; x86_64-pc-linux-gnu)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - boston.accountservergroup.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - tim.thechases.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221499>

On 2013-04-16 19:29, David Aguilar wrote:
> On Tue, Apr 16, 2013 at 6:38 PM, Tim Chase <git@tim.thechases.com>
> wrote:
> >   git commit -am "Long-bodied commit comment about b.txt changes"
> >   # whoops, just wanted B
> 
> Save the commit's ID here so that we can reuse its message later:
> 
>     orig_commit=$(git rev-parse HEAD)
> 
> >   git rebase -i HEAD^^
> >   # change the "Added b.txt..." commit to "edit"
> >   git reset HEAD^  # pull the changes out of the pending commit
> >   git add a.txt
> >   git commit -m "Tweaked a.txt"
> >   git add b.txt
> >   git commit ${MAGIC_HERE}
> 
> ...reuse the commit message by passing the "-c" option to "git
> commit":
> 
>     git commit --reset-author -c $orig_commit

Wild guess or not, using -c worked great.  With the appropriate
section of the docs now in hand, I discovered that it could even be
simplified to just

  git commit -c ORIG_HEAD [...]

as rebase stashes that information away for me already as "ORIG_HEAD".

Thanks!

-tkc
