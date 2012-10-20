From: Cheeray Huang <cheeray.huang@gmail.com>
Subject: Report a bug, about track remote repository.
Date: Sun, 21 Oct 2012 02:49:57 +0800
Message-ID: <5082F255.9060600@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 20 20:52:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TPe9d-0003NI-93
	for gcvg-git-2@plane.gmane.org; Sat, 20 Oct 2012 20:52:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754423Ab2JTSuF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Oct 2012 14:50:05 -0400
Received: from mail-da0-f46.google.com ([209.85.210.46]:44572 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751560Ab2JTSuE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Oct 2012 14:50:04 -0400
Received: by mail-da0-f46.google.com with SMTP id n41so734209dak.19
        for <git@vger.kernel.org>; Sat, 20 Oct 2012 11:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        bh=r3oib3Z2EdDAFT5UKyj/Y3H7YLT275saroVT7palICY=;
        b=rjtmFGtdjo8835GTph6/Fp1fG1Qw7gloPHfTzGCaQtNBO1e4hfPEprW7KgOjvdA7bn
         9VwLDQ9Jzy/dU/rlrNQvUzBtqkfCZviAAH6UNW7bAVnwySZ20jQQ0NBPzunUMujcq9WY
         RSOX0Pqx+xwTBGYxCNh2SGuKCvDfBFPU88hER8avPS2zT8+Z4RjOMHiWDOsIHGAzUoHq
         2oeq9MaucUjytvYC/KL8P9C3ePl7y6RMS3Sy1wKUPXcEmqmcC/d4m5Bpe4PgB1Jx6sjB
         tj4iVdA1/ejeNiD3SnB7VvSdZyi/XjRgxlViF7nNn8ZW3iCETnp2IvyzKx/v0kStinUF
         eV+w==
Received: by 10.68.136.100 with SMTP id pz4mr17039380pbb.135.1350759003932;
        Sat, 20 Oct 2012 11:50:03 -0700 (PDT)
Received: from [192.168.1.101] ([115.195.168.67])
        by mx.google.com with ESMTPS id pw2sm3175470pbb.59.2012.10.20.11.50.01
        (version=SSLv3 cipher=OTHER);
        Sat, 20 Oct 2012 11:50:03 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:15.0) Gecko/20120827 Thunderbird/15.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208091>

Hi,

I think I found a bug, when I used local branches to track remote 
branch. But I'm not very sure, can anyone double check this?  I'd like 
to finger this out. I think you can reproduce this bug as below steps:

precondition:

Suppose that you have a remote branch in repository, named origin/work. 
And then you want to track it with a local branch.

Steps:

1. So you can do this:

git checkout -t origin/work

now, you have a local branch also named "work" to track "origin/work".
It works nicely, you can use "push/pull" command without any detail 
parameters to sync anything with the remote branch.

2. Create another branch, ex. named "work2", to track "origin/work" 
again, though maybe there are not so many people that will do like this.

You will find that local branch "work2" can't "push" to "origin/work".
ex. After you committed something in work2, you typed "git status", git 
would tell you:

Your branch is ahead of 'origin/work' by x commit.

And then you used "git push", git can't display the information about 
changing hash value in remote branch, just printed "everything is up to 
date".

Actually, you can use some exact parameters to solve this,  such as:

git push origin work2:work

But, I still think it is a bug.

BTW, I found this bug when I used github. I don't know whether it is  
related to github.


-- 
B&R,
Cheeray
