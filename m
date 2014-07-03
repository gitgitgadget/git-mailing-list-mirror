From: Eldon Nelson <eldon_nelson@ieee.org>
Subject: Re: Compile Error on Git 2.0.1 on Redhat 5.9 with Fix
Date: Thu, 3 Jul 2014 15:13:07 -0500
Message-ID: <CAH5EwqbZygNg=Hiv_fTJ1wg5G07n_kUj77XK9eUmqh9+WPS3Dg@mail.gmail.com>
References: <CAH5EwqY8D=CGxB+rZvwPH5115r9qmRCBBvJMG_o0962d4Uquxw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 03 22:13:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X2nNZ-0001xD-LF
	for gcvg-git-2@plane.gmane.org; Thu, 03 Jul 2014 22:13:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752497AbaGCUNJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jul 2014 16:13:09 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:46574 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751852AbaGCUNI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Jul 2014 16:13:08 -0400
Received: by mail-pa0-f42.google.com with SMTP id lj1so765722pab.15
        for <git@vger.kernel.org>; Thu, 03 Jul 2014 13:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:content-type;
        bh=yQVZjh6lT9nFdFYxfRX9ntbQGsFmdI3QCt0orAOT5yk=;
        b=d61eHk1JasxbTVleZWuH48hDv2bcuc0GgtuvHU3MOC1kmcI+uLoh2Xc6RHbgK7pIPl
         23R0tcfhmOxxGTmq7iIBnGxaReRpmJKI56a0w6xdcJv/qP17mONeXU3aDntmb2AtkJYk
         SnuT0nMxR1SscoXTQ6fe+hwO/znN/BM1VH7PVYjBMgtesT4Nr855+7krdIIG8B6ig6Eq
         C5mcd5KnpQC/GMJXb8lW/lyk/6du7gVTrPWDec+QzAVlK+KFq+jOyYX9D71AiYWT4piI
         TzQpkX/GpHgdaygnoO2HWPK586CxWJw5tJW17S9sEwr4UM4WbNKJKnyhTDLfZ2g2Yb1j
         NrdQ==
X-Received: by 10.67.15.40 with SMTP id fl8mr6764904pad.69.1404418387966; Thu,
 03 Jul 2014 13:13:07 -0700 (PDT)
Received: by 10.70.128.48 with HTTP; Thu, 3 Jul 2014 13:13:07 -0700 (PDT)
In-Reply-To: <CAH5EwqY8D=CGxB+rZvwPH5115r9qmRCBBvJMG_o0962d4Uquxw@mail.gmail.com>
X-Google-Sender-Auth: 7TOTmlK59CvcgPMhbwG61JJS6Ew
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252879>

Thanks for the tip Jeff.  "config.mak.autogen" is created in the git
compile only when you do a "./configure".  Mine had the bad reference
to "gar" in it due to the following.

It was caused because my path had a reference to a non-related "gar"
executable (some internal command).  I saw the compile trying to
execute it and removed it from my path.  Doing a "make clean"
afterwards didn't remove the "config.mak.autogen" which had mistakenly
thought that I was using "gar" and not "ar".

When I fixed my path to not include the company specific "gar" and
started with a fresh untar it worked perfectly.  It also didn't make a
"config.mak.autogen" since that isn't what is recommended to do in the
git docs for install.

This is closed due to my own user error.

config.mak.autogen

# git Makefile configuration, included in main Makefile
# config.mak.autogen.  Generated from config.mak.in by configure.

CC = cc
CFLAGS = -g -O2
CPPFLAGS =
LDFLAGS =
AR = gar
TAR = gtar

~~~~~~~~~~~~
Eldon Nelson
eldon_nelson@ieee.org
