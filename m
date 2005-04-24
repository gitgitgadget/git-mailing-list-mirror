From: David Lang <david.lang@digitalinsight.com>
Subject: Re: Hash collision count
Date: Sun, 24 Apr 2005 00:56:24 -0700 (PDT)
Message-ID: <Pine.LNX.4.62.0504240053480.32437@qynat.qvtvafvgr.pbz>
References: <426AAFC3.800@pobox.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Git Mailing List <git@vger.kernel.org>,
	Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Sun Apr 24 09:51:51 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DPbu8-0001nd-VU
	for gcvg-git@gmane.org; Sun, 24 Apr 2005 09:51:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262286AbVDXH4h (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Apr 2005 03:56:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262287AbVDXH4g
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Apr 2005 03:56:36 -0400
Received: from warden-p.diginsite.com ([208.29.163.248]:32472 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP id S262286AbVDXH4e
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Apr 2005 03:56:34 -0400
Received: from wlvims01.diginsite.com by warden.diginsite.com
          via smtpd (for vger.kernel.org [12.107.209.244]) with SMTP; Sun, 24 Apr 2005 00:56:34 -0700
Received: by calexc01.diginsite.com with Internet Mail Service (5.5.2657.72)
	id <JDHLYCH0>; Sun, 24 Apr 2005 00:56:25 -0700
Received: from dlang.diginsite.com ([10.201.10.67]) by wlvexc00.digitalinsight.com with SMTP (Microsoft Exchange Internet Mail Service Version 5.5.2657.72)
	id J2V6XWM2; Sun, 24 Apr 2005 00:56:24 -0700
To: Jeff Garzik <jgarzik@pobox.com>
X-X-Sender: dlang@dlang.diginsite.com
In-Reply-To: <426AAFC3.800@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sat, 23 Apr 2005, Jeff Garzik wrote:

> Ideally a hash + collision-count pair would make the best key, rather than 
> just hash alone.
>
> A collision -will- occur eventually, and it is trivial to avoid this problem:
>
> 	$n = 0
> 	attempt to store as $hash-$n
> 	if $hash-$n exists (unlikely)
> 		$n++
> 		goto restart
> 	key = $hash-$n
>
> Tangent-as-the-reason-I-bring-this-up:
>
> One of my long-term projects is an archive service, somewhat like Plan9's 
> venti:  a multi-server key-value database, with sha1 hash as the key.
>
> However, as the database grows into the terabyte (possibly petabyte) range, 
> the likelihood of a collision transitions rapidly from unlikely -> possible 
> -> likely.
>
> Since it is -so- simple to guarantee that you avoid collisions, I'm hoping 
> git will do so before the key structure is too ingrained.

Jeff, this can't work becouse you don't know what objects exist on other 
servers, in fact given the number of different repositories that will 
eventually exist the odds are good that when the colision occures it will 
be when object repositories get combined,

David Lang
-- 
There are two ways of constructing a software design. One way is to make it so simple that there are obviously no deficiencies. And the other way is to make it so complicated that there are no obvious deficiencies.
  -- C.A.R. Hoare
