From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 3/3] Initialize variables with values
Date: Thu, 9 May 2013 06:21:15 -0700
Message-ID: <20130509132115.GA3375@elie>
References: <518AF79A.5000408@cs-ware.de>
 <518AF843.6040501@cs-ware.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Sven Strickroth <sven@cs-ware.de>
X-From: git-owner@vger.kernel.org Thu May 09 15:21:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UaQmq-0004HU-TL
	for gcvg-git-2@plane.gmane.org; Thu, 09 May 2013 15:21:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752278Ab3EINVZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 May 2013 09:21:25 -0400
Received: from mail-bk0-f51.google.com ([209.85.214.51]:45404 "EHLO
	mail-bk0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751211Ab3EINVZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 May 2013 09:21:25 -0400
Received: by mail-bk0-f51.google.com with SMTP id ji2so1478586bkc.10
        for <git@vger.kernel.org>; Thu, 09 May 2013 06:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=U5QO2AQEtI0g1W/OhzAhtQcs2FPWRv5EecaDm5ciHnY=;
        b=Th2A+Tu2i7GQcYlpc45BeXK2GPe9juV56F3DqRzO/LuLuTfbzERzRMXqjFaTvsFwJW
         tthDAIYyF0CGnsLlB15hI2l7ylHSt3J1Y2HpGwp5EFfCWnNFjENvaapu4Rzxcvlhshu6
         htShNhr5eF2rzYqHhO4HbRZ5ujIe78mRLuCjAzyjpCt2VOgNIZ8bntkdkqsP9nsrxdz/
         aXxmHJz21VNK70X7iLtDLqaaKamZUpyzO8vLdWx3tFnzGmgraWDHibWoNjxBM/4wsw1O
         Rs3ZYZznjOiZfFZALEeqqQWc8SyS8+PNtRSnMT7tvkEKtrJggQeCwCyx7bncB1mRSXnP
         Zeow==
X-Received: by 10.205.24.201 with SMTP id rf9mr3111094bkb.73.1368105683713;
        Thu, 09 May 2013 06:21:23 -0700 (PDT)
Received: from elie ([213.221.117.228])
        by mx.google.com with ESMTPSA id f3sm762436bkj.21.2013.05.09.06.21.21
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 09 May 2013 06:21:21 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <518AF843.6040501@cs-ware.de>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223731>

Hi,

Sven Strickroth wrote:

> With MSVC initializing a variable with "int a=a" causes a warning about
> using an uninitialized value.
[...]
> --- a/builtin/rev-list.c
> +++ b/builtin/rev-list.c
> @@ -338,7 +338,7 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
>  		mark_edges_uninteresting(revs.commits, &revs, show_edge);
>  
>  	if (bisect_list) {
> -		int reaches = reaches, all = all;
> +		int reaches = 0, all = 0;

A correct way to spell this is

		int reaches, all;

which, as a bonus, lets the compiler warn if they are used
uninitialized.  Does that provoke warnings?

Thanks,
Jonathan
