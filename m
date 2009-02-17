From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] rev-list: estimate number of bisection step left
Date: Tue, 17 Feb 2009 15:44:54 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902171542490.6185@intel-tinevez-2-302>
References: <20090217060944.488184b0.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Ingo Molnar <mingo@elte.hu>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Tue Feb 17 15:46:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZRDS-0005ks-51
	for gcvg-git-2@gmane.org; Tue, 17 Feb 2009 15:46:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752558AbZBQOo7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Feb 2009 09:44:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752518AbZBQOo6
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Feb 2009 09:44:58 -0500
Received: from mail.gmx.net ([213.165.64.20]:56673 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752125AbZBQOo6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Feb 2009 09:44:58 -0500
Received: (qmail invoked by alias); 17 Feb 2009 14:44:56 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp046) with SMTP; 17 Feb 2009 15:44:56 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18X6P5+Z8IXrJkgefT3G+qEPl1pdR20VMUi4wp98k
	POHKxuq0/ZuPAe
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <20090217060944.488184b0.chriscool@tuxfamily.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.71
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110393>

Hi,

On Tue, 17 Feb 2009, Christian Couder wrote:

> +static int estimate_bisect_steps(int all)
> +{
> +	int log2 = 0;
> +	int left = (all >> 1) - 1;
> +
> +	if (left <= 0)
> +		return 0;
> +
> +	do {
> +		left = left >> 1;
> +		log2++;
> +	} while (left);
> +
> +	return log2;
> +}

How about this instead, calling it from cmd_rev_list directly?

	static int log2(int n)
	{
		int log2;

		for (log2 = 0; n > 1; log2++)
			n >>= 1;

		return log2;
	}

Ciao,
Dscho
