From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] git-svn: write memoized data explicitly to avoid
	Storable bug
Date: Mon, 19 Jul 2010 06:39:03 +0000
Message-ID: <20100719063903.GA3680@dcvr.yhbt.net>
References: <1279455469-6384-1-git-send-email-vsu@altlinux.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, A Large Angry SCM <gitzilla@gmail.com>,
	Sergey Vlasov <vsu@altlinux.ru>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 19 08:39:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oak0O-0004yk-OB
	for gcvg-git-2@lo.gmane.org; Mon, 19 Jul 2010 08:39:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754199Ab0GSGjG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Jul 2010 02:39:06 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:45992 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754103Ab0GSGjF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Jul 2010 02:39:05 -0400
Received: from localhost (unknown [127.0.2.5])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1F9FF1F516;
	Mon, 19 Jul 2010 06:39:04 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1279455469-6384-1-git-send-email-vsu@altlinux.ru>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151245>

Sergey Vlasov <vsu@altlinux.ru> wrote:
> Apparently using the Storable module during global destruction is
> unsafe - there is a bug which can cause segmentation faults:
> 
>   http://rt.cpan.org/Public/Bug/Display.html?id=36087
>   http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=482355
> 
> The persistent memoization support introduced in commit 8bff7c538
> relied on global destruction to write cached data, which was leading
> to segfaults in some Perl configurations.  Calling Memoize::unmemoize
> in the END block forces the cache writeout to be performed earlier,
> thus avoiding the bug.
> 
> Signed-off-by: Sergey Vlasov <vsu@altlinux.ru>

Thanks Sergey,

Acked-by: Eric Wong <normalperson@yhbt.net>

...and pushed to git://git.bogomips.org/git-svn

-- 
Eric Wong
