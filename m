From: Andy Lowry <andy.work@nglowry.com>
Subject: Re: BUG in git diff-index
Date: Thu, 31 Mar 2016 15:30:48 -0400
Message-ID: <56FD7AE8.4090905@nglowry.com>
References: <loom.20160331T143733-916@post.gmane.org>
 <20160331140515.GA31116@sigill.intra.peff.net>
 <CAJxkE8SVF_ikHqDCh6eHExq=seitHPVpxW2GmPo40jtqWvz1JQ@mail.gmail.com>
 <20160331142704.GC31116@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Mar 31 21:30:57 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aliIx-0006IO-Nw
	for gcvg-git-2@plane.gmane.org; Thu, 31 Mar 2016 21:30:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756904AbcCaTav (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Mar 2016 15:30:51 -0400
Received: from mail-qg0-f66.google.com ([209.85.192.66]:35592 "EHLO
	mail-qg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756277AbcCaTau (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Mar 2016 15:30:50 -0400
Received: by mail-qg0-f66.google.com with SMTP id b32so7791647qgf.2
        for <git@vger.kernel.org>; Thu, 31 Mar 2016 12:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nglowry-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=aW3ahF1E2tlCyTl6DNdGdS6Q8yGhuG/YHStEB8iZ430=;
        b=CRqmIol2ZEhsqLOSnFBthG+7px1XIrdnJGgbfhFtIn0ebyIga6JIB/szEXbmqoEYMc
         T5sZjaKpgzTVRSTdLTuJ9iOjHcv30bcZ9LTA/im6KQ1u60O+mam8TPgTxgNc7Aho9f1I
         Kq8L1hNXO3yEyZr6dkKONRnnEHS9rkPolXKxhqhtY0EyAtuFDZfZIN5rQvVgPPPahjO9
         KVefzjsWJO3p5kuv3MiEO04akHSVWLeY1rzwEojgb3qpjaq+484Bndq4jI2ENaHSCwuM
         DK/xMmpeh8yWkinUJdC7PdjU7E3P2cG5wCDIbPqy6Wxs38I/Nfg1s5E7hpfKkhVdGwzP
         ASnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=aW3ahF1E2tlCyTl6DNdGdS6Q8yGhuG/YHStEB8iZ430=;
        b=fP4i3/xyRlp+FHyJvQFLD5CuzUKck2VuE+4Hwl+cspp0lWeFRc8t3lzySn8qnDoCGI
         kYS6/0sjEg5S6uDxIBl10IhIWHgZ0ckEyJhVH2Z87oDJekCoBtkELhDPHZcSNaEiCsgj
         0UR2jGC92foC2BCsmgK8d/j5u86hRG4FQK6307pQq9d9uVqX/1lJk3NGfa9bHmgCxGZD
         GR2iHJHn3v5yVSvDnL3AQ8k0snrsTPYMnPINzgy1FiYyAaSDODWl+abSirU7xUIz8oeo
         0nF/ttMCY/7InvL74Jn2m4LCTSH1BAm2pYwuGKNdRPMiRe/M7qa8f/HOOqBhqard0jU4
         2NSA==
X-Gm-Message-State: AD7BkJKIlPpFhfXi4ZMuWz+PM+Vp8XNUWaaH5VFPQbU9aZjrAzZDwpgA2/W7KyOToUatsA==
X-Received: by 10.141.3.11 with SMTP id f11mr20083889qhd.90.1459452649681;
        Thu, 31 Mar 2016 12:30:49 -0700 (PDT)
Received: from [127.0.0.1] (ool-4574ffea.dyn.optonline.net. [69.116.255.234])
        by smtp.googlemail.com with ESMTPSA id x10sm4065001qhc.42.2016.03.31.12.30.48
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 31 Mar 2016 12:30:48 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.1
In-Reply-To: <20160331142704.GC31116@sigill.intra.peff.net>
X-Antivirus: avast! (VPS 160331-1, 03/31/2016), Outbound message
X-Antivirus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290453>

OK, great. I think the update-index command is what I need.

If you'll indulge me, I'll describe my use-case in detail, and if you 
see anything screwy about it, I'd appreciate feedback. But don't feel 
obligated - you've been a great help already.

This is all about publishing updates to a static web site hosted as a 
gh-pages branch on a github repo.

Our master branch has everything that goes into building the site, and 
we use subtree push to update gh-pages with the embedded subtree that 
contains the generated site.

I'm creating a bash script that does the publishing, and as a general 
rule, we want to publish only from the master branch, and only if it's 
clean and up-to-date. And we also want to make sure that the embedded 
site reflects the current source content.

It's in that last requirement where diff-index comes in. The script runs 
a site build, and then should fail the policy check if that results in 
any changes to the working tree (including the embedded site)/. /I don't 
want the script to change the index in any way (e.g. so that unintended 
changes revealed by this policy check are less likely to be accidentally 
commited).

If I understand correctly, the update-index operation you indicated will 
not change index membership at all, but will simply resync the index 
members with actual working tree files.

So I think now that the script should do "update-index --refresh" 
followed by "diff-index --quiet HEAD". Sound correct?

Andy

On 3/31/2016 10:27 AM, Jeff King wrote:
> On Thu, Mar 31, 2016 at 10:12:07AM -0400, Andy Lowry wrote:
>
>> What I'm actually after is a tree-to-filesystem comparison, regardless
>> of index. I've currently got a "diff" thrown in as a "work-around"
>> before "diff-index", but  now I understand it's not a workaround at
>> all. If there's a better way to achieve what I'm after, I'd appreciate
>> a tip. Otherwise I'll just change the comments explaining why there's
>> a "diff" in my script.
> If your workaround is just to refresh the index, then you can do "git
> update-index --refresh", rather than diff.
>
> I don't think there is a plumbing command to do a direct
> filesystem-to-tree comparison without having an index at all. "git diff
> <treeish>" claims in the documentation to do so, but besides not being
> plumbing, I think it is really just doing the same thing as diff-index,
> under the hood. The index is a pretty fundamental part of git's view of
> the working tree.
>
> -Peff
