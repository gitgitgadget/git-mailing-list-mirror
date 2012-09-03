From: Marco Stornelli <marco.stornelli@gmail.com>
Subject: Re: [PATCH v4] Thunderbird: fix appp.sh format problems
Date: Mon, 03 Sep 2012 17:48:50 +0200
Message-ID: <5044D162.1010608@gmail.com>
References: <5040C59A.6090303@gmail.com> <50412E2D.7070503@kdbg.org> <5041BC94.7000304@gmail.com> <504214AA.9080706@kdbg.org> <50425F8B.5020406@gmail.com> <7voblognny.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 03 17:55:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T8Yzy-0001jA-S8
	for gcvg-git-2@plane.gmane.org; Mon, 03 Sep 2012 17:55:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756090Ab2ICPzc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Sep 2012 11:55:32 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:44978 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752843Ab2ICPzb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Sep 2012 11:55:31 -0400
Received: by bkwj10 with SMTP id j10so2252881bkw.19
        for <git@vger.kernel.org>; Mon, 03 Sep 2012 08:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=9e4TIkiUXXJNT2oXiMNsxmsrK3XqgGV7gGT1BpJO5dA=;
        b=BWVW4IGcDeHd5DcBw/zZQp9DLhjRZghkKpZo0Re+xAqHiLv2pKekezY9+RzV5olWZg
         vGWCgzTCTcgUmOQLpuZriggbaYh5WZPwl37BnxI2m5wG1Rf86FUA4lxigjL4u0tOXovM
         ri8RtSdWP4BL9CRZD9z40KXdBuZ8YN37iCgveszRRGblZiVhDOYWR/JoD6RdT8vf1NFy
         OfzkKdhUmpydcok8ksWztmYaefwwYagF9bJ4Bf9Gh0QDK00aFCwmoXBoiAHCP28STy4n
         cOqZ4wuxfOfSNfRpT9lrrbn8DyaP2KLI9IAsKybeKytF852Bmi9hiu15IMZktHK5+g9J
         3sow==
Received: by 10.204.145.90 with SMTP id c26mr7272000bkv.34.1346687729811;
        Mon, 03 Sep 2012 08:55:29 -0700 (PDT)
Received: from [80.183.109.210] (host210-109-dynamic.183-80-r.retail.telecomitalia.it. [80.183.109.210])
        by mx.google.com with ESMTPS id he8sm8424246bkc.3.2012.09.03.08.55.27
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 03 Sep 2012 08:55:28 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:13.0) Gecko/20120601 Thunderbird/13.0
In-Reply-To: <7voblognny.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204700>

Il 02/09/2012 22:42, Junio C Hamano ha scritto:
> Marco Stornelli <marco.stornelli@gmail.com> writes:
>
>> Il 01/09/2012 15:59, Johannes Sixt ha scritto:
>>
>>> Look how you write:
>>>
>>>     perl -e '... $ENV{'PATCHTMP'} ...'
>>>
>>> That is, perl actually sees this script:
>>>
>>>     ... $ENV{PATCHTMP} ...
>>>
>>> (no quotes around PATCHTMP). That my be perfectly valid perl, but is not
>>> what you intended.
>>
>> I don't understand what you mean when you say "is not what you
>> intended"...
>
> When you wrote this:
>
>      CCS=`perl -e 'local $/=undef; open FILE, $ENV{'PATCHTMP'};...
>
> which one of the following did you mean to feed Perl?
>
>   (1) open FILE, $ENV{'PATCHTMP'};
>   (2) open FILE, $ENV{PATCHTMP};
>
> The patch text makes it look as if you wanted to do (1), but what is
> fed to perl is (2), as Johannes points out.
>
> Saying:
>
>      CCS=`perl -e 'local $/=undef; open FILE, $ENV{PATCHTMP};...
>
> would have been more natural if you really meant to do (2), don't
> you think?  So what you wrote is at least misleading.
>
> But I think I agree with Johannes's rewrite of the loop, so this may
> be a moot point.
>

I tried the Johannes's script, but it seems it doesn't work well with 
the pattern of format-patch (To: <mail1>,\n   <mail2>,\n    <mailN>). 
The multilines are not well managed. I can change my script to double 
quotas (I think perl and regexp are much more powerful rather than the 
while loop though it can be less readable), if it's not ok, I let other 
git shell expert to adjust the script. I hope this thread it will be 
useful for others.

Marco
