From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH 3/6] push: support pushing HEAD to real branch name
Date: Sun, 11 Nov 2007 15:17:03 +0100
Message-ID: <47370EDF.3090907@op5.se>
References: <1194789708646-git-send-email-prohaska@zib.de> <11947897083381-git-send-email-prohaska@zib.de> <11947897081278-git-send-email-prohaska@zib.de> <11947897083159-git-send-email-prohaska@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Steffen Prohaska <gitster@pobox.com>
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Sun Nov 11 15:17:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrDcq-0006w4-W5
	for gcvg-git-2@gmane.org; Sun, 11 Nov 2007 15:17:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752921AbXKKORI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Nov 2007 09:17:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753296AbXKKORH
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Nov 2007 09:17:07 -0500
Received: from mail.op5.se ([193.201.96.20]:47031 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752921AbXKKORG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Nov 2007 09:17:06 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 2CBAB1F08748;
	Sun, 11 Nov 2007 15:17:05 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.499
X-Spam-Level: 
X-Spam-Status: No, score=-2.499 tagged_above=-10 required=6.6
	tests=[BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RdJwTPFb4UtR; Sun, 11 Nov 2007 15:17:04 +0100 (CET)
Received: from nox.op5.se (unknown [172.27.78.26])
	by mail.op5.se (Postfix) with ESMTP id 5C5551F08746;
	Sun, 11 Nov 2007 15:17:04 +0100 (CET)
User-Agent: Thunderbird 2.0.0.5 (X11/20070727)
In-Reply-To: <11947897083159-git-send-email-prohaska@zib.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64465>

Steffen Prohaska wrote:
> diff --git a/builtin-push.c b/builtin-push.c
> index 6d1da07..a99ba0c 100644
> --- a/builtin-push.c
> +++ b/builtin-push.c
> @@ -44,6 +44,15 @@ static void set_refspecs(const char **refs, int nr)
>  			strcat(tag, refs[i]);
>  			ref = tag;
>  		}
> +		if (!strcmp("HEAD", ref)) {
> +			unsigned char sha1_dummy[20];
> +			ref = resolve_ref(ref, sha1_dummy, 1, NULL);
> +			if (!ref)
> +				die("HEAD cannot be resolved.");
> +			if (strncmp(ref, "refs/heads/", 11))

Why not prefixcmp(ref, "refs/heads/")?

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
