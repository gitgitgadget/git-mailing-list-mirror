From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 11/14] t3032-*.sh: Pass the -b (--binary) option to sed
 on cygwin
Date: Tue, 14 Dec 2010 18:32:33 -0500
Message-ID: <4D07FE91.2090003@sunshineco.com>
References: <4D07B8B5.2030409@ramsay1.demon.co.uk> <7vtyigtaxn.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	GIT Mailing-list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 15 00:32:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PSeMQ-0005SA-RQ
	for gcvg-git-2@lo.gmane.org; Wed, 15 Dec 2010 00:32:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754982Ab0LNXcl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Dec 2010 18:32:41 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:50697 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753573Ab0LNXck (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Dec 2010 18:32:40 -0500
Received: by qwa26 with SMTP id 26so1339539qwa.19
        for <git@vger.kernel.org>; Tue, 14 Dec 2010 15:32:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=l4ASG6D8N6kvNLIdg2MhfoKrtlnipQU6qDklLlkTzFw=;
        b=lhyMT0qygOi+8LWRiH5afXeN2T/YVRYxrgvDdUZg9Ab/mUlS++DJXe6fggSAwV3/sP
         QoU0zVIgUQzAop4ZhGlk3n2lZXz0GiAe10/quFFG13tDEIAXgH5inBhtEtOahHXUjOtE
         QyR3lrXBS7mN6MY+8EVIKtzS8DetQNBomkfuY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=x1AWRIpjpoVSVH3ZdJcroW107wkxHNNr9smVhcBJGI11AtPfcla6WxynRvxOl1Pjgz
         lm6pnfzgN4jqMUgylzPMmO+xAKUIazQcay7Ec+ZD3WP9Na6XJkELmatIU+A2hyGs+rAZ
         HPa+PFp6q1W6EEiUtT8kAvHw6bWBHlfNLcs6c=
Received: by 10.224.67.146 with SMTP id r18mr5744770qai.91.1292369559429;
        Tue, 14 Dec 2010 15:32:39 -0800 (PST)
Received: from [192.168.1.2] (user-12l2cil.cable.mindspring.com [69.81.50.85])
        by mx.google.com with ESMTPS id k15sm309489qcu.35.2010.12.14.15.32.37
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 14 Dec 2010 15:32:38 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; en-US; rv:1.9.2.13) Gecko/20101207 Thunderbird/3.1.7
In-Reply-To: <7vtyigtaxn.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163720>

On 12/14/2010 2:24 PM, Junio C Hamano wrote:
> Ramsay Jones<ramsay@ramsay1.demon.co.uk>  writes:
>> The test using the conflict_hunks helper function (test 9) fails
>> on cygwin, since sed (by default) throws away the CR from CRLF
>> line endings. This behaviour is undesirable, since the validation
>> code expects the CRLF line-ending to be present. In order to fix
>> the problem we pass the -b (--binary) option to sed, using the
>> SED_OPTIONS variable. We use the SED_STRIPS_CR prerequisite in the
>> conditional initialisation of SED_OPTIONS.
>>
>> Signed-off-by: Ramsay Jones<ramsay@ramsay1.demon.co.uk>
>> ---
>>
>> Note that this test does not fail on MinGW, but I don't
>> really know why, given commit ca02ad3... ahem ;-)
>
> Ahem, indeed.  Why?

t3032 does indeed fail on MinGW, and was fixed in the msysgit port by 
[1], but was subsequently "lost" when msysgit was rebased onto 
junio/next [2] which did not have that test. Consequently, the fix never 
made it into the mainline git source.

[1]: 
http://groups.google.com/group/msysgit/browse_thread/thread/587d32ee034b0cbe/dca93dc6ad755012#dca93dc6ad755012
[2]: 
http://groups.google.com/group/msysgit/browse_thread/thread/d522ec5c13a3af0b/718eaedffc042fb5#718eaedffc042fb5

-- ES
