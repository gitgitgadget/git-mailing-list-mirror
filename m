From: David Greaves <david@dgreaves.com>
Subject: Re: [PATCH Cogito] cg-init breaks if . contains sub-dir
Date: Tue, 10 May 2005 09:42:23 +0100
Message-ID: <428073EF.4090407@dgreaves.com>
References: <20050509233904.GB878@osuosl.org> <pan.2005.05.10.03.41.15.683163@smurf.noris.de> <428043EB.7010004@didntduck.org> <20050510075227.GA8176@lug-owl.de> <20050510080445.GB8176@lug-owl.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Brian Gerst <bgerst@didntduck.org>,
	Matthias Urlichs <smurf@smurf.noris.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 10 10:36:18 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DVQD7-0000ID-FK
	for gcvg-git@gmane.org; Tue, 10 May 2005 10:35:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261584AbVEJImn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 May 2005 04:42:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261585AbVEJImn
	(ORCPT <rfc822;git-outgoing>); Tue, 10 May 2005 04:42:43 -0400
Received: from s2.ukfsn.org ([217.158.120.143]:21654 "EHLO mail.ukfsn.org")
	by vger.kernel.org with ESMTP id S261584AbVEJImf (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 May 2005 04:42:35 -0400
Received: from localhost (lucy.ukfsn.org [127.0.0.1])
	by mail.ukfsn.org (Postfix) with ESMTP
	id 2697CE6DAA; Tue, 10 May 2005 09:41:28 +0100 (BST)
Received: from mail.ukfsn.org ([127.0.0.1])
 by localhost (lucy.ukfsn.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 04092-10; Tue, 10 May 2005 09:41:28 +0100 (BST)
Received: from oak.dgreaves.com (unknown [217.135.133.19])
	by mail.ukfsn.org (Postfix) with ESMTP
	id 60B04E6DA8; Tue, 10 May 2005 09:41:27 +0100 (BST)
Received: from ash.dgreaves.com ([10.0.0.90])
	by oak.dgreaves.com with esmtp (Exim 4.20)
	id 1DVQJr-0000L3-Eb; Tue, 10 May 2005 09:42:23 +0100
User-Agent: Debian Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: en-us, en
To: Jan-Benedict Glaw <jbglaw@lug-owl.de>
In-Reply-To: <20050510080445.GB8176@lug-owl.de>
X-Enigmail-Version: 0.91.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Jan-Benedict Glaw wrote:

>On Tue, 2005-05-10 09:52:27 +0200, Jan-Benedict Glaw <jbglaw@lug-owl.de> wrote:
>  
>
>>On Tue, 2005-05-10 01:17:31 -0400, Brian Gerst <bgerst@didntduck.org> wrote:
>>    
>>
>>>But it can handle symlinks:
>>>
>>>	find * -type f -o -type l -print0 | xargs -0r cg-add
>>>      
>>>
>>This won't work because the explicit OR (-o) lower precedence compared
>>to the implicit AND between "-type l" and "-print0", thus this find
>>command will do print0 IFF the matched entry is a symlink. Use something
>>like this instead:
>>
>>	find * \( -type f -o tyle l \) -print0 | ...
>>    
>>
>
>Btw, this won't find dot files, so using "." as the path list (instead
>of "*") might be wise...
>  
>
This is a good thing - git ignores dot-files. see:
  http://www.dgreaves.com/git/git-update-cache.html
*
<file> *
    Files to act on. Note that files begining with *.* are discarded.
    This includes ./file and dir/./file. If you don't want this, then
    use cleaner names. The same applies to directories ending */* and
    paths with *//* 

Cogito should eventually spot and remove these since find * will
obviously find files beginning with a dot in subdirectories.

David

-- 

