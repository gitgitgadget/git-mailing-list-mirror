From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH/RFC 0/3] --seed as an alias for --dissociate --reference
Date: Mon, 25 May 2015 01:53:14 +0200
Message-ID: <5562646A.1080608@alum.mit.edu>
References: <20150521041435.GA18978@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Cc: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 25 01:59:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ywfo1-000802-Q1
	for gcvg-git-2@plane.gmane.org; Mon, 25 May 2015 01:59:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751420AbbEXXxa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 May 2015 19:53:30 -0400
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:42448 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751354AbbEXXxa (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 24 May 2015 19:53:30 -0400
X-AuditID: 1207440d-f79026d000000bad-38-5562646d41b8
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id 39.50.02989.D6462655; Sun, 24 May 2015 19:53:17 -0400 (EDT)
Received: from [192.168.69.130] (p5DDB1007.dip0.t-ipconnect.de [93.219.16.7])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t4ONrFAx022543
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Sun, 24 May 2015 19:53:16 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.7.0
In-Reply-To: <20150521041435.GA18978@peff.net>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnleLIzCtJLcpLzFFi42IRYndR1M1NSQo1mHdd3qLrSjeTRUPvFWaL
	Hy09zA7MHs969zB6XLyk7PF5k1wAcxS3TVJiSVlwZnqevl0Cd8bBz7fZCp5xVOy5fYilgfEL
	WxcjJ4eEgInE5yl3oGwxiQv31gPZXBxCApcZJW50bmWGcM4ySXw+N4cZpIpXQFti44oNLF2M
	HBwsAqoSh6eagITZBHQlFvU0M4GERQWCJF6/zIWoFpQ4OfMJC4gtImAkcePDN7BdzAJqEoeW
	PGIEsYUFfCTmbz4HNl0IaMzsN1/BbE4BPYktd9cyQdSrS/yZd4kZwpaXaN46m3kCo8AsJCtm
	ISmbhaRsASPzKka5xJzSXN3cxMyc4tRk3eLkxLy81CJdI73czBK91JTSTYyQwOXdwfh/ncwh
	RgEORiUe3gUGiaFCrIllxZW5hxglOZiURHmv2yeFCvEl5adUZiQWZ8QXleakFh9ilOBgVhLh
	jYoGyvGmJFZWpRblw6SkOViUxHnVlqj7CQmkJ5akZqemFqQWwWRlODiUJHgnJQE1ChalpqdW
	pGXmlCCkmTg4QYZzSYkUp+alpBYllpZkxIPiNL4YGKkgKR6gveLJIHuLCxJzgaIQracYFaXE
	eXeDzBUASWSU5sGNhaWjV4ziQF8K8waDtPMAUxlc9yugwUxAg680J4IMLklESEk1MFqwc7Kd
	cN83zdL35ZwOjdyZJ9uzHL/zzj3glcdSnPSm8H2Z0Cem5kUnLwjLfAjN/KiY81bE7thdpv6j
	LUnCOqtePnSIl+uZUKsZdevSEZcyn3N/9HafOr/t7YmVetGTV/IfObN8fV/cyQvv 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269832>

Thanks for working on this. I have one little bikeshedding comment...

On 05/21/2015 06:14 AM, Jeff King wrote:
> [...]
> There are a few open issues with this series:
> 
>   1. Assuming that "seed" is a reasonable verb for this concept, is
>      "--seed=<repo>" OK for the option?  Would "--seed-from=<repo>" be
>      better? (Also, the response "bleh, seed is a terrible name" is
>      fine, too, but only if accompanied by your own suggestion :) ).

I think "seed" is a pretty good name. The only downside is that "seed"
suggests that the process injects just a few seeds that are much smaller
than the whole. But in fact, (hopefully) this option causes the bulk of
the needed objects to be pre-fetched.

I can't think of any name that is clearly better. Some brainstorming:

* prepare -- meh
* prime (as in "prime the pump"). But "prime" alone could have too many
meanings, so...
* prime-from
* pre-fetch or pre-fetch-from
* pre-load or pre-load-from

BTW I think "--seed-from=<repo>" is more self-explanatory than
"--seed=<repo>".

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
