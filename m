From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Problem signing a tag
Date: Wed, 04 Nov 2009 15:28:10 +0100
Message-ID: <4AF18F7A.2000904@drmicha.warpmail.net>
References: <200911021558.17550.joshua@eeinternet.com> <81b0412b0911022331q2976b6e6u575a9700b212623d@mail.gmail.com> <200911030911.47030.joshua@eeinternet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
To: "Joshua J. Kugler" <joshua@eeinternet.com>
X-From: git-owner@vger.kernel.org Wed Nov 04 15:29:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5grK-0007Ls-1N
	for gcvg-git-2@lo.gmane.org; Wed, 04 Nov 2009 15:29:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756590AbZKDO2P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Nov 2009 09:28:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756579AbZKDO2O
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Nov 2009 09:28:14 -0500
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:54134 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756571AbZKDO2N (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 4 Nov 2009 09:28:13 -0500
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 129D3BEEF6;
	Wed,  4 Nov 2009 09:28:18 -0500 (EST)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Wed, 04 Nov 2009 09:28:18 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=555b83hyZa0nxKfjQGQg48b9mK4=; b=KqXQyGaJBWkDF8vTAYYmB5JLBw9t7ZrWj1Zm+wTYxs4ouEBBAAiF5ue5anQbixmF1JVebp6SrjpuIfbD9YmR6z7qj/aiiv5etJp7Jhxf8HWDKdSI4tUPpae37Ztqc2V9QsTtiopgAoZYuf+nd5tXQivSxvEbC8/wqyVcvt8Ry+M=
X-Sasl-enc: auWqOICGzVBED0+bo+2F6jdaYzNH5YSYYsNw94wcj0Qa 1257344897
Received: from localhost.localdomain (heawood.math.tu-clausthal.de [139.174.44.4])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 4D3ED4A54F1;
	Wed,  4 Nov 2009 09:28:17 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.6pre) Gecko/20091104 Lightning/1.0pre Shredder/3.0pre
In-Reply-To: <200911030911.47030.joshua@eeinternet.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132088>

Joshua J. Kugler venit, vidit, dixit 03.11.2009 19:11:
> On Monday 02 November 2009, Alex Riesen said something like:
>> On Tue, Nov 3, 2009 at 01:58, Joshua J. Kugler <joshua@eeinternet.com> 
> wrote:
>>> Nobody on the git IRC channel responded to this question, even
>>> after asking it a few times, so I thought I'd try here.
>>>
>>> I'm having trouble signing a tag.  I'm using this command:
>>>
>>> git tag -u EAFD344D14EA086E -F .git/TAG_EDITMSG tag_name
>>>
>>> I type in my passphrase, and am then told:
>>>
>>> error: gpg failed to sign the tag
>>> error: unable to sign the tag
>>>
>>> However, if I use this command:
>>>
>>> gpg -s -u EAFD344D14EA086E
>>>
>>> and use the same passphrase, it works fine. Is there any way to
>>> find out why a key-signing is failing?
>>
>> What does "echo $?" after it prints? IOW, maybe plain gpg fails too,
>> without printing anything special, and you don't pay attention to the
>> exit code. Git does. And it runs "gpg -bsau <key-id>".
> 
> $ git tag -s -F .git/TAG_EDITMSG tag_name
> 
> You need a passphrase to unlock the secret key for
> user: "Joshua J. Kugler <joshua@azariah.com>"
> 1024-bit DSA key, ID 14EA086E, created 2009-08-09
> 
> gpg: problem with the agent - disabling agent use
> error: gpg failed to sign the tag
> error: unable to sign the tag
> $ echo $?
> 128
> 
> And when I sign at the prompt:
> 
> $ gpg -sa
> 
> You need a passphrase to unlock the secret key for
> user: "Joshua J. Kugler <joshua@azariah.com>"
> 1024-bit DSA key, ID 14EA086E, created 2009-08-09
> 
> gpg: problem with the agent - disabling agent use
> Blah blah blah blah
> Blah blah blah blah
> $ echo $?
> 2

[...]

I assume you don't want to use gpg-agent, that should be the easy way out.

If gpg is trying to contact the agent it means that "use-agent" is set
(from the config) and, probably, also that GPG_AGENT_INFO is set but no
agent responds at that socket. (echo $GPG_AGENT_INFO)

Many distros set up this stuff automatically. Try unsetting both:
unset GPG_AGENT_INFO
gpg --no-use-agent ...

If that helps you can put "--no-use-agent" in your gpg config.

2 is a non-fatal error, 128 a fatal one, btw.

Michael
