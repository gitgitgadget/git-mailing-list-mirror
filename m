From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: [PATCH] tone down the detached head warning
Date: Thu, 1 Feb 2007 08:44:32 +0000
Message-ID: <200702010844.34500.andyparkins@gmail.com>
References: <Pine.LNX.4.64.0701311405430.3021@xanadu.home> <87wt32ah2e.wl%cworth@cworth.org> <eprbaa$o0m$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 01 09:45:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HCXYu-0001KE-EK
	for gcvg-git@gmane.org; Thu, 01 Feb 2007 09:44:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422696AbXBAIok (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Feb 2007 03:44:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422697AbXBAIok
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Feb 2007 03:44:40 -0500
Received: from ug-out-1314.google.com ([66.249.92.174]:7245 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422696AbXBAIoj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Feb 2007 03:44:39 -0500
Received: by ug-out-1314.google.com with SMTP id 44so405646uga
        for <git@vger.kernel.org>; Thu, 01 Feb 2007 00:44:38 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=SlM/1FXUa7Wa6M61mPpdxytKn+w54q6V5fV8Q+8RQc3eRg9pX4sBMfEARItp4e0Rw6ybSIuDtBs4l+/ekwdBZe6lOkIkcVMdK55g8jMc0OBqnsuJrp4C6GA5B/orx0z5A1uBYFyzozD2KnFcLpkBoDLKCwyNQMzy9v/rZoWH0os=
Received: by 10.66.255.7 with SMTP id c7mr2418443ugi.1170319477897;
        Thu, 01 Feb 2007 00:44:37 -0800 (PST)
Received: from 360run094l ( [194.70.53.227])
        by mx.google.com with ESMTP id 13sm2318283ugb.2007.02.01.00.44.37;
        Thu, 01 Feb 2007 00:44:37 -0800 (PST)
User-Agent: KMail/1.9.5
In-Reply-To: <eprbaa$o0m$1@sea.gmane.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38332>

On Thursday 2007 February 01 00:14, Jakub Narebski wrote:

> Although the fact that clone copies all branches and tags (I don't think
> there is a way to clone only subset of branches), and that fetch is multi

There is, as long as you are willing to organise your branches in a consistent 
way.  I keep all my branches with the prefix "ap/" then on another 
development machine I just have

 pull = refs/heads/ap/*:refs/heads/up/ap/*

In my config.  This means I can make local branches that won't be grabbed 
during the fetch, but still have branches automatically exported.

This actually highlights a weakness in the globbing.  There is no way, for 
example, to grab only unprefixed branches because the glob is blind to path 
dividers (as is usual).  What would be even better would be a two glob 
symbols, one meaning "do cross separators", one meaning "don't".  I think 
rsync solves it for it's include/exclude patterns with a double asterisk.  
That is:

 rsync -av --exclude "foo/*/bar" src/ dest/

Would exclude anything called "bar" two levels under "foo/"; wheras

 rsync -av --exclude "foo/**/bar" src/ dest/

Would exclude anything called "bar" anywhere deeper than two levels 
under "foo".

I haven't thought of a good way of applying this in git though, and I have a 
feeling that it could just complicate things excessively.


Andy

-- 
Dr Andy Parkins, M Eng (hons), MIEE
andyparkins@gmail.com
