From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH] Remove useless temporary integer in builtin/push.c
Date: Fri, 30 Jul 2010 00:21:33 +0200
Message-ID: <201007300021.34061.trast@student.ethz.ch>
References: <70ee84752cb7db08c65c608a12ed321dd2c26830.1280419073.git.jaredhance@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>, <gitster@pobox.com>
To: Jared Hance <jaredhance@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 30 00:21:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OebU9-0002cP-At
	for gcvg-git-2@lo.gmane.org; Fri, 30 Jul 2010 00:21:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756694Ab0G2WVh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Jul 2010 18:21:37 -0400
Received: from gwse.ethz.ch ([129.132.178.237]:40854 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756600Ab0G2WVg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Jul 2010 18:21:36 -0400
Received: from CAS22.d.ethz.ch (172.31.51.112) by gws00.d.ethz.ch
 (129.132.178.237) with Microsoft SMTP Server (TLS) id 8.2.254.0; Fri, 30 Jul
 2010 00:21:35 +0200
Received: from thomas.site (84.74.100.241) by CAS22.d.ethz.ch (172.31.51.112)
 with Microsoft SMTP Server (TLS) id 14.0.702.0; Fri, 30 Jul 2010 00:21:35
 +0200
User-Agent: KMail/1.13.5 (Linux/2.6.34-12-desktop; KDE/4.4.4; x86_64; ; )
In-Reply-To: <70ee84752cb7db08c65c608a12ed321dd2c26830.1280419073.git.jaredhance@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152206>

Jared Hance wrote:
> Creating a variable nr here to use throughout the function only to change
> refspec_nr to nr at the end, having not used refspec_nr the entire time,
> is rather pointless. Instead, simply increment refspec_nr.
> 
> Signed-off-by: Jared Hance <jaredhance@gmail.com>
[...]
> -	int nr = refspec_nr + 1;
> -	refspec = xrealloc(refspec, nr * sizeof(char *));
> -	refspec[nr-1] = ref;
> -	refspec_nr = nr;
> +	refspec_nr++;
> +	refspec = xrealloc(refspec, refspec_nr * sizeof(char *));
> +	refspec[refspec_nr-1] = ref;

While you're already here, you could switch to ALLOC_GROW instead to
avoid the n**2 behaviour of xrealloc...

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
