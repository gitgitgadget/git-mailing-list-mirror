From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [msysGit] Pull request for msysGit patches
Date: Tue, 28 Sep 2010 22:23:42 -0400
Message-ID: <4CA2A32E.3050802@sunshineco.com>
References: <87ocbitd33.fsf@fox.patthoyts.tk> <201009282252.25688.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Pat Thoyts <patthoyts@users.sourceforge.net>,
	msysgit@googlegroups.com, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Wed Sep 29 04:24:04 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P0mKx-0004p8-A7
	for gcvg-git-2@lo.gmane.org; Wed, 29 Sep 2010 04:24:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751858Ab0I2CXr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Sep 2010 22:23:47 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:33936 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751102Ab0I2CXq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Sep 2010 22:23:46 -0400
Received: by gxk9 with SMTP id 9so127999gxk.19
        for <git@vger.kernel.org>; Tue, 28 Sep 2010 19:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=6a4UeEJvUNeTXqe3Na8y9bHUcxPQS4gIi7drKUTQNpQ=;
        b=e6/B6n8IT23ecctpXApJlX+/PgD6zKS2sRUKq+fAh+i4+EzSGLVwLZU1iGR8O0eANZ
         S/MPWoT+QZWUgA77IMwoQ0WXugzADbdyEH2c8RJJmNXT9WKDIH3UAqXtCXCKWVXA7niw
         kCZAHSsqKUA6rJY30JyZuIoSPIKOyP8aQiXQE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=n18VgiiSufxZoPhDFVli7K8gGbYfTn92pYqotsQxPUYDPnZU5HPtLSZnG8WYsVIQO2
         r9K0iSVzl+Tl3czOJPTc+yKPuT4d2R4bfrQihtnG2tbyxLTJqe1Dl5T2kQK7uvISxtQ0
         I2RrPZlPFb6gHyUCk5Vm4gK5MsvyaIfNHCVQw=
Received: by 10.101.185.6 with SMTP id m6mr1067678anp.22.1285727025808;
        Tue, 28 Sep 2010 19:23:45 -0700 (PDT)
Received: from [192.168.1.1] (user-12l2cil.cable.mindspring.com [69.81.50.85])
        by mx.google.com with ESMTPS id w6sm9222659anb.23.2010.09.28.19.23.43
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 28 Sep 2010 19:23:44 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; en-US; rv:1.9.2.9) Gecko/20100915 Thunderbird/3.1.4
In-Reply-To: <201009282252.25688.j6t@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157521>

Hi Hannes,

On 9/28/2010 4:52 PM, Johannes Sixt wrote:
> On Dienstag, 28. September 2010, Pat Thoyts wrote:
>> Junio,
>>
>> The msysGit tree currently tracks some 50+ patches on top of 'next'. I
>> have gathered 42 of these that look good to move upstream.
>
> I've browsed through the list, and I'll annotate my opinion below. When I
> say 'OK', then this means that the patch looks good, but it doesn't imply
> that I have tested it.
>
>>        Side-step line-ending corruption leading to t3032 failures.
>
> This one has non-portable 'export foo=bar', but it is in a MinGW specific
> path, so it should be fine. But why do we need to export GREP_OPTIONS, but
> not SED_OPTIONS?

I also normally avoid unportable 'export foo=bar'. In the particular 
case of GREP_OPTIONS, when commenting on my original patch submission, 
Dscho suggested 'test_have_prereq MINGW && export GREP_OPTIONS=foo' so 
that is the form which made it into the final patch. While considering 
whether this unportable usage was worthwhile, I took into consideration 
the fact that a much more senior project member preferred it, that the 
MinGW-specific build environment is Bash-based, and that a couple other 
test scripts (t1509, t5560) also employ this form. If preferred, the 
patches can be re-submitted to avoid the unportable usage.

Regarding exporting GREP_OPTIONS but not SED_OPTIONS: grep explicitly 
recognizes the GREP_OPTIONS environment variable. My original patch did 
not export GREP_OPTIONS, but instead referenced it as $GREP_OPTIONS in 
the grep invocation. Upon review, Dscho preferred the variable to be 
exported rather than referenced manually as $GREP_OPTIONS. sed, on the 
other hand, does not recognize any 'options' environment variable. It is 
necessary, therefore, to interpolate $SED_OPTIONS directly during the 
sed invocation. This variable is therefore local to the script and need 
not be exported.

-- ES
