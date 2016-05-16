From: Vasily Titskiy <qehgt0@gmail.com>
Subject: Re: [PATCH] Ignore dirty submodule states during stash
Date: Mon, 16 May 2016 15:46:06 +0000
Message-ID: <20160516154606.GA8797@gmail.com>
References: <20160516020735.GA7884@gmail.com>
 <CAGZ79kaTss6ctZDCiRP2wjuxH+rJ79RKFLM79_FJN+37Bed+HQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Mon May 16 17:46:51 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b2Kj8-0000hc-D6
	for gcvg-git-2@plane.gmane.org; Mon, 16 May 2016 17:46:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754193AbcEPPqN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 May 2016 11:46:13 -0400
Received: from mail-yw0-f193.google.com ([209.85.161.193]:36119 "EHLO
	mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754111AbcEPPqJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 May 2016 11:46:09 -0400
Received: by mail-yw0-f193.google.com with SMTP id u62so19970636ywe.3
        for <git@vger.kernel.org>; Mon, 16 May 2016 08:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=w/oWY6NRcwPLqG6GQZZwgNcDeGxHXkUid5XY6B8A1BM=;
        b=ufwMw1UGioqrWQE8kLqnwrL099SaLoxwsTyEGfVQGwBLp4ITamS6sFnueePIJOB5xr
         K59sWbkNFRqFUdQ31y+B0uylJkQ2yBamGlLg/NueIjNCnMBkUrVNPA8yqRucNi7XkcXs
         4eepa5TsDt3XvljCHACpMHBTryrFGpVf0MuUOMroe+Y+XmTZcmxiwe4HxahvXHwAuWRB
         fT8kEATh61oorIZzf7O/ZGO91/GgIfNDRLVhLurbOOpryZ+rROXe6Vze5L3lB1s36KXE
         sAw2J9KCfScptiVs0jgYsrufmBTKaA4XrKDb1JxCLNxheyRddo0+78wUfaBkqGOK3p9r
         gBCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=w/oWY6NRcwPLqG6GQZZwgNcDeGxHXkUid5XY6B8A1BM=;
        b=CzmQdDKUW8LSlM1Br0SiUBdbJnwvHIAqWIRuqZmwwn+HeCXkhTdIrpn/DTAsMPbrFu
         iHhIb3GOJFRvTHhh0w4QaEW1N6poiUHaxyxc4zS/WfL/Dm2YH7GA2+LRWycWm6s8tUvo
         Idd389A/tuWhY8oAvZTfquOuhbXXl6grwmCBfOZXEVk8Iwj44Q2f2QJwNJdaeSRemjY2
         S+SdBNHdZ1ypc+AHY2TNyfitX3153j/jAF5ZLxDCn6QZiQFik+dFiR4WiBjiYcOBbq9Z
         Yn5BehfP3m+KP+ugKX6LMKQ1wSKeVwq2MpK8K3MCK1ZsXP29iwnTu6sYIA4qNMq1j3rS
         XECQ==
X-Gm-Message-State: AOPr4FX3CBV4zReqdbKtiRMRvhIgH9GqEzDnUr0gRCYheHTO6g+l5NfbfGad0s77ynukHA==
X-Received: by 10.13.243.5 with SMTP id c5mr16712493ywf.40.1463413568409;
        Mon, 16 May 2016 08:46:08 -0700 (PDT)
Received: from gmail.com ([2600:3c02::f03c:91ff:fe96:da77])
        by smtp.gmail.com with ESMTPSA id d68sm19637967ywe.53.2016.05.16.08.46.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 May 2016 08:46:08 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAGZ79kaTss6ctZDCiRP2wjuxH+rJ79RKFLM79_FJN+37Bed+HQ@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294743>

Hi Stefan,

On Sun, May 15, 2016 at 11:37:20PM -0700, Stefan Beller wrote:
> On Sun, May 15, 2016 at 7:07 PM, Vasily Titskiy <qehgt0@gmail.com> wrote:
> > Do not save states of submodules as stash should ignore it.
> 
> Can you explain why this is a good idea?
> (It is not obvious to me either way.)
Actually, submodules are already ignored by stash, but not fully (it was introduced in commit 6848d58).
Current behavior is counter-intuitive, for example (if one has a project with a submodule):
 $ cd sub1
 $ edit .. commit .. edit .. commit. Alternatively, just checkout some other commit
 $ cd .. # back to main project
 $ git stash save
   No local changes to save
 $ # so, stash declares there are no changes
 $ edit main.cpp
 $ # For example, I need to update my working tree to latest master
 $ git stash save # save local changes of 'main.cpp'...
 $ git pull --recurse-submodules && git submodule update --recursive # update to latest
 $ git stash pop # I expect to get stashed changes for 'main.cpp', but...
   warning: Failed to merge submodule sub1 (commits don't follow merge-base)
   Auto-merging sub1
   CONFLICT (submodule): Merge conflict in sub1

So, this is the issue. Instead of getting my local changes, I got a conflict (and stash is not 
poped out). The root cause is the 'stash' command does not know how to deal with submodules,
but currently it tries to save the state of submodules, and even tries to re-apply the state
(and it fails of course). The proposed solution fixes this behaviour.

All internal tests work fine with the change.


> 
> Do we need a test/documentation updates for this?
I don't think so, 'stash' have never claimed submodule support.

> 
> >
> > Signed-off-by: Vasily Titskiy <qehgt0@gmail.com>
> > ---
> >  git-stash.sh | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/git-stash.sh b/git-stash.sh
> > index c7c65e2..b500c44 100755
> > --- a/git-stash.sh
> > +++ b/git-stash.sh
> > @@ -116,7 +116,7 @@ create_stash () {
> >                         git read-tree --index-output="$TMPindex" -m $i_tree &&
> >                         GIT_INDEX_FILE="$TMPindex" &&
> >                         export GIT_INDEX_FILE &&
> > -                       git diff --name-only -z HEAD -- >"$TMP-stagenames" &&
> > +                       git diff --name-only --ignore-submodules -z HEAD -- >"$TMP-stagenames" &&
> >                         git update-index -z --add --remove --stdin <"$TMP-stagenames" &&
> >                         git write-tree &&
> >                         rm -f "$TMPindex"
> > --
> > 2.1.4
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe git" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
