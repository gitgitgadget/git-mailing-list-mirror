From: Brian Norris <computersforpeace@gmail.com>
Subject: Re: [BUG] git-log: tracking deleted file in a repository with
 multiple "initial commit" histories
Date: Thu, 18 Feb 2016 14:27:13 -0800
Message-ID: <20160218222713.GA50021@google.com>
References: <20160216202442.GH21465@google.com>
 <20160216204557.GB27484@sigill.intra.peff.net>
 <20160216212429.GA39536@google.com>
 <20160216222942.GA9014@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Feb 18 23:27:21 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aWX2f-0003nW-4y
	for gcvg-git-2@plane.gmane.org; Thu, 18 Feb 2016 23:27:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756908AbcBRW1R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Feb 2016 17:27:17 -0500
Received: from mail-pf0-f173.google.com ([209.85.192.173]:35273 "EHLO
	mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751357AbcBRW1Q (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Feb 2016 17:27:16 -0500
Received: by mail-pf0-f173.google.com with SMTP id c10so40100037pfc.2
        for <git@vger.kernel.org>; Thu, 18 Feb 2016 14:27:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=ibS5WNKInTSj+oBg1OqyVQhwsb3AgMwjeFORKybHUUg=;
        b=S8GhnkuP8hSOs5zZHKcyqSzYpZ9Z9b+80DamTAU9fRuC47eLp3tPlAyNpRoCXUzv+P
         /JDB9Ht8hVPA81mrT7zPWVRPhVB0hFVbQ9BEEz2B/Ry8MvfHwXHJJET7nkpFNW2a7Ipr
         8xswMLRcBHVdiNwttO48ApeGr1DfKF6meP42XOKcBLbMVjfEQeCnCD5b/bOCc0bPktqE
         cLsJw9r81kdC+tomJyB9cW1I2fOWBWttTyBlQj4C13ogWo49byYxNK0ZgmdZVwYEgNc4
         fGPqlsEifbIJcnWuZvIS/sZ/adjDNfPTmpZODH9gfxfQhAeBIQZ8E4r0gtOEADQZqmzo
         +mVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=ibS5WNKInTSj+oBg1OqyVQhwsb3AgMwjeFORKybHUUg=;
        b=VpTAaKtUWhzZY37OPn656wxnLuQau93G9UFyPhQN4UG+K/EZ4peKw5iYZx0Px3kcrU
         pr/9jrl4IMJ3bQyxRzJT1xPqTP8H2QIbcEeVPGbtk/9Wc0wvMCXvWlfxNcvfcXfoHVFz
         53UI0NWY3+oNiwSf6rVu7SuuKIyio7mpknVfDQLu+BLMOUtfQe6zIJbZkctbpNWvQIdL
         wnbefrH1a7ctBWHS+mEXg+FVMmguKfDb3GcRO4hfxagVRn5Xb+t3NHZnpyoK+Ez9eokV
         aJklWiK85Bo4AhXE/xDu8NJn7Fb3ht6rF5wJzVhIexSciKnFtTgiSWwET3VOfXzl66Wh
         YJGA==
X-Gm-Message-State: AG10YOSpwsMju/y4kKS/Bb9yhh8/cZEZymT6ZFZ41wSfR5XiuokrehAmnX7CvCg8+eB4YA==
X-Received: by 10.98.42.207 with SMTP id q198mr13863292pfq.103.1455834435753;
        Thu, 18 Feb 2016 14:27:15 -0800 (PST)
Received: from google.com ([2620:0:1000:1301:9c6d:194d:d3e3:2ea4])
        by smtp.gmail.com with ESMTPSA id g10sm12579982pfd.92.2016.02.18.14.27.14
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 18 Feb 2016 14:27:15 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20160216222942.GA9014@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286635>

On Tue, Feb 16, 2016 at 05:29:42PM -0500, Jeff King wrote:
> On Tue, Feb 16, 2016 at 01:24:29PM -0800, Brian Norris wrote:
> 
> > On Tue, Feb 16, 2016 at 03:45:57PM -0500, Jeff King wrote:
> > > See the section on History Simplification in git-log. But basically,
> > > when you specify a pathspec, git does not traverse side branches that
> > > had no effect on the given pathspec.
> > 
> > Thanks for the pointer. Is this done primarily for performance reasons,
> > or for UI simplicity (e.g., to avoid some kinds of double-counting)?
> > Seems like it generates unintuitive behaviors, but if it's helping block
> > other unintuitive behaviors, then maybe it can't be resolved easily.
> 
> Both, I think. Try looking at "--full-history" and you will see that it
> has a lot of cruft that is probably not that interesting. But

I wasn't seeing the "cruft" at first, but now I see. It appears, BTW,
that 'git log --full-history -- <path>' gives vastly different commits
than 'git log --full-history --graph -- <path>'. (The latter has a lot
more "cruft" about unrelated merges.) That seems like a weird
inconsistency...

> simplifying further (e.g., with "--simplify-merges") doesn't tell much
> of the whole story (or maybe it does; we do see the final deletion
> there, which is the end state).

git log --full-history --simplify-merges -- init/iptables.conf
and
git log --full-history --simplify-merges --graph --oneline -- init/iptables.conf

give good results for me, showing every commit that actually modifies
the file, AFAICT.

> > FWIW, I quite often use git-log to look at the history of a deleted
> > file. Seems like a pretty big hole if the default behavior is going to
> > prune away the entire history of the file.
> 
> It doesn't normally.

That doesn't really change my statement.

> What happened is that you had two parallel
> histories, and the final state of the file could be explained by
> following the simpler of the two histories (the one where it never
> existed in the first place).

I (sort of) understand what happened. But I disagree that it's a good
default. It's obviously not what the user is asking for.

> > > If you want to see the full history, you can with "--full-history"
> > > (there are some other simplification possibilities, but I don't think
> > > any of them are interesting for your particular case).
> > 
> > --full-history gives me what I want (I'll admit, I didn't read through
> > all the other "History Simplification" documentation). Can I make this
> > the default somehow?
> 
> No, but you can make an alias that includes it.

Sure.

Thanks for the help!

Brian
