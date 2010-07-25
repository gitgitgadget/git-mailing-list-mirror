From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 1/2] log-tree: simplify digit_in_number
Date: Sun, 25 Jul 2010 12:46:02 -0500
Message-ID: <20100725174602.GA9146@burratino>
References: <1280079381-4548-1-git-send-email-ralf.thielow@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ralf Thielow <ralf.thielow@googlemail.com>
X-From: git-owner@vger.kernel.org Sun Jul 25 19:47:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Od5IB-00089f-Og
	for gcvg-git-2@lo.gmane.org; Sun, 25 Jul 2010 19:47:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752165Ab0GYRrK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Jul 2010 13:47:10 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:59189 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751105Ab0GYRrJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Jul 2010 13:47:09 -0400
Received: by gwb20 with SMTP id 20so1178975gwb.19
        for <git@vger.kernel.org>; Sun, 25 Jul 2010 10:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=THLqJA4wpaT9YLFrz0ZUbwbtKdFKIGEMZaGrvY+2A0w=;
        b=rKb9bhj9nF3UtuWB08qXlkGRaf5bqeODf8A5OhRusRXJ7xP53QRWsOsAbBLcslYqUI
         WjXIMk70TdFBB2hBbuXVZqK4rlsvlTVCfp/emlyFZXgaUaqdPklRNKGVGpSxmxt/UMbY
         jLl6+tCaV5J9fZrPke5Xwu3sDSEUNCdHa/aXM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=of19SyGE4Y9tiLbYvHX89a/fEcX1haKOKNy+F1BArpEZUO1nVBecGTgw0PMoczCnSH
         OZHA0F45SWLt9B43fkIwTEi8KfPguuqE4OTWvkXFUVRIFYwPHW/6XPlmFkRbtCR5zxtZ
         +9tnkAJvg0dmqrsoSrzkKH9cJ4yV4fRq7lC20=
Received: by 10.100.174.16 with SMTP id w16mr6595771ane.258.1280080028482;
        Sun, 25 Jul 2010 10:47:08 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id p12sm4842466ane.14.2010.07.25.10.47.07
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 25 Jul 2010 10:47:07 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1280079381-4548-1-git-send-email-ralf.thielow@googlemail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151772>

Ralf Thielow wrote:

> +++ b/log-tree.c
> @@ -254,12 +254,10 @@ static void append_signoff(struct strbuf *sb, const char *signoff)
>  
>  static unsigned int digits_in_number(unsigned int number)
>  {
> -	unsigned int i = 10, result = 1;
> -	while (i <= number) {
> -		i *= 10;
> -		result++;
> -	}
> -	return result;
> +	int digits = 0;
> +	while (number /= 10) 
> +		digits++;
> +	return digits++;

I think you mean "return ++digits;".

But other questions come to mind first:

 - What is the motivation?  How did this come up and what does your change
   improve?

 - Why rewrite this in one patch, only to rewrite it again?

Hope that helps,
Jonathan
