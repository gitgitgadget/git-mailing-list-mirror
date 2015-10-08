From: Junio C Hamano <gitster@pobox.com>
Subject: Re: please strip MIME-Version and Content-T{ype,ransfer-Encoding} in git am --scissors
Date: Thu, 08 Oct 2015 12:28:46 -0700
Message-ID: <xmqqvbahqhw1.fsf@gitster.mtv.corp.google.com>
References: <1444162070-22034-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<1444162070-22034-2-git-send-email-u.kleine-koenig@pengutronix.de>
	<5614CDAE.6070604@ti.com> <20151007075338.GH3982@pengutronix.de>
	<20151007102822.GT23801@atomide.com>
	<20151008071728.GO3982@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
X-From: git-owner@vger.kernel.org Thu Oct 08 21:28:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZkGs1-0001kG-8L
	for gcvg-git-2@plane.gmane.org; Thu, 08 Oct 2015 21:28:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756589AbbJHT2t convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 8 Oct 2015 15:28:49 -0400
Received: from mail-pa0-f50.google.com ([209.85.220.50]:33448 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756572AbbJHT2s (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Oct 2015 15:28:48 -0400
Received: by pacex6 with SMTP id ex6so63072601pac.0
        for <git@vger.kernel.org>; Thu, 08 Oct 2015 12:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:content-transfer-encoding;
        bh=+8QsSanmbPbN0J07U93OzsE3dFXRbzQwjKdE/HSqpqE=;
        b=VId2gYMNDTmL8asoJJtoEbrio3TmSf9VgKD9ZnbigUxmOOI0gy3BDN6CwXBLZLfKlk
         Wfboao9VNx8lQJvP4eN/Kl9zFvcPWmIRj92wCT7wAKzmQKkDPGFYFK1zYNkXheiNx4qP
         lKsStpa1jrtxCxEDO3JYYVCahp47hU9rxdMcPHIC5XiLR2qRyes1FkedutodEwx8sXrv
         jj4//qJGMHVGmoAum3sjxwlUOWv8BjVOGlSgKaDyObYuvMZbGa7wCWLZJYV1gKl8iG9H
         pJlAitGjTrlKlhOvmI++i9ps1nJSuQPAN69Jgfe4IIkhc9w/mfRN9DaVvurqfZ4pSlsp
         GXzQ==
X-Received: by 10.68.234.167 with SMTP id uf7mr9863847pbc.51.1444332527647;
        Thu, 08 Oct 2015 12:28:47 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:8f0:649c:42a6:426d])
        by smtp.gmail.com with ESMTPSA id zn9sm47387698pac.48.2015.10.08.12.28.46
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Thu, 08 Oct 2015 12:28:46 -0700 (PDT)
In-Reply-To: <20151008071728.GO3982@pengutronix.de> ("Uwe =?utf-8?Q?Kleine?=
 =?utf-8?Q?-K=C3=B6nig=22's?=
	message of "Thu, 8 Oct 2015 09:17:28 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279268>

Uwe Kleine-K=C3=B6nig  <u.kleine-koenig@pengutronix.de> writes:

> Hello,
>
> when applying the mail below (without the '> ' prefix) using git am
> --scissors the result looks like:
>
> 	$ git show
> 	commit 26ef0606927cc1979faa4166d7f9f3584b5cdc61
> 	Author: Tony Lindgren <tony@atomide.com>
> 	Date:   Tue Oct 6 05:36:17 2015 -0700
>
> 	    memory: omap-gpmc: Fix unselectable debug option for GPMC
> 	   =20
> 	    MIME-Version: 1.0
> 	    Content-Type: text/plain; charset=3DUTF-8
> 	    Content-Transfer-Encoding: 8bit
> 	   =20
> 	    Commit 63aa945b1013 ("memory: omap-gpmc: Add Kconfig option for =
debug")
> 	    added a debug option for GPMC, but somehow managed to keep it un=
selectable.
> 	   =20
> 	[...]
>
> 	$ git version
> 	git version 2.6.0
>
> The obvious improvement is to strip all headers like git am does with=
out
> --scissors.

Does this have anything to do with scissors, though?  If you remove
everything before "8< ---" in the body of Tony's message (i.e. keep
the in-body headers starting with "From:" and ending with CTE) and
try again, I would suspect that you will get the same result.

I also think that the "MIME-Version" thing is what gives this;
mailinfo and am do not really use it, and consider that the in-body
header ends there.

The right approach to tweak mailinfo to cope with this better would
be to keep a bit more state inside mailinfo.c::handle_commit_msg()
so that if we are (1) using in-body headers, (2) have already seen
_some_ valid in-body header like "Subject:" and "From: ", and (3)
have not seen a blank line, discard lines that we do not care about
(e.g. "MIME-VERSION: 1.0").


> If someone wants a bounce of the original mail, just ask per PM.

I have no idea what you are talking about here...


> On Wed, Oct 07, 2015 at 03:41:19AM -0700, Tony Lindgren wrote:
>> * Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de> [151007 00:=
57]:
>> > On Wed, Oct 07, 2015 at 10:45:50AM +0300, Roger Quadros wrote:
>> > >=20
>> > > How about this instead?
>> > >=20
>> > > NOTE: Apart from matching the register setup with the bootloader=
 you also need to
>> > > match the GPMC FCLK frequency used by the bootloader else the GP=
MC timings
>> > > won't be identical with the bootloader timings.
>> > Yeah, sounds better, thanks.
>> >=20
>> > > Also you might need to build this patch on top of
>> > > http://article.gmane.org/gmane.linux.kernel/2054796
>> > I talked to Tony about this patch yesterday on irc, but I didn't f=
ind it
>> > in the archives yet when I sent my mail.
>>=20
>> Yes sorry here's a repost with your and Roger's changes folded in an=
d
>> edited a bit. Probably best to keep them together with this patch.
>>=20
>> Does the following look OK to you guys?
>>=20
>> Regards,
>>=20
>> Tony
>>=20
>> 8< ----------------
>> From: Tony Lindgren <tony@atomide.com>
>> Date: Tue, 6 Oct 2015 05:36:17 -0700
>> Subject: [PATCH] memory: omap-gpmc: Fix unselectable debug option fo=
r GPMC
>> MIME-Version: 1.0
>> Content-Type: text/plain; charset=3DUTF-8
>> Content-Transfer-Encoding: 8bit
>>=20
>> Commit 63aa945b1013 ("memory: omap-gpmc: Add Kconfig option for debu=
g")
>> added a debug option for GPMC, but somehow managed to keep it unsele=
ctable.
>>=20
>> This probably happened because I had some uncommitted changes and th=
e
>> ...
