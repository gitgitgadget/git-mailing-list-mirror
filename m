From: Mark Levedahl <mlevedahl@gmail.com>
Subject: Re: [PATCH] gitk - restore operation of git-reset on Cygwin
Date: Fri, 23 May 2008 18:26:51 -0400
Message-ID: <483744AB.8070509@gmail.com>
References: <1211511636-3552-1-git-send-email-mlevedahl@gmail.com> <18486.15879.551874.408651@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Sat May 24 00:27:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jzfjs-0002uh-7Q
	for gcvg-git-2@gmane.org; Sat, 24 May 2008 00:27:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755959AbYEWW1A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 May 2008 18:27:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756743AbYEWW1A
	(ORCPT <rfc822;git-outgoing>); Fri, 23 May 2008 18:27:00 -0400
Received: from gv-out-0910.google.com ([216.239.58.187]:17187 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755806AbYEWW07 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 May 2008 18:26:59 -0400
Received: by gv-out-0910.google.com with SMTP id e6so963037gvc.37
        for <git@vger.kernel.org>; Fri, 23 May 2008 15:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        bh=fO6aa8XUJMmncPUlqYywG6Hrfwb44vaYWNBRljKV7g4=;
        b=FHuGT43Rc2fTlY9b3neP8y3IEzKCaGFLUssw2qQiEnpzgNmh6i2Emw30RT596zuvWP6Qpv2C82JDQcIpKiVuBF0HDw1f3NHEhuRj2OzFampIAXSxV4Dn2Y/7/9y8kdiBEYpBWLaNDxFJ3e7e8Q8fRxkIxZqAY6NfFsgxWWNBkIs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=BZJzQ7wtb+ZIZL8QKphxB/D+aMgxa5h+3gCwmcDWMAlRO9/dkA8KwJr7uIlU4ORzhvgbJb7Bik9+8X2jI+DhXmI2ordB8ousWnyw5+2YNpluw1FLxgBchBSgwrRn08txPnDJcn68N8G2Cl8ZBdSUgDeOHKZ+5zDR763YoBix7sM=
Received: by 10.150.69.41 with SMTP id r41mr487398yba.128.1211581614443;
        Fri, 23 May 2008 15:26:54 -0700 (PDT)
Received: from ?192.168.1.117? ( [71.126.133.203])
        by mx.google.com with ESMTPS id 9sm47319yxs.5.2008.05.23.15.26.52
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 23 May 2008 15:26:53 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.14 (Windows/20080421)
In-Reply-To: <18486.15879.551874.408651@cargo.ozlabs.ibm.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82763>

Paul Mackerras wrote:
> Mark Levedahl writes:
>
>   
>> Commit 6df7403a98737 modified the call to git-reset to invoke git
>> directly rather than using "sh -c", but is redirecting stderr to stdout.
>> This does not work on Cygwin, probably because the Tcl/Tk package is
>> a windows program rather than Cygwin. The result is always an error
>> message proclaiming 'can not find channel named "1"'. This restores
>> invocation through sh -c.
>>     
>
> Are you using Tk 8.4 or 8.5?  The man pages for 8.5 imply that the
> 2>@1 form should work for all platforms, but maybe that wasn't true in
> 8.4.  If that's the case it's worth mentioning in the patch
> description.
>
> Paul.
>   
Cygwin's Tcl/Tk is essentially frozen at 8.4.1. However, I really 
believe the problem is that the Tcl/Tk is not a full Cygwin application: 
it is mostly Windows, with only a few pieces converted to Posix through 
the cygwin.dll, so many things don't quite work correctly. For instance, 
the current gitk works fine under a pure Cygwin build of Tcl/Tk (8.4.13) 
I have locally. So, I believe the commit message I wrote is correct.

Mark
