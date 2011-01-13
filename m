From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Applying .gitattributes text/eol changes
Date: Thu, 13 Jan 2011 14:23:09 +0100
Message-ID: <4D2EFCBD.4020402@drmicha.warpmail.net>
References: <4D220500.2000104@syntevo.com> <4D2C4902.4010705@drmicha.warpmail.net> <4D2C62DF.20706@syntevo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Marc Strapetz <marc.strapetz@syntevo.com>
X-From: git-owner@vger.kernel.org Thu Jan 13 14:26:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PdNBb-0005fm-0V
	for gcvg-git-2@lo.gmane.org; Thu, 13 Jan 2011 14:25:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756732Ab1AMNZt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Jan 2011 08:25:49 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:51895 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756667Ab1AMNZs (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 13 Jan 2011 08:25:48 -0500
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 85A92204F6;
	Thu, 13 Jan 2011 08:25:47 -0500 (EST)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute3.internal (MEProxy); Thu, 13 Jan 2011 08:25:47 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=UVg1jF58GcynSLlMQ6YAVlCYT8U=; b=XlQYsLPGVVF4HIVvVoDqyugGQO8pSwwnoZmeZ5Pf6Oup6svR7ZyOxAdOMtmvjhCLVTM+8OV8VMtoANZgE8/9alPV4bKpUzrZAk5S/yWmHeoAU+C1JsrcMhW5cl3PC4n+1jP+VODiHiz5qe2b0lpE2yfAqlWDnKOi4EKwm+nUNao=
X-Sasl-enc: WNIIRz/EPDhOxrNT9rYll90DQ87IvkftbBdFoYihyfVd 1294925147
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 0B9A944048D;
	Thu, 13 Jan 2011 08:25:46 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.13) Gecko/20101209 Fedora/3.1.7-0.35.b3pre.fc14 Lightning/1.0b3pre Thunderbird/3.1.7
In-Reply-To: <4D2C62DF.20706@syntevo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165051>

Marc Strapetz venit, vidit, dixit 11.01.2011 15:02:
> On 11.01.2011 13:11, Michael J Gruber wrote:
>> Marc Strapetz venit, vidit, dixit 03.01.2011 18:18:
>>> I'm looking for an unobtrusive way to apply (committed) changes for
>>> text/eol attributes to the working tree. For instance, after having
>>> changed "*.txt eol=crlf" to "*.txt eol=lf", all *.txt files should be
>>> converted from CRLF to LF endings. The only advice I found so far is to
>>> remove .git/index and do a reset --hard. The disadvantage of this
>>> approach is that every file will be touched:
>>>
>>> - although the content does not change, timestamps will be changed. This
>>
>> The bytewise content does change.
> 
> The content has only changed for *.txt files, but the timestamps of
> *all* files are updated. I guess (but didn't verify from code), that in

Well, sure...

> case of missing .git/index, Git freshly writes all working tree files,
> ignoring already existing files which already have the correct content.
> Maybe this behavior is by intention and makes sense in some cases. In my
> case it has adverse effects on IDEs and probably other tools which are
> monitoring the file system.

...but changing gitattributes is something you don't do routinely in
your workflow; so, at worst there would be an occasional unnecessary run
of your build process.

> 
>>> One solution I could think of which might be helpful in other situations
>>> as well would be to have an "--unobtrusive" option for reset which would
>>> only replace a file if the content has actually been changed.
>>
>> How about
>>
>> git ls-files \*.txt | xargs touch -a
>> git ls-files \*.txt | git checkout
> 
> That won't be helpful as it requires me to know what has changed.

But you do know that only (at most) *.txt have changed!

Michael
