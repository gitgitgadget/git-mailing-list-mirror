From: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [PATCH] compat-util: add _DEFAULT_SOURCE define
Date: Wed, 17 Sep 2014 12:54:50 +0900
Message-ID: <20140917035450.GA881@swordfish>
References: <1410672815-2555-1-git-send-email-sergey.senozhatsky@gmail.com>
 <xmqq61go7lme.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 17 05:55:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XU6Ku-0006JB-HG
	for gcvg-git-2@plane.gmane.org; Wed, 17 Sep 2014 05:55:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754165AbaIQDzO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Sep 2014 23:55:14 -0400
Received: from mail-pd0-f181.google.com ([209.85.192.181]:60266 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754063AbaIQDzM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Sep 2014 23:55:12 -0400
Received: by mail-pd0-f181.google.com with SMTP id w10so1216161pde.40
        for <git@vger.kernel.org>; Tue, 16 Sep 2014 20:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=zOF7Se88NgM1BMxCdg0USCb68MNOJufqer2CioxFMqc=;
        b=YG7kVYJnpJ/g8VKXu68eMiqdrYakI+l+GucfaFmiqWROaCET6SdzVZX4NCs9C2W+5v
         T1c/egTgUPkJFZM8ZxYzD8yTHfQRzIAdr+pIWaMinMzwZ53iuWHRaBBIDrBB7cyyOGMF
         ri+/cxSjS0sMSyD2eu8iSCxAQemfYH/skhIHN0/gwZLY3zPXYIPJv7oLGw6xUqKgtp9z
         PcHbbea25UnCQyCB3WP39UN2iN9dxorkl4BAkLo19O5X38O1/u0AgiXRyrLc+iDHgJkk
         hnMHbskFsQqrf5INL7AoyONZ2nuSKskRJBGZeIPJ+Yo0wXSIzjK9xXF4S0qu/OHzts8v
         MX3g==
X-Received: by 10.70.126.9 with SMTP id mu9mr903710pdb.151.1410926112054;
        Tue, 16 Sep 2014 20:55:12 -0700 (PDT)
Received: from localhost ([175.223.24.46])
        by mx.google.com with ESMTPSA id fh10sm15432567pdb.71.2014.09.16.20.55.10
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Sep 2014 20:55:11 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <xmqq61go7lme.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257209>

Hello,

On (09/15/14 12:02), Junio C Hamano wrote:
> Date: Mon, 15 Sep 2014 12:02:33 -0700
> From: Junio C Hamano <gitster@pobox.com>
> To: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
> Cc: git@vger.kernel.org
> Subject: Re: [PATCH] compat-util: add _DEFAULT_SOURCE define
> User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
> 
> Sergey Senozhatsky <sergey.senozhatsky@gmail.com> writes:
> 
> > glibc has deprecated the use of _BSD_SOURCE define
> >
> >   warning "_BSD_SOURCE and _SVID_SOURCE are deprecated, use _DEFAULT_SOURCE"
> >
> > To make it easier to maintain a cross platform source code, that
> > warning can be suppressed by _DEFAULT_SOURCE.
> >
> > Define both _BSD_SOURCE, _DEFAULT_SOURCE and cleanup the build.
> 
> I can see you defined DEFAULT_SOURCE, but where did you do "cleanup
> the build"?  Or did you mean "define both (in order) to clean up"?

yes. sorry, I meant "in order to clean up". otherwise, the build is
a bit noisy:

[..]
    CC base85.o
    CC bisect.o
    * new link flags
    * new prefix flags
    CC branch.o
    CC blob.o
In file included from /usr/include/unistd.h:25:0,
                 from git-compat-util.h:98,
                 from cache.h:4,
                 from blob.c:1:
/usr/include/features.h:148:3: warning: #warning "_BSD_SOURCE and _SVID_SOURCE are deprecated, use _DEFAULT_SOURCE" [-Wcpp]
 # warning "_BSD_SOURCE and _SVID_SOURCE are deprecated, use _DEFAULT_SOURCE"
   ^
In file included from /usr/include/unistd.h:25:0,
                 from git-compat-util.h:98,
                 from branch.c:1:
/usr/include/features.h:148:3: warning: #warning "_BSD_SOURCE and _SVID_SOURCE are deprecated, use _DEFAULT_SOURCE" [-Wcpp]
 # warning "_BSD_SOURCE and _SVID_SOURCE are deprecated, use _DEFAULT_SOURCE"
   ^
In file included from /usr/include/unistd.h:25:0,
                 from git-compat-util.h:98,
                 from cache.h:4,
                 from base85.c:1:
/usr/include/features.h:148:3: warning: #warning "_BSD_SOURCE and _SVID_SOURCE are deprecated, use _DEFAULT_SOURCE" [-Wcpp]
 # warning "_BSD_SOURCE and _SVID_SOURCE are deprecated, use _DEFAULT_SOURCE"
   ^
In file included from /usr/include/unistd.h:25:0,
                 from git-compat-util.h:98,
                 from cache.h:4,
                 from bisect.c:1:
/usr/include/features.h:148:3: warning: #warning "_BSD_SOURCE and _SVID_SOURCE are deprecated, use _DEFAULT_SOURCE" [-Wcpp]
 # warning "_BSD_SOURCE and _SVID_SOURCE are deprecated, use _DEFAULT_SOURCE"
   ^

[..]

> Just making sure we are not only seeing a patch half eaten by mail
> transport somewhere.

sure.

	-ss

> >
> > Signed-off-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
> > ---
> >  git-compat-util.h | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/git-compat-util.h b/git-compat-util.h
> > index 4e7e3f8..08a9ee2 100644
> > --- a/git-compat-util.h
> > +++ b/git-compat-util.h
> > @@ -82,6 +82,7 @@
> >  #define _ALL_SOURCE 1
> >  #define _GNU_SOURCE 1
> >  #define _BSD_SOURCE 1
> > +#define _DEFAULT_SOURCE 1
> >  #define _NETBSD_SOURCE 1
> >  #define _SGI_SOURCE 1
> 
