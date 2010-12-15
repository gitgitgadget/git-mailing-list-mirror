From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 11/14] t3032-*.sh: Pass the -b (--binary) option to sed
 on cygwin
Date: Wed, 15 Dec 2010 04:30:30 -0500
Message-ID: <4D088AB6.5090501@sunshineco.com>
References: <4D07B8B5.2030409@ramsay1.demon.co.uk> <7vtyigtaxn.fsf@alter.siamese.dyndns.org> <4D07FE91.2090003@sunshineco.com> <4D087AC7.2090705@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	GIT Mailing-list <git@vger.kernel.org>,
	Pat Thoyts <patthoyts@gmail.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Dec 15 10:37:07 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PSnnH-0006iT-00
	for gcvg-git-2@lo.gmane.org; Wed, 15 Dec 2010 10:37:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752238Ab0LOJg6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Dec 2010 04:36:58 -0500
Received: from mail-vw0-f52.google.com ([209.85.212.52]:51376 "EHLO
	mail-vw0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752208Ab0LOJg4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Dec 2010 04:36:56 -0500
X-Greylist: delayed 382 seconds by postgrey-1.27 at vger.kernel.org; Wed, 15 Dec 2010 04:36:56 EST
Received: by vws13 with SMTP id 13so686782vws.11
        for <git@vger.kernel.org>; Wed, 15 Dec 2010 01:36:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=8hTKBo+eGfNBwusWvrNpQ9cBck2c59MySBJGDnn9Lrw=;
        b=A2VZSgm5WxEhv5pu6ghnfJzssIrBKPumo4t4XyoOjT0SI59RCZqQDvM5OJGHhWVhcM
         6Dnyj58XdTp1zFMdZv8sYlKPBODxKg4JZnIS/otKmMiNGeADop0GYeeFViEnXPlaXwTX
         971o6S7wIpFjUQNktLGApZB6EMWVH85CKQc5A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=Z+kJPTztIQtjyRTFeEUgmLrGQ4RYkrSLM+mRAJ2ZTYX+eSuFMBNWcEEqSL3ZNyc+jd
         sPPPrYhztHJbOwXB39reL1+N2TYE6AcOtaEbte562gRllGKMv8UY4cpEVtLd2nZV7oNz
         ELtE1GLkN6zyU3nbqp9uSKaqWUdP3hfZTPBgc=
Received: by 10.220.181.135 with SMTP id by7mr1698989vcb.258.1292405434118;
        Wed, 15 Dec 2010 01:30:34 -0800 (PST)
Received: from [192.168.1.2] (user-12l2cil.cable.mindspring.com [69.81.50.85])
        by mx.google.com with ESMTPS id w15sm406195vbx.10.2010.12.15.01.30.32
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 15 Dec 2010 01:30:32 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; en-US; rv:1.9.2.13) Gecko/20101207 Thunderbird/3.1.7
In-Reply-To: <4D087AC7.2090705@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163750>

On 12/15/2010 3:22 AM, Johannes Sixt wrote:
> Am 12/15/2010 0:32, schrieb Eric Sunshine:
>> On 12/14/2010 2:24 PM, Junio C Hamano wrote:
>>> Ramsay Jones<ramsay@ramsay1.demon.co.uk>   writes:
>>>> The test using the conflict_hunks helper function (test 9) fails
>>>> on cygwin, since sed (by default) throws away the CR from CRLF
>>>> line endings. This behaviour is undesirable, since the validation
>>>> code expects the CRLF line-ending to be present. In order to fix
>>>> the problem we pass the -b (--binary) option to sed, using the
>>>> SED_OPTIONS variable. We use the SED_STRIPS_CR prerequisite in the
>>>> conditional initialisation of SED_OPTIONS.
>>>>
>>>> Signed-off-by: Ramsay Jones<ramsay@ramsay1.demon.co.uk>
>>>> ---
>>>>
>>>> Note that this test does not fail on MinGW, but I don't
>>>> really know why, given commit ca02ad3... ahem ;-)
>>>
>>> Ahem, indeed.  Why?
>>
>> t3032 does indeed fail on MinGW, and was fixed in the msysgit port by [1],
>> but was subsequently "lost" when msysgit was rebased onto junio/next [2]
>> which did not have that test. Consequently, the fix never made it into the
>> mainline git source.
>
> Sorry, but on MinGW, I only need the GREP_OPTIONS part of that fix, but
> not the SED_OPTIONS. It's also mysterious for me.
>
> OTOH, the fix in ca02ad3 that applies to t6038, does not work for me as is
> because my sed does not understand -b; it needs --nocr. Maybe it is the
> sed version that makes the difference?
>
> D:\Src\mingw-git\t>sed --version
> GNU sed version 3.02

Failure of t3032 was reported by Pat Thoyts [1] when preparing for the 
v1.7.3 release. The problem was diagnosed and patched via [2] under the 
standard msysgit netinstall [3] environment. From commit message [2], 
GREP_OPTIONS and SED_OPTIONS were applied to resolve distinct cases of 
line-terminator "corruption" (t3032.4-t3032.8 and t3032.9, respectively) 
within that environment at the time the patch was prepared.

Your tool versions may indeed not be compatible with those of the 
netinstall environment [3]:

$ sed --version
GNU sed version 4.2.1

Unfortunately, the old --nocr is not recognized by modern GNU sed:

$ sed --nocr
sed: unrecognized option `--nocr'

[1]: 
http://groups.google.com/group/msysgit/browse_thread/thread/70110298ae72caea/a39b121bb0feccf4?lnk=gst&q=t3032#a39b121bb0feccf4
[2]: 
http://groups.google.com/group/msysgit/browse_thread/thread/587d32ee034b0cbe/dca93dc6ad755012#dca93dc6ad755012
[3]: http://code.google.com/p/msysgit/downloads/list 
[msysGit-netinstall-1.7.3.1-preview20101002.exe]

-- ES
