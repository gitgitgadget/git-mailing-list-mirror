From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH 4/5] Full rework of quote_c_style and write_name_quoted.
Date: Wed, 19 Sep 2007 08:37:31 +0200
Message-ID: <46F0C3AB.8010801@op5.se>
References: <20070918223947.GB4535@artemis.corp> <20070918224122.2B55D344AB3@madism.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Wed Sep 19 08:37:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXtBv-0004Wi-MG
	for gcvg-git-2@gmane.org; Wed, 19 Sep 2007 08:37:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752503AbXISGhj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Sep 2007 02:37:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752138AbXISGhj
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Sep 2007 02:37:39 -0400
Received: from mail.op5.se ([193.201.96.20]:39313 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751927AbXISGhi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Sep 2007 02:37:38 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 246FB19445E;
	Wed, 19 Sep 2007 08:37:36 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Score: -4.399
X-Spam-Level: 
X-Spam-Status: No, score=-4.399 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ehvTbVPuBOQf; Wed, 19 Sep 2007 08:37:35 +0200 (CEST)
Received: from nox.op5.se (unknown [192.168.1.178])
	by mail.op5.se (Postfix) with ESMTP id A669419435A;
	Wed, 19 Sep 2007 08:37:34 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.5 (X11/20070719)
In-Reply-To: <20070918224122.2B55D344AB3@madism.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58682>

Pierre Habouzit wrote:
>  
> diff --git a/builtin-blame.c b/builtin-blame.c
> index e364b6c..16c0ca8 100644
> --- a/builtin-blame.c
> +++ b/builtin-blame.c
> @@ -1430,8 +1430,7 @@ static void get_commit_info(struct commit *commit,
>  static void write_filename_info(const char *path)
>  {
>  	printf("filename ");
> -	write_name_quoted(NULL, 0, path, 1, stdout);
> -	putchar('\n');
> +	write_name_quoted(path, stdout, '\n');
>  }
>  

This looks like a candidate for a macro. I'm not sure if gcc optimizes
sibling calls in void functions with -O2, and it doesn't inline without
-O3.

>  
> -static void diff_flush_raw(struct diff_filepair *p,
> -			   struct diff_options *options)
> +static void diff_flush_raw(struct diff_filepair *p, struct diff_options *opt)

Parameter rename? I'd have thought the patch was big enough as it is ;-)


Other than that, the diffstat calls this a good patch, and given the fact that
all your previous series passed all tests, I assume this one does too.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
