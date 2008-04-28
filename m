From: Paolo Bonzini <bonzini@gnu.org>
Subject: Re: [PATCH] rebase--interactive: Replace unportable 'tac' by a sed
   script.
Date: Mon, 28 Apr 2008 10:58:04 +0200
Message-ID: <4815919C.6060001@gnu.org>
References: <8D73338C-4EC3-4078-8A34-51DAC1842C2B@silverinsanity.com> <20080427064250.GA5455@sigill.intra.peff.net> <739FA851-F7F5-4CF9-B384-25AA7022B0C2@silverinsanity.com> <48158070.7090007@viscovery.net> <7v7ieie6hm.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Brian Gernhardt <benji@silverinsanity.com>,
	Jeff King <peff@peff.net>, git list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 28 10:59:18 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JqPCJ-0004xL-T1
	for gcvg-git-2@gmane.org; Mon, 28 Apr 2008 10:58:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761101AbYD1I6H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2008 04:58:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760683AbYD1I6H
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Apr 2008 04:58:07 -0400
Received: from fg-out-1718.google.com ([72.14.220.152]:27264 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757106AbYD1I6F (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2008 04:58:05 -0400
Received: by fg-out-1718.google.com with SMTP id l27so4859914fgb.17
        for <git@vger.kernel.org>; Mon, 28 Apr 2008 01:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:newsgroups:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:sender;
        bh=/92VrJo12h1UmvX9En9S1F8lJtr7MgfJXI4h3u6jYwc=;
        b=vWlmzf6+qEdL4YFrg8CyKVS87vgVbeU3WskqIUVa9ylBmTphVeQoczjzF3tN8Y5JYnVvinJ4ViVD04gHzvbhrH9RoRJ5zE42v5t22mdePM4bH0yRJ1h82hCrYP7RPcGCFb0I+z5VkAg8mqiEBwXTiiaBDES75r3EeHfo9GK0zkU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:newsgroups:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:sender;
        b=I+KbROS1cIPHTYwuQDBVvyg2qB7rCCk7BB8snYENraQwTCWZNcAPJWT0YtgnqN0KybBFKqgmIa0YMB34kPv/BjNCDW115ZNxF3JCkwRlFqC+9Pyv/0JsYL7ZuJqeWPUPBl7IOLUkVDo95s5p4DHZmQ/mni4XuDQ1L4k0L6Shapg=
Received: by 10.86.59.18 with SMTP id h18mr7099547fga.22.1209373083832;
        Mon, 28 Apr 2008 01:58:03 -0700 (PDT)
Received: from scientist-2.local ( [195.176.178.209])
        by mx.google.com with ESMTPS id j10sm8502363mue.14.2008.04.28.01.58.02
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 28 Apr 2008 01:58:03 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.12 (Macintosh/20080213)
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <7v7ieie6hm.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80509>


>> Here's my try, which avoids the perl hammer. ;)
>> ...
>> -	tac | \
>> +	sed -ne '1!G;$p;h' | \
> 
> Thanks for trying, but frankly, I'd prefer the Perl hammer, as any
> advanced sed scripting tend to be far less portable.

In fact this script is not portable. :-(  Not so much because of its 
"advanced-ness", but because it loads the entire file in memory, and 
thus hits the limit on the buffer length of many seds.

Paolo
