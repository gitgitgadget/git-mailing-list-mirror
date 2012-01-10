From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH v2 3/6] clone: factor out checkout code
Date: Tue, 10 Jan 2012 09:01:18 +0700
Message-ID: <CACsJy8DZpA0sQ6ZYjgrp8PsRTsYm0nOfSXcDOEhB2TRjqwbM0Q@mail.gmail.com>
References: <1325771380-18862-1-git-send-email-pclouds@gmail.com>
 <1326023188-15559-1-git-send-email-pclouds@gmail.com> <1326023188-15559-3-git-send-email-pclouds@gmail.com>
 <7vd3ascs85.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 10 03:01:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RkR2B-0006mI-Qb
	for gcvg-git-2@lo.gmane.org; Tue, 10 Jan 2012 03:01:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932281Ab2AJCBv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 9 Jan 2012 21:01:51 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:43996 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751493Ab2AJCBu convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 Jan 2012 21:01:50 -0500
Received: by eaad14 with SMTP id d14so2354356eaa.19
        for <git@vger.kernel.org>; Mon, 09 Jan 2012 18:01:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=i4IYYf2LGVZ6etwqoVVP4MC+LfWFT0jYoT8O+E/HrmE=;
        b=VW2mrm7vEiRPWcL3cKX1RGb6AWCsPFqfv259Xe039fp8vBC3CNiq663Jt37OXj0EOm
         80MXj+YpyxrR66Ksao22R/9742m4vLu1RBdzgy1HHcTDrU30X5jduWiNs5Vd9AzQ5AIv
         uVlLS4ZW1TTR4ydB1mEyG1waDnkFPfUdaaEeg=
Received: by 10.204.154.136 with SMTP id o8mr8250830bkw.112.1326160909373;
 Mon, 09 Jan 2012 18:01:49 -0800 (PST)
Received: by 10.204.66.77 with HTTP; Mon, 9 Jan 2012 18:01:18 -0800 (PST)
In-Reply-To: <7vd3ascs85.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188208>

2012/1/10 Junio C Hamano <gitster@pobox.com>:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy =C2=A0<pclouds@gmail.com> w=
rites:
>
>> Read HEAD from disk instead of relying on local variable
>> our_head_points_at, so that if earlier code fails to make HEAD
>> properly, it'll be detected.
>
> The end result might be more or less the same with your patch from th=
e
> end-user's point of view, but "if earlier code fails", shouldn't you
> detect and diagnose it right there?

Sure, but another fence does not harm. There's also one thing I missed
in the commit message that it makes update head code and checkout code
more independent. Update head code does not need to maintain
our_head_points_at at the end for checkout anymore.

> If you observe lack of "HEAD" in checkout(), you cannot tell if that =
was
> because the remote did not have anything usable in the first place, o=
r
> because we knew where it should point at (and may have even attempted=
 to
> create it) but somehow failed to make it point at it.

The lack of HEAD probably won't happen because HEAD is created by
default in init-db. This is mainly to catch invalid HEAD (like putting
"refs/tags/something" in HEAD).
--=20
Duy
