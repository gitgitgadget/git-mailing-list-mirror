From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 3/3] implement pattern matching in ce_path_match
Date: Wed, 14 Jan 2009 16:44:36 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901141641500.3586@pacific.mpi-cbg.de>
References: <1231944876-29930-1-git-send-email-drizzd@aon.at> <1231944876-29930-2-git-send-email-drizzd@aon.at> <1231944876-29930-3-git-send-email-drizzd@aon.at> <1231944876-29930-4-git-send-email-drizzd@aon.at>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	johannes@familieschneider.info
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Wed Jan 14 16:49:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LN7vc-0001q4-L6
	for gcvg-git-2@gmane.org; Wed, 14 Jan 2009 16:45:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751621AbZANPnt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jan 2009 10:43:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751486AbZANPnt
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Jan 2009 10:43:49 -0500
Received: from mail.gmx.net ([213.165.64.20]:59143 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751279AbZANPns (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jan 2009 10:43:48 -0500
Received: (qmail invoked by alias); 14 Jan 2009 15:43:45 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp047) with SMTP; 14 Jan 2009 16:43:45 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/As+8ThO7A3xVVWDVQHysk1EYrC6aMCSM8K1ZKvy
	kPnbta7VxD1bl0
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <1231944876-29930-4-git-send-email-drizzd@aon.at>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105644>

Hi,

On Wed, 14 Jan 2009, Clemens Buchacher wrote:

> @@ -25,6 +25,17 @@ static int default_show_root = 1;
>  static const char *fmt_patch_subject_prefix = "PATCH";
>  static const char *fmt_pretty;
>  
> +static int has_special(const char *p)
> +{
> +	int x;
> +
> +	while ((x = *p++) != '\0')
> +		if (isspecial(x))
> +			return 1;
> +
> +	return 0;
> +}

I would prefer something like this:

	static int has_special(const char *p)
	{
		while (*p)
			if (isspecial(*(p++)))
				return 1;
		return 0;
	}

but that is probably a matter of taste.

Ciao,
Dscho
