From: Eldon Nelson <eldon_nelson@ieee.org>
Subject: Compile Error on Git 2.0.1 on Redhat 5.9 with Fix
Date: Wed, 2 Jul 2014 10:56:25 -0500
Message-ID: <CAH5EwqY8D=CGxB+rZvwPH5115r9qmRCBBvJMG_o0962d4Uquxw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 02 17:56:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X2Mtb-0006OA-Jh
	for gcvg-git-2@plane.gmane.org; Wed, 02 Jul 2014 17:56:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755451AbaGBP41 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jul 2014 11:56:27 -0400
Received: from mail-pd0-f179.google.com ([209.85.192.179]:55164 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755377AbaGBP40 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jul 2014 11:56:26 -0400
Received: by mail-pd0-f179.google.com with SMTP id w10so12130376pde.24
        for <git@vger.kernel.org>; Wed, 02 Jul 2014 08:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:date:message-id:subject:from:to:content-type;
        bh=ghOR3eOgmx046+l+lAN+36OYW2EAR/uin6G4wZw8XOs=;
        b=xhER+3uZ+S//34KQtC+gkK8P9NNwiMIyHGlwxWqB0OidCetPKxWVIaoiDDZ3ilvyh8
         ojVQKouKQthjlMcRWXwGkPTETT+6cZl2aQbDxbhz2mTmHNEXGsVVtNjcXsBjc/V0f0jf
         7vGZSpIMLSV/bcYx5jyJ+nhExAmwq55Q9Li0W7NY4u7lAgfzn6b3G9KK/u9mUgI4GxfO
         2gsYVm4IeLs02DzjdT3RfCuzvuE2pIKRKHKivH2GZprJTlup17vUwpnyE23mJgZrJSj/
         JoGj9cJmoMKr+Qnbczi+KrmQzfCOJsT1cvwj39XQPFoHbVCcwk+/9wzSnVEgC94Ra4h1
         Hfbw==
X-Received: by 10.66.141.76 with SMTP id rm12mr5033769pab.138.1404316585922;
 Wed, 02 Jul 2014 08:56:25 -0700 (PDT)
Received: by 10.70.128.48 with HTTP; Wed, 2 Jul 2014 08:56:25 -0700 (PDT)
X-Google-Sender-Auth: OIgNuYFn56rUXT1in8bea5vhjCY
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252789>

When compiling Git 2.0.1 on RedHat 5.9 as a non-root user I get the
following error:

BUILD ERROR

```
make prefix=/home/eldon/local all doc info
...
    CC zlib.o
    CC unix-socket.o
    CC thread-utils.o
    CC compat/strlcpy.o
    AR libgit.a
/bin/sh: gar: command not found
make: *** [libgit.a] Error 127
```

My fix was to make a symlink below:

SYMLINK

```
gar -> /usr/bin/ar
```

LINUX VERSION

```
> lsb_release -i -r
Distributor ID: RedHatEnterpriseClient
Release:        5.9
```

I think the fix is to allow the use of "ar" if "gar" does not exist. I
don't know if this exists for every Redhat install but "gar" is not
available in /usr/bin but "ar" does.

```
> /usr/bin/ar --version
GNU ar 2.17.50.0.6-20.el5_8.3 20061020
Copyright 2005 Free Software Foundation, Inc.
```

It could just be my corporate install of RedHat that is weird, but
thought this might be at least a point to describe a fix.

```
gcc --version
gcc (GCC) 4.1.2 20080704 (Red Hat 4.1.2-54)
Copyright (C) 2006 Free Software Foundation, Inc.
```

~~~~~~~~~~~~
Eldon Nelson
eldon_nelson@ieee.org
Cell: 952-393-3481
