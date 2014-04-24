From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [RTC/PATCH] Add 'update-branch' hook
Date: Thu, 24 Apr 2014 13:08:23 -0500
Message-ID: <53595317c11b4_1f7b143d31089@nysa.notmuch>
References: <1398047016-21643-1-git-send-email-felipe.contreras@gmail.com>
 <5355793A.5020000@gmail.com>
 <53558476703cb_5c94d452ec4e@nysa.notmuch>
 <53558A54.4060801@gmail.com>
 <53558ae6f1282_604be1f30cf3@nysa.notmuch>
 <53559020.1050407@gmail.com>
 <53558f6269f91_640076f2f08f@nysa.notmuch>
 <857g6h5ssh.fsf@stephe-leake.org>
 <5356996d12ede_3e5aed7308e5@nysa.notmuch>
 <85mwfc4hab.fsf@stephe-leake.org>
 <535782d95bbed_24448772ec7a@nysa.notmuch>
 <8538h24xdg.fsf@stephe-leake.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
To: Stephen Leake <stephen_leake@stephe-leake.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 24 20:19:05 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WdOEf-0006Mb-Ju
	for gcvg-git-2@plane.gmane.org; Thu, 24 Apr 2014 20:19:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932526AbaDXSSx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Apr 2014 14:18:53 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:61515 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932418AbaDXSSu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Apr 2014 14:18:50 -0400
Received: by mail-ob0-f174.google.com with SMTP id gq1so3070551obb.19
        for <git@vger.kernel.org>; Thu, 24 Apr 2014 11:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:message-id:in-reply-to:references:subject:mime-version
         :content-type:content-transfer-encoding;
        bh=8qzj4R5wBHAApdAamNl4VraIM0k6LLltLRW1eA22NNs=;
        b=kYhtmQ2YUTsj4hCg4zxIMGkPXRaqT5TOR9n3TbmBENnUhoXhlzA0u0c8OxbU0uN5zR
         i117GHMwZKLXiiEM5sw85U0p8b9C6IsyMxktYqtN4wMw8Ngcz5H33Q0weqms2NSpmmFZ
         VAOOtK1NAfNvvCxNmg6DW96vTFBm1OjZou7VkJvAbRgJaN+4dD+W2mlQO9nlABPZQfpE
         VlnS2zM9Vd0se3ZvOf6mndUK6bS2bhHFRLwf1OeHa8SP7np87vpqR9RmWbMBMzHuaXCZ
         vkx61nCAP4cogm4iSZv3QeCP/ZhIxf3rlVWZzIWCNrpDlh8cFnVgiAhWW/boylOlV5E4
         o8VA==
X-Received: by 10.182.104.101 with SMTP id gd5mr2751468obb.54.1398363530344;
        Thu, 24 Apr 2014 11:18:50 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id ii8sm10004126obb.11.2014.04.24.11.18.48
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Apr 2014 11:18:49 -0700 (PDT)
In-Reply-To: <8538h24xdg.fsf@stephe-leake.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246985>

Stephen Leake wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
> 
> >> >> I have a branch which should always be recompiled on update;
> >> >> post-update-branch would be a good place for that.
> >> >
> >> > And why would pre-update-branch not serve that purpose?
> >> 
> >> Because the code that needs to be compiled is not yet in the workspace
> >
> > And it won't be in 'post-update-branch' either.
> 
> Then you are using a very odd definition of "post update"

It's not. The branch was updated, not the workspace.

> >  % git checkout master
> >  % git branch feature-a stable
> >  <- update-branch hook will be called here
> >
> > The hook will get 'feature-a' as the first argument, but the code in the
> > workspace would correspond to 'master'; the checked out branch (pre or post).
> 
> Then the hooks should be called 'pre-branch', 'post-branch'; there is no
> "update" involved.

Of course there is. A 'branch' hook would be triggered when you create a new
branch (e.g. `git branch`), however, it should not be triggered when you update
a branch (e.g. `git rebase`).

> The hook I need is actually "post-merge", since "merge" is the command that
> updates the workspace.

I'd say it's probably 'post-checkout'.

-- 
Felipe Contreras
