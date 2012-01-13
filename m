From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: [RFC][PATCH v2] git on Mac OS and precomposed unicode
Date: Fri, 13 Jan 2012 22:52:46 +0100
Message-ID: <4F10A7AE.6030004@web.de>
References: <201201091745.30415.tboegi@web.de> <7vd3asejrr.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, tb <tboegi@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 13 22:53:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rlp3Z-0003pB-QO
	for gcvg-git-2@lo.gmane.org; Fri, 13 Jan 2012 22:53:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759287Ab2AMVxA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Jan 2012 16:53:00 -0500
Received: from fmmailgate02.web.de ([217.72.192.227]:43558 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754002Ab2AMVw7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jan 2012 16:52:59 -0500
Received: from moweb002.kundenserver.de (moweb002.kundenserver.de [172.19.20.108])
	by fmmailgate02.web.de (Postfix) with ESMTP id 0047C1BFA101B
	for <git@vger.kernel.org>; Fri, 13 Jan 2012 22:52:53 +0100 (CET)
Received: from [192.168.209.16] ([194.22.188.61]) by smtp.web.de (mrweb002)
 with ESMTPA (Nemesis) id 0Lilcj-1SOSan3Jcb-00cfII; Fri, 13 Jan 2012 22:52:52
 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.24) Gecko/20111101 SUSE/3.1.16 Thunderbird/3.1.16
In-Reply-To: <7vd3asejrr.fsf@alter.siamese.dyndns.org>
X-Provags-ID: V02:K0:500Z4vqX9fha32QG+qjEmiCNiBdqNUf92mcb7UmPYhb
 Svtp2hDBG555KWYGXYwSgewudLYz4bFZz7/EQVGoH3YJLYkPQi
 0pOB4O6d7egBbxYbsB3ovDKSrR2pc8CSzWvkLRRnXO5WXE2K4k
 HWfPaGsaLJL0tMqJAH5VWzlcFkuqwqXn6XesjNIdY9jAg/hwQb
 w2fuBoN4NmC4LLuIt5Vjg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188539>

On 01/09/2012 08:52 PM, Junio C Hamano wrote:
[snip]
 >probe_utf8_pathname_composition(path, len);
Done

[snip]

 >and implementation of the function body in compat/darwin.c (Didn't I see a
 >comment on the name of this file, by the way? What was the conclusion of
 > the discussion?).

I renamed the compat/darwin.[ch] into compat/precomposed_utf8.[ch]
>> +{
>> +	int i = 0;
>> +	int first_arg = 0; /* convert everything */
>> +	const char *oldarg;
>> +	char *newarg;
>> +	iconv_t ic_precompose;
>> +
>> +	git_config(precomposed_unicode_config, NULL);
>
> Hmmmmm.  Is it safe to call git_config() this early in the program?  Have
> we determined if we are in a git managed repository and where its $GIT_DIR
> is?
>
According to my understanding, yes:
git_config is called with the custom function precomposed_unicode_config():

git_config(precomposed_unicode_config, NULL);


where
  precomposed_unicode_config()

fishes for the config variable  "core.precomposedunicode" and puts the 
result into
int precomposed_unicode_config.

After that, when precomposed_unicode_config==0, argv_precomposed() will 
return.


  I'll send the V3 RFC/PATCH
/Torsten
