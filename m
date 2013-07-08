From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 2/4] name-rev: allow converting the exact object name at
 the tip of a ref
Date: Mon, 8 Jul 2013 17:50:16 +0530
Message-ID: <CALkWK0kSqaMrD_YuT8OxLo8yLEc0APd2Ca7FapKstqqmcYbC7A@mail.gmail.com>
References: <1373236424-25617-1-git-send-email-gitster@pobox.com> <1373236424-25617-3-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 08 14:21:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UwARB-0000pu-TX
	for gcvg-git-2@plane.gmane.org; Mon, 08 Jul 2013 14:21:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751335Ab3GHMU5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jul 2013 08:20:57 -0400
Received: from mail-ie0-f171.google.com ([209.85.223.171]:58367 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750998Ab3GHMU4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jul 2013 08:20:56 -0400
Received: by mail-ie0-f171.google.com with SMTP id qd12so9885446ieb.30
        for <git@vger.kernel.org>; Mon, 08 Jul 2013 05:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=pvzUQPzsg4b46bqPQRpmELrFErFR5cHqO3DmArX0lJ0=;
        b=jQ22lcmiPCirmTFtWNSnWLJXJF3DnXXrh6lpMWONt3erYcCJaZ39q3LO3y96zAUCXd
         +6cLx2Z71pzk3k3TTOcJo/+WzOjuoTRtmxKaG0S/tFRVSA5sWlvhRe0JwGrLCJJPBRra
         OG8FRdG6ql6t/GRd+AhCXbgbR7L95xiWBeeKztPD3AA7CnJDWH5gewvtj6z6Uwd1wCzC
         bV0A3415USlHO8inKRi90/vuHTNaMqzoat/+OInfMuT3kY88ZsGWdpNMKC+2lLqJEhIe
         7fzM7bimxMy18NnJN8le8AcQ6yl1o0vWkNs91HOh/LbDOFFMOvS6ZLygEWXxUzIFwwCf
         HqeA==
X-Received: by 10.50.47.12 with SMTP id z12mr8355233igm.50.1373286056321; Mon,
 08 Jul 2013 05:20:56 -0700 (PDT)
Received: by 10.64.37.130 with HTTP; Mon, 8 Jul 2013 05:20:16 -0700 (PDT)
In-Reply-To: <1373236424-25617-3-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229843>

Junio C Hamano wrote:
> "git name-rev" is supposed to convert 40-hex object names into
> strings that name the same objects based on refs, that can be fed to
> "git rev-parse" to get the same object names back, so
>
>     $ git rev-parse v1.8.3 v1.8.3^0 | git name-rev --stdin
>     8af06057d0c31a24e8737ae846ac2e116e8bafb9
>     edca4152560522a431a51fc0a06147fc680b5b18 (tags/v1.8.3^0)

Wait, what?

  $ git name-rev 8af060
  8af060 tags/v1.8.3^0

Isn't this a failure specific to --stdin?

> Teach it to show this instead:
>
>     $ git rev-parse v1.8.3 v1.8.3^0 | git name-rev --stdin
>     8af06057d0c31a24e8737ae846ac2e116e8bafb9 (tags/v1.8.3)
>     edca4152560522a431a51fc0a06147fc680b5b18 (tags/v1.8.3^0)

Wait, what is name-rev?

  Finds symbolic names suitable for human digestion for revisions
  given in any format parsable by git rev-parse.

It is meant to name _revisions_ (aka. commits): in that context, what
sense does it make to distinguish between tags/v1.8.3 and
tags/v1.8.3^0?
