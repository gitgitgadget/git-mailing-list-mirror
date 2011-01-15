From: Maaartin-1 <grajcar1@seznam.cz>
Subject: Re: [RFC/PATCH 2/1] fixup! Documentation: start to explain what git
 replace is for
Date: Sat, 15 Jan 2011 01:04:28 +0100
Message-ID: <4D30E48C.4060400@seznam.cz>
References: <746745466.20110111134101@mail.ru> <20110114084903.GD11343@burratino> <4D308B69.1050003@seznam.cz> <201101142348.31647.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Aleksey Shumkin <zapped@mail.ru>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 15 01:04:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PdtdL-0005dZ-6q
	for gcvg-git-2@lo.gmane.org; Sat, 15 Jan 2011 01:04:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751213Ab1AOAEh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Jan 2011 19:04:37 -0500
Received: from smtp.seznam.cz ([77.75.76.43]:40495 "EHLO smtp.seznam.cz"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750774Ab1AOAEg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Jan 2011 19:04:36 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=beta; d=seznam.cz;
	h=X-Seznam-DomainKeys:X-Seznam-SPF:X-Virus-Info:Received:Message-ID:Date:From:User-Agent:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-Smtpd:X-Seznam-User:X-Session:X-Country:X-QM-Mark;
	b=KjpcWBNVztNx3DK6MYtAKBWXaw1vIEv90YoCLMjV0zP00ZEBC+RIIf+snySo9aoWR
	Cev2PqBtDKpbvVWipRVazVR4qxYEw3w5/3WnkKN8hqISAnkY/9y3rWzs8F8rC7gaO7T
	2eIFprmcTq7j3EMYsDSRd5m7OZXE+R/VKm2s+n0=
X-Seznam-DomainKeys: unknown
X-Seznam-SPF: neutral
X-Virus-Info: clean
Received: from [10.0.3.100] (188-120-198-113.luckynet.cz [188.120.198.113])
	by email-relay2.ng.seznam.cz (Seznam SMTPD 1.2.14@16206) with ESMTP;
	Sat, 15 Jan 2011 01:04:30 +0100 (CET)  
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.2; en-US; rv:1.9.2.13) Gecko/20101207 Thunderbird/3.1.7
In-Reply-To: <201101142348.31647.jnareb@gmail.com>
X-Smtpd: 1.2.14@16206
X-Seznam-User: grajcar1@seznam.cz
X-Session: 16557
X-Country: CZ
X-QM-Mark: email-qm1<575400087>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165130>

On 11-01-14 23:48, Jakub Narebski wrote:
> On Fri, 14 Jan 2011, Maaartin-1 wrote:
>> On 11-01-14 09:49, Jonathan Nieder wrote:
>>> Some tweaks suggested by Maaartin:

>>> [side note: please do not prune the cc list; I only stumbled on this
>>> message in the online archive by luck]
>>
>> What could I have done about it? I didn't received it by email and
>> answered using post.gmane.org. There's no way to add CC there. If I'd
>> wrote an email instead, it wouldn't be placed in the thread.
> 
> In a good newsreader, like e.g. Gnus from GNU Emacs, you have option
> to do 'reply all via email', which includes also git@vger.kernel.org,
> i.e. mailing list from which gmane newsgroup is created.  That's what
> I do nowadays (usually).

I hate using Emacs for too many things. However, I'm starting to use
Thunderbird as newsreader, and it's quite OK.

>> I'd go the other way round and use "-i" so I'd need only one file. Using
>> a shell variable instead would be even better, s. below.
> 
> No, using shell variable for storing commit object is *not* a good idea.
> Either save it to temporary file, where you can edit it using editor of
> your choice, or use pipeline.

I see that the line-breaks get (for whatever reason) replaced by blanks,
sorry for the noise.

>>> +$ sed "/^tree / a \\
>>> +parent $(git rev-parse v2.4)" <tmp >new                <4>
>>
>> $ first_commit = $($ echo $first_commit |
>> sed  "/^tree / a \\
>> parent $(git rev-parse v2.4)")                      <4>
>>
>> Unfortunately, the line got too long. For sed unaware people like me it
>> may not be obvious that a line break is required.
> 
> No, it is not required, I think.

You're right, sorry again.

> If you don't use temporary file, which you can edit, you can use pipeline
> instead:
> 
>   $ new_commit=$(git cat-file commit $first_commit |
>                  sed -e "/^tree / a\\parent $(git rev-parse v2.4)" |
>                  git hash-object -t commit -w --stdin
> 
>   $ git replace $first_commit $new_commit

I know, I just thought, using such a pipe is not very enlightening, but
it's actually quite easy to follow.
