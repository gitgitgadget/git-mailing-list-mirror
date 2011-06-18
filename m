From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [RFC/PATCH 0/7] user-configurable git-archive output formats
Date: Sat, 18 Jun 2011 17:40:47 +0200
Message-ID: <4DFCC6FF.8020801@lsrfire.ath.cx>
References: <20110614181732.GA31635@sigill.intra.peff.net> <20110614181821.GA32685@sigill.intra.peff.net> <4DF7B90B.9050802@lsrfire.ath.cx> <20110614201433.GB1567@sigill.intra.peff.net> <20110614204521.GA12776@sigill.intra.peff.net> <20110615223030.GA16110@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	"J.H." <warthog19@eaglescrag.net>, git@vger.kernel.org,
	git-dev@github.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 18 17:41:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QXxeA-00059U-46
	for gcvg-git-2@lo.gmane.org; Sat, 18 Jun 2011 17:41:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756173Ab1FRPlN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Jun 2011 11:41:13 -0400
Received: from lo.gmane.org ([80.91.229.12]:51567 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752873Ab1FRPlM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Jun 2011 11:41:12 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1QXxe2-000544-6W
	for git@vger.kernel.org; Sat, 18 Jun 2011 17:41:10 +0200
Received: from p4ffdb206.dip.t-dialin.net ([79.253.178.6])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 18 Jun 2011 17:41:10 +0200
Received: from rene.scharfe by p4ffdb206.dip.t-dialin.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 18 Jun 2011 17:41:10 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: p4ffdb206.dip.t-dialin.net
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; de; rv:1.9.2.17) Gecko/20110414 Thunderbird/3.1.10
In-Reply-To: <20110615223030.GA16110@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175975>

Am 16.06.2011 00:30, schrieb Jeff King:
>   2. In theory you might want to plug in external helpers that are not
>      just stream filters, but actually their own container formats (like
>      zip). I think people who want 7zip would want this.
> 
>      But how does git-archive interact with the helper? By definition
>      the data it wants is the set of files, not a single stream. So
>      either:
> 
>        a. We give the helper a temporary exported checkout, and it
>           generates the stream from that.
> 
>        b. We use tar as the lingua franca of streaming file containers,
>           and let the helper deal with converting to its preferred
>           output format.
> 
>       Option (a) seems horribly inefficient on disk I/O. And if we did
>       want to do that, I think it's largely unrelated to this patch
>       series.
> 
>       You can actually do option (b) with this series. In its worst
>       case, you can do the same as (a): just untar into a temporary
>       directory and compress from there. But a well-written helper could
>       convert tar into the output format on the fly.

Both can be done today, locally.  One just needs to add a tar-to-7z/any
program for 2.b). :)

Currently the easiest way to apply LZMA compression would be to pipe
--format=tar through the xz utils.  This method is supported by your
patches and the result can be read by 7-Zip.  It should be good enough
for most uses; I think we can disregard the whole point 2 until users
start to ask for these other formats or use cases.
