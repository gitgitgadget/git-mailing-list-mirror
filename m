From: Ronald Weiss <weiss.ronald@gmail.com>
Subject: Re: [PATCH v2.1] commit: add --ignore-submodules[=<when>] parameter
Date: Mon, 31 Mar 2014 23:50:17 +0200
Message-ID: <CABxC_L88+eaQJUog0Bhj3EVE0A0NN=hh0heWogjuv2jve7Gx=A@mail.gmail.com>
References: <CABxC_L92v=cV=+e_DNa0L6f21LB0BRP5duai2h_heGJN_PRoUQ@mail.gmail.com>
	<5335A78C.60401@web.de>
	<CABxC_L-4=qcZiix05dL8GrDJXv=19fw4yB0qFzRRfw=G=_Gxbg@mail.gmail.com>
	<53374E49.9000702@gmail.com>
	<533874F9.3090802@web.de>
	<5338AC36.6000109@gmail.com>
	<5338B1B0.3050703@gmail.com>
	<5339BAE4.8020306@web.de>
	<5339D213.4070303@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, Heiko Voigt <hvoigt@hvoigt.net>,
	Junio C Hamano <gitster@pobox.com>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Mon Mar 31 23:51:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WUk6p-0004wt-FZ
	for gcvg-git-2@plane.gmane.org; Mon, 31 Mar 2014 23:51:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751780AbaCaVvE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Mar 2014 17:51:04 -0400
Received: from mail-oa0-f54.google.com ([209.85.219.54]:39667 "EHLO
	mail-oa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751687AbaCaVuS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Mar 2014 17:50:18 -0400
Received: by mail-oa0-f54.google.com with SMTP id n16so10072363oag.41
        for <git@vger.kernel.org>; Mon, 31 Mar 2014 14:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=vZiKzXQtJ3c2nMRSXzaEc46FGzMZxL+DlY9eOiLFM/Q=;
        b=NvEyIo+rcMfQBtib5mBd83qAdD2CngCONQlwKPmkhuDHFazwJxz4E03MOwUu36UDAO
         72wUtAZNCMUImU0sHGcaeFANHCmG8gAH+Fge2AQtO96otWuhV4GDeSKKFtMEdmIJ0Wj1
         mQl0FfID8QkA/vdnieXaDE81UIWvXQAtsJI2gw1clLH2mVbyfIjNLngbGx8d6UmSym7Q
         90i9yUS/dCZJcw6DefEccTFHb19K+kF1I5d0EUilstxSEqkymBeggkigzExGlk2ZePFW
         XPNE7cGDNP/kXrqkn3n2c3zIiOVcSaO41O1iNIMQYopXMyaN3si0s2XcZ53ecdpH3F+S
         ESaQ==
X-Received: by 10.60.62.34 with SMTP id v2mr11054882oer.37.1396302618039; Mon,
 31 Mar 2014 14:50:18 -0700 (PDT)
Received: by 10.76.154.68 with HTTP; Mon, 31 Mar 2014 14:50:17 -0700 (PDT)
In-Reply-To: <5339D213.4070303@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245545>

On Mon, Mar 31, 2014 at 10:37 PM, Jens Lehmann <Jens.Lehmann@web.de> wrote:
> ... maybe the best way is to leave index_differs_from() unchanged
> and call that function with the correct diff_flags instead:
>
> +               int diff_flags = DIFF_OPT_OVERRIDE_SUBMODULE_CONFIG;
> +               if (ignore_submodule_arg &&
> +                   !strcmp(ignore_submodule_arg, "all"))
> +                       diff_flags |= DIFF_OPT_IGNORE_SUBMODULES;
> +               commitable = index_differs_from(parent, diff_flags);
>
> Not thoroughly tested yet, but that'd also prevent any fallout for
> the two callsites of index_differs_from() in sequencer.c.

Thanks for this hint, that is really much nicer. I'll test that, and
post updated patch if it works.
