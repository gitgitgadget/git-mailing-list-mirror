From: A Large Angry SCM <gitzilla@gmail.com>
Subject: git-rev-list --merge-order bug?
Date: Wed, 29 Jun 2005 15:14:18 -0400
Message-ID: <42C2F30A.7030102@gmail.com>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Wed Jun 29 21:07:49 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dnhu3-0001kF-P5
	for gcvg-git@gmane.org; Wed, 29 Jun 2005 21:07:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262432AbVF2TOY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 29 Jun 2005 15:14:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262433AbVF2TOY
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Jun 2005 15:14:24 -0400
Received: from wproxy.gmail.com ([64.233.184.192]:6663 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262432AbVF2TOU (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 29 Jun 2005 15:14:20 -0400
Received: by wproxy.gmail.com with SMTP id 57so837120wri
        for <git@vger.kernel.org>; Wed, 29 Jun 2005 12:14:20 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:disposition-notification-to:date:from:reply-to:user-agent:x-accept-language:mime-version:to:subject:content-type:content-transfer-encoding;
        b=q80E+xSnNn/8NshEZgACCoPza80LMjIU+iv5oMZfN5lmRbAzg6dyoTR5eQvJQkkRohkdgLeTT/1aT/6Ehz7NDpRF6kHX7qRYuy+2bMADprZ6Gcnj5ZgEi+U0aBCfgPTG2mZ/tg4pi0piBk4RPUI3/d8NyhmZ5yWsR4jnEmXNUAs=
Received: by 10.54.24.3 with SMTP id 3mr186347wrx;
        Wed, 29 Jun 2005 12:14:20 -0700 (PDT)
Received: from ?10.0.0.6? ([70.89.97.97])
        by mx.gmail.com with ESMTP id 66sm623271wra.2005.06.29.12.14.19;
        Wed, 29 Jun 2005 12:14:20 -0700 (PDT)
User-Agent: Mozilla Thunderbird 1.0 (X11/20041207)
X-Accept-Language: en-us, en
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

I've noticed that git-rev-list will sometimes return a different 
*number* of commit objects depending on whether the "--merge-order" 
switch was used.

For example:

Get a copy of Linus' git git repository from rsync.kernel.org and try 
the following:

git-rev-list ee28152d03f2cf4b5e3ebc25f7f03f9654d3aa0d \
	^aa03413467a2f2ada900817dc2a8e3904549b5fe |wc -l

git-rev-list ee28152d03f2cf4b5e3ebc25f7f03f9654d3aa0d \
	^aa03413467a2f2ada900817dc2a8e3904549b5fe --merge-order |wc -l

The first git-rev-list returns 4 commits and the second returns 304.

Those commits are dated 2005-05-03 and 2005-05-02. If you use gitk, 
search for ``builtin'' which will jump to the merge base of the 2 branches.
