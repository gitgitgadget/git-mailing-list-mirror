From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: git-cherry-pick and git-commit --amend in version 1.7.6.4
Date: Thu, 6 Oct 2011 09:09:06 -0400
Message-ID: <CAG+J_DzY6oW3CgCPDhD81Eue1Ygh+3pR7Q_NZEhauH_qkyUwqQ@mail.gmail.com>
References: <4E8C6F2F.1070306@6wind.com>
	<CAG+J_DynqAK8uXDPtHwWpGhfA5qFZifucs91qL79Pu_DmCxG3g@mail.gmail.com>
	<4E8D5AD0.2040509@6wind.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
To: nicolas.dichtel@6wind.com
X-From: git-owner@vger.kernel.org Thu Oct 06 15:09:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RBnhL-0003Nd-PF
	for gcvg-git-2@lo.gmane.org; Thu, 06 Oct 2011 15:09:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935809Ab1JFNJI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 6 Oct 2011 09:09:08 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:50268 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758284Ab1JFNJH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 6 Oct 2011 09:09:07 -0400
Received: by ggnv2 with SMTP id v2so1667364ggn.19
        for <git@vger.kernel.org>; Thu, 06 Oct 2011 06:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=jUqg4tq/COtUcyTS7uODiE8GKh68VnxwneCpX0BwobQ=;
        b=SdqSvz4E5OAxRb5gVlEoaATK6AOKRUwE3r6YxREd7MywNEwMcLBT4bMuyYHchQJ8VO
         j2mDKFoOKp4+paHFTZ6Om64swAJcrWFfnKHVd+x899OnpBNrsyxmkwaIu58qUElDl0Yr
         OHK+Tt/drvSUSvlPu9etirFx+DdTyVEU405Cg=
Received: by 10.147.5.21 with SMTP id h21mr454730yai.26.1317906546656; Thu, 06
 Oct 2011 06:09:06 -0700 (PDT)
Received: by 10.147.32.18 with HTTP; Thu, 6 Oct 2011 06:09:06 -0700 (PDT)
In-Reply-To: <4E8D5AD0.2040509@6wind.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182943>

On Thu, Oct 6, 2011 at 3:37 AM, Nicolas Dichtel
<nicolas.dichtel@6wind.com> wrote:
> # ls .git
> branches =C2=A0COMMIT_EDITMSG =C2=A0config =C2=A0description =C2=A0FE=
TCH_HEAD =C2=A0HEAD =C2=A0hooks
> =C2=A0index info =C2=A0logs =C2=A0objects =C2=A0ORIG_HEAD =C2=A0packe=
d-refs =C2=A0refs

No CHERRY_PICK_HEAD, so far so good.

> # git cherry-pick 3f78d1f210ff89af77f042ab7f4a8fee39feb1c9
> [dev 4cca2c2] drivers/net/usb/asix.c: Fix unaligned accesses
> =C2=A01 files changed, 33 insertions(+), 1 deletions(-)

cherry-pick completes successfully.

> # ls .git
> branches =C2=A0CHERRY_PICK_HEAD =C2=A0COMMIT_EDITMSG =C2=A0config =C2=
=A0description =C2=A0FETCH_HEAD
> HEAD =C2=A0hooks =C2=A0index =C2=A0info =C2=A0logs =C2=A0objects =C2=A0=
ORIG_HEAD =C2=A0packed-refs =C2=A0refs

This is bad. CHERRY_PICK_HEAD should only exist if the cherry-pick fail=
ed.

I really don't know what could cause this. Possibly a hook in your repo=
?

Using "GIT_TRACE=3D1 git cherry-pick
3f78d1f210ff89af77f042ab7f4a8fee39feb1c9" will tell you whether git is
running any hooks.

I can't think of anything config-wise that would cause this behavior.

I'll peer at the code some more...

j.
