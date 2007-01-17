From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC] Git config file reader in Perl (WIP)
Date: Wed, 17 Jan 2007 13:11:35 +0100
Message-ID: <200701171311.36358.jnareb@gmail.com>
References: <200701150144.56793.jnareb@gmail.com> <200701171048.03686.jnareb@gmail.com> <Pine.LNX.4.63.0701171138371.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Nikolai Weibull <now@bitwi.se>, Junio C Hamano <junkio@cox.net>,
	Eric Wong <normalperson@yhbt.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 17 13:11:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H79de-0004wK-46
	for gcvg-git@gmane.org; Wed, 17 Jan 2007 13:11:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750696AbXAQMLM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 17 Jan 2007 07:11:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750969AbXAQMLM
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Jan 2007 07:11:12 -0500
Received: from ug-out-1314.google.com ([66.249.92.170]:14296 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750696AbXAQMLK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jan 2007 07:11:10 -0500
Received: by ug-out-1314.google.com with SMTP id 44so1970277uga
        for <git@vger.kernel.org>; Wed, 17 Jan 2007 04:11:09 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=BFw59ibvvYq8YVtdCDlz9JHDZfK1MUpKLLhrtiuxi8JmdfRUxebbnT1QJ5SzlY3eDHRE6dnC1NQ/z4id61nBAmx0tGGrcXGT58RJioiU/M+vJOtB8Z36y2HnTr5O81IEWlqdkMn26eWQG5q1PutgMfS9a+wdCanv4oCgkKGtN+M=
Received: by 10.67.97.7 with SMTP id z7mr9354693ugl.1169035869069;
        Wed, 17 Jan 2007 04:11:09 -0800 (PST)
Received: from host-81-190-20-200.torun.mm.pl ( [81.190.20.200])
        by mx.google.com with ESMTP id 29sm8485424uga.2007.01.17.04.11.08;
        Wed, 17 Jan 2007 04:11:08 -0800 (PST)
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
User-Agent: KMail/1.9.3
In-Reply-To: <Pine.LNX.4.63.0701171138371.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36995>

Johannes Schindelin wrote:
> 
> On Wed, 17 Jan 2007, Jakub Narebski wrote:
> 
>> Johannes Schindelin wrote:
>>> 
>>> On Wed, 17 Jan 2007, Jakub Narebski wrote:
>>> 
>>>> Johannes Schindelin wrote:
>>>> 
>>>>> So, how about a "git repo-config --dump" which outputs a stream of NUL 
>>>>> separated keys and values? This should be really easy to "parse", and 
>>>>> there are no ambiguities: No key or value can contain a NUL.
>>>> 
>>>> Good idea, although "\n" would work as well as NUL.
>>> 
>>> No it would not:
>>> 
>>> 	[someSection]
>>> 		thisKey = has\na\nvalue\with\nseveral\nnewlines
>> 
>> $ fatal: bad config file line <nn> in <config>
> 
> Yeah, sorry. But you got the point.

No, I don't got the point. No key or value can contain "\n".

>>>> The only problem is with "key without value" case, i.e. something like
>>>> 
>>>>   [section]
>>>>   	noval
>>>> 
>>>> which shows as
>>>> 
>>>>   section.noval
>>> 
>>> but is equivalent to
>>> 
>>> 	[section]
>>> 		noval = true
>>> 
>>> Since it is by definition a boolean value.
>> 
>> But only for "git repo-config --bool --get section.noval" output.
>> Semantically equivalent to "true".
>> 
>> But without --bool it returns like it was "".
> 
> Yes, it returns "", but this is _wrong_. A single "[section] noval" _only_ 
> makes sense as a boolean. The information lies in its _presence_, which is 
> as good as saying "true".

With "\n" as separator you can simply rrturn NUL in the noval case.

-- 
Jakub Narebski
Poland
