From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Git commit behaving strangely
Date: Tue, 20 Jul 2010 22:06:09 -0500
Message-ID: <20100721030608.GA25992@burratino>
References: <4C465B34.2040407@zqureshi.in>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Zeeshan Qureshi <zeeshan@zqureshi.in>
X-From: git-owner@vger.kernel.org Wed Jul 21 05:07:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ObPeR-0004QX-9c
	for gcvg-git-2@lo.gmane.org; Wed, 21 Jul 2010 05:07:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932983Ab0GUDHJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Jul 2010 23:07:09 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:59205 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762049Ab0GUDHI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Jul 2010 23:07:08 -0400
Received: by iwn7 with SMTP id 7so6381020iwn.19
        for <git@vger.kernel.org>; Tue, 20 Jul 2010 20:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=yJXuNlTDILtTtaNosB+AZbK2TTyZFz2pyMHoJRELFNQ=;
        b=njLTJxHF5FDFwZfgh//TId4aY9bnGdZsK13XebylvYVD0hS83hYAeBpPWDX0Wibyhe
         oBm7wTQOnfNLrv26jPpbRC+mWMKhDKkpM1B0xqBTPB1rFUJd5Y17imylbu3ftbCwBK2f
         3nu8anCmAN2CBmdXlsrKLweXVITepJRO6gF2U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=dGiy9Jwb/ZbVOw2bBLp5ZqsQCczN1HqjCfwknIdf1z7PXKFYuth04v8D88RnkvorxP
         GI46vEZ/D+A+JTICxQoSS99J5RHO9gaH8ON4zrMgVxkeovQV072LoLDnZfvaKG/J0UTT
         mDe48EaEiFcqlbfQv2M/XSb3109Kcgmu3WVfA=
Received: by 10.231.32.134 with SMTP id c6mr2174912ibd.156.1279681627214;
        Tue, 20 Jul 2010 20:07:07 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 34sm28225808ibi.0.2010.07.20.20.07.06
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 20 Jul 2010 20:07:06 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4C465B34.2040407@zqureshi.in>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151387>

Hi Zeeshan,

Zeeshan Qureshi wrote:

> 3. then i added 1 new line to both closing.txt and file.txt
> 4. i added the file closing.txt to the staging are by running 'git
> add closing.txt'
> 5. now i ran 'git checkout' (by mistake)
[...]
> 7. Now when i run 'git commit -m "closing again"', the change is not
> committed even though i get a new commit id.
> 
> The output of 'git log -p' is this (as you can clearly see, there
> are new commits but no change has been recorded)

Strange.  I tried to reproduce this but I got different results
(the new commit includes in a change to closing.txt).  What am
I doing wrong?

 git init repo
 cd repo

 echo 'hello world' >file.txt
 git add .
 git commit -m 'Initial version of repo, a test repository'

 echo closing >closing.txt
 git add closing.txt
 git commit -m 'Goodbye, all'

 echo 'hi!' >>file.txt
 echo 'again?' >>closing.txt
 git add closing.txt

 git checkout
 git diff --cached

 git commit -m 'closing again'
 git log -p
