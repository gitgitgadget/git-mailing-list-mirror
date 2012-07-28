From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 1/8] SVN 1.7 will truncate "not-a%40{0}" to just "not-a".
Date: Sat, 28 Jul 2012 09:16:52 -0500
Message-ID: <20120728141652.GA1603@burratino>
References: <1343468872-72133-1-git-send-email-schwern@pobox.com>
 <1343468872-72133-2-git-send-email-schwern@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com, robbat2@gentoo.org,
	bwalton@artsci.utoronto.ca, normalperson@yhbt.net
To: "Michael G. Schwern" <schwern@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jul 28 16:17:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sv7pL-0001XQ-6w
	for gcvg-git-2@plane.gmane.org; Sat, 28 Jul 2012 16:17:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752454Ab2G1ORC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Jul 2012 10:17:02 -0400
Received: from mail-gh0-f174.google.com ([209.85.160.174]:61930 "EHLO
	mail-gh0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752383Ab2G1ORA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Jul 2012 10:17:00 -0400
Received: by ghrr11 with SMTP id r11so3970505ghr.19
        for <git@vger.kernel.org>; Sat, 28 Jul 2012 07:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=/DZWANel9ntBfcD5MmUJtyyjXKIdnPVPjuO+H97lo3U=;
        b=VAx7niYEeiXWQ7Pw66X3QoKr+YqANRhiT6qUj/9lDO54W6FAQOM/xPMiti9rGxJ/dh
         BnsCvvcI/lruwXHqXVLquOkYepZDJW2puCIWVd+jVoAxJX8edwEvBGq+rn6EP8VrKrmy
         NHSSDPomxxDnLhIt/7HUz/J5cGKkSQQvSuNLAxAFXzm+q3ZlvbUpLIZ9Mev7h5J+DmKz
         HuzHcR8asPR5DuRGH51WvT23iByivhY9cKHQ7mAA04MRcw8CMG+3TDKUouK2yrPv0+2S
         NrtfW2Yev+r4LQTd5BDBGBSy6MYtInOKFasssUu7hSxEwYU9iM3R875/y1RE8anBbms/
         wc4Q==
Received: by 10.43.64.81 with SMTP id xh17mr3107672icb.48.1343485019951;
        Sat, 28 Jul 2012 07:16:59 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id iw1sm1777821igc.13.2012.07.28.07.16.59
        (version=SSLv3 cipher=OTHER);
        Sat, 28 Jul 2012 07:16:59 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1343468872-72133-2-git-send-email-schwern@pobox.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202439>

Michael G. Schwern wrote:

> Rather than guess what SVN is going to do for each version, make the test use
> the branch name that was actually created.
[...]
> -		git rev-parse "refs/remotes/not-a%40{0}reflog"
> +		git rev-parse "refs/remotes/$non_reflog"

Doesn't this defeat the point of the testcase (checking that git-svn
is able to avoid creating git refs containing @{, following the rules
from git-check-ref-format(1))?

Do you know when SVN truncates the directory name?  Would historical
SVN repositories or historical SVN servers be able to have a directory
named with a %40 in it, or has this been disallowed completely,
leaving problematic historical repositories to be dumped with old SVN,
tweaked, and reloaded with new SVN?

Thanks,
Jonathan
