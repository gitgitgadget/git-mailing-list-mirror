From: Sergio Callegari <sergio.callegari@gmail.com>
Subject: Re: On refreshing the index
Date: Mon, 15 Mar 2010 01:19:01 +0100
Message-ID: <4B9D7CF5.5010404@gmail.com>
References: <loom.20100311T191149-453@post.gmane.org> <7vmxyb3la7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 15 01:19:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nqy1g-0004xK-Jt
	for gcvg-git-2@lo.gmane.org; Mon, 15 Mar 2010 01:19:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934522Ab0COATK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Mar 2010 20:19:10 -0400
Received: from mail-fx0-f227.google.com ([209.85.220.227]:57045 "EHLO
	mail-fx0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934529Ab0COATH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Mar 2010 20:19:07 -0400
Received: by fxm27 with SMTP id 27so3342376fxm.28
        for <git@vger.kernel.org>; Sun, 14 Mar 2010 17:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=zj5nDcitom2l7Qp/v7WBEmvwbfxWyI5c6uiKxLBbBdg=;
        b=wqyBAGLgqd0VpzFQT1f3ia9EwGSQ9pUHfkV5xFi6tOMxxh/8NKBe85oWBBQBw+GeOy
         hajHKMmoYMYqwzA5+JLRSrR4ZlIxj3CxDqQYMBxk5PA6ROZHDbbJziy3gZWo0oTnuSEh
         Q6rbuW2cAeoHDjJPuIsNr0PMLLc6+ZghvnyyM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=s5krhep3u0nN5paTctgVhhVkjaGRmh47Wgh6/wqmqVfK0fGRZEGYS55RQ7HCZqJSbc
         dZB2XN5D41u1qonLfmhQrDCHJa1V5+8bM7cgYqYI0KpdWtYrbGutqasXigr7lJk1PxOm
         mwLVRKqmeQSnYSKqSxuh1JYybIZLtCp6vXIzc=
Received: by 10.103.135.25 with SMTP id m25mr2109082mun.32.1268612345150;
        Sun, 14 Mar 2010 17:19:05 -0700 (PDT)
Received: from [192.168.1.101] (adsl-ull-214-33.51-151.net24.it [151.51.33.214])
        by mx.google.com with ESMTPS id e8sm17542701muf.9.2010.03.14.17.19.03
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 14 Mar 2010 17:19:04 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.23 (X11/20090817)
In-Reply-To: <7vmxyb3la7.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142162>

Junio C Hamano wrote:
> Sergio Callegari <sergio.callegari@gmail.com> writes:
>
>   
>> If I run git status, git runs filters on a couple of opendocument files for
>> which a filter is defined
>>
>> GIT_TRACE=1 git status
>> trace: built-in: git 'status'
>> trace: run_command: 'rezip -p ODF_UNCOMPRESS2'
>> trace: exec: 'sh' '-c' 'rezip -p ODF_UNCOMPRESS2' 'rezip -p ODF_UNCOMPRESS2'
>> trace: run_command: 'rezip -p ODF_UNCOMPRESS2'
>> trace: exec: 'sh' '-c' 'rezip -p ODF_UNCOMPRESS2' 'rezip -p ODF_UNCOMPRESS2'
>> # On branch M05
>> # Untracked files:
>> #   (use "git add <file>..." to include in what will be committed)
>> #
>> #       WIP/
>> #       program.txt
>> #       program.txt~
>> nothing added to commit but untracked files present (use "git add" to track)
>>     
>
> What does "git diff-files" and/or "git diff-index HEAD" say at this point?
> If they do not say there are no difference, that means that the file on
> the filesystem and the blob registered in the index are different, even
> though after transmogrified with rezip (whatever it does) these two
> different blobs may look the same.
>   
Neither git diff-files" and/or "git diff-index HEAD say nothing at this 
point...

> I think the difference between "may look the same" and "identical" is what
> you are seeing.  Try "git add" on those paths and see what happens.
>   
Is there any way I can find out which file is the guilty one since git 
diff-files says nothing? E.g. a trace telling me on what is the filter 
being called?

BTW... some notes that may be useful...

1) rezip is a mere recompressor.  It takes a zip file and re-creates it 
at zero compression, so that the git delta logic can do a good job on it 
on repacking.  I've found this useful on zip files, openoffice files, 
jar files, etc.

2) if I clone outside git, git update-index --refresh is always ok at 
making git status fast (i.e. not running expensive filters).

3) The problem always happens when I switch branches, right after the 
switch.

Sergio
