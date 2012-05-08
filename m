From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 2/5] status: refactor colopts handling
Date: Tue, 8 May 2012 20:27:45 +0700
Message-ID: <CACsJy8ADt0C=gyom8R15GoM+_6oHDvWasMgSqnwbiKqnXGwxug@mail.gmail.com>
References: <20120507212125.GA19532@sigill.intra.peff.net> <20120507212333.GB19567@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Zak Johnson <zakj@nox.cx>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue May 08 15:28:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SRkSq-0005Fc-FH
	for gcvg-git-2@plane.gmane.org; Tue, 08 May 2012 15:28:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755301Ab2EHN2U convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 May 2012 09:28:20 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:60735 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755192Ab2EHN2S convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 May 2012 09:28:18 -0400
Received: by werb10 with SMTP id b10so1903995wer.19
        for <git@vger.kernel.org>; Tue, 08 May 2012 06:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=/RkYYlLqS7Wf8FKJxzWbBzKvy0hbIWAggfTgb0teFzU=;
        b=Z1lbbq3AXGS8jIF5ovweZQ1pQ7lHEHSCpgAQaTbbfpLdaz1RDe1zSN7Uf3oqo/OmRx
         XatkuO9VJ0X5LV0MBfrJXPcq7F2BMwsmV2RCYjIm2MqmtANJujkYyGawBSVvz3n0BaZM
         EFec5OV0oJzp4fj0TGS9ObAxgucu22uXa7RKmxJpXiNZnxShhg6eL14QYJV1eQOZ1E97
         tcCgKtmyJEwkL4IvOeior9yJW9gmaDiJ6u5jaEAt8cdViQfHdbVThN5gw44OElNIPpOs
         srQf5A+hcDBeXEVV849Yo3YlNbjKHZIiSRAGyBdntOp6tVwh7wX+3/s83soFBWi2Y01U
         NTdg==
Received: by 10.216.145.153 with SMTP id p25mr12293334wej.112.1336483695720;
 Tue, 08 May 2012 06:28:15 -0700 (PDT)
Received: by 10.223.14.193 with HTTP; Tue, 8 May 2012 06:27:45 -0700 (PDT)
In-Reply-To: <20120507212333.GB19567@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197362>

On Tue, May 8, 2012 at 4:23 AM, Jeff King <peff@peff.net> wrote:
> The current code reads the config and command-line options
> into a separate "colopts" variable, and then copies the
> contents of that variable into the "struct wt_status". We
> can eliminate the extra variable and copy just write
> straight into the wt_status struct.
>
> This simplifies the "status" code a little bit.
> Unfortunately, it makes the "commit" code one line more
> complex; a side effect of the separate variable was that
> "commit" did not copy the colopts variable, so any
> column.status configuration had no effect.
>
> The result still ends up cleaner, though. In the previous
> version, it was unclear whether commit simply forgot to copy
> the colopt variable, or whether it was intentional. Now it
> explicitly turns off column options. Furthermore, if commit
> later learns to respect column.status, this will make the
> end result simpler. I punted on just adding that feature
> now, because it was sufficiently non-obvious that it should
> not go into a refactoring patch.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> For the reasons mentioned above, this ended up as a less impressive
> cleanup than I had hoped. I think it's still worth doing, but I won't=
 be
> too sad if it gets dropped.

I'm neutral. But this patch reduces one line so it wins a "yes" from me=
=2E

> =C2=A0builtin/commit.c | 13 ++++++-------
> =C2=A0wt-status.h =C2=A0 =C2=A0 =C2=A0| =C2=A02 +-
> =C2=A02 files changed, 7 insertions(+), 8 deletions(-)
--=20
Duy
