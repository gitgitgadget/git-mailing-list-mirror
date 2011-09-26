From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: Re: Git is not scalable with too many refs/*
Date: Mon, 26 Sep 2011 17:49:06 +0100
Message-ID: <2b7c307b138bd6061209795056a593ca@quantumfyre.co.uk>
References: <4DF6A8B6.9030301@op5.se>
 <201109260948.25312.mfick@codeaurora.org>
 <CAGdFq_hRmSif4=V+9h8=S1fWfPCj+meRY8xGyfgv=SWk+DrBQw@mail.gmail.com>
 <201109261038.34527.mfick@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Cc: Sverre Rabbelier <srabbelier@gmail.com>, <git@vger.kernel.org>
To: Martin Fick <mfick@codeaurora.org>
X-From: git-owner@vger.kernel.org Mon Sep 26 18:49:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R8EMl-0007aa-Jw
	for gcvg-git-2@lo.gmane.org; Mon, 26 Sep 2011 18:49:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751439Ab1IZQtK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Sep 2011 12:49:10 -0400
Received: from neutrino.quantumfyre.co.uk ([93.93.128.23]:45821 "EHLO
	neutrino.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751191Ab1IZQtJ (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 26 Sep 2011 12:49:09 -0400
Received: from reaper.quantumfyre.co.uk (quantumfyre-1-pt.tunnel.tserv5.lon1.ipv6.he.net [IPv6:2001:470:1f08:1724::2])
	by neutrino.quantumfyre.co.uk (Postfix) with ESMTP id C76DEC0602;
	Mon, 26 Sep 2011 17:49:07 +0100 (BST)
Received: from localhost (localhost [127.0.0.1])
	by reaper.quantumfyre.co.uk (Postfix) with ESMTP id 73BCF36A824;
	Mon, 26 Sep 2011 17:49:07 +0100 (BST)
X-Virus-Scanned: amavisd-new at reaper
Received: from reaper.quantumfyre.co.uk ([127.0.0.1])
	by localhost (reaper.quantumfyre.co.uk [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id w8JDrSkqfkYS; Mon, 26 Sep 2011 17:49:06 +0100 (BST)
Received: from webmail.quantumfyre.co.uk (reaper.quantumfyre.co.uk [192.168.0.2])
	by reaper.quantumfyre.co.uk (Postfix) with ESMTP id C99D436A750;
	Mon, 26 Sep 2011 17:49:06 +0100 (BST)
In-Reply-To: <201109261038.34527.mfick@codeaurora.org>
X-Sender: julian@quantumfyre.co.uk
User-Agent: Roundcube Webmail/0.5.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182131>

On Mon, 26 Sep 2011 10:38:34 -0600, Martin Fick wrote:
> On Monday, September 26, 2011 09:56:50 am Sverre Rabbelier
> wrote:
>> Heya,
>>
>> On Mon, Sep 26, 2011 at 17:48, Martin Fick
> <mfick@codeaurora.org> wrote:
>> > Hmm, I was thinking that too, and I just did a test.
>> >
>> > Instead of storing the changes under refs/changes, I
>> > fetched them under refs/heads/changes and then ran git
>> > 1.7.6 and it took about 3 mins.  Then, I ran the
>> > 1.7.7.rc0.73 with
>> > c774aab98ce6c5ef7aaacbef38da0a501eb671d4 reverted and
>> > it only took 13s!  So, if this indeed tests what you
>> > were suggesting, I think it shows that even in the
>> > intended case this change slowed things down?
>>
>> And if you run 1.7.7 without that commit reverted?
>
> Sorry, I probably confused things by mentioning 1.7.6, the
> bad commit was way before that early 1.5 days...
>
> As for 1.7.7, I don't think that exists yet, so did you mean
> the 1.7.7.rc0.73 version that I mentioned above without the
> revert?  Strangely enough, that ends up being
> 1.7.7.rc0.72.g4b5ea.  That is also slow with
> refs/heads/changes > 3mins.

Hmm ... something interesting is going on.

I created a little test repo with ~100k unpacked refs.

I tried "time git branch" with three versions of git, and I got (hot 
cache times):

git version 1.7.6.1: ~1.2s
git version 1.7.7.rc3: ~1.2s
git version 1.7.7.rc3.1.gbc93f: ~40s

Where the third was with the commit reverted.  That was almost 40s of 
100% CPU - my poor laptop had to turn the fans up to noisy ...

> -Martin

-- 
Julian
