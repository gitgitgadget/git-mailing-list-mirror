From: nathan spindel <nathans@gmail.com>
Subject: Re: git-instaweb should 'just work' on Mac OS X
Date: Sat, 10 May 2008 16:19:29 -0700
Message-ID: <F08C97B0-A7EE-4A32-9657-DCBDD291502A@gmail.com>
References: <B41867BF-1635-4611-9656-04F8C375BE61@gmail.com> <D1BFDAC1-A959-44BD-A562-D787A68612B1@sb.org>
Mime-Version: 1.0 (Apple Message framework v919.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Kevin Ballard <kevin@sb.org>
X-From: git-owner@vger.kernel.org Sun May 11 01:20:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JuyMx-0005H6-AP
	for gcvg-git-2@gmane.org; Sun, 11 May 2008 01:20:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755795AbYEJXTc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 May 2008 19:19:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754928AbYEJXTb
	(ORCPT <rfc822;git-outgoing>); Sat, 10 May 2008 19:19:31 -0400
Received: from wf-out-1314.google.com ([209.85.200.173]:25376 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753530AbYEJXTa (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 May 2008 19:19:30 -0400
Received: by wf-out-1314.google.com with SMTP id 27so1709306wfd.4
        for <git@vger.kernel.org>; Sat, 10 May 2008 16:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:cc:message-id:from:to:in-reply-to:content-type:content-transfer-encoding:mime-version:subject:date:references:x-mailer;
        bh=Hp0r9FLnH65/EPc/u13Nw6VyQ4E0vlCQcHNUegze9PE=;
        b=tMRXPyj4eOyJZ3Nj7s4Oh4G5T87IutidmAgc/tTCKNqIGd2L/F7tNlBWdrOMtajCnWLtnwpjoj38v/osG29j1q0COheimAKjVtaeqZs44zoHPztN8qz7epJq4KRzJuKhTrhVEf0RNVn47sh4YrrCp0umYuvBCI9nDEmoO00PkAc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=cc:message-id:from:to:in-reply-to:content-type:content-transfer-encoding:mime-version:subject:date:references:x-mailer;
        b=UOVe3sXOUkDWpK1VT027EKBlSM29wLiefaoCcv+5YSkaSuOLc31vvxNvNSvO4YkFyVGNwhhJkKskC5VmrOnqUzY6ozQmmsdINCkH4AHzu4ogkJtU9KfluPX+NKi4EbWMOjT4tR4jH14/17Ok05KxYxZjTqCoPL8iWxG4e+3pmYY=
Received: by 10.142.115.10 with SMTP id n10mr2616317wfc.8.1210461570375;
        Sat, 10 May 2008 16:19:30 -0700 (PDT)
Received: from ?10.0.1.4? ( [76.14.71.118])
        by mx.google.com with ESMTPS id 27sm14029227wff.7.2008.05.10.16.19.29
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 10 May 2008 16:19:30 -0700 (PDT)
In-Reply-To: <D1BFDAC1-A959-44BD-A562-D787A68612B1@sb.org>
X-Mailer: Apple Mail (2.919.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81713>

On May 10, 2008, at 3:49 PM, Kevin Ballard wrote:

> On May 10, 2008, at 2:27 PM, nathan spindel wrote:
>
>> I've investigated what it would take for git-instaweb to 'just  
>> work' on
>> Mac OS X 10.5 when running the command with no arguments. This  
>> would be
>> of benefit to many Mac git users since they shouldn't be expected to
>> troubleshoot this problem. Here are the current issues at play:
>>
>> - lighttpd does not come with Mac OS X by default, so git-instaweb
>>  currently exits with "lighttpd not found...".
>>
>> - git-instaweb doesn't fallback to using other web servers on the  
>> system
>>  if the default command doesn't exist.
>>
>> - Mac OS X does come with webrick and 'git-instaweb -d webrick'  
>> _does_ just
>>  work. It's probably slower than Apache though (?).
>>
>> - Mac OS X also comes with mongrel, which is a great alternative, but
>>  git-instaweb doesn't support it.
>>
>> - Mac OS X's Apache installation is different than what git-instaweb
>>  expects in a couple areas:
>>  - the Apache binary is called 'httpd', not 'apache2', and git- 
>> instaweb
>>    only looks for the latter.
>>  - the modules on Mac OS X live in /usr/libexec/apache2 but by  
>> default
>>    git-instaweb looks for /usr/lib/apache2/modules.
>>  - Apache attempts to create its 'accept serialization lock file' at
>>    /private/var/run/ but that path is only writeable by root (a  
>> workaround
>>    is to add a LockFile directive to the conf file that places it
>>    in $fqgitdir/gitweb/tmp).
>>
>> I'm interested in fixing this to make the experience smoother for  
>> Mac users.
>> What is the community's preferred avenue of fixing this?
>
> If I were to fix this, I'd suggest making apache2 work properly. I  
> patched the git-svn tests to do this a while back, so you could look  
> at what's I did there (3644da7214).

Thanks Kevin. Your patch is similar to how I imagined fixing apache2.

Would you suggest fixing the other non-starter issue (git-instaweb  
doesn't fallback to other daemons if the default doesn't exist)?  Or  
maybe changing the default to apache2 on Mac OS X installs (that seems  
like a poorer fix)?

-nathan
