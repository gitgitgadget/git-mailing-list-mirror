From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: t5704: problem with OS X sed
Date: Tue, 06 Mar 2012 13:01:17 -0800 (PST)
Message-ID: <m362ehtpgp.fsf@localhost.localdomain>
References: <E40E6E02-8960-4A10-9E71-28F9CDB120F8@silverinsanity.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Thomas Rast <trast@inf.ethz.ch>,
	BJ Hargrave <bj@bjhargrave.com>
To: Brian Gernhardt <benji@silverinsanity.com>
X-From: git-owner@vger.kernel.org Tue Mar 06 22:01:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S51Vd-0004w8-Eb
	for gcvg-git-2@plane.gmane.org; Tue, 06 Mar 2012 22:01:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031111Ab2CFVBU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Mar 2012 16:01:20 -0500
Received: from mail-we0-f174.google.com ([74.125.82.174]:37150 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031076Ab2CFVBT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Mar 2012 16:01:19 -0500
Received: by wejx9 with SMTP id x9so3336860wej.19
        for <git@vger.kernel.org>; Tue, 06 Mar 2012 13:01:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=nCHhhGjIxiSKD5Q/+HJnBLzo/Df8h4qei6ofqPGUjbk=;
        b=Nx77aPKJgTLFU00qxVQVSZWOgvW5Dkn7ZvUhWwYykR6fYQEUpu1j2F4Z/PPswajPsU
         HfFdTtRPGsjvfbeedm8mIoh8RsHYWRzuQMtq3Xf3jy4PTGDx6cXIaTmB7UyeXFVbmX45
         RN7gZ06SH4O4h22/x5LazRoUyE3v6U/lzAI/ZqhbAWVHPR3q947dTW/lYcC0+ahaqo4J
         5ppxjk5GbNO9xpGlEPhV9Uv6YsjizAOGxoOSOxQhGhzUbRQiNGl+gcrgY52lTStYN2i+
         riqk3XddzJ43ZVXctzVLnOq2G7Lcqyn9pwz4LXiSPNlrzGkgrPSvES0bBcwCsyHJA34T
         3rNw==
Received: by 10.180.79.135 with SMTP id j7mr18290618wix.19.1331067678024;
        Tue, 06 Mar 2012 13:01:18 -0800 (PST)
Received: from localhost.localdomain (abwf76.neoplus.adsl.tpnet.pl. [83.8.229.76])
        by mx.google.com with ESMTPS id fa9sm24295865wib.5.2012.03.06.13.01.16
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 06 Mar 2012 13:01:17 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id q26L0aPb007858;
	Tue, 6 Mar 2012 22:00:46 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id q26L06qc007853;
	Tue, 6 Mar 2012 22:00:06 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <E40E6E02-8960-4A10-9E71-28F9CDB120F8@silverinsanity.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192393>

Brian Gernhardt <benji@silverinsanity.com> writes:

> t5704's newest test has always failed for my on OS X.  It's taken a little while for me to find the time to try to fix it.  Unfortunately, my sed-fu has proven not up to the task:
> 
> sed: 1: "/^-/{p;q}": extra characters at the end of q command
> not ok - 7 ridiculously long subject in boundary
> #	
> #		: >file4 &&
> #		test_tick &&
> #		git add file4 &&
> #		printf "%01200d
> #	" 0 | git commit -F - &&
> #		test_commit fifth &&
> #		git bundle create long-subject-bundle.bdl HEAD^..HEAD &&
> #		git bundle list-heads long-subject-bundle.bdl >heads &&
> #		test -s heads &&
> #		git fetch long-subject-bundle.bdl &&
> #		sed -n "/^-/{p;q}" long-subject-bundle.bdl >boundary &&
> #		grep "^-$_x40 " boundary
> #	
> 
> I've tried various bits of whitespace or splitting the commands in
> two, but haven't hit on the proper combination of commands.
> 
> Of course, if I remove the sed invocation, I get the following error
> from grep: "Regular expression too big"
> 
> It seems to me that using sed to find a single line and then
> grepping for it is somewhat redundant.
> 
> If someone else has suggestions on how to make this test work on OS
> X, I'm happy to help test them.

Thomas Rast proposed a patch to fix this issue, as reported by
BJ Hargrave, in

  Re: [ANNOUNCE] Git 1.7.9.3
  Message-ID: <87y5rd4wci.fsf@thomas.inf.ethz.ch>
  http://thread.gmane.org/gmane.linux.kernel/1262318/focus=192355

as

  [PATCH] t5704: fix nonportable sed/grep usages

HTH
-- 
Jakub Narebski
