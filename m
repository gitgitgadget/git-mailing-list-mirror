From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: git pull (Re: need advice on usage patterns)
Date: Mon, 26 Jul 2010 15:06:13 -0500
Message-ID: <20100726200613.GB1451@burratino>
References: <AANLkTi=g2YNQtiH7+xzqWeoOV6p5r+Nwtt2kkCd3u6JN@mail.gmail.com>
 <20100726033634.GA30877@burratino>
 <201007260916.27306.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Geoff Russell <geoffrey.russell@gmail.com>, git@vger.kernel.org,
	Michael J Gruber <git@drmicha.warpmail.net>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Mon Jul 26 22:07:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OdTxP-0005kF-6S
	for gcvg-git-2@lo.gmane.org; Mon, 26 Jul 2010 22:07:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754914Ab0GZUHW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Jul 2010 16:07:22 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:59197 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752517Ab0GZUHV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Jul 2010 16:07:21 -0400
Received: by vws3 with SMTP id 3so2766629vws.19
        for <git@vger.kernel.org>; Mon, 26 Jul 2010 13:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=PECDIKmJc2jOo107ZNbWLca58itkmOuJiab2q+puXKg=;
        b=WuXrCT1fP7VCDYUY1gmvarw0/1ehQ7+pFQsKHNvmt6wJk0Aj5JzZbLGK8lY3BfH22Q
         xcd37p5L1Xbvy8aRy1wYJdD8nqRW1IKaGvF30gk9FQAkKqm4S1AB37IgvgVN/gyQusY5
         BAuO70RTdxKwjbHwWmWvXos7SWQ5cjgj41D9Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=YjzZVolWaDWk1givk3HElTODuwB0Hw9WyIJA257GWquKRzCq5OlCD9KqKnhdVwcl0v
         3x8czZuPi4ndMKp8jDHv2NSDnhjVp/klRGPQlm7O6fErDcQY01GoNqhBZZnw5boSRB0f
         BbmWh82u1WMT/pud6fgtgK7Npwwcvv3qoiVpM=
Received: by 10.220.121.233 with SMTP id i41mr4501453vcr.3.1280174841214;
        Mon, 26 Jul 2010 13:07:21 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id v11sm2058320vbb.11.2010.07.26.13.07.19
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 26 Jul 2010 13:07:20 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <201007260916.27306.trast@student.ethz.ch>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151890>

Thomas Rast wrote:

> In my ears, "a `git pull` is..." sounds weird.  I would remove the
> 'a'.

Good idea.

> Jonathan Nieder wrote:

>> -*Warning*: Running 'git pull' (actually, the underlying 'git merge')
>> -with uncommitted changes is discouraged: while possible, it leaves you
>> -in a state that is hard to back out of in the case of a conflict.
>[...]
>> +See linkgit:git-merge[1] for details, including how conflicts
>> +are presented and handled.  To cancel a conflicting merge,
>> +use `git reset --merge`.
[...]
>                       Or worse, verify that their git-reset has
> --merge by a quick test (1b5b465 is in 1.6.2) but then find that it
> does not help with backing out of a merge (e11d7b5 is only in 1.7.0!).
> 
> Then again, who reads these manpages anyway?  And we shouldn't let old
> versions get in the way of having consistent and up-to-date docs.  So,

Agh, surely we can do better.  Maybe:

	See linkgit:git-merge[1] for details, including how conflicts
	are presented and handled.

	ifdef::stalenotes[]
	In git 1.7.0 or later, to cancel a conflicting merge, use
	`git reset --merge`.
	*Warning*: In older versions of git, running 'git pull'
	with uncommited changes is discouraged: while possible,
	it leaves you in a state that may be hard to back out of
	in the case of a conflict.
	else::stalenotes[]
	To cancel a conflicting merge, use `git reset --merge`.
	endif::stalenotes[]

with the appropriate corresponding change to todo:dodoc.sh.
