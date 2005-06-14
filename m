From: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH] Unset TZ in t5000
Date: Tue, 14 Jun 2005 17:17:38 +0200
Message-ID: <42AEF512.5040107@lsrfire.ath.cx>
References: <20050614131727.23011.qmail@web41211.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 14 17:14:20 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DiD6q-0001Lm-6T
	for gcvg-git@gmane.org; Tue, 14 Jun 2005 17:13:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261164AbVFNPS1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 14 Jun 2005 11:18:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261154AbVFNPS1
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Jun 2005 11:18:27 -0400
Received: from neapel230.server4you.de ([217.172.187.230]:44212 "EHLO
	neapel230.server4you.de") by vger.kernel.org with ESMTP
	id S261153AbVFNPRy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Jun 2005 11:17:54 -0400
Received: from [10.0.1.3] (p508E62CF.dip.t-dialin.net [80.142.98.207])
	by neapel230.server4you.de (Postfix) with ESMTP id D269989;
	Tue, 14 Jun 2005 17:17:50 +0200 (CEST)
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: de-DE, de, en-us, en
To: Mark Allen <mrallen1@yahoo.com>
In-Reply-To: <20050614131727.23011.qmail@web41211.mail.yahoo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Mark Allen schrieb:
> --- Rene Scharfe <rene.scharfe@lsrfire.ath.cx> wrote:> Mark Allen schrieb:
>  > The expression
> 
>>   length($5)<7 ? $5":00" : $5
>>
>>(where $5 is a time value) is there to cope with tars that format the
>>time like hh:mm instead of the expected hh:mm:ss.
> 
> 
> I put (escaped) parenthesis around the length function and now it works as expected.
> Here's a new patch. Please ack if you approve. 
> 
> Thanks,
> 
> --Mark
> 
> Signed-off-by: Mark Allen <mrallen1@yahoo.com>
> 
> 
> ------------------------------------------------------------------------
> 
> diff --git a/t/t5000-tar-tree.sh b/t/t5000-tar-tree.sh
> --- a/t/t5000-tar-tree.sh
> +++ b/t/t5000-tar-tree.sh
> @@ -50,8 +50,9 @@ test_expect_success \
>  
>  test_expect_success \
>      'validate file modification time' \
> -    'tar tvf b.tar a/a |
> -     awk \{print\ \$4,\ length\(\$5\)\<7\ ?\ \$5\":00\"\ :\ \$5\} >b.mtime &&
> +    'TZ= tar tvf b.tar a/a |
> +     awk \{print\ \$4,\ \(length\(\$5\)\<7\)\ ?\ \$5\":00\"\ :\ \$5\} \
> +     >b.mtime &&
>       echo "2005-05-27 22:00:00" >expected.mtime &&
>       diff expected.mtime b.mtime'
>  

Acked-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
