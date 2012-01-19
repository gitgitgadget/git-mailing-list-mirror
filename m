From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] i18n: disable i18n for shell scripts if NO_GETTEXT defined
Date: Thu, 19 Jan 2012 10:24:35 +0100
Message-ID: <CALxABCZsKHbLCwv0SKGt_M_GoTJ5eQZ3feUR-Ho4hW_TQuoFgg@mail.gmail.com>
References: <CALxABCZME-g++HxMsD4Nrn1J6s27vN7M_KQSVT3PeLWBqP7qJg@mail.gmail.com>
 <CACBZZX4TsL-tj04PmUwGNWjXO+JY-8unAv-aRKOGvgB71qdYCg@mail.gmail.com>
 <CALxABCadHdvR02Br9e6STy0w+EPoycUKr62RiSUSP_EPF-TH3g@mail.gmail.com>
 <CACBZZX4tB6DGV-1tiuOamq7ACPk0a-=1Pb9Vk1SgyDqAq-EFOw@mail.gmail.com> <7vfwfclf4v.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 19 10:25:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RnoEx-0002eE-OZ
	for gcvg-git-2@lo.gmane.org; Thu, 19 Jan 2012 10:25:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756597Ab2ASJY7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 19 Jan 2012 04:24:59 -0500
Received: from mail-tul01m020-f174.google.com ([209.85.214.174]:35357 "EHLO
	mail-tul01m020-f174.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755071Ab2ASJY5 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jan 2012 04:24:57 -0500
Received: by obcva7 with SMTP id va7so8406591obc.19
        for <git@vger.kernel.org>; Thu, 19 Jan 2012 01:24:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=sT3Tpk4qjTukqGZBZVOyosm/T3FrO+0dAsC5nMcDJoM=;
        b=u3d7shgV+KqW6cP4mecWXPHQuFBECmE/oHrUDxst+c9CXUbX9uqiobfy9lmOIFqvNW
         Y7iQ9XyDEJFxtOsg0kf1Bbib/kumjVloLbHcjzj/fmRTrttLRzEVEUyHVI9ra8MNXBu/
         FbOPBPnfYUmGWrM8y7vykVOMrbCq03iME5r8Q=
Received: by 10.182.216.100 with SMTP id op4mr22249505obc.53.1326965096423;
 Thu, 19 Jan 2012 01:24:56 -0800 (PST)
Received: by 10.182.226.41 with HTTP; Thu, 19 Jan 2012 01:24:35 -0800 (PST)
In-Reply-To: <7vfwfclf4v.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188798>

On Thu, Jan 19, 2012 at 01:17, Junio C Hamano <gitster@pobox.com> wrote=
:
> So we need "MY_GETTEXT_IS_BROKEN" to decline the use of system gettex=
t
> in addition to "NO_GETTEXT" to ask Git not to translate the messages.=
 Is
> that correct?

I think yes.

> If that is the case, should we do something like
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0LANG=3DC LC_ALL=3DC
> =C2=A0 =C2=A0 =C2=A0 =C2=A0export LANG LC_ALL
>
> in our shell scripts, when building for NO_GETTEXT target?

Just for the record: gettext here stays broken with LANG and LC_ALL set=
 to C.
But the locale-dependent formatting in C functions will change. Wont be=
 a
problem here, though. The named formatting is broken, too: strftime, fo=
r
instance, always formats in C locale.
