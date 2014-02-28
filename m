From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH 17/19] Portable alloca for Git
Date: Fri, 28 Feb 2014 14:50:04 +0100
Message-ID: <CABPQNSadTGfiue6G+6x7_o10Ri1E7D5vZFU=Cp8rAha+j9jwSA@mail.gmail.com>
References: <cover.1393257006.git.kirr@mns.spb.ru> <f08867ee212e27074dbb4cbb06af408b16dba0a1.1393257006.git.kirr@mns.spb.ru>
 <CABPQNSaVQuXBEnSrs6hdHwEbaBKFr-NjKpuBRNnbkM+HtfJ4Ag@mail.gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>,
	Brandon Casey <drafnel@gmail.com>,
	Marius Storm-Olsen <mstormo@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Gerrit Pape <pape@smarden.org>,
	Petr Salinger <Petr.Salinger@seznam.cz>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Thomas Schwinge <tschwinge@gnu.org>
To: Kirill Smelkov <kirr@mns.spb.ru>
X-From: git-owner@vger.kernel.org Fri Feb 28 14:50:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJNq6-0004hA-Gj
	for gcvg-git-2@plane.gmane.org; Fri, 28 Feb 2014 14:50:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752223AbaB1Nur (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Feb 2014 08:50:47 -0500
Received: from mail-ie0-f172.google.com ([209.85.223.172]:56266 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752072AbaB1Nup (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Feb 2014 08:50:45 -0500
Received: by mail-ie0-f172.google.com with SMTP id as1so2908632iec.31
        for <git@vger.kernel.org>; Fri, 28 Feb 2014 05:50:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=yMwqibDtH0kxlnVPEnptsJKt5EWLTOn/4H/67pQCSUA=;
        b=Ls/vwXv1TmzUnpnR4kDyzpbeCW+fLuRWnM4XFByi6glhkZH96rF5YrDbMs+mllgmZt
         gOK5oXbGgaBi7m+5J+Se04yHB3cBsovHwN+SLsqINA4DygOM3WS1P7RwfxL24mY1f/EN
         TI7ackF9qoeEkIKN6f7CRNG9z6wM86ySbB7dTBbPk717KbWTV9dngTiDNH5hN5ty1FDZ
         ErLrY57rSWgQwfXcijUkKymVI4KbheWWumoCieELs72a6k+ZxfH48qHhGjm62+PtrtNl
         5JaePMzWr8ySQOSfk8BusjXU3kLZNhoKvD7lR0h6i4LJnXpaplNLtcmdUr0nDEQQEkt0
         fBAw==
X-Received: by 10.50.78.229 with SMTP id e5mr4117606igx.24.1393595444834; Fri,
 28 Feb 2014 05:50:44 -0800 (PST)
Received: by 10.64.166.135 with HTTP; Fri, 28 Feb 2014 05:50:04 -0800 (PST)
In-Reply-To: <CABPQNSaVQuXBEnSrs6hdHwEbaBKFr-NjKpuBRNnbkM+HtfJ4Ag@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242957>

On Fri, Feb 28, 2014 at 2:44 PM, Erik Faye-Lund <kusmabite@gmail.com> wrote:
> On Mon, Feb 24, 2014 at 5:21 PM, Kirill Smelkov <kirr@mns.spb.ru> wrote:
>> diff --git a/Makefile b/Makefile
>> index dddaf4f..0334806 100644
>> --- a/Makefile
>> +++ b/Makefile
>> @@ -316,6 +321,7 @@ endif
>>  ifeq ($(uname_S),Windows)
>>         GIT_VERSION := $(GIT_VERSION).MSVC
>>         pathsep = ;
>> +       HAVE_ALLOCA_H = YesPlease
>>         NO_PREAD = YesPlease
>>         NEEDS_CRYPTO_WITH_SSL = YesPlease
>>         NO_LIBGEN_H = YesPlease
>
> In MSVC, alloca is defined in in malloc.h, not alloca.h:
>
> http://msdn.microsoft.com/en-us/library/wb1s57t5.aspx
>
> In fact, it has no alloca.h at all. But we don't have malloca.h in
> mingw either, so creating a compat/win32/alloca.h that includes
> malloc.h is probably sufficient.

"But we don't have alloca.h in mingw either", sorry.
