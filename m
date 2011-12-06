From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH] userdiff: allow * between cpp funcname words
Date: Tue, 06 Dec 2011 21:52:22 +0100
Message-ID: <4EDE8086.9080303@kdbg.org>
References: <a639d328e15bce3057de9238ee31097d15850de1.1323189110.git.trast@student.ethz.ch> <20111206190217.GD9492@sigill.intra.peff.net> <201112062117.57690.trast@student.ethz.ch> <20111206201944.GB27930@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Thomas Rast <trast@student.ethz.ch>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Dec 06 21:52:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RY208-00084t-Er
	for gcvg-git-2@lo.gmane.org; Tue, 06 Dec 2011 21:52:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753443Ab1LFUw2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Dec 2011 15:52:28 -0500
Received: from bsmtp4.bon.at ([195.3.86.186]:17230 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753382Ab1LFUw1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Dec 2011 15:52:27 -0500
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id AE390130049;
	Tue,  6 Dec 2011 21:51:22 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 1639919F5FB;
	Tue,  6 Dec 2011 21:52:23 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; de; rv:1.9.2.24) Gecko/20111101 SUSE/3.1.16 Thunderbird/3.1.16
In-Reply-To: <20111206201944.GB27930@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186381>

Am 06.12.2011 21:19, schrieb Jeff King:
> On Tue, Dec 06, 2011 at 09:17:56PM +0100, Thomas Rast wrote:
> 
>>> Looks reasonable to me. You can see the difference, for instance, with:
>>>
>>>   git show -U1 3c73a1d
>>>
>>> (The -U1 is because of the annoying "we will start looking for the
>>> header at the top of context, not the top of changes" behavior I
>>> mentioned last week).
>>
>> Actually (sadly) I'll have to revise it.  It doesn't match much of C++
>> either, and I haven't yet come up with a reasonable regex that
>> matches, say,
>>
>>   foo::Bar<int>::t& Baz::operator<<(
>>
>> which I would call ludicrous, but it's valid C++.
> 
> Ick, yeah. Maybe it is worth doing the "*" thing for now, and then
> worrying about advanced C++ stuff on top as another patch. AFAICT, your
> original patch is a strict improvement.

Excuse me, where's the problem? The above example shows this

@@ -105,8 +105,8 @@ char *url_decode(const char *url)
        struct strbuf out = STRBUF_INIT;
-       const char *slash = strchr(url, '/');
+       const char *colon = strchr(url, ':');
...

with current 4cb5d10b. This looks quite correct, no?

-- Hannes
