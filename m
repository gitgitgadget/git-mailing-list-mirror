From: "Kevin P. Fleming" <kpfleming@digium.com>
Subject: Re: [PATCH] Corrected return values in prep_for_email;
Date: Thu, 09 Dec 2010 09:19:36 -0600
Organization: Digium, Inc.
Message-ID: <4D00F388.5090806@digium.com>
References: <002501cb962c$5fa3aa40$1eeafec0$@me.uk> <7v1v5tqswl.fsf@alter.siamese.dyndns.org> <4CFE8E97.4020508@digium.com> <004201cb97a4$6127cc60$23776520$@me.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: 'Junio C Hamano' <gitster@pobox.com>, git@vger.kernel.org
To: Alan Raison <alan@theraisons.me.uk>
X-From: git-owner@vger.kernel.org Thu Dec 09 16:19:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQiHZ-00037n-3W
	for gcvg-git-2@lo.gmane.org; Thu, 09 Dec 2010 16:19:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755509Ab0LIPTn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Dec 2010 10:19:43 -0500
Received: from mail.digium.com ([216.207.245.2]:54488 "EHLO mail.digium.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752922Ab0LIPTm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Dec 2010 10:19:42 -0500
Received: from zimbra.digium.internal ([10.24.55.203] helo=zimbra.hsv.digium.com)
	by mail.digium.com with esmtp (Exim 4.69)
	(envelope-from <kpfleming@digium.com>)
	id 1PQiHQ-0006xb-WD; Thu, 09 Dec 2010 09:19:37 -0600
Received: from localhost (localhost.localdomain [127.0.0.1])
	by zimbra.hsv.digium.com (Postfix) with ESMTP id E5FACD8194;
	Thu,  9 Dec 2010 09:19:36 -0600 (CST)
Received: from zimbra.hsv.digium.com ([127.0.0.1])
	by localhost (zimbra.hsv.digium.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ODFLBiAlrdAC; Thu,  9 Dec 2010 09:19:36 -0600 (CST)
Received: from [10.24.250.46] (unknown [10.24.250.46])
	by zimbra.hsv.digium.com (Postfix) with ESMTPSA id 1401BD8024;
	Thu,  9 Dec 2010 09:19:36 -0600 (CST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.12) Gecko/20101027 Thunderbird/3.1.6
In-Reply-To: <004201cb97a4$6127cc60$23776520$@me.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163289>

On 12/09/2010 07:24 AM, Alan Raison wrote:
>  From ebe98d1c682f268b39a7eaf3ef529accbf0ac61c Mon Sep 17 00:00:00 2001
> From: Alan Raison<alan@theraisons.me.uk>
> Date: Mon, 6 Dec 2010 15:49:21 +0000
> Subject: [PATCH] Corrected return values in prep_for_email;
>
> Function was returning 0 for failure and 1 for success which was breaking
> the logic in the main loop.
>
> Corrected to return 0 for success, 1 for failure.  Function now also returns
> in all cases, rather than exiting.

Your commit message will need a Signed-Off-By line, but...

Acked-By: Kevin P. Fleming <kpfleming@digium.com>

> ---
>   contrib/hooks/post-receive-email |    8 ++++----
>   1 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/contrib/hooks/post-receive-email
> b/contrib/hooks/post-receive-email
> index 85724bf..f99ea95 100755
> --- a/contrib/hooks/post-receive-email
> +++ b/contrib/hooks/post-receive-email
> @@ -144,13 +144,13 @@ prep_for_email()
>   			short_refname=${refname##refs/remotes/}
>   			echo>&2 "*** Push-update of tracking branch,
> $refname"
>   			echo>&2 "***  - no email generated."
> -			exit 0
> +			return 1
>   			;;
>   		*)
>   			# Anything else (is there anything else?)
>   			echo>&2 "*** Unknown type of update to $refname
> ($rev_type)"
>   			echo>&2 "***  - no email generated"
> -			return 0
> +			return 1
>   			;;
>   	esac
>
> @@ -166,10 +166,10 @@ prep_for_email()
>   		esac
>   		echo>&2 "*** $config_name is not set so no email will be
> sent"
>   		echo>&2 "*** for $refname update $oldrev->$newrev"
> -		return 0
> +		return 1
>   	fi
>
> -	return 1
> +	return 0
>   }
>
>   #


-- 
Kevin P. Fleming
Digium, Inc. | Director of Software Technologies
445 Jan Davis Drive NW - Huntsville, AL 35806 - USA
skype: kpfleming | jabber: kfleming@digium.com
Check us out at www.digium.com & www.asterisk.org
