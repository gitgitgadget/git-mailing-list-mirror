From: Alex Vandiver <alex@chmrr.net>
Subject: Re: Race condition in git push --mirror can cause silent ref rewinding
Date: Mon, 14 Jul 2014 00:09:16 -0400
Message-ID: <53C357EC.8060300@chmrr.net>
References: <53B47535.3020101@chmrr.net> <xmqqfvijflnr.fsf@gitster.dls.corp.google.com> <53B49173.4020001@chmrr.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 14 06:15:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X6Xfu-0002jj-3P
	for gcvg-git-2@plane.gmane.org; Mon, 14 Jul 2014 06:15:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750770AbaGNEPe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jul 2014 00:15:34 -0400
Received: from chmrr.net ([173.237.205.2]:42206 "EHLO mycon.chmrr.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750703AbaGNEPd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jul 2014 00:15:33 -0400
X-Greylist: delayed 371 seconds by postgrey-1.27 at vger.kernel.org; Mon, 14 Jul 2014 00:15:33 EDT
Received: from localhost (localhost [127.0.0.1])
	by mycon.chmrr.net (Postfix) with ESMTP id 56EE3100C3C;
	Mon, 14 Jul 2014 00:09:21 -0400 (EDT)
X-Virus-Scanned: Debian amavisd-new at chmrr.net
Received: from mycon.chmrr.net ([127.0.0.1])
	by localhost (mycon.chmrr.net [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id H2Lv6YkTPjpO; Mon, 14 Jul 2014 00:09:16 -0400 (EDT)
Received: from [10.0.1.28] (c-65-96-172-157.hsd1.ma.comcast.net [65.96.172.157])
	(using TLSv1 with cipher ECDHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mycon.chmrr.net (Postfix) with ESMTPSA id A7524100B0D;
	Mon, 14 Jul 2014 00:09:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=chmrr.net; s=mail;
	t=1405310956; bh=DVPAM2BlfRbXm8olLqRQRkjZFtrDp2FBDdl+AotXB/0=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=cwXpEwQSBQs/IkLTIwxmpWqRk09JdpF+JNUjvbPjYPB1iRJq+iT97piKlSNjx30Gq
	 TRuiZp5Y4IpX+Ja3amYmLyarE9sHvqcThxokwD05qGACG/2YrB5fQfAUMluZcbjy+2
	 EdmmX+GZBRFVvyY/zBW0YLA8XWD3VaZTvV/38fNU=
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <53B49173.4020001@chmrr.net>
X-Enigmail-Version: 1.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253465>

On 07/02/2014 07:10 PM, Alex Vandiver wrote:
> On 07/02/2014 06:20 PM, Junio C Hamano wrote:
>> Alex Vandiver <alex@chmrr.net> writes:
>>
>>>     [remote "github"]
>>>         url = git@github.com:bestpractical/rt.git
>>>         fetch = +refs/*:refs/*
>>>         mirror = yes
>>
>> "git push github master^:master" must stay a usable way to update
>> the published repository to an arbitrary commit, so "if set to
>> mirror, do not pretend that a fetch in reverse has happened during
>> 'git push'" will not be a solution to this issue.
> 
> Hm?  I'm confused, as mirror isn't compatible with refspecs:
> 
> $ git push github master^:master
> error: --mirror can't be combined with refspecs

Just following up on this -- can you clarify your statement about "git
push github master^:master" in light of the fact that --mirror already
disallows such?
 - Alex
