From: Artur Skawina <art.08.09@gmail.com>
Subject: Re: [PATCH 0/7] block-sha1: improved SHA1 hashing
Date: Fri, 07 Aug 2009 02:53:53 +0200
Message-ID: <4A7B7B21.1000001@gmail.com>
References: <alpine.LFD.2.01.0908060803140.3390@localhost.localdomain> <4A7B1166.8020507@gmail.com> <alpine.LFD.2.01.0908061052320.3390@localhost.localdomain> <4A7B2A88.2040602@gmail.com> <alpine.LFD.2.01.0908061233360.3390@localhost.localdomain> <4A7B384C.2020407@gmail.com> <alpine.LFD.2.01.0908061329320.3390@localhost.localdomain> <4A7B4D84.80906@gmail.com> <4A7B509A.5010405@gmail.com> <alpine.LFD.2.01.0908061502570.3390@localhost.localdomain> <4A7B5F4C.30102@gmail.com> <alpine.LFD.2.01.0908061559120.3390@localhost.localdomain> <alpine.LFD.2.01.0908061609340.3390@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Aug 07 02:54:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MZDif-0000CC-JZ
	for gcvg-git-2@gmane.org; Fri, 07 Aug 2009 02:54:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754395AbZHGAx6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Aug 2009 20:53:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754177AbZHGAx5
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Aug 2009 20:53:57 -0400
Received: from mail-bw0-f213.google.com ([209.85.218.213]:65005 "EHLO
	mail-bw0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754093AbZHGAx5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Aug 2009 20:53:57 -0400
Received: by bwz9 with SMTP id 9so1111285bwz.41
        for <git@vger.kernel.org>; Thu, 06 Aug 2009 17:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :x-enigmail-version:content-type:content-transfer-encoding;
        bh=rYhihnrvS1sCS3u8HQe5XxlTKYIGtLhAPUM+6jGPSmU=;
        b=rTGQ/XwPQIKIKJ2oyKXYalc6CWQx6FtkKOijWpkr30zsmsctwZyyrl62puHtWIU1HV
         ovTArJ2LEwwXb0XzurvZ8Jf+qA1WPqjr7OGbXIi2Qovy6kvvyn4feOGoNP+ILnhPG9ZS
         NruaZ2jH+Eqf+ILaBEk630e5lRnCtZsjHvqKY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding;
        b=DkJkKYbE508qx54lOg+qIDB93ISMsGer27O5SDQ/eVRmSo/cbelajAOyaN3r8gS42F
         TX6A1XH6+ux+UOIuJhV8OE514VxXSSwnZk0MT5G4LQTt9x+VCWPY2Ecqfkm2U4udjpYp
         1Nf0cLDCkFQBCmTznAhc4RoFzLRPZsHNrm5xc=
Received: by 10.102.244.4 with SMTP id r4mr216013muh.90.1249606435661;
        Thu, 06 Aug 2009 17:53:55 -0700 (PDT)
Received: from ?172.19.43.221? (ip-89-174-40-138.multimo.pl [89.174.40.138])
        by mx.google.com with ESMTPS id i5sm2424523mue.55.2009.08.06.17.53.54
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 06 Aug 2009 17:53:54 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.22pre (X11/20090422)
In-Reply-To: <alpine.LFD.2.01.0908061609340.3390@localhost.localdomain>
X-Enigmail-Version: 0.95.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125148>

Linus Torvalds wrote:
> 
> Just out of curiosity, does anything change if you change the
> 
> 	B = SHA_ROR(B,2)
> 
> into a
> 
> 	B = SHA_ROR(SHA_ROR(B,1),1)
> 
> instead? It's very possible that it becomes _much_ worse, but I guess it's 

Did try that yesterday, didn't help. Will recheck now.. yep:

before: linus          0.3554       171.7
after:  linus           0.407         150

still true for the current version.

> So optimizing for P4 is often the wrong thing.
> 
> Secondly, P4's are going away. You may have one, but they are getting 
> rare. So optimizing for them is a losing proposition in the long run.

Sure, no argument; it's just that avoiding the P4 pitfalls is usually
not that hard and the impact on other, non-netburst, archs is low.
There are a lot of P4s out there and they're not going away soon.
(i'm still keeping most of my git trees on a P3...)

For generic C code such as this the difference for your i7 was -2% and
+70% for my P4; all the other (but one, i think) optimizations which
worked on P4 also applied to 32-bit i7. As i happen to have a p4 i can
just as well test the code on it, many improvements will likely apply
to other cpus too. That's all, i doubt anybody seriously considered
"optimizing for P4"; there is a reason intel discontinued them :)

The atom is a more important target, but only the asm versions did well
there so far.

artur
