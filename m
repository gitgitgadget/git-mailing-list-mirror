From: Neal Kreitzinger <nkreitzinger@gmail.com>
Subject: Re: post-update to stash after push to non-bare current branch
Date: Wed, 18 Jan 2012 12:33:44 -0600
Message-ID: <4F171088.4080006@gmail.com>
References: <jf70vc$kol$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Neal Kreitzinger <neal@rsss.com>
X-From: git-owner@vger.kernel.org Wed Jan 18 19:34:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RnaKm-000323-8g
	for gcvg-git-2@lo.gmane.org; Wed, 18 Jan 2012 19:34:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758046Ab2ARSds (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jan 2012 13:33:48 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:37267 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758040Ab2ARSdr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jan 2012 13:33:47 -0500
Received: by yenm6 with SMTP id m6so971150yen.19
        for <git@vger.kernel.org>; Wed, 18 Jan 2012 10:33:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:newsgroups:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=c7j9QLW58xZLfmqw85CBoHyC9I85TtVWrXtd3dUjFgE=;
        b=U444LdtXwBG5ZBjn6Qki7/qvWxwdX/RBAN7Jvho/XSTV79lkEcLEUQ5Sml7qoHyBpJ
         46A21QsagZOTwtSMynWrJi+gdAm7e3qzpKifJ12ZpBidPzihmwC6RX1x67pJPqwjL6uT
         SZdcgOnavgTTRdZMROnNs/OMEkUBxSVcF9diA=
Received: by 10.236.175.36 with SMTP id y24mr32981927yhl.64.1326911626858;
        Wed, 18 Jan 2012 10:33:46 -0800 (PST)
Received: from [172.25.2.210] ([67.63.162.200])
        by mx.google.com with ESMTPS id e66sm44087315yhk.6.2012.01.18.10.33.45
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 18 Jan 2012 10:33:46 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.2.25) Gecko/20111213 Thunderbird/3.1.17
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <jf70vc$kol$1@dough.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188754>

On 1/18/2012 11:53 AM, Neal Kreitzinger wrote:
> We use the worktree of git-repos as the webroot for virtual hosts assigned
> to ports so we can directly test changes to dev and test git-repos.  We have
> some developers who want to develop offline on laptops and push to these
> non-bare repos so they can test their changes.  My plan is to set
> receive.denyCurrentBranch = warn, and then use the post-update hook on the
> remote non-bare to do a stash of the worktree and index.  My assumption is
> that post-update hook only executes after a successful push.  Correct?  I
> only want to stash the non-bare remote work-tree and index after a
> successful push to it (effectively doing a git-reset --hard, but also
> keeping any changes to the worktree/index of the non-bare remote as a safety
> in case someone does directly make uncommitted changes on the non-bare
> remote.)
>
If I manually run git-stash on the non-bare remote after pushing to it 
from a clone (receive.denyCurrentBranch=warn) it works as expected and 
leaves the worktree and index matching the new HEAD.  However, when 
post-update runs the git-stash is leaves the worktree dirty.  (git 1.7.1)

v/r,
neal
