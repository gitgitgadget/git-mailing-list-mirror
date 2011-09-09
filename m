From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: Git is not scalable with too many refs/*
Date: Fri, 9 Sep 2011 03:13:56 +0200
Message-ID: <201109090313.56898.trast@student.ethz.ch>
References: <4DF6A8B6.9030301@op5.se> <1315529522448-6774328.post@n2.nabble.com> <201109090305.15896.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: Martin Fick <mfick@codeaurora.org>,
	Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Fri Sep 09 03:14:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R1pg7-0005zs-9h
	for gcvg-git-2@lo.gmane.org; Fri, 09 Sep 2011 03:14:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758011Ab1IIBOm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Sep 2011 21:14:42 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:28551 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758112Ab1IIBN6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Sep 2011 21:13:58 -0400
Received: from CAS21.d.ethz.ch (172.31.51.111) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.1.289.1; Fri, 9 Sep
 2011 03:13:55 +0200
Received: from thomas.inf.ethz.ch (188.155.176.28) by CAS21.d.ethz.ch
 (172.31.51.111) with Microsoft SMTP Server (TLS) id 14.1.289.1; Fri, 9 Sep
 2011 03:13:56 +0200
User-Agent: KMail/1.13.7 (Linux/3.0.4-43-desktop; KDE/4.6.5; x86_64; ; )
In-Reply-To: <201109090305.15896.trast@student.ethz.ch>
X-Originating-IP: [188.155.176.28]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181017>

Thomas Rast wrote:
> +       const char *argv[] = {NULL, NULL, "--not", "--all", NULL};
> +       int argc = ARRAY_SIZE(argv) - 1;
> +
> +       init_revisions(&rev, NULL);
> 
> which means that the --all needs to walk all commits reachable from
> all refs and flag them as uninteresting.

Scratch that, it "only" needs to mark every tip commit and then walk
them back to about where the interesting commits end.

In any case, since the uninteresting set only gets larger, it should
be possible to reuse the same revision walker.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
