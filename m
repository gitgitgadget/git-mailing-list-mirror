From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] git-compat-util: Avoid strcasecmp() being inlined
Date: Thu, 12 Sep 2013 11:38:49 -0700
Message-ID: <20130912183849.GI4326@google.com>
References: <523094F0.9000509@gmail.com>
 <20130911182921.GE4326@google.com>
 <CAHGBnuN0pSmX7_mM6xpRqpF4qPVbP7oBK416NrTVM7tu=DZTjg@mail.gmail.com>
 <20130911214116.GA12235@sigill.intra.peff.net>
 <CAHGBnuP3iX9pqm5kK9_WjAXr5moDuJ1jxtUkXwKEt2jjLTcLkQ@mail.gmail.com>
 <20130912101419.GY2582@serenity.lan>
 <xmqq61u6qcez.fsf@gitster.dls.corp.google.com>
 <20130912182057.GB32069@sigill.intra.peff.net>
 <xmqqd2odq45y.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, John Keeping <john@keeping.me.uk>,
	Sebastian Schuberth <sschuberth@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Karsten Blees <karsten.blees@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 12 20:39:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VKBn8-0008KY-Ry
	for gcvg-git-2@plane.gmane.org; Thu, 12 Sep 2013 20:38:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755519Ab3ILSiy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Sep 2013 14:38:54 -0400
Received: from mail-pb0-f44.google.com ([209.85.160.44]:44426 "EHLO
	mail-pb0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755300Ab3ILSiy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Sep 2013 14:38:54 -0400
Received: by mail-pb0-f44.google.com with SMTP id xa7so174486pbc.31
        for <git@vger.kernel.org>; Thu, 12 Sep 2013 11:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=EyCaoWap0jC1sLaTbmr5pvl6SGcn52EthiIC/lOFznE=;
        b=E9qkJfTXNBk3drVa4sw2hVjPOAVDCcRyPmLczwIgAeHIGckWTActgJJyj2dQ4yaywo
         IKc1H1SKTdZmPdSNTC4VH2xPEqM2dTgW9d0HGo4nrOorsvv+umz7LbQin8RM+r/Y2ZtM
         JDr1vI2CH5YwYHiB35rKLLksXccUH8K9/G+MH04FXGsZw2e+7FVbSXLkgVwd/tZVKNSC
         kKSqq0tc0hvhudvlSmib+OYQfyU+Dfre4K54PS7EP+dPkCrt7xTZZX5Is35Kvr2bzTwW
         DWrZ1d1j4LWHOdktFfTma9fPfjka6gykMgMjOPdwQ/m0OMqldWWbeAwoI0EBMx7ggbNb
         F+Ng==
X-Received: by 10.68.253.227 with SMTP id ad3mr2986916pbd.189.1379011133734;
        Thu, 12 Sep 2013 11:38:53 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id gh9sm6383083pbc.40.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 12 Sep 2013 11:38:52 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <xmqqd2odq45y.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234670>

Junio C Hamano wrote:

> I think we would want something like below.

Looks good to me, but

> -- >8 --
> Subject: [PATCH] mailmap: work around implementations with pure inline strcasecmp
>
> On some systems, string.h has _only_ inline definition of strcasecmp

Please specify which system we are talking about: s/some systems/MinGW 4.0/

[...]
> --- a/mailmap.c
> +++ b/mailmap.c
> @@ -52,6 +52,19 @@ static void free_mailmap_entry(void *p, const char *s)
>  	string_list_clear_func(&me->namemap, free_mailmap_info);
>  }
>  
> +/*
> + * On some systems, string.h has _only_ inline definition of strcasecmp

Likewise.

With or without that change,
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
