From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: RFC: git cat-file --follow-symlinks?
Date: Thu, 30 Apr 2015 12:04:10 +0200
Message-ID: <87383ihqzp.fsf@igel.home>
References: <1430341032.14907.9.camel@ubuntu>
	<xmqqlhha4otr.fsf@gitster.dls.corp.google.com>
	<1430343059.14907.18.camel@ubuntu> <20150429214817.GA2725@peff.net>
	<1430346576.14907.40.camel@ubuntu> <20150429231150.GB3887@peff.net>
	<20150430003750.GA4258@peff.net> <1430355983.14907.55.camel@ubuntu>
	<20150430011612.GA7530@peff.net> <1430358345.14907.62.camel@ubuntu>
	<20150430033725.GB12361@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: David Turner <dturner@twopensource.com>,
	Junio C Hamano <gitster@pobox.com>,
	git mailing list <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Apr 30 12:05:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YnlKb-0002CB-3L
	for gcvg-git-2@plane.gmane.org; Thu, 30 Apr 2015 12:04:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751798AbbD3KER (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Apr 2015 06:04:17 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:57248 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751414AbbD3KEP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Apr 2015 06:04:15 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
	by mail-out.m-online.net (Postfix) with ESMTP id 3lcskM60Hsz3hhV1;
	Thu, 30 Apr 2015 12:04:11 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
	by mail.m-online.net (Postfix) with ESMTP id 3lcskM2dv8zvjDv;
	Thu, 30 Apr 2015 12:04:11 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
	by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavisd-new, port 10024)
	with ESMTP id xMQcqmfHQ93N; Thu, 30 Apr 2015 12:04:10 +0200 (CEST)
X-Auth-Info: 6s8wJHk12HqjKqyEcHNq1RSa7YmEjtdTtjY3rvlhtOjVYO1jUQHJpTJTPC/bK3fz
Received: from igel.home (ppp-93-104-94-204.dynamic.mnet-online.de [93.104.94.204])
	by mail.mnet-online.de (Postfix) with ESMTPA;
	Thu, 30 Apr 2015 12:04:10 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
	id 38A802C3C8B; Thu, 30 Apr 2015 12:04:10 +0200 (CEST)
X-Yow: I'm a fuschia bowling ball somewhere in Brittany
In-Reply-To: <20150430033725.GB12361@peff.net> (Jeff King's message of "Wed,
	29 Apr 2015 23:37:25 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268067>

Jeff King <peff@peff.net> writes:

>   4. Return the last object we could resolve, as I described. So
>      foo/bar/baz (with "../../../external" as its content) in this case.
>      When you resolve a name, you can ask for the context we discovered
>      along the way by traversing the tree. The mode is one example we've
>      already discussed, but the path name is another. So something like:
>
>        echo "HEAD^{resolve}:fleem" |
>        git cat-file --batch="%(objectname) %(size) %(intreepath)"
>
>      would show:
>
>        1234abcd 17 foo/bar/baz
>        ../../../external
>
>      And then the caller knows that the path is not relative to the
>      original "fleem", but rather to "foo/bar/baz".

Note that ".." will always follow the *physical* structure, so if
foo/bar/baz is walking over symbolic links, "../../.." may lead you to
somewhere else entirely.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
