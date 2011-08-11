From: David Aguilar <davvid@gmail.com>
Subject: Re: git-mergetool: wrap tools with 3 files only to use the BASE
 file instead of MERGED
Date: Thu, 11 Aug 2011 02:37:32 -0700
Message-ID: <20110811093731.GB29507@gmail.com>
References: <20110810160356.GA32126@ortolo.eu>
 <20110810161211.GC4076@elie.gateway.2wire.net>
 <20110811083835.GA29507@gmail.com>
 <20110811084955.GA31233@elie.gateway.2wire.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Tanguy Ortolo <tanguy+debian@ortolo.eu>, git@vger.kernel.org,
	Sebastian Schuberth <sschuberth@gmail.com>,
	Charles Bailey <charles@hashpling.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 11 11:37:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QrRho-0001LC-Pb
	for gcvg-git-2@lo.gmane.org; Thu, 11 Aug 2011 11:37:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754282Ab1HKJhc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Aug 2011 05:37:32 -0400
Received: from mail-iy0-f170.google.com ([209.85.210.170]:43733 "EHLO
	mail-iy0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753592Ab1HKJhb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Aug 2011 05:37:31 -0400
Received: by iye16 with SMTP id 16so962073iye.1
        for <git@vger.kernel.org>; Thu, 11 Aug 2011 02:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=PLfWHxzJ/XeWzUppbzSV00FJ9kMn+MgljNAtYpNtN5M=;
        b=SW8CmP/6gbgvQP2EShvCUXp6Bja668Kcg+PE6lMRzq9tUkZTzP8NXkKp0ELkM3s2lr
         cXpJ5Mkrs1agQ4tn5MCPX9jX6uu/o51pfOjxNO4a5pAKsC4qiDotdpCDvte+Bd4BZtZt
         o7bnEOa900h2UeuJvzHb/ZOpIx1OB9+L7VmA8=
Received: by 10.42.28.3 with SMTP id l3mr10035743icc.14.1313055450564;
        Thu, 11 Aug 2011 02:37:30 -0700 (PDT)
Received: from gmail.com (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id uo4sm2866600icb.10.2011.08.11.02.37.28
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 11 Aug 2011 02:37:29 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110811084955.GA31233@elie.gateway.2wire.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179097>

On Thu, Aug 11, 2011 at 03:49:55AM -0500, Jonathan Nieder wrote:
> David Aguilar wrote:
> 
> > I think it sounds like a good thing for certain tools.
> > Sebastian mentioned it being fine in ecmerge and bc3.
> > xxdiff also lets you specify the output file, so it
> > probably wouldn't need it either, I think.
> 
> At the risk of taking away the itch for a good feature: meld joined
> the crowd of tools with -o to specify an output file in v1.5.0.
> 
>  http://thread.gmane.org/gmane.comp.gnome.meld.general/1270

What's the best way to use this and not break existing users?

meld v1.5.0 was released in December.
We could parse `meld --version` and use the new --output flag on
newer setups, leaving old setups alone.  That's a lot of
code to carry around but it's nicest to users.

Here's another idea..
mergetool--lib has vimdiff and vimdiff2.  Maybe we can add a new
meld3 tool that uses the --output flag?  Users with older setups
are unaffected. Documentation is changed to mention meld v1.5.0
and the meld3 tool.  New users have to configure :-/

Alternatively, rename the existing meld to meld2 and let the
new style call take over the current meld tool.
Older setups with new git that use meld can adjust their
config.

(and the final option: refactor mergetool--lib into separate
 files.  Yes, we should do that too! ;-))

what do you think?
-- 
					David
