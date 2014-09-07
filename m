From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH v3 2/2] headers: include dependent headers
Date: Sun, 7 Sep 2014 13:37:16 -0700
Message-ID: <20140907203715.GB61326@gmail.com>
References: <1410082617-59230-1-git-send-email-davvid@gmail.com>
 <540C350F.3080906@web.de>
 <540C3AEC.7080908@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>, git@vger.kernel.org,
	Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Sun Sep 07 22:37:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XQjDR-0001HL-Rh
	for gcvg-git-2@plane.gmane.org; Sun, 07 Sep 2014 22:37:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752114AbaIGUha convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 7 Sep 2014 16:37:30 -0400
Received: from mail-pd0-f176.google.com ([209.85.192.176]:65240 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751980AbaIGUh3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Sep 2014 16:37:29 -0400
Received: by mail-pd0-f176.google.com with SMTP id y13so1660986pdi.7
        for <git@vger.kernel.org>; Sun, 07 Sep 2014 13:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=0dXHpFY+pPzpxw7Ep3EEfcq6QcBl1qiiwbtUgEoDmb4=;
        b=k1JEAYzD/rfXG9z/JBHehtgg13OmaxbProXdK8VA8fICJpBfY+VOFILnG3dpjVOEgE
         G/sqO5xLlaxHziktq5A2cxJPx2C45IEnHDG/PPbCbTrRZ0Rw0y6fsycpft3w6Sxrq/o5
         cFxROf5FBQfsv/F2Chpc2A0mYx1kyHwbyVnqKQqttN8UMmOUs2WECjaNjnAh0aGdgtuF
         6gwgEJARtfImFwdaYvkv0xYl0JgHcOhBixYmsbjTiA/mGTbrjb7Q1jbG+Fks/+jjaSXs
         K8WJpUPv+f83tJn7Hktj3Ra1ZYZ5FIULjOSaLEoHfh09lUcio+vzBaHWdxqb2f6eBQVz
         k+/Q==
X-Received: by 10.66.168.165 with SMTP id zx5mr6524560pab.133.1410122249001;
        Sun, 07 Sep 2014 13:37:29 -0700 (PDT)
Received: from gmail.com (208-106-56-2.static.sonic.net. [208.106.56.2])
        by mx.google.com with ESMTPSA id rk11sm7564303pab.22.2014.09.07.13.37.27
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sun, 07 Sep 2014 13:37:28 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <540C3AEC.7080908@ramsay1.demon.co.uk>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256628>

On Sun, Sep 07, 2014 at 12:01:00PM +0100, Ramsay Jones wrote:
> On 07/09/14 11:35, Ren=C3=A9 Scharfe wrote:
> > Am 07.09.2014 um 11:36 schrieb David Aguilar:
> >> Add dependent headers so that including a header does not
> >> require including additional headers.
> >>
> >> This makes it so that "gcc -c $header" succeeds for each header.
> >=20
> >> diff --git a/cache.h b/cache.h
> >> index 4d5b76c..8b827d7 100644
> >> --- a/cache.h
> >> +++ b/cache.h
> >> @@ -1,7 +1,6 @@
> >>   #ifndef CACHE_H
> >>   #define CACHE_H
> >>
> >> -#include "git-compat-util.h"
> >>   #include "strbuf.h"
> >>   #include "hashmap.h"
> >>   #include "advice.h"
> >=20
> > Oh, that's a new change and worth mentioning in the commit message.
>=20
> Hmm, does this not break git? Unless you also change each '.c' file w=
hich
> includes cache.h to also include git-compat-util.h first, then I susp=
ect
> (if nothing else) file I/O may be broken. (see _FILE_OFFSET_BITS).
>=20
> Also, see Documentation/CodingGuidelines (lines 331-333).

This one should be okay because hashmap.h includes git-compat-util.h.

Jonathan will be re-rolling so I'll definitely read and test the
patches when they're ready.  They'll probably be a more focused,
surgical change then this version.

cheers,
--=20
David
