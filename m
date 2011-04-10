From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH/RFC 10/11] gitweb.js: Add UI for selecting common timezone to display dates
Date: Sun, 10 Apr 2011 17:10:43 +0200
Message-ID: <201104101710.44685.jnareb@gmail.com>
References: <1302389366-21515-1-git-send-email-jnareb@gmail.com> <1302389366-21515-11-git-send-email-jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: John 'Warthog9' Hawley <warthog9@eaglescrag.net>,
	Kevin Cernekee <cernekee@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 10 17:11:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q8wI1-0006nQ-EU
	for gcvg-git-2@lo.gmane.org; Sun, 10 Apr 2011 17:11:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754338Ab1DJPKz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Apr 2011 11:10:55 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:50444 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753883Ab1DJPKy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Apr 2011 11:10:54 -0400
Received: by fxm17 with SMTP id 17so3115043fxm.19
        for <git@vger.kernel.org>; Sun, 10 Apr 2011 08:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=B2G3+h7uvLemhvANCt/C2m6TYoE8jvZk3yVFKpppsGc=;
        b=vPCQS1NKzQJ81Y3o4huqJWcOfx5EqW8tFVunz76MnoyT35R0dUhCROxloPTYuj2M/8
         yQzT/P1kJRy07NYVHGn8tprqSPELp0jzhR6MHQZlfOOzhuxX7Dh6xeI5of9CZulfX+3l
         t33GBJ4z10ywmAUuN8Au89X7lS2poUUu7zmLc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=RkDsTNcVBkUJXheL4VDEI2+vMxSM0H7bBPT57zuioC6IF/4ojN2OG4mXXfbxG4/bNp
         x653HK0XCeukQmXA+Zfp3TkbIH3DwvC4ssMWpK99R5Q8w1NZTIRDD4wRr5BO5l0rSVqv
         tgOw3nRAKAOhsF6wefcDfXGUqFyZ3z7aLg9QM=
Received: by 10.223.127.210 with SMTP id h18mr497501fas.73.1302448252546;
        Sun, 10 Apr 2011 08:10:52 -0700 (PDT)
Received: from [192.168.1.13] (abwa66.neoplus.adsl.tpnet.pl [83.8.224.66])
        by mx.google.com with ESMTPS id p16sm1368400fax.45.2011.04.10.08.10.50
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 10 Apr 2011 08:10:51 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <1302389366-21515-11-git-send-email-jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171254>

Jakub Narebski wrote:

> KNOWN BUGS:
> ===========

> * Replacing inline style for 'popup' and 'close-button' elements of
>   timezone menu with style defined in gitweb.css results in menu being
>   put between datetime and its local part, as if absolute positioning
>   didn't remove element from the flow.
> 
>   Currently style is duplicated in gitweb.css (in CSS file) and in
>   <element>.style.cssText (in JavaScript).

I'm very sorry, false alarm.  The error was mine: the CSS in gitweb.css
is incorrect; I forgot that in CSS you have only C-like "/* foo */"
comments, and C++ / JavaScript-like "// ... \n" doesn't work.

See e.g.: http://jigsaw.w3.org/css-validator/validator?uri=http%3A%2F%2Frepo.or.cz%2Fw%2Fgit%2Fjnareb-git.git%2Fblob_plain%2F524656258696381f9e6b9169256688165e21a3f9%3A%2Fgitweb%2Fstatic%2Fgitweb.css&lang=en&profile=css21&usermedium=all&warning=1
  

Will fix.

> diff --git a/gitweb/static/gitweb.css b/gitweb/static/gitweb.css
> index 79d7eeb..6d17e12 100644
> --- a/gitweb/static/gitweb.css
> +++ b/gitweb/static/gitweb.css
> @@ -579,6 +579,31 @@ div.remote {
>  	display: inline-block;
>  }
>  
> +/* JavaScript-base timezone manipulation */
> +
> +.popup { // timezone selection UI
            ^^

Should be

  +.popup { /* timezone selection UI */

> +	position: absolute;
> +	top: 0; right: 0;
> +	border: 1px solid;
> +	background-color: #f0f0f0;
> +}

-- 
Jakub Narebski
Poland
