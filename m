From: Vincent van Ravesteijn <vfr@lyx.org>
Subject: Re: rebase problem
Date: Sat, 17 Mar 2012 17:11:21 +0100
Message-ID: <4F64B7A9.20805@lyx.org>
References: <OF506B5658.3E449452-ONC12579C4.00460A6E-C12579C4.0047355D@transmode.se> <4F649202.4080102@lyx.org> <OF03E8C640.7C5AF318-ONC12579C4.004F7449-C12579C4.004FCF5C@transmode.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Joakim Tjernlund <joakim.tjernlund@transmode.se>
X-From: git-owner@vger.kernel.org Sat Mar 17 17:11:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S8wE9-00039H-Qq
	for gcvg-git-2@plane.gmane.org; Sat, 17 Mar 2012 17:11:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752184Ab2CQQLZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Mar 2012 12:11:25 -0400
Received: from mail-ee0-f46.google.com ([74.125.83.46]:44769 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751660Ab2CQQLY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Mar 2012 12:11:24 -0400
Received: by eekc41 with SMTP id c41so2416310eek.19
        for <git@vger.kernel.org>; Sat, 17 Mar 2012 09:11:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding
         :x-gm-message-state;
        bh=j++ENM3P00ueb+uepJjv+byPo4+fBW976eRaxWE4maI=;
        b=dfANuCjsz/EYZjJKaNDxS/20qY1YOZiPoqvJ3eIIeiqcq/H8BJvUKoB20StWJfAo1Q
         ieif+IgLrVXybmsREnms35ixEXC4+pXBiPu5pmvLcJV/PtgMaqG7ojqcX2PRCX4J1i1N
         emU55Td9Gv8sp+jwm1ApXma+2y6XCRDzJUmI2ZuZin6/24nK8GLaReHnmKjypAB0uDU6
         5wRW4cThKuTvWM+xrx3UjbSXl4fEz3wPb+PVR50STCWrY+d/pfw+GN6xqddbLfaW/+l6
         ZRb/AcHMnUjAVx8g2WlKQCkfB55YVNQs39C65gq8BeVVy0cakwqG7/LqGkRFzwPf8Vd8
         Y+8g==
Received: by 10.14.183.136 with SMTP id q8mr803449eem.60.1332000683312;
        Sat, 17 Mar 2012 09:11:23 -0700 (PDT)
Received: from [192.168.1.4] (j175101.upc-j.chello.nl. [24.132.175.101])
        by mx.google.com with ESMTPS id x8sm29938569eea.10.2012.03.17.09.11.22
        (version=SSLv3 cipher=OTHER);
        Sat, 17 Mar 2012 09:11:22 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:10.0.2) Gecko/20120216 Thunderbird/10.0.2
In-Reply-To: <OF03E8C640.7C5AF318-ONC12579C4.004F7449-C12579C4.004FCF5C@transmode.se>
X-Gm-Message-State: ALoCoQlYsAPc10ulue755cahPGFG5b7rRuHwnChMo7KUxihmziGzIsVHCsIOLc+cTCo78q+QhSdT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193336>

Op 17-3-2012 15:31, Joakim Tjernlund schreef:
> Vincent van Ravesteijn<vfr@lyx.org>  wrote on 2012/03/17 14:30:42:
>> Op 17-3-2012 13:57, Joakim Tjernlund schreef:
>>> A co-worker this on our local u-boot repo:
>>>     git checkout master
>>>     git fetch denx/master
>>>     git merge denx/master
>>> <resolve conflicts>
>>>     git commit
>>>     ...
>>>     git commit
>>> Now u-boot is working again
>>> then update to latest u-boot so:
>>>     git fetch denx/master
>>>     git rebase denx/master
>>> Now it is a mess, that rebase seems to start from way back as a
>>> staring reference, not from the last merge shown above.
>>> I guess I forgotten how git works, what did go wrong?
>>>
>>>     Jocke
>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe git" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> The situation is like this:
>>
>>    master - C - o - o - D - o - o - o - A
>>                        /
>>    denx/master- - - - o - o - o - o - B
>>
>> Now, you ask to rebase master (A) onto denx/master (B). If master would
>> have started from D, it would indeed apply the commits D -- A on top of
>> B. In your case, however, master already had a lot of commits that were
>> not in denx/master: C -- D  (including the merge resolution). So it will
>> also apply C -- D on top of  B.
> Thanks, this makes sense. How do I get from above to
>
>     master - C - o - o - D - o - o - o - A
>                         /
>     denx/master- - o - B
>
>
> Jocke
>
Don't you just want to merge with denx/master again ?

    master - C - o - o - D - o - o - o - A
                        /               /
    denx/master- - o - o - o - o - o - B


In this way you pull in the new commits from denx/master.

Of course you can rework your history such to obtain what you drew 
above, but this means you need to rewrite some of the history, which you 
probably don't want to do if you share this code with colleagues. But 
well, if you really want:

git checkout D~1
git merge B
git rebase --onto HEAD D master

Vincent
