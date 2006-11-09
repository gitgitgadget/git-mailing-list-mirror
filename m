X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Seth Falcon <sethfalcon@gmail.com>
Subject: Re: [PATCH] git-svn: fix dcommit losing changes when out-of-date from svn
Date: Thu, 09 Nov 2006 09:42:03 -0800
Message-ID: <m2r6wcy0t0.fsf@ziti.local>
References: <455277A6.2000404@midwinter.com>
	<20061109091937.GA22853@localdomain>
	<7vfyctkki5.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 9 Nov 2006 17:42:40 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:to:subject:references:from:date:in-reply-to:message-id:user-agent:mime-version:content-type;
        b=K4F4AeprM+Fha8FGqmFF+d3nJ1KWaN6oWuWHoU2COCjxon+kunSws8CO72LGzzcOhLzVH7MQCIto69B4hSANz4ag34f/tXp2WeLXQhWrG0sc7koi7hxsHi8I1L6VI3QuXGflsZk3f0xor7Ct1ilE0F4A4kVjjmSaxn2/ULjzN9M=
In-Reply-To: <7vfyctkki5.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's message of "Thu, 09 Nov 2006 02:00:18 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (darwin)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31198>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GiDuu-0005GB-6c for gcvg-git@gmane.org; Thu, 09 Nov
 2006 18:42:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S966048AbWKIRmQ (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 9 Nov 2006
 12:42:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966049AbWKIRmQ
 (ORCPT <rfc822;git-outgoing>); Thu, 9 Nov 2006 12:42:16 -0500
Received: from ug-out-1314.google.com ([66.249.92.168]:47962 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S966048AbWKIRmP
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 9 Nov 2006 12:42:15 -0500
Received: by ug-out-1314.google.com with SMTP id m3so288966ugc for
 <git@vger.kernel.org>; Thu, 09 Nov 2006 09:42:13 -0800 (PST)
Received: by 10.78.127.6 with SMTP id z6mr1333471huc.1163094132925; Thu, 09
 Nov 2006 09:42:12 -0800 (PST)
Received: from ziti.local ( [140.107.181.122]) by mx.google.com with ESMTP id
 3sm1146746hud.2006.11.09.09.42.11; Thu, 09 Nov 2006 09:42:12 -0800 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Junio C Hamano <junkio@cox.net> writes:
> Eric Wong <normalperson@yhbt.net> writes:
>
>> There was a bug in dcommit (and commit-diff) which caused deltas
>> to be generated against the latest version of the changed file
>> in a repository, and not the revision we are diffing (the tree)
>> against locally.
>>
>> This bug can cause recent changes to the svn repository to be
>> silently clobbered by git-svn if our repository is out-of-date.

Eric, with this patch, is a dcommit operation as safe as a regular svn
commit from an svn working copy?  That is, the commit will abort if
the svn repository has changes that your git-svn/git repo hasn't yet
seen?  I'm pretty sure the answer is yes, but I'd like to be sure :-)

> Steven, I do not interact with real svn repository myself so I
> can only judge from the test in this patch and Steven's test
> case, so it would be more assuring for me if you can confirm it
> fixes the issue for you.

I'm not Steven, but I was reproducing the bug and with Eric's patch, I
get a nice error/abort when I try to dcommit when the svn repos has
relevant changes that I have not fetched yet.

Best,

