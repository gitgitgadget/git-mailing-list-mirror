From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v5 17/35] commit_lock_file(): die() if called for
 unlocked lockfile object
Date: Tue, 16 Sep 2014 15:17:45 -0700
Message-ID: <20140916221745.GQ29050@google.com>
References: <1410896036-12750-1-git-send-email-mhagger@alum.mit.edu>
 <1410896036-12750-18-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>,
	Jeff King <peff@peff.net>,
	Ronnie Sahlberg <sahlberg@google.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Sep 17 00:17:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XU14L-0007Cs-BA
	for gcvg-git-2@plane.gmane.org; Wed, 17 Sep 2014 00:17:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753183AbaIPWRt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Sep 2014 18:17:49 -0400
Received: from mail-pa0-f47.google.com ([209.85.220.47]:49466 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752512AbaIPWRs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Sep 2014 18:17:48 -0400
Received: by mail-pa0-f47.google.com with SMTP id ey11so673329pad.20
        for <git@vger.kernel.org>; Tue, 16 Sep 2014 15:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=FMlaMAj1dpdc1N4SRaf4FAhDPKY0uHdLpxCF3y2T0Lw=;
        b=zzY6zxyB0Ou42KrO8/UqDfzI9I6tz7w1vFwR7NB/PxoxdS/XRH12wMeBGSaZ9THEtx
         INfvSka+kv8aNGbANbkSv1s9WlVSxINm0GA0SjETRLhgN7t+i0fO2KW6HKNxKILd4QDA
         uM9rJ//VEpcgVSvZZP5NERPYblO+24ifkklWLEXWDjmTtF5yVHwhjKsn0CCSu78qUGhF
         ay5d4Tm+LAbE41Cgbw5+jo4Fr44R+WUF94jkTf1njqMMKnJvG2mMxQvIsthhyaSHd3vl
         ABYbXXz9SIbTRdUBrG8fLd+5H62HepCj8gLJPQzYFBKmspXouo91RFKJYVbabxQOYjCt
         ZhQA==
X-Received: by 10.66.254.195 with SMTP id ak3mr9627100pad.142.1410905868295;
        Tue, 16 Sep 2014 15:17:48 -0700 (PDT)
Received: from google.com (aiede.mtv.corp.google.com [172.27.69.120])
        by mx.google.com with ESMTPSA id td4sm15039474pbc.36.2014.09.16.15.17.47
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 16 Sep 2014 15:17:47 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1410896036-12750-18-git-send-email-mhagger@alum.mit.edu>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257201>

Michael Haggerty wrote:

> --- a/lockfile.c
> +++ b/lockfile.c
> @@ -312,6 +312,9 @@ int commit_lock_file(struct lock_file *lk)
>  {
>  	char result_file[PATH_MAX];
>  
> +	if (!lk->filename[0])
> +		die("BUG: attempt to commit unlocked object");

Sure, this is fine instead of an assert() too. :)

Thanks,
Jonathan
