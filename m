From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 1/2] Introduce leaky().
Date: Tue, 24 Jun 2008 14:28:30 -0700 (PDT)
Message-ID: <m3skv2jzey.fsf@localhost.localdomain>
References: <1214338474-16822-1-git-send-email-madcoder@debian.org>
	<1214338474-16822-2-git-send-email-madcoder@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Tue Jun 24 23:29:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBG4w-0001q7-1f
	for gcvg-git-2@gmane.org; Tue, 24 Jun 2008 23:29:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752995AbYFXV2e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jun 2008 17:28:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751130AbYFXV2e
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jun 2008 17:28:34 -0400
Received: from nf-out-0910.google.com ([64.233.182.188]:60179 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751293AbYFXV2d (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jun 2008 17:28:33 -0400
Received: by nf-out-0910.google.com with SMTP id d3so66181nfc.21
        for <git@vger.kernel.org>; Tue, 24 Jun 2008 14:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=zOZpJCHWyK69UKKKHsWbzg3zswznne9mjgT2+h8hCw8=;
        b=mg9oCKgrIzcYLQbDWj6+uSqKRXCrx1384qTBK2pDZUkMQT/tGgtDqL8E/5HGp/oNvh
         d5+DPRWD/2SU1gg8kVbEAbbjxfyUd1lAbafZKlYiubmUymvQL+pVEzJ8rp35v5IYJM+A
         OT8Ik43FC42RFn+fhvSzGww3fHugrMJuomvIk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=VXx50J3hPZTWlWrW7nk7FsicG+IdGJ4M9Dw5X3Ons4jzpMlKPhWEhqYr/pb8KonwpF
         8SNZm9Hlzy/kjJk6CYfkiSxsrqLREPrm5f2J9pelyx/i/zYml80qwLrScvogJkHL23fe
         wCv0Mazr9zU4ClCxXFImDBSfgCixKmK2RiN48=
Received: by 10.210.115.15 with SMTP id n15mr776284ebc.28.1214342911676;
        Tue, 24 Jun 2008 14:28:31 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.223.44])
        by mx.google.com with ESMTPS id d2sm1138207nfc.31.2008.06.24.14.28.28
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 24 Jun 2008 14:28:30 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m5OLSQeN011286;
	Tue, 24 Jun 2008 23:28:27 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m5OLSLtv011281;
	Tue, 24 Jun 2008 23:28:21 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1214338474-16822-2-git-send-email-madcoder@debian.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86152>

Pierre Habouzit <madcoder@debian.org> writes:

> diff --git a/Makefile b/Makefile

> +#
> +# Define COLLECT_LEAKS_AT_EXIT if you want memory marked as leaky() at exit.

I think s/at exit/to be freed &/;


> diff --git a/cache.h b/cache.h

Hmmm... cache?

>  /* alloc.c */
> +#ifdef COLLECT_LEAKS_AT_EXIT
> +extern void *leaky(void *);
> +#else
> +# define leaky(x) x
> +#endif

Not 

+# define leaky(x) (x)

to be careful?
-- 
Jakub Narebski
Poland
ShadeHawk on #git
