From: Thomas Harning <harningt@gmail.com>
Subject: Git Notes - Track rebase/etc + reverse-lookup for bugs ideas
Date: Mon, 10 Nov 2008 12:37:20 -0500
Message-ID: <6A0F154C-B9FE-4770-BF70-82A5BEBF907C@gmail.com>
Mime-Version: 1.0 (Apple Message framework v929.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 10 18:39:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kzaiq-0000e1-7j
	for gcvg-git-2@gmane.org; Mon, 10 Nov 2008 18:38:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754240AbYKJRh2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Nov 2008 12:37:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754202AbYKJRh2
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Nov 2008 12:37:28 -0500
Received: from ug-out-1314.google.com ([66.249.92.174]:9612 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754163AbYKJRh1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Nov 2008 12:37:27 -0500
Received: by ug-out-1314.google.com with SMTP id 39so457081ugf.37
        for <git@vger.kernel.org>; Mon, 10 Nov 2008 09:37:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:from:to
         :content-type:content-transfer-encoding:mime-version:subject:date:cc
         :x-mailer;
        bh=lXRWyFmI7DUVwPxpatzdP1z0av5oS/RQxSHFhcYefvA=;
        b=PpedF3cUlsPXg0P2HN/FlxdgpGauoWDyoFrRysihoec5/XgcnlhqUwLuudiSeBku5y
         7J64QwZ/13ais5/JqruvWBcHPDN29/FOnX9a6qHawgP8wCfh4a5xHYkN4fX0Lzfi31SM
         uWRYGtq13puntLvrwLVui5LGePQF6hyAihtsg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:from:to:content-type:content-transfer-encoding
         :mime-version:subject:date:cc:x-mailer;
        b=SylvxxgSnYBWHGsTPC/fkxGkiMW38g/MBCU/+tMozk+qIlreLUjOq0HImFOJgNB4hD
         zCvTc7QiJgH7mAPv+nYC/NhSa+0lQZgwESNVT9eYlQuOP15U0t3sA0Nv4k2+b0cNxnrj
         T6Ns7TIOWxsBiay60tNeB72BUBI1lsxKfZfRk=
Received: by 10.67.116.7 with SMTP id t7mr2249584ugm.63.1226338645250;
        Mon, 10 Nov 2008 09:37:25 -0800 (PST)
Received: from ?10.1.10.196? ([75.149.208.122])
        by mx.google.com with ESMTPS id b35sm8349373ugd.33.2008.11.10.09.37.22
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 10 Nov 2008 09:37:23 -0800 (PST)
X-Mailer: Apple Mail (2.929.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100533>

Just wondering, has there been any looking into whether the git-notes  
concept can track rebases?


Reading over what git-notes is leads me to think it could be a good  
mechanism for the distributed bug-tracking idea I had some time ago.
The only gotcha I see is that there would have to be some reverse  
mapping / fast lookup to track the commit objects that given notes are  
attached to.... and to facilitate individual assignment... notes  
applied to notes.


Example structure:

Commits A B C D
Notes   BUG
Notes	nA nC    == bug notes

A <- nA
|\
B C <- nC
|/
D


nA <- BUG
nB <- BUG


Operations for bug-tracking:

1) List all 'BUG'-type items that would refer to individual notes
2) List 'BUG' items reachable from a point
    Perhaps with criterion that a certain 'bug note' attribute is not  
set...
    or that a 'BUG_CLOSED' note is not attached to the given 'bug note'


... this seems to be somewhat of an extreme abuse of the notes  
system... but I could imagine it may have uses outside...
