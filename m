From: "Aaron Gray" <aaronngray.lists@googlemail.com>
Subject: Re: git & ssh on F10 server
Date: Sat, 18 Apr 2009 16:12:32 +0100
Message-ID: <DD909F216D254CDAB2A0C0847AEB75C0@HPLAPTOP>
References: <489CF11BD65F439998B6CF3FCC610576@HPLAPTOP> <alpine.LNX.2.00.0904171716150.8346@reaper.quantumfyre.co.uk> <FD77671D77E2465097BD60A1E144BB91@HPLAPTOP> <alpine.LNX.2.00.0904171812330.8773@reaper.quantumfyre.co.uk>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=response
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: "Julian Phillips" <julian@quantumfyre.co.uk>
X-From: git-owner@vger.kernel.org Sat Apr 18 17:14:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LvCF8-0004ym-TN
	for gcvg-git-2@gmane.org; Sat, 18 Apr 2009 17:14:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755869AbZDRPMh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Apr 2009 11:12:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754953AbZDRPMh
	(ORCPT <rfc822;git-outgoing>); Sat, 18 Apr 2009 11:12:37 -0400
Received: from mail-ew0-f176.google.com ([209.85.219.176]:42439 "EHLO
	mail-ew0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754294AbZDRPMf (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Apr 2009 11:12:35 -0400
Received: by ewy24 with SMTP id 24so586324ewy.37
        for <git@vger.kernel.org>; Sat, 18 Apr 2009 08:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:from:to:cc
         :references:subject:date:mime-version:content-type
         :content-transfer-encoding:x-priority:x-msmail-priority:x-mailer
         :x-mimeole;
        bh=5GiclbWXsuZldoeDM0oirh+O3JwzUhKY37Clv4UEunU=;
        b=n3QWUBXxDECNHJjCqkThCN2ZDy7Jl/hBXXu07+v+jOW/AuOY4YXrtUZNApg1nIMDyY
         CnlXq0yOjcaa2BXrP4wnSDF7nzbHj8+Ho3W+cTU/HVQGn7bZay+M1BGpC99m+w0gfMBH
         pqNJHSqSoq0+cv28JR3NdbqhDIzbSnlVP0I3g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=message-id:from:to:cc:references:subject:date:mime-version
         :content-type:content-transfer-encoding:x-priority:x-msmail-priority
         :x-mailer:x-mimeole;
        b=JjUuvutkO58o/YaqZ+sZ3oUK4kYtA/VQXtD+BrZZcg+gxMI3Cx5mICGSU5fLCq5PMF
         N6R0HzQB/SmhzJRiwz9nZKM3Ec9ayqAlB9pGlMu/mizTSg1Y2qqohXbTJUotxdOdSdke
         W23+RLK0gYwAcHihSzojxPKivS5edjRM3wPPw=
Received: by 10.210.128.10 with SMTP id a10mr3932715ebd.15.1240067553855;
        Sat, 18 Apr 2009 08:12:33 -0700 (PDT)
Received: from HPLAPTOP (mwgray.force9.co.uk [212.159.110.144])
        by mx.google.com with ESMTPS id 23sm487089eya.15.2009.04.18.08.12.33
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 18 Apr 2009 08:12:33 -0700 (PDT)
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5512
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.5579
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116829>

> On Fri, 17 Apr 2009, Aaron Gray wrote:
>>>  On Fri, 17 Apr 2009, Aaron Gray wrote:
>>>
>>> >  Hi,
>>> >
>>> >  we have a Fedora 10 server in SELinux enforcing mode setup running 
>>> > git-deamon and gitweb (with home grown SElinux policy).
>>> >
>>> >  Anyway now we find out you cannot do a 'push' over the basic git 
>>> > protocol, back to the server repository.
>>>
>>>  You can push over git://, but you get no authentication mechanism so 
>>> it's
>>>  disabled by default.  It's only really useful if you trust everyone who
>>>  has IP access to the server.
>>
>> How do go about I enabling it ?
>
> You have to enable the receive-pack service.  You can either enable it for 
> all repositories by using the --enable=<service> option to git-daemon, or 
> on a per-repository basis by setting daemon.receivepack to true in the 
> repositories that you want to enable push for.

Okay I have added the following to 'config' :-

[daemon]
        receivepack = true

and done an 'service xinetd restart' just in case, probably not needed.

I have tried a 'git push git://.../repo' but it is hanging, btw I am using 
Cygwin on the client, and F10 on the server.

Trying to clone an empty repository also hangs. btw I have sucessfully 
cloned big repositories.

Aaron

>>> >  So now am trying to get git to work over ssh. The repositories are 
>>> > located /pub/git/*/.git
>>> >
>>> >  Basic attempts using BerliOS'es instructions for client end failed.
>>> >
>>> >
>>> > 
>>> > http://developer.berlios.de/docman/display_doc.php?docid=1812&group_id=2
>>> >
>>> >  Could someone please help us with this.
>>> >
>>> >  Aaron
>>>
>>>  You haven't said what commands you tried, nor what the errors you 
>>> received
>>>  were, so it's a bit hard to say what went wrong ...
>>>
>>
>> git push ssh://ang@git.site.org/pub/git/llvm/trunk milestone1
>> Pushing to ssh://ang@git.site.org/pub/git/llvm/trunk
>> fatal:  exec ssh failed.
>> fatal:  The remote end hung up unexpectedly
>
> Sounds like git didn't find ssh on your path.
> What version of git is this btw?
>
>> A clone failed simularly
>>
>> I was expecting it to ask for a password. Should I try a DSA certificate 
>> ?
>>
>> Thanks,
>>
>> Aaron
>>
>>
>
> -- 
> Julian
>
>  ---
> "It's my cookie file and if I come up with something that's lame and I 
> like it,
> it goes in."
> -- karl (Karl Lehenbauer) 
