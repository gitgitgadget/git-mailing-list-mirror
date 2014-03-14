From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: question about: Facebook makes Mercurial faster than Git
Date: Fri, 14 Mar 2014 19:58:15 +0700
Message-ID: <CACsJy8CP57WqQ1k3jhqZpypua0RimJbE2K5K=WCyheDMk=5L+g@mail.gmail.com>
References: <531D8ED9.7040305@gmx.net> <CANgJU+W+f3KUxehDGxd+f77RO24VadsnOV=szE2MkBXjs8wDCQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Dennis Luehring <dl.soluz@gmx.net>, Git <git@vger.kernel.org>
To: demerphq <demerphq@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 14 13:58:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WORhN-0007Sf-Ax
	for gcvg-git-2@plane.gmane.org; Fri, 14 Mar 2014 13:58:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754638AbaCNM6t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Mar 2014 08:58:49 -0400
Received: from mail-qc0-f182.google.com ([209.85.216.182]:45200 "EHLO
	mail-qc0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754328AbaCNM6r (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Mar 2014 08:58:47 -0400
Received: by mail-qc0-f182.google.com with SMTP id e16so2786412qcx.13
        for <git@vger.kernel.org>; Fri, 14 Mar 2014 05:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=uDXufASoaw3ttzYinP3lnp1DpfCBfjWNMoOusgOTFnE=;
        b=Vl4JxaSztyYTeCvKd0oa90eBYW7bzoP47yvPec1fCaUYWRZzZueS6JQZCdp2lHfps/
         BiS4iEeAGw6WQeSpkKuab69d3k1Ds6wfqw2ju62P3UvjhLNV/ssWc+4hNw8BMXAnUhxk
         fV6e0npIOTCKS1o4Jt1cJTVa6lv4Lt1Vn1GvC37LS+Q6b99GOtcXzlp9WkI7ghRK2Ycj
         gNaCTdGG5+kflLwACgcZc08Qajv8crbEXl2EtxcJC8pSobxt+ex9B6QS40qJ8xlREKC4
         JFvXqVV+hPsTUIDz9rvLCSUm+9/GHC6bqf4So7pX6HAhZQxFWh9y8ACCLSQfsjHDWd+D
         yGHg==
X-Received: by 10.229.236.194 with SMTP id kl2mr2258792qcb.15.1394801926525;
 Fri, 14 Mar 2014 05:58:46 -0700 (PDT)
Received: by 10.96.146.102 with HTTP; Fri, 14 Mar 2014 05:58:15 -0700 (PDT)
In-Reply-To: <CANgJU+W+f3KUxehDGxd+f77RO24VadsnOV=szE2MkBXjs8wDCQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244088>

On Mon, Mar 10, 2014 at 6:28 PM, demerphq <demerphq@gmail.com> wrote:
> I had the impression, and I would not be surprised if they had the
> impression that the git development community is relatively
> unconcerned about performance issues on larger repositories.
>
> There have been other reports, which are difficult to keep track of
> without a bug tracking system, but the ones I know of are:
>
> Poor performance of git status with large number of excluded files and
> large repositories.

I thought this has been improved lately.. I think we could do better
still, but my wip is nowhere ready for anybody's eyes.

> Poor performance, and breakage, on repositories with very large
> numbers of files in them.

index v5 and sparse checkout should help a bit. The ultimate solution,
though, is narrow clone that's nowhere near finishing. Well, if you
need all files present in worktree, then narrow clone does not help
either..

On the same line, poor performance on repos with a lot of very large
files also. Junio's split-blob series was a start, but no one picked
it up, so I guess your impression was right.

> (Rebase for instance will break if you rebase a commit that contains a *lot* of files.)

Interesting. I guess it hits shell's limitations? Roughly how many
files to break it?

> Poor performance in protocol layer (and other places) with repos with
> large numbers of refs. (Maybe this is fixed, not sure.)

Ah.. no it's not. It's being stirred up again though, in both protocol
and ref backend.
-- 
Duy
