From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH 6/8 v2] sh-tools: add a run_merge_tool function
Date: Wed, 1 Apr 2009 01:36:49 -0700
Message-ID: <20090401083649.GA30594@gmail.com>
References: <1238400684-14881-1-git-send-email-davvid@gmail.com> <885649360903311115o6131988emdcba6ef215ec0ab0@mail.gmail.com> <200904010011.10296.markus.heidelberg@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: James Pickens <jepicken@gmail.com>, gitster@pobox.com,
	git@vger.kernel.org
To: Markus Heidelberg <markus.heidelberg@web.de>
X-From: git-owner@vger.kernel.org Wed Apr 01 10:38:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LovyL-0006Rs-4c
	for gcvg-git-2@gmane.org; Wed, 01 Apr 2009 10:38:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758011AbZDAIhD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Apr 2009 04:37:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756766AbZDAIhB
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Apr 2009 04:37:01 -0400
Received: from rv-out-0506.google.com ([209.85.198.229]:55979 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753836AbZDAIg7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Apr 2009 04:36:59 -0400
Received: by rv-out-0506.google.com with SMTP id f9so3506970rvb.1
        for <git@vger.kernel.org>; Wed, 01 Apr 2009 01:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=pl4nlW7fUhv10CB8v+1O2gagYzRskP2IEbHfT40Lyes=;
        b=BsZgOjWV7nr0N9M5L76fZ1YhYcM9QDwvh18oOAz9GKX4cr5kSrfTR34eujjs5e9xt9
         FJ2dyyF/0DzTpFNd71DgDcfv2OTzj+6f/SCxncbX6D2rD+5maTC8xHY4S01Xlk4IdufJ
         1vP39nSzet7kDIT0O1dROlVi1yFQhEI7wenxY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=q0WV3QzB4CNzXVPKeYW+mdZ/QGHh1u4wE/c38MrfyVwBszzYpD9C7fqKQXOKhouup8
         m63BdinlT1ynM8vnF5IjVJB9xDKqgWE6arbOmyPRvrgeTtAvXfCdy47qq9O/lCm6x6LI
         4PLbaV4CJAVqWr6BmB/i06fZFYFY6oClhz6cA=
Received: by 10.114.178.13 with SMTP id a13mr5060696waf.88.1238575017525;
        Wed, 01 Apr 2009 01:36:57 -0700 (PDT)
Received: from gmail.com (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id c26sm7091493waa.15.2009.04.01.01.36.56
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 01 Apr 2009 01:36:57 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <200904010011.10296.markus.heidelberg@web.de>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115355>


On  0, Markus Heidelberg <markus.heidelberg@web.de> wrote:
> James Pickens, 31.03.2009:
> > On Mon, Mar 30, 2009 at 1:11 AM, David Aguilar <davvid@gmail.com> wrote:
> > > This function launches merge tools and will be used to refactor
> > > git-(diff|merge)tool.

sorry this whole series is being rewriten...


> > 
> > Thanks for writing difftool; I find it quite useful.  I tried it with
> > tkdiff, and noticed that it shows the 'merge preview' window even though it
> > isn't doing a merge.  If a user with unstaged changes were to carelessly
> > click the 'save and exit' button, his changes could be lost.  So I think
> > it's a good idea to stop the merge preview window from showing up under
> > difftool.  To do that I think you just have to remove the '-o "$MERGED"'
> > option to tkdiff.
> 
> This mail made me see an issue with your patch series. Sorry, I haven't
> seen this earlier, my review was just scratching the surface, I merely
> applied it and looked through it, but didn't actually test it. Lack of
> time.
> 
> The invocations seem to be appropriate only for mergetool, it is just
> the invocations from the old git-mergetool.sh, not from the old
> git-difftool-helper.sh. This means, git-difftool opens 3 files instead
> of 2.
> 
> I think there are preset diff tools, which opened 3 files instead of 2
> before this series (I just tested kdiff3, it opened 3 files). Seems to
> be originated from the fact, that they were initially copied from
> git-mergetool.sh.
> 
> Markus
> 

-- 
		David
