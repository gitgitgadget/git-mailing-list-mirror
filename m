From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] Building Git on Tru64
Date: Thu, 15 Apr 2010 21:29:11 +0200
Message-ID: <r2n81b0412b1004151229g6fe840a1v23a9d06f72e8d36a@mail.gmail.com>
References: <1271358589.19032.1370170305@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Daniel Richard G." <skunk@iskunk.org>
X-From: git-owner@vger.kernel.org Thu Apr 15 21:29:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O2Ukl-0006Vw-WE
	for gcvg-git-2@lo.gmane.org; Thu, 15 Apr 2010 21:29:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756265Ab0DOT3Y convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 15 Apr 2010 15:29:24 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:60078 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756253Ab0DOT3O convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 15 Apr 2010 15:29:14 -0400
Received: by gyg13 with SMTP id 13so902300gyg.19
        for <git@vger.kernel.org>; Thu, 15 Apr 2010 12:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:received:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=IcEo8m6cYe0v1QGe0LQKvyzYg2lzfgWFbZIBs7uEiUk=;
        b=l7cwEvODC2szJCHmQt5SR1OAHersYle2D7gJTgEklZQOy4FdjJ4uJjR70E90OdXIA7
         lH16JG4N0KA2+MzQvtRFRHNfxWdWIVLFwsuncbZUHL+VywN2nIW/dI18/r9p/fZqg3E/
         NmOYoQS2J3/uxs97Qq0/F2mghQoxvoy9bAYIc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=a9co9iR2mTTF+xYrk1LHjt8vzTZCd0rWs4nm62TiIUyx9a7OvbB0KmN4ZoMopDBZ6h
         Lb2ulhlMR1hTftvFCdqptTIBtvFUBBELdj52tv/7F4AaVqX61dGdoMFaPqJLH4kbCVRX
         HPKcYVFljkmD6sa98+8PReBU47q4ZCEE0P13w=
Received: by 10.100.212.9 with HTTP; Thu, 15 Apr 2010 12:29:11 -0700 (PDT)
In-Reply-To: <1271358589.19032.1370170305@webmail.messagingengine.com>
Received: by 10.100.24.39 with SMTP id 39mr1067287anx.20.1271359752023; Thu, 
	15 Apr 2010 12:29:12 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145013>

On Thu, Apr 15, 2010 at 21:09, Daniel Richard G. <skunk@iskunk.org> wro=
te:
> * On Tru64, MAP_FAILED is #defined as (-1L), and the compiler chokes =
if
> =C2=A0you directly compare a pointer to an integer. So, need to cast
> =C2=A0MAP_FAILED to (void *), redundant as that may seem.

That one may be better handled at one place (git-compat-util.h?) with
something like:

  #ifdef Tru64
  #define MAP_FAILED ((void *)MAP_FAILED)
  #endif

P.S. You may consider reading Documentation/SubmittingPatches.
The way you did it is a little unconventional.
