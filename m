From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH v2 6/7] rebase: write better reflog messages
Date: Wed, 19 Jun 2013 07:39:54 +0200
Message-ID: <51C1442A.2010904@viscovery.net>
References: <1371581737-10013-1-git-send-email-artagnon@gmail.com> <1371581737-10013-7-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 19 07:40:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UpB88-0003fk-Gb
	for gcvg-git-2@plane.gmane.org; Wed, 19 Jun 2013 07:40:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753439Ab3FSFkD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Jun 2013 01:40:03 -0400
Received: from so.liwest.at ([212.33.55.13]:10536 "EHLO so.liwest.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752001Ab3FSFkC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Jun 2013 01:40:02 -0400
Received: from [81.10.228.254] (helo=theia.linz.viscovery)
	by so.liwest.at with esmtpa (Exim 4.77)
	(envelope-from <j.sixt@viscovery.net>)
	id 1UpB7a-0005o6-Qw; Wed, 19 Jun 2013 07:39:55 +0200
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 7CAC91660F;
	Wed, 19 Jun 2013 07:39:54 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130509 Thunderbird/17.0.6
In-Reply-To: <1371581737-10013-7-git-send-email-artagnon@gmail.com>
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228341>

Am 6/18/2013 20:55, schrieb Ramkumar Ramachandra:
> Now that the "checkout" invoked internally from "rebase" knows to honor
> GIT_REFLOG_ACTION, we can start to use it to write a better reflog
> message when "rebase anotherbranch", "rebase --onto branch",
> etc. internally checks out the new fork point.  We will write:
> 
>   rebase: checkout master
> 
> instead of the old
> 
>   rebase

> diff --git a/git-rebase--am.sh b/git-rebase--am.sh
> index 34e3102..69fae7a 100644
> --- a/git-rebase--am.sh
> +++ b/git-rebase--am.sh
> @@ -5,11 +5,13 @@
>  
>  case "$action" in
>  continue)
> +	GIT_REFLOG_ACTION="$base_reflog_action"

I haven't followed the topic closely, but I wonder why there are so many
explicit assignments to GIT_REFLOG_ACTION. Is calling set_reflog_action
(defined in git-sh-setup) the wrong thing to do?

-- Hannes
