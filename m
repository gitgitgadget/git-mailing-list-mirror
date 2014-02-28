From: Karsten Blees <karsten.blees@gmail.com>
Subject: Re: Branch Name Case Sensitivity
Date: Fri, 28 Feb 2014 14:56:45 +0100
Message-ID: <5310959D.709@gmail.com>
References: <CAJHY66EQD280QgXBCoZU4y_aqSEu3A1hXzeW7X-rtT6vMZ92oA@mail.gmail.com>	<xmqqvbw0xrl6.fsf@gitster.dls.corp.google.com>	<530FA0C1.3000109@web.de>	<530FBB1D.3050505@gmail.com> <CAJHY66FtC03YbJrbVn+adsePkYnVD2RGH1TGkzz2pKNBoee_iQ@mail.gmail.com> <53102FB0.6040603@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>,
	Lee Hopkins <leerhop@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 28 14:56:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJNvk-000310-EF
	for gcvg-git-2@plane.gmane.org; Fri, 28 Feb 2014 14:56:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751904AbaB1N4o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Feb 2014 08:56:44 -0500
Received: from mail-ea0-f175.google.com ([209.85.215.175]:36454 "EHLO
	mail-ea0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751712AbaB1N4n (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Feb 2014 08:56:43 -0500
Received: by mail-ea0-f175.google.com with SMTP id z10so2657861ead.20
        for <git@vger.kernel.org>; Fri, 28 Feb 2014 05:56:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=c8FhjGT8MEJ03759NyMoVF4yElHfWBGrujJg38pvD+E=;
        b=FUpcAfNRsDpyplgdY77TUawwRrWUz3YeHi+QgS0l3XPqUwRGW6TIL7Ir4gy5i0353t
         zI4tEUN6CzLBDYtrnrxEmO0LpbClN+d1CafA97MxS01YtUJA4xObJ0X4srovFjkyohf1
         YOQax2PNaXFqfeP1O9GONCl8nTMlJAumxADwzX9dwwYuuJ6e8kpcwwFVS0NSk9zPzcUT
         0wINUHDLa5xW3Y53S2tkYpR75tqhnI/yVICX2xQAUuZIi1aklcDMQ/VoRhLXn3eDav9t
         oQqhTjUvr7YONsVPsHAur2+wFa4sBEX682lHHvGXAGXoX3Oc0oJNOFElC01M/3WxOZUk
         Eoow==
X-Received: by 10.15.99.201 with SMTP id bl49mr21516497eeb.53.1393595802195;
        Fri, 28 Feb 2014 05:56:42 -0800 (PST)
Received: from [10.1.100.54] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id i1sm10717603eeo.16.2014.02.28.05.56.40
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 28 Feb 2014 05:56:41 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.3.0
In-Reply-To: <53102FB0.6040603@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242958>

Am 28.02.2014 07:41, schrieb Johannes Sixt:
> Am 2/28/2014 0:38, schrieb Lee Hopkins:
>>> If I understand the issue correctly, the problem is that packed-refs
>>> are always case-sensitive, even if core.ignorecase=true. OTOH,
> 
> core.ignorecase is intended to affect filenames of the worktree, not
> anything else, BTW.
> 

from git-config(1):
"enables various workarounds to enable git to work better on filesystems that are not case sensitive"

It says nothing about work-tree only, so I'd expect it to apply to all git components that store potentially case-sensitive information in file names.

...it also says "better", not "flawlessly" :-)

>>> checking / updating _unpacked_ refs on a case-insensitive file system
>>> is naturally case-insensitive. So wouldn't it be a better workaround
>>> to disallow packed refs (i.e. 'git config gc.packrefs false')?
>>
>> You are correct, the issue boils down to mixing the usage of 
>> packed-refs and loose refs on case insensitive file systems. So either 
>> always using packed-refs or always using loose refs would take care of 
>> the problem. Based Michael Haggerty's response, it seems that always 
>> using loose refs would be a better workaround.
> 
> So, everybody on a case-insensitive file system should pay the price even
> if they do not need the "feature"? No way.
> 
> If you are on a case-insensitive filesystem, or work on a cross-platform
> project, ensure that you avoid ambiguous refs. Problem solved.
> 

So its OK to lose data if you accidentally use an ambiguous ref? I cannot believe you actually meant that.

IMO the proper solution is to teach packed-refs about core.ignorecase. Until that happens, disabling gc.packrefs seems to be a valid workaround for people who have that problem.
