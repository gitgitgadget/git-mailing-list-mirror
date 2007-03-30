From: Andy Parkins <andyparkins@gmail.com>
Subject: git-add has gone lstat() mad
Date: Fri, 30 Mar 2007 20:55:10 +0100
Message-ID: <200703302055.13619.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 30 22:06:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HXNMU-00059u-3f
	for gcvg-git@gmane.org; Fri, 30 Mar 2007 22:06:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752578AbXC3UF7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 30 Mar 2007 16:05:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753075AbXC3UF7
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Mar 2007 16:05:59 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:46182 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752578AbXC3UF6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Mar 2007 16:05:58 -0400
Received: by ug-out-1314.google.com with SMTP id 44so923294uga
        for <git@vger.kernel.org>; Fri, 30 Mar 2007 13:05:56 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=Mp/CiYpyNNlztbUFjh2JFSI1QGgzzRIOf+omGoBm6x1L/VH29qC+cdJzoghZcH8cgR/qOTlHdiN9bCRfclkBTXijiTFmDVYKdNq9pFOTasjiSvwUHd7XDz12VmXFuMG2qFC9Ep09UInDlHxg+4eHqenbZAB0+B0cRQTKXqHK65g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=PqTcxxyd8AVIgdVOmXfG3gH9Nh/LoOZL0+nAqCc/BqYdbgkV0YAwQf56+jBkQSjwQZr4GLFwX5AY4rLu2/9eDdQb8/T/3uZk8u4MPtRKpDe54jaKSwAtMtgF7Vs6wpY1Ho+Y+dE/utOmDEJ7nJVCriaDTFqNWSUVjYoGAwLa2Xw=
Received: by 10.66.244.10 with SMTP id r10mr2424802ugh.1175284717016;
        Fri, 30 Mar 2007 12:58:37 -0700 (PDT)
Received: from grissom.internal.parkins.org.uk ( [84.201.153.164])
        by mx.google.com with ESMTP id g30sm3660432ugd.2007.03.30.12.58.35;
        Fri, 30 Mar 2007 12:58:36 -0700 (PDT)
User-Agent: KMail/1.9.6
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hello,

I was interested in trying out the GIT_WORK_DIR stuff, but ended up 
being unable to.  The thing that stopped me is present in master as 
well:

 $ git --version
 git version 1.5.1.rc3.20.gaa453
 $ cd $HOME
 $ git init
 $ git add .bashrc

At this point the CPU pegs at 100% systime.  An strace shows that git is 
calling lstat64() on every file in my home directory.  I killed git 
before it scanned everything I've ever done.

I only want to track one file; is git meant to scan every file in the 
directory even though I'm not adding any of them?



Andy
-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
