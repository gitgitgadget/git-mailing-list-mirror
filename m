From: Edgar Toernig <froese@gmx.de>
Subject: Re: Trying to use AUTHOR_DATE
Date: Sat, 30 Apr 2005 05:23:18 +0200
Message-ID: <20050430052318.1bd4b189.froese@gmx.de>
References: <200504292314.j3TNE1P23342@unix-os.sc.intel.com>
	<200504300021.j3U0La023762@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: "H. Peter Anvin" <hpa@zytor.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 30 05:18:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DRiUK-000737-V3
	for gcvg-git@gmane.org; Sat, 30 Apr 2005 05:17:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262487AbVD3DX0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Apr 2005 23:23:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262493AbVD3DX0
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Apr 2005 23:23:26 -0400
Received: from imap.gmx.net ([213.165.64.20]:46466 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262487AbVD3DXW (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 Apr 2005 23:23:22 -0400
Received: (qmail invoked by alias); 30 Apr 2005 03:23:21 -0000
Received: from p50906D95.dip.t-dialin.net (EHLO dialup) [80.144.109.149]
  by mail.gmx.net (mp026) with SMTP; 30 Apr 2005 05:23:21 +0200
X-Authenticated: #271361
To: tony.luck@intel.com
In-Reply-To: <200504300021.j3U0La023762@unix-os.sc.intel.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

tony.luck@intel.com wrote:
>
> > There was a time-parsing bug somewhere, where mktime() got invoked on a 
> > UTC date.  I proposed changing it to curl_gettime() instead.
> 
> Here's a patch to switch to using curl_getdate():

Another dependency :-(   I can live without http-pull but not
without commit-tree.

What's wrong with the patch I sent to fix this:

	http://marc.theaimsgroup.com/?m=111446501003389

> +	/* find the timezone at the end */
> +	p = date + strlen(date);
> +	while (p > date && isdigit(*--p))
> +		;
> +	if ((*p == '+' || *p == '-') && strlen(p) == 5)
> +		snprintf(result, maxlen, "%lu %5.5s", then, p);

This will choke on dates from Linus which have a trailing comment:

	Date: Fri, 29 Apr 2005 15:26:14 -0700 (PDT)

Ciao, ET.
