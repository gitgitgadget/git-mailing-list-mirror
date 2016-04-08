From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH v3 03/16] index-helper: new daemon for caching index and
 related stuff
Date: Fri, 08 Apr 2016 18:16:24 -0400
Organization: Twitter
Message-ID: <1460153784.5540.19.camel@twopensource.com>
References: <1459980722-4836-1-git-send-email-dturner@twopensource.com>
	 <1459980722-4836-4-git-send-email-dturner@twopensource.com>
	 <CACsJy8C5NhaAAW=wzpwkBdLvVZz8wVM7QX==n_CL5g+LLAKY=A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>, aevarb@gmail.com,
	jeffhost@microsoft.com
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 09 00:16:43 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aoehm-0004XR-LS
	for gcvg-git-2@plane.gmane.org; Sat, 09 Apr 2016 00:16:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753788AbcDHWQ2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Apr 2016 18:16:28 -0400
Received: from mail-qg0-f53.google.com ([209.85.192.53]:35010 "EHLO
	mail-qg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752686AbcDHWQ1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Apr 2016 18:16:27 -0400
Received: by mail-qg0-f53.google.com with SMTP id f105so78543970qge.2
        for <git@vger.kernel.org>; Fri, 08 Apr 2016 15:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=2rsfC87yWXrasOSSGuwGOuOeN3iVqBw7Ons92UjsDNY=;
        b=ko3BEZZg5X9d0QqqxyC1eQWfY4A2UASXsIOmg4PQl/oll6vHJe9Eae/WMcigXrfpMr
         18d2frm1ywugoWGkF3pzrOvQBJbEngZLNyedhMIKj7NrHtzIrd51ne+xJkHn3d28tmS1
         mg/Mkvb29u6sW33WSQwsJ+fY7ui0XKCMbqnPzcNs6YkqbXuh7SAPAAo1g/+6wLWjDSFr
         YlfV/07Rjmxhz/tTfslnLD74pZwwZ0SyBTiYw8C6EQCMg8+ye7sRDRQGNC7TAk+Sf8Ls
         tXOsCk0lNONCJ8MSX1X7ZXd78UqCHCCPOIIJcjpwLEDaMQwnSBYLzxszCBSOaZ+iKbqN
         7bEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=2rsfC87yWXrasOSSGuwGOuOeN3iVqBw7Ons92UjsDNY=;
        b=ljk4J2WMrKbaVNKMSkGYh3MJhpASTV1DLXXzO5JtYyyqRcD1hg2AuxKvqJVLM5n6hg
         ArV1+Ld96Z9xdXOvWY+zewZOzpgMKLSeL/iTXe0wwHzO/l5jTM0P/mDZHcMje0N9Y3IQ
         pDf0t1NABBkN0kPd/tz3G6/Cvh8ZIqRyso6EhuyC8valHvNCY9mANj4TdCKB6HxHMn0J
         otoz/gQhzhvtJpuXhURkwAKBhgChBt/cz4G5EAkDrtY4XfvYM63lD0/zN4ayfDWA6CFd
         xbPhDDuBItiTEhyzb1io9iYgmJM1RnqB3jI1SD72au9LAI2u7BYvvIt9bwI+ObC8Zwwk
         K3fg==
X-Gm-Message-State: AD7BkJLgOChVzazvRjv2JlrrXN85ikN55xZ96aOunAU+b00iCcYG6rZ2D4MNhF3SZT0S1g==
X-Received: by 10.140.136.70 with SMTP id 67mr15235976qhi.46.1460153785998;
        Fri, 08 Apr 2016 15:16:25 -0700 (PDT)
Received: from ubuntu ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id s8sm6339393qhb.20.2016.04.08.15.16.24
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 08 Apr 2016 15:16:25 -0700 (PDT)
In-Reply-To: <CACsJy8C5NhaAAW=wzpwkBdLvVZz8wVM7QX==n_CL5g+LLAKY=A@mail.gmail.com>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291074>

On Fri, 2016-04-08 at 18:26 +0700, Duy Nguyen wrote:
> On Thu, Apr 7, 2016 at 5:11 AM, David Turner <
> dturner@twopensource.com> wrote:
> > @@ -1045,4 +1046,21 @@ struct tm *git_gmtime_r(const time_t *,
> > struct tm *);
> >  #define getc_unlocked(fh) getc(fh)
> >  #endif
> > 
> > +#ifdef __linux__
> > +#define UNIX_PATH_MAX 108
> > +#elif defined(__APPLE__) || defined(BSD)
> > +#define UNIX_PATH_MAX 104
> > +#else
> > +/*
> > + * Quoth POSIX: The size of sun_path has intentionally been left
> > + * undefined. This is because different implementations use
> > different
> > + * sizes. For example, 4.3 BSD uses a size of 108, and 4.4 BSD
> > uses a
> > + * size of 104. Since most implementations originate from BSD
> > + * versions, the size is typically in the range 92 to 108.
> > + *
> > + * Thanks, POSIX!  Super-helpful!  Hope we don't overflow any
> > buffers!
> > + */
> > +#define UNIX_PATH_MAX 92
> > +#endif
> 
> Okay. You probably want to fix unix-socket.c too, and maybe reuse
> that
> code instead of opening unix sockets manually. There's a check in
> unix_sockaddr_init() about sizeof(sun_path) but I'm not sure if it
> suffices.
> 
> BTW, it looks like you tested this on Mac. But config.mak.uname only
> enables HAVE_SHM on Linux. Should it be enabled on Mac as well at
> least?

I did not in fact test on Mac.  I should have.  And indeed I need to
change config.mak.uname. 

Also I was leaking some memory.  And had some whiny warnings.  And had
a bug around how non-blocking sockets work on Mac. 

And SHM on Macs works a bit differently than on Linux in at least two
irritating ways. 

So, uh, new version to come once I actually make it work on Mac.
Probably Monday.
