From: Vincent van Ravesteijn <vfr@lyx.org>
Subject: Re: Confusing git log --- First time bug submission please advise on
 best practices
Date: Thu, 6 Feb 2014 17:08:16 +0100
Message-ID: <CAAH6HY8unuytrKpEA-eisojUkG=X4D+o+vQDO5bC5YCSmusoHw@mail.gmail.com>
References: <CAJaBJzJeeEKpaTVXv+LnZd49xjnDjU25y9i_3kKNOrRPVbP-wg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Francis Stephens <francisstephens@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 06 17:08:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WBRVB-00007R-4J
	for gcvg-git-2@plane.gmane.org; Thu, 06 Feb 2014 17:08:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756518AbaBFQIV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Feb 2014 11:08:21 -0500
Received: from mail-ob0-f182.google.com ([209.85.214.182]:58879 "EHLO
	mail-ob0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756515AbaBFQIR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Feb 2014 11:08:17 -0500
Received: by mail-ob0-f182.google.com with SMTP id wm4so2449044obc.13
        for <git@vger.kernel.org>; Thu, 06 Feb 2014 08:08:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=mDcY/Y3uEohxOHn0XwicEuql0d/2WMrQ29dd1F/F0S8=;
        b=FKDkXEWRtym92dbnCwc2hjvIcwdMkKYcoTcy54ZaYiHe0XBd6eml5FesCH0f0/WinP
         T4C43PoA3jlzOqtzWR+g2s8juv0zCmb2/KkVOk4tZLbezrzvX/zgP6YwlIKmUIyuD4Mh
         e8gMSa7EYbRwCOdlCnyJkhtIx+flG6mmZdlUmj5KyJqOPIsDpHWUgzr5j+U0jnXxFgLh
         98JgWcA1LDLg//hKRLzhx24ntt/d6NnJ9GYWt+gcVyzyzberB4iWRnCSmn3uSvU0+act
         zr73eMmG8IYbDfd0teAnx6nTWj0UzZ9YmGRMP2vepCeyc2hAD535mJE5f2rskcGkQnxU
         Qbew==
X-Gm-Message-State: ALoCoQliAlk8UA45SotSqAh69kW7dIQwfSWy9xmuY2CWtzJGJW36ZUab4gbeG4y5jsOeb/TeN0FH
X-Received: by 10.60.45.105 with SMTP id l9mr3273302oem.53.1391702896860; Thu,
 06 Feb 2014 08:08:16 -0800 (PST)
Received: by 10.60.6.105 with HTTP; Thu, 6 Feb 2014 08:08:16 -0800 (PST)
In-Reply-To: <CAJaBJzJeeEKpaTVXv+LnZd49xjnDjU25y9i_3kKNOrRPVbP-wg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241701>

On Thu, Feb 6, 2014 at 3:02 PM, Francis Stephens
<francisstephens@gmail.com> wrote:
>
> My co-worker has an inconsistent git log output. Please see that
> attached files for output (I've made a best effort to remove
> confidential info from them).
>
> Comparing the two log commands we can see that master and
> originssh/master have a shared common commit at
>
> <John Doe> (4 hours ago) d85832d
> More pom fixes
>
> The top commit for originssh/master and the second to top for master.
>
> I would expect that both logs would share an _identical_ history from
> that commit onward. But the log for master contains the following
>
> <Jeremy Doe> (27 hours ago) 239ea21 (my-work)
> renamed class
>
> <Jeremy Doe> (28 hours ago) 27750b2
> Merge branch 'master' of
> http://githost.companyname-dev.local/trading-development/sports-container-framework
>
> and
>
> <Jeremy Doe> (2 days ago) a933acb
> white space changes
>
> <Jeremy Doe> (2 days ago) b5e51e7
> Merge branch 'master' of
> http://githost.companyname-dev.local/trading-development/sports-container-framework
>
> <Jeremy Doe> (2 days ago) 3a0f787
> removed public methods
>
> <Jeremy Doe> (2 days ago) 4e91130
> added the xml deserialisation
>
> None of which appear in the originssh/master log. Is there a scenario
> in which this is expected. It was my understanding that any two
> commits with the same hash have exactly the same history.
>
> Thanks for your time.

The commits that are in the log for master and which are not in the
log for originssh/master are merged in at "6833fd4 (HEAD, master);
Completed merge".

As "git log" can only present the commits in a linear way, it shows
the commits from the ancentry of both parents of HEAD in a reverse
chronological order. This means that the commits from the two
ancestries are mixed and commits that are shown after each other don't
have to be parent and child. See the documentation of "git log" and
the section "Commit Ordering": "By default, the commits are shown in
reverse chronological order."

Vincent
