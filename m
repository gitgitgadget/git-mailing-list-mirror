From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [WIP/RFC 04/13] notes.h/c: Propagate combine_notes_fn return
 value to add_note() and beyond
Date: Fri, 23 Jul 2010 10:23:44 -0500
Message-ID: <20100723152344.GA1709@burratino>
References: <1279880104-29796-1-git-send-email-johan@herland.net>
 <1279880104-29796-5-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Fri Jul 23 17:24:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OcK7L-0000kT-1J
	for gcvg-git-2@lo.gmane.org; Fri, 23 Jul 2010 17:24:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759921Ab0GWPYt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Jul 2010 11:24:49 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:59202 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756148Ab0GWPYs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jul 2010 11:24:48 -0400
Received: by ewy23 with SMTP id 23so139509ewy.19
        for <git@vger.kernel.org>; Fri, 23 Jul 2010 08:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=TjOKUvGmEJ/LCbNW9DsXhgrFlG+5gQzZbgbfuJ4PWSU=;
        b=QuXMgI0G0oc9Bl4bDczBX7deKdLVDFg47t8XAz1LVoJjnaTHO6G+4v+9UoULdkn3do
         GfzalLTtKmwI/2ARZhtXZTzirQyGFuwpT5v8zCXjxlANI+f7FcNZlbCn0p0bNAX7T07z
         9r2L/E8TUKbZxnxQV98HcMrFymrLmojVJzvC8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=YctbFjVJSixfbqCEV5SZHV4fzL8346hpLjR6GOafsc/J34TMXHm0V1uxef6u8BSr8B
         +Mw/jkaG7RXolaHttduN39fLUCR/OWtTB9BYcyQ/xqKKnqKiA83G4/6bvD6h/UWVb8+j
         d1pGKkqOscp8aC9eCp10LiLCDz76hZO43J6+Y=
Received: by 10.213.32.212 with SMTP id e20mr3308236ebd.80.1279898686886;
        Fri, 23 Jul 2010 08:24:46 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id v59sm541324eeh.16.2010.07.23.08.24.44
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 23 Jul 2010 08:24:45 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1279880104-29796-5-git-send-email-johan@herland.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151542>

Hi,

Johan Herland wrote:

> --- a/builtin/notes.c
> +++ b/builtin/notes.c
> @@ -574,6 +574,7 @@ static int add(int argc, const char **argv, const char *prefix)
>  	if (is_null_sha1(new_note))
>  		remove_note(t, object);
>  	else
> +		/* No return value checking; c_n_overwrite always returns 0 */
>  		add_note(t, object, new_note, combine_notes_overwrite);

I suspect something like

	if (add_note(t, object, ...))
		die("confused: combine_notes_overwrite failed");

would be less likely to fall out of date. ;-)

This whole series is good stuff.  I look forward to trying it
out.

Thanks,
Jonathan
