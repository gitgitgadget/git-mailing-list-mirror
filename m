From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] i18n: add infrastructure for translating Git with gettext
Date: Wed, 16 Nov 2011 04:33:19 -0600
Message-ID: <20111116103319.GB30753@elie.hsd1.il.comcast.net>
References: <1321191835-24062-1-git-send-email-avarab@gmail.com>
 <7vlirhx14x.fsf@alter.siamese.dyndns.org>
 <CACBZZX4nypBW1agNw6NrC-7LBWbjZ1ycgpn-zvBsg0x4EDBD0g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jakub Narebski <jnareb@gmail.com>,
	Jeff Epler <jepler@unpythonic.net>,
	Johannes Sixt <j6t@kdbg.org>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Thomas Rast <trast@student.ethz.ch>,
	Peter Krefting <peter@softwolves.pp.se>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 16 11:33:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RQco7-0004No-03
	for gcvg-git-2@lo.gmane.org; Wed, 16 Nov 2011 11:33:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755856Ab1KPKd0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 16 Nov 2011 05:33:26 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:59965 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755620Ab1KPKdZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 Nov 2011 05:33:25 -0500
Received: by yenq3 with SMTP id q3so1762034yen.19
        for <git@vger.kernel.org>; Wed, 16 Nov 2011 02:33:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=0JFeQiAi43OtVkja6gmWaYrFtSqCcnPsASk4O96UngE=;
        b=CnCQJum3IEwTl13GyPOGgM+fKzN9XR5MIvJYbzdmpaDxjQGDYvnXgnmQecLUe7L2vY
         LI/7yVSgQDKwxfvXFC/LV4e3VYaVm/lhgk1MPAxUOIamI4FoaXMjM5KVh4pHJmmYN6SM
         tbDGy1gIC3YMstNmgaz6VkqT461l3VPUV4pnA=
Received: by 10.50.77.229 with SMTP id v5mr32364754igw.13.1321439604981;
        Wed, 16 Nov 2011 02:33:24 -0800 (PST)
Received: from elie.hsd1.il.comcast.net (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id dd36sm42744051ibb.7.2011.11.16.02.33.23
        (version=SSLv3 cipher=OTHER);
        Wed, 16 Nov 2011 02:33:24 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CACBZZX4nypBW1agNw6NrC-7LBWbjZ1ycgpn-zvBsg0x4EDBD0g@mail.gmail.com>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185536>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> Here's what we do with the sharedir currently:
>
>  * It's used as the gitwebdir already, and is used also as the
>    localedir with this patch:
>
>     sharedir =3D $(prefix)/share
>     gitwebdir =3D $(sharedir)/gitweb
>     localedir =3D $(sharedir)/locale

This has $(prefix)/ (e.g., /usr/) at the start.

>  * Even then I can't find the option that makes gitweb put something
>    in it, after a "make" with this patch:
>
>     $ find share -type f
>     share/locale/is/LC_MESSAGES/git.mo

This does not.

>  * It *is* important that we have this under a
>    $SOMETHING/is/LC_MESSAGES/git.mo structure, since we set
>    GIT_TEXTDOMAINDIR to $SOMETHING, and the gettext library will only
>    understand something in this layout.
>
>    But that $SOMETHING doesn't have to be $ROOT/share, it could be
>    e.g. $ROOT/po/generated, which would make it not conflict with the
>    gitwebdir.

Yeah, makes sense.  bin-wrappers/git has to get its locales from
somewhere.
