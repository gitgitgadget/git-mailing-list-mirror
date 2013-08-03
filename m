From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: change remote to track new branch
Date: Sat, 3 Aug 2013 10:05:19 -0700
Message-ID: <20130803170519.GC2893@elie.Belkin>
References: <20130803024032.GA28666@analysisandsolutions.com>
 <m2d2pvp7nw.fsf@linux-m68k.org>
 <20130803162821.GA945@analysisandsolutions.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andreas Schwab <schwab@linux-m68k.org>,
	Git Mailing List <git@vger.kernel.org>
To: Daniel Convissor <danielc@analysisandsolutions.com>
X-From: git-owner@vger.kernel.org Sat Aug 03 19:05:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V5fGi-0005X6-8Z
	for gcvg-git-2@plane.gmane.org; Sat, 03 Aug 2013 19:05:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752545Ab3HCRFY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Aug 2013 13:05:24 -0400
Received: from mail-pd0-f179.google.com ([209.85.192.179]:42766 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752505Ab3HCRFY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Aug 2013 13:05:24 -0400
Received: by mail-pd0-f179.google.com with SMTP id v10so1729508pde.24
        for <git@vger.kernel.org>; Sat, 03 Aug 2013 10:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=zOSf0ff5A32d/Lpduo9wMu4ekOZwktAyY/yc0rAAdP8=;
        b=tDN3t0dGmgq3w0dYBXllaHvKcozfXBpQXM4zDrP0veuQ0Sx0bm70Iy/emSQ70+TiFV
         uXM6C6JP/dAkg0KYksirS0cWWu174093Spd84WQf6A/Y5zSuoSb8jDDTXWGv0VG5WR89
         YWjCi1lzqPIMHbTwxvAci6OZvZwnIFx1qTP4pEbAF4a4bLqQS1KDojIzOg5JV87faApM
         J4oW+pJiCALMM8/d3gb30MikdIubuT+12R6w5NNpW+Cudu1hdEBx6fdK+Z7VgcWYtpky
         8hT6uaVfPIwnyM4mAjHOHKznIYiINtIA/ncZp+bmtV6zaIel2sAzvvTRz6KGwxvUA7O6
         hjRA==
X-Received: by 10.68.93.227 with SMTP id cx3mr13947670pbb.146.1375549523485;
        Sat, 03 Aug 2013 10:05:23 -0700 (PDT)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPSA id a5sm17179142pbw.4.2013.08.03.10.05.21
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 03 Aug 2013 10:05:22 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20130803162821.GA945@analysisandsolutions.com>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231608>

Daniel Convissor wrote:
> On Sat, Aug 03, 2013 at 09:14:59AM +0200, Andreas Schwab wrote:

>> Use "git remote set-branches" to change the tracked branches of a
>> remote.  Use "git branch --set-upstream-to" to change the upstream of a
>> branch (or create a new branch from the new upstream).
>
> Thanks.  Those commands were introduced in 1.8.  Is there a way to do it
> in 1.7, please?

"git remote set-branches" was introduced by v1.7.8-rc2~4^2~1.  Are you
stuck on 1.7.2.5, perhaps?  In older (and current) versions of git,
you can control the list of branches tracked by a remote by modifying
its "fetch" refspec in .git/config:

	[remote "origin"]
		url = ...
		fetch = +refs/heads/master:refs/remotes/origin/master
		fetch = +refs/heads/next:refs/remotes/origin/next

"git branch --set-upstream-to" is from v1.8.0-rc0~50^2~4.  In older
versions of git,

	git branch --set-upstream-to=origin/master master

was spelled as

	git branch --set-upstream master origin/master

or the branch's upstream can be set directly in .git/config by
modifying the "remote" and "merge" values in the [branch "foo"]
paragraph.

Hope that helps,
Jonathan
