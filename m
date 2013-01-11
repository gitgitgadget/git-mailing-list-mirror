From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: Version 1.8.1 does not compile on Cygwin 1.7.14
Date: Fri, 11 Jan 2013 21:17:50 +0100
Message-ID: <CALxABCavvW77djKQnbQsjCBcahmMfrP24SDz609NG-94_ifZ9Q@mail.gmail.com>
References: <2491041.bQ51Qu8HcA@thunderbird> <1890551.8jTmplCF6O@thunderbird>
 <BB541ECCD3F04E479F06CA491DDB598D@black> <50E92675.4010907@web.de>
 <20130106093211.GB10956@elie.Belkin> <50E946EB.1000709@web.de>
 <20130106095757.GC10956@elie.Belkin> <50E9647F.4090209@gmail.com>
 <20130106120917.GC22081@elie.Belkin> <7vfw2enl2l.fsf@alter.siamese.dyndns.org>
 <50E9F7C2.1000603@gmail.com> <FBDECCA565D94DF9838DD81FE2E2543A@black>
 <7v1udxladc.fsf@alter.siamese.dyndns.org> <50EB8EB5.6080204@gmail.com> <CALxABCYHRp17rcoOca1xWG9S19fq2rotz8FEKo09jNdrgMLiyQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Jason Pyeron <jpyeron@pdinc.us>, git@vger.kernel.org,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
	"Stephen & Linda Smith" <ischis2@cox.net>,
	Eric Blake <eblake@redhat.com>
To: Mark Levedahl <mlevedahl@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 11 21:18:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ttl3f-0004go-7w
	for gcvg-git-2@plane.gmane.org; Fri, 11 Jan 2013 21:18:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754036Ab3AKUSL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jan 2013 15:18:11 -0500
Received: from mail-pa0-f43.google.com ([209.85.220.43]:35159 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753945Ab3AKUSK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jan 2013 15:18:10 -0500
Received: by mail-pa0-f43.google.com with SMTP id fb10so1205667pad.16
        for <git@vger.kernel.org>; Fri, 11 Jan 2013 12:18:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=cWrSWUKd6vWp9Jjj0g1pUtjQKmfuupDzlFETtA3iwSg=;
        b=iHME4XBlAoCge7LUUi3hnU39QwCvh/Ot8qLEf2gkm97zrLQVmlUH3fsQEIidiVC1Y1
         T9j+Wa/5np49aaeBEsJzoMOComzmHWgBRuIXO2MEX8KPF1ltMXSxunssNwCAK1Ogv0Um
         cqcFREbWEn8BnVoJg1qwm8spWDRnhKU+i/3XWAfDtLW8T0XyjVwcs2zucsPMD/7PJWD3
         zt/1qe2dsPAr+KVPr4wFfsZHZWf9CrDJsLSxw3Qs0wAEIU1tMUliy4M5DoU1r2lw2+/G
         tH7yZ1Ec/RX/dQwcKE3iFPtUMKNzy3clesQCLKP4tFEipp89ZuNtRG/UdGW++H9Gs6bo
         xwwg==
Received: by 10.66.73.138 with SMTP id l10mr210106223pav.44.1357935490625;
 Fri, 11 Jan 2013 12:18:10 -0800 (PST)
Received: by 10.66.15.67 with HTTP; Fri, 11 Jan 2013 12:17:50 -0800 (PST)
In-Reply-To: <CALxABCYHRp17rcoOca1xWG9S19fq2rotz8FEKo09jNdrgMLiyQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213240>

On Fri, Jan 11, 2013 at 9:08 PM, Alex Riesen <raa.lkml@gmail.com> wrote:
> This short discussion on GitHub (file git-compat-util.h) might be relevant:
>
> https://github.com/msysgit/git/commit/435bdf8c7ffa493f8f6f2e8f329f8cc22db16ce6#commitcomment-2407194
>
> The change suggested there (to remove an inclusion of windows.h in
> git-compat-util.h) might simplify the solution a little. Might even
> remove the need for auto-configuration in Makefile (worked for me).

Just to be clear, the change is this:

diff --git a/git-compat-util.h b/git-compat-util.h
index 4a1979f..780a919 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -85,12 +85,6 @@
 #define _NETBSD_SOURCE 1
 #define _SGI_SOURCE 1

-#ifdef WIN32 /* Both MinGW and MSVC */
-#define WIN32_LEAN_AND_MEAN  /* stops windows.h including winsock.h */
-#include <winsock2.h>
-#include <windows.h>
-#endif
-
 #include <unistd.h>
 #include <stdio.h>
 #include <sys/stat.h>
