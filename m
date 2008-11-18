From: justin <juddhuck@gmail.com>
Subject: git-submodule/before-rebase hook
Date: Mon, 17 Nov 2008 19:59:28 -0800
Message-ID: <CC8B9B47-4985-4B96-B8DB-0B351633C849@justinbalthrop.com>
Mime-Version: 1.0 (Apple Message framework v929.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 18 05:01:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L2Hlu-0008Ea-CN
	for gcvg-git-2@gmane.org; Tue, 18 Nov 2008 05:01:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751076AbYKRD7c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Nov 2008 22:59:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751864AbYKRD7c
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Nov 2008 22:59:32 -0500
Received: from rv-out-0506.google.com ([209.85.198.232]:20578 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751061AbYKRD7b (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Nov 2008 22:59:31 -0500
Received: by rv-out-0506.google.com with SMTP id k40so2734934rvb.1
        for <git@vger.kernel.org>; Mon, 17 Nov 2008 19:59:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:to:content-type
         :content-transfer-encoding:mime-version:subject:date:x-mailer:from;
        bh=YeKVQJyKAhbjybIKrdBbijdSXs3E1uYFgix65A+VLPg=;
        b=dHCUx13SaGucXp2tAy/XHpqTn5th4/Y5z3rqfW6jGDz92RwEnTv1mlH4XdZUd5Pm8W
         9j4fDISDM0TBTqxq7n69QghdkL1xjbi2vUvNgXV/bhHm6qCUexdBLwvXNI3+lvOzsMq0
         cwr8O8Sy8Du9wiigYJ/xMTs2tMiRjsaWWFoMs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:to:content-type:content-transfer-encoding:mime-version
         :subject:date:x-mailer:from;
        b=VpUipZObShLDXi9Iujyyxq8FS7RcTlVdapzNTRAQV5EqyiaPCg/+XBFp2u+VZ8Bdzu
         8QwTgw5AQS57XLE1ZBDjkhvg1DhUGYou2OJ+YkwSBlBoHKz1yQPugCvInBuE4Z2yzx95
         TeRD0TLgX7sTYQpYygQ/HB8d+dqgcy4WCgqWI=
Received: by 10.141.29.21 with SMTP id g21mr2676694rvj.44.1226980770653;
        Mon, 17 Nov 2008 19:59:30 -0800 (PST)
Received: from bender.geni.com (63-203-180-99.ded.pacbell.net [63.203.180.99])
        by mx.google.com with ESMTPS id g31sm11543895rvb.7.2008.11.17.19.59.29
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 17 Nov 2008 19:59:30 -0800 (PST)
X-Mailer: Apple Mail (2.929.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101258>

I just discovered git-submodule today, and already I can see it making  
my life a lot easier. I develop several modules that are used in two  
different projects, and being able to check in changes from the  
submodule in either project is something I have been wanting to do for  
a while. But there is one shortcoming in git-submodule that I haven't  
figured out how to overcome... yet.

When I make a change to a submodule and push that change to the parent  
repository, the change appears to all other users of the repository as  
a modification to the submodule commit version. A few people at our  
company use 'git ci -a' to add all of their changes, and I'm afraid  
they are going to unknowingly revert the submodule back to a previous  
version. So my plan was to add a post-pull hook that does 'git  
submodule update --init', so that people who don't do development on  
the submodule will get updates every time they pull. Unfortunately  
though, there is no such hook in git. I thought post-merge was going  
to work, but most people at our company use 'git pull --rebase', and  
post-merge isn't called in that case. The post-checkout hook is  
called, but the pull hasn't been completed at that point, so updating  
the submodule doesn't work. Alas, if only there was a post-rebase hook.

Any ideas other than patching every employee's git source to add a  
post-rebase hook?

Thanks,
Justin
