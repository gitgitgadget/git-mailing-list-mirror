From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: git status: small difference between stating whole repository and small subdirectory
Date: Mon, 20 Feb 2012 15:09:57 +0100
Message-ID: <87ty2l38ay.fsf@thomas.inf.ethz.ch>
References: <8762f9k5sg.fsf@thomas.inf.ethz.ch>
	<CAA01Cso_8=159UDMFUHiYz1X=gYtpbqRO4h3TMw7N=4YMV8YNg@mail.gmail.com>
	<20120215190318.GA5992@sigill.intra.peff.net>
	<CAA01Cso5y23UMguEe0vwOc6kR3-DjuC8-LTMDsMeeOKU4rVGvg@mail.gmail.com>
	<20120216192001.GB4348@sigill.intra.peff.net>
	<CAA01Csq6vSekW=Fa236bB0H3LVtN43Gb2aLMVE+A1wVyUqYJ7A@mail.gmail.com>
	<20120217203755.GA30114@sigill.intra.peff.net>
	<7vaa4hrtbe.fsf@alter.siamese.dyndns.org>
	<20120217222912.GC31830@sigill.intra.peff.net>
	<CAA01CsozANwtox06iihKBL8iii175FHAhChmNhG1B0ofGKWcEA@mail.gmail.com>
	<20120220140653.GC5131@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 20 15:10:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RzTwN-0006DU-GP
	for gcvg-git-2@plane.gmane.org; Mon, 20 Feb 2012 15:10:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752962Ab2BTOKA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Feb 2012 09:10:00 -0500
Received: from edge10.ethz.ch ([82.130.75.186]:21727 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752788Ab2BTOJ7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Feb 2012 09:09:59 -0500
Received: from CAS20.d.ethz.ch (172.31.51.110) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.1.355.2; Mon, 20 Feb
 2012 15:09:57 +0100
Received: from thomas.inf.ethz.ch.ethz.ch (129.132.153.233) by CAS20.d.ethz.ch
 (172.31.51.110) with Microsoft SMTP Server (TLS) id 14.1.355.2; Mon, 20 Feb
 2012 15:09:57 +0100
In-Reply-To: <20120220140653.GC5131@sigill.intra.peff.net> (Jeff King's
	message of "Mon, 20 Feb 2012 09:06:53 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191071>

Jeff King <peff@peff.net> writes:

> On Mon, Feb 20, 2012 at 09:25:00AM +0100, Piotr Krukowiecki wrote:
>
>> Is the cache set? Not sure how to check it. t0090-cache-tree.sh uses
>> test-dump-cache-tree and executes "read-tree HEAD" to establish the
>> cache, but in my case read-tree does not make the cache dumpable (but
>> it improves status performance).
>> 
>> $ test-dump-cache-tree  | wc -l
>> 0
>> $ git read-tree HEAD
>> $ test-dump-cache-tree  | wc -l
>> 0
>> $ echo 3 | sudo tee /proc/sys/vm/drop_caches && time git status -- .
>> [...]
>> real	0m1.085s
>
> Hmm. I would think test-dump-cache-tree would do it. I don't know why
> read-tree wouldn't fill it in, though.
>
> Interestingly, on my git.git repo, I had an empty cache. Running "git
> read-tree HEAD" filled it (according to test-dump-cache-tree). It seems
> that running "git checkout" empties the cache.  So perhaps git could do
> better about keeping the cache valid over time.

test_expect_failure 'checkout gives cache-tree' '
	git checkout HEAD^ &&
	test_shallow_cache_tree
'

;-)

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
