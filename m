From: Ringo De Smet <ringo.desmet@gmail.com>
Subject: gitosis and symlink requirement
Date: Tue, 5 May 2009 14:50:30 +0200
Message-ID: <C4130655-CC74-498B-AF99-045F79D367B9@gmail.com>
Mime-Version: 1.0 (Apple Message framework v930.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 05 14:51:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M1K6v-0001bP-Ay
	for gcvg-git-2@gmane.org; Tue, 05 May 2009 14:51:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756065AbZEEMuf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 May 2009 08:50:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756439AbZEEMue
	(ORCPT <rfc822;git-outgoing>); Tue, 5 May 2009 08:50:34 -0400
Received: from mail-fx0-f158.google.com ([209.85.220.158]:42952 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755721AbZEEMud (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 May 2009 08:50:33 -0400
Received: by fxm2 with SMTP id 2so4562798fxm.37
        for <git@vger.kernel.org>; Tue, 05 May 2009 05:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:from:to
         :content-type:content-transfer-encoding:mime-version:subject:date
         :x-mailer;
        bh=k0hDLC7AMThkfvxPtr6QIwklAx5KFlmWju2Cl/nyfWg=;
        b=PSNhUdlvWjp7UJBw+b0H1hjFKbupJ/y8jKwhtXmn6JP+v8fGB4NL7LbbpzP0qWzGIL
         fXXoVREq8k/vmLqQkvSAfNS/ghbcFrOuzQPAyEdlZLIB8fnxPA5OiRt/30oYaIMSbAas
         1xhRvxquARpxxCGcv3SIkWYvWJGxDR9izM4GI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:from:to:content-type:content-transfer-encoding
         :mime-version:subject:date:x-mailer;
        b=QUeXRvfesWjY3TLLYTTvzjjo5i5JpQ+Mto+n20y9sNcyNtXWbEnT/b0ZVkCJwg9O8/
         +KcZha5f+fOtrqO15hmCUxAhUu/wjEEL8Mhwpe3V+CtaJYS03UYwVgvifRZb/GU+F99R
         sUgQ+MSekuTxM85eFkk/WvzJyGvQPLNg84CKA=
Received: by 10.103.231.16 with SMTP id i16mr35225mur.7.1241527831995;
        Tue, 05 May 2009 05:50:31 -0700 (PDT)
Received: from ?192.168.12.151? ([85.255.197.126])
        by mx.google.com with ESMTPS id w5sm19674451mue.4.2009.05.05.05.50.31
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 05 May 2009 05:50:31 -0700 (PDT)
X-Mailer: Apple Mail (2.930.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118294>

Hello Tommi,

I just tried to setup gitosis on a VirtualBox virtual machine with  
guest OS Ubuntu 8.10 Intredid Server (amd64). However, the  
installation fails with the following stacktrace:

Initialized empty Git repository in /home/git/repositories/gitosis- 
admin.git/
Reinitialized existing Git repository in /home/git/repositories/ 
gitosis-admin.git/
Traceback (most recent call last):
   File "/usr/bin/gitosis-init", line 8, in <module>
     load_entry_point('gitosis==0.2', 'console_scripts', 'gitosis- 
init')()
   File "/usr/lib/python2.5/site-packages/gitosis-0.2-py2.5.egg/ 
gitosis/app.py", line 24, in run
     return app.main()
   File "/usr/lib/python2.5/site-packages/gitosis-0.2-py2.5.egg/ 
gitosis/app.py", line 38, in main
     self.handle_args(parser, cfg, options, args)
   File "/usr/lib/python2.5/site-packages/gitosis-0.2-py2.5.egg/ 
gitosis/init.py", line 142, in handle_args
     symlink_config(git_dir=admin_repository)
   File "/usr/lib/python2.5/site-packages/gitosis-0.2-py2.5.egg/ 
gitosis/init.py", line 64, in symlink_config
     tmp,
OSError: [Errno 1] Operation not permitted

I found the rootcause: I run /home/git on a VirtualBox Shared Folder.  
I use this setup since all my Shared Folders of the host OS are in a  
backup plan. The git home folder is mounted using the vboxsf file  
system type, which does not support symbolic links:

http://www.virtualbox.org/ticket/818

Is there a possibility of updating gitosis so the symlinking is not  
needed?

Ringo De Smet
