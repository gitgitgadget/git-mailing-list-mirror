From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCHv4 6/6] is_submodule_modified(): clear environment properly
Date: Wed, 24 Feb 2010 09:06:01 +0100
Message-ID: <4B84DDE9.8000301@viscovery.net>
References: <1266996196-25978-1-git-send-email-giuseppe.bilotta@gmail.com> <1266996196-25978-7-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	msysGit Mailinglist <msysgit@googlegroups.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 24 09:06:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NkCG6-0005Nq-9e
	for gcvg-git-2@lo.gmane.org; Wed, 24 Feb 2010 09:06:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753476Ab0BXIGH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Feb 2010 03:06:07 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:25112 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753132Ab0BXIGG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Feb 2010 03:06:06 -0500
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1NkCFu-0003Wa-FP; Wed, 24 Feb 2010 09:06:02 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 3099A1660F;
	Wed, 24 Feb 2010 09:06:02 +0100 (CET)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <1266996196-25978-7-git-send-email-giuseppe.bilotta@gmail.com>
X-Enigmail-Version: 0.95.5
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140917>

Giuseppe Bilotta schrieb:
> +	const char *env[local_repo_env_size+2];

Variable sized arrays are prohibited.

>  	struct strbuf buf = STRBUF_INIT;
>  
> +	/* Copy local_repo_env to env, letting i
> +	   rest at the last NULL */
> +	while (env[i] = local_repo_env[i])
> +		++i; /* do nothing */
> +

This looks very inconsistent: At the one hand, you use l_r_e_size to
allocate the space, but then you iterate over it assuming that the list is
(also) NULL-terminated. But this is only a minor nit.

-- Hannes
