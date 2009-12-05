From: "James P. Howard, II" <jh@jameshoward.us>
Subject: Re: [PATCH] Cast &cp to eliminate a compile-time warning on
 FreeBSD 8-STABLE.
Date: Sat, 5 Dec 2009 18:03:50 -0500
Message-ID: <20091205230350.GA3810@thermopylae.local>
References: <1259968322-66072-1-git-send-email-jh@jameshoward.us>
 <20091205161405.GA9272@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Dec 06 00:04:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NH3fb-0002QY-7O
	for gcvg-git-2@lo.gmane.org; Sun, 06 Dec 2009 00:04:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932242AbZLEXD4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Dec 2009 18:03:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757465AbZLEXDz
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Dec 2009 18:03:55 -0500
Received: from mail-qy0-f192.google.com ([209.85.221.192]:60393 "EHLO
	mail-qy0-f192.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757029AbZLEXDz (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Dec 2009 18:03:55 -0500
Received: by qyk30 with SMTP id 30so1531582qyk.33
        for <git@vger.kernel.org>; Sat, 05 Dec 2009 15:04:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:date:from:to:cc
         :subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=/qcboORRIpRtKxoGYzX+Z7lHIWvBksJb0Qbl89c4ukI=;
        b=EFqxR/drAi/VrhHQtgFB8nJBy/A3Yd6IvH+AIEBV88yIuACxE79cXTPqRLuL3pevTU
         ghgBeJmwJn8lHdkBkTh0bBDmypYVIVVhCf0LxhU7JjrF2R2f9C71XKanlP/NDfxYNfwf
         aYfE0qo3FPHSKJAjt6nExOpbZcW6lVEb0kMl4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=SG8bOyaXEu//8bgC7MM5o5PZ8ZO9wThGL4BmXPUvDePiDqlehGpUmorbZmpIQWqhO/
         B6/up/eWFNx2I6vo5Y/Jr7xx4scYTNE7Q5X4PdhkGnF70p/YJnN3qqA5NnkrUnBc+3rx
         GIvdNuRGkfHzsGijY1iUhqW5LUYYU9sh1xuIo=
Received: by 10.224.108.204 with SMTP id g12mr2617684qap.270.1260054241365;
        Sat, 05 Dec 2009 15:04:01 -0800 (PST)
Received: from thermopylae.local (c-68-57-75-220.hsd1.va.comcast.net [68.57.75.220])
        by mx.google.com with ESMTPS id 21sm2633167qyk.8.2009.12.05.15.03.59
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 05 Dec 2009 15:04:00 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20091205161405.GA9272@sigill.intra.peff.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134634>

On Sat, Dec 05, 2009 at 11:14:05AM -0500, Jeff King wrote:

> On Fri, Dec 04, 2009 at 06:12:02PM -0500, James P. Howard, II wrote:
> 
> > --- a/utf8.c
> > +++ b/utf8.c
> > @@ -449,7 +449,7 @@ char *reencode_string(const char *in, const char *out_encoding, const char *in_e
> >  	cp = (iconv_ibp)in;
> >  
> >  	while (1) {
> > -		size_t cnt = iconv(conv, &cp, &insz, &outpos, &outsz);
> > +		size_t cnt = iconv(conv, (const char **)&cp, &insz, &outpos, &outsz);
> >  
> >  		if (cnt == -1) {
> >  			size_t sofar;
> 
> Aren't you now introducing a warning for all of the other platforms
> which take a "char **"? Should you instead just be building with
> OLD_ICONV=Yes on your platform? See commit fd547a9 for details.

Yes, and it was brought to my attention within 10 minutes of my first
post.

James

-- 
James P. Howard, II, MPA MBCS
jh@jameshoward.us
