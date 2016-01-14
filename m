From: =?windows-1252?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH/RFC] t0060: basename("//") is implementation defined
Date: Thu, 14 Jan 2016 12:47:43 +0100
Message-ID: <56978ADF.5040401@web.de>
References: <1452718561-32226-1-git-send-email-tboegi@web.de> <alpine.DEB.2.20.1601140758420.2964@virtualbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>, tboegi@web.de
X-From: git-owner@vger.kernel.org Thu Jan 14 12:47:59 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJgNh-0004Jx-0J
	for gcvg-git-2@plane.gmane.org; Thu, 14 Jan 2016 12:47:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751777AbcANLrw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jan 2016 06:47:52 -0500
Received: from mout.web.de ([212.227.15.4]:49349 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751317AbcANLrv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jan 2016 06:47:51 -0500
Received: from [192.168.88.199] ([194.47.243.242]) by smtp.web.de (mrweb001)
 with ESMTPSA (Nemesis) id 0LfAbI-1ZqzOf3srY-00okp6; Thu, 14 Jan 2016 12:47:50
 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:31.0) Gecko/20100101 Icedove/31.8.0
In-Reply-To: <alpine.DEB.2.20.1601140758420.2964@virtualbox>
X-Provags-ID: V03:K0:Gw/v6EVhStH2hDcMrJ4jQP5el4ZXz6zyo5XTzwiOawi510DZY1F
 dcUuduwRx36fDSOfy5TsUhOtqHC2xmXjQHJlH0ui0+FkzziMVQ3rJyzSO2WasIc7HG42AQ9
 FpJ3npS2DVjKc4qbHqVQeotGAny3vKN7tvc8otyiLoW8EFrkHtcvgeNC6Ko+LT6TB2xL7wU
 19U1tSl1bIQFjbKeYT9jQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:n0oVe2jMHRE=:V5QbzqEYfNFoQx9VEWcsnz
 5WS5bbbS3afNy4OpB7CPAoR9pB0j0ABh3L+p00VUqlt6CCv0QmzMnT4my/Al+hiJ8FjQHf/mx
 VVL37rsZD/4FXZU2VVZkU9oE3PU4ZUyeXcDciEAi4dIf7B4eaPkrtSCRoN7vB5OVJeLscyxmV
 T1SKELYVNY309HbdZWi597/MqTlwnBRGQyWdPFTr4Mv6Z3KzCtNlyL3oJaS8Qezgvi/8zf5bx
 +Lp9a1Qs3SQsD2smcVOArquxvzWhQB8+BHk3vrttdpmElAkqYb/HXIFzGV4M+46vLVaeTfYWE
 P63uKCMwj3lHD2Rc0KtugExspLffy+hBVeTdV4fGivwThLOVqQQ1VHRD5j8EF1ixbxwKw+UDO
 8Gq3LqGf3dPUvOJE9Qodw0M9NEEIq812eo8F2Ftbe7GD9wjoMaWGeKtHQz5BTKnIn84IfKRfl
 xcevZS6t1g9n0CI0e3VTsy0eDDG1pAXoHexsCmpk0O14TMN3duhMXj8sATgFFTvgse7E/Dt0n
 Sc4VkpbEUGg9OuiKPtPcxRHoG9srFQruH8UYY5tJF3OEFlXCyDZ89z9K2Ddfq7rppMKUbDveY
 lPX/230bHq8xuq8EwtMZ8UWaQt5KssoBkLiklC5mk1usTXbYgn425yEp8vsgWIKH26po5QpSq
 MqLa7YfRJHjLxkN8j5xRktD7JMHEkkO6C+xbW45swiWQwNJk1TPcdFyTxtzznDmOprRXyKx+R
 F5SB+kjHIZUeX+jsFPgPbehE0OGM42PvFpchm5AOi3dPM8STVpwZvvGaZ5NbsCAZm1LaQFaE 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284031>

On 01/14/2016 08:00 AM, Johannes Schindelin wrote:
> Hi Torsten,
>
> On Wed, 13 Jan 2016, tboegi@web.de wrote:
>
>> diff --git a/test-path-utils.c b/test-path-utils.c
>> index 4ab68ac..db0bb39 100644
>> --- a/test-path-utils.c
>> +++ b/test-path-utils.c
>> @@ -142,7 +142,9 @@ static struct test_data dirname_data[] = {
>>   	{ ".",               "."      },
>>   	{ "..",              "."      },
>>   	{ "/",               "/"      },
>> +#if defined(NO_LIBGEN_H)
>>   	{ "//",              "//"     },
>> +#endif
> This would miss faulty implementations that return completely bogus
> outputs for the "//" input. Not very likely, I agree, but the entire
> intention of this regression test is to verify that Git's expectations are
> met (and to document those expectations).
>
> I hope you like the alternative patch I just sent out.
Yepp, looks good. Thanks for the work.
