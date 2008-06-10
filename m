From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Recovering from repository corruption
Date: Tue, 10 Jun 2008 22:14:40 +0200
Message-ID: <200806102214.40805.jnareb@gmail.com>
References: <6dbd4d000806101026m458513ecqa8141f509bad7602@mail.gmail.com> <200806102159.02875.jnareb@gmail.com> <6dbd4d000806101303j4b2032ajc6e004e0a82e4db5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Denis Bueno" <dbueno@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 10 22:15:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6AFx-0003tt-0N
	for gcvg-git-2@gmane.org; Tue, 10 Jun 2008 22:15:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754311AbYFJUOy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jun 2008 16:14:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754144AbYFJUOx
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jun 2008 16:14:53 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:63111 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753765AbYFJUOx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jun 2008 16:14:53 -0400
Received: by ug-out-1314.google.com with SMTP id h2so161295ugf.16
        for <git@vger.kernel.org>; Tue, 10 Jun 2008 13:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=yJmbWBQhNBMQg9tL1ZKz/Cy0LJvh+ulR2Zi37vOUCrE=;
        b=QVx2v7NdwTfauwZYeSgClPkAUplKzHip4HXMpigJP1TQ6kf0VKRkjl9bMEJk1PmCPp
         9NipJ1NJM8X4k91oBGvegWTnY1o6V5xLVi3dI/LbEL8xgMVi4+18Ny3TDUN5qQLde3xW
         +OA6leAsdrbcD+ri6ApubR1dlXgsomtCAnSXc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=K8BrzgbzMrY+QziSz/yftJO7AGUACrvcyeC1CciImsViFs4Z7rsJsUj4F6rr+MoO9t
         umKu4O+VDLld5KCShTRG3u1lEM37s2Fj2RGsm+1b+aCHOqGp3AfRiDJ13tOsIOCMpZFE
         GMCcEyVWrD8H1qFO/l6b3wwprjqgNljqBfGgw=
Received: by 10.210.59.14 with SMTP id h14mr4491747eba.13.1213128891175;
        Tue, 10 Jun 2008 13:14:51 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.192.165])
        by mx.google.com with ESMTPS id t12sm13986879gvd.10.2008.06.10.13.14.47
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 10 Jun 2008 13:14:48 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <6dbd4d000806101303j4b2032ajc6e004e0a82e4db5@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84543>

On Tue, 10 Jun 2008, Denis Bueno wrote:
> On Tue, Jun 10, 2008, Jakub Narebski <jnareb@gmail.com> wrote: 
>> Denis Bueno wrote:
>>>
>>> Shouldn't these be unreferenced now that I've run filter-branch?
>>
>> Try to clone this repository (using file:/// pseudo-protocol to force 
>> transfer of objects instead of hardlinking them), and chek if the
>> problem persists in the clone too.  If not, error/missing might be
>> in "garbage".
>>
>> But I'm not sure...
> 
> You're onto something:
> 
> [dorothy.local /tmp <Tue Jun 10> <16:02:08>]
> tmp[176] > git clone file:///Volumes/work/identity.fb/
> Initialized empty Git repository in /tmp/identity.fb/.git/
> remote: Counting objects: 401, done.
> remote: Compressing objects: 100% (364/364), done.
> remote: Total 401 (delta 170), reused 0 (delta 0)
> Receiving objects: 100% (401/401), 233.76 KiB, done.
> Resolving deltas: 100% (170/170), done.
> 
> [dorothy.local /tmp <Tue Jun 10> <16:02:22>]
> tmp[177] > cd identity.fb/
> /tmp/identity.fb
> 
> [dorothy.local /tmp/identity.fb <Tue Jun 10> <16:02:24>]
> identity.fb[178] > git fsck --full
> broken link from  commit 4737fea59fdc8325e09b5206cc7a6ac593446ce3
>               to  commit fe431b4b69453ad9207a5528cf9b9d12ef69c988
> dangling commit 28aa69aafc8ae901e588f6d341b3e6d3558c6d26
> dangling commit 884a8024fbcb9367726abb25f8bb6ac539712d46
> missing commit fe431b4b69453ad9207a5528cf9b9d12ef69c988
> 
> But I've just substituted one error for another.  Are these errors
> easier to fix?

Please remember that in such clone you _don't_ have grafts info (unless
you copy it manually), so it is a good test if you correctly rewrote 
history using git-filter-branch.  So take a look at history in your 
clone using gitk or some similar tool.

In the history you mentioned:

    ...---a---*   b---c---d---*   e---...
           \     /         \     /
            \-X-/           \---/

you should rewritr from 'a'=='X^' to, and including 'e' (and not only 
from 'd').


But if it is not the case I'm afraid I wouldn't be able to offer any 
further insight...

-- 
Jakub Narebski
Poland
