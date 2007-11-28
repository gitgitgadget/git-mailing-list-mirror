From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Do check_repository_format() early
Date: Wed, 28 Nov 2007 17:05:05 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711281703470.27959@racer.site>
References: <20071128165837.GA5903@laptop>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463811741-605244460-1196269505=:27959"
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 28 18:06:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IxQM6-0002rk-FC
	for gcvg-git-2@gmane.org; Wed, 28 Nov 2007 18:05:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758934AbXK1RFQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Nov 2007 12:05:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758465AbXK1RFQ
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Nov 2007 12:05:16 -0500
Received: from mail.gmx.net ([213.165.64.20]:50038 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758020AbXK1RFP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Nov 2007 12:05:15 -0500
Received: (qmail invoked by alias); 28 Nov 2007 17:05:12 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp040) with SMTP; 28 Nov 2007 18:05:12 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/lgsV2RwDlFpRTIQn9ydvdxjY8ohvw+tBIj65lyM
	7OBMIVTAhSkyGt
X-X-Sender: gene099@racer.site
In-Reply-To: <20071128165837.GA5903@laptop>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66386>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463811741-605244460-1196269505=:27959
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: 8BIT

Hi,

On Wed, 28 Nov 2007, Nguyễn Thái Ngọc Duy wrote:

> @@ -246,8 +246,13 @@ const char *setup_git_directory_gently(int *nongit_ok)
>  			static char buffer[1024 + 1];
>  			const char *retval;
>  
> -			if (!work_tree_env)
> -				return set_work_tree(gitdirenv);
> +			if (!work_tree_env) {
> +				retval = set_work_tree(gitdirenv);
> +				/* config may override worktree */
> +				check_repository_format();
> +				return retval;
> +			}
> +			check_repository_format();

Why not move this check before the if?  Other than that, ACK.

Ciao,
Dscho

---1463811741-605244460-1196269505=:27959--
