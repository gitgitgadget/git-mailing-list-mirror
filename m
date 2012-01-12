From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH] tree_entry_interesting: make recursive mode default
Date: Thu, 12 Jan 2012 12:44:30 +0700
Message-ID: <CACsJy8BEGKctdeDsZAyDGfG_JQ96RpTpXFZvJs5M1vKH3w=_WA@mail.gmail.com>
References: <20120111063104.GA3153@burratino> <1326341371-16628-1-git-send-email-pclouds@gmail.com>
 <7v1ur54ikk.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 12 06:45:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RlDTp-0006yC-Mx
	for gcvg-git-2@lo.gmane.org; Thu, 12 Jan 2012 06:45:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751937Ab2ALFpF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 12 Jan 2012 00:45:05 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:50543 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751042Ab2ALFpD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Jan 2012 00:45:03 -0500
Received: by bkvi17 with SMTP id i17so997979bkv.19
        for <git@vger.kernel.org>; Wed, 11 Jan 2012 21:45:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=LUKxyKsd0Po9YTeriXPD4dpSm5ETPKTn3M9z4HQ22G8=;
        b=jSGhgXuPHRd0I1rj9D8kyuqFO8d4by4H2RxZGnXiuumHYoL2e2GHzDuNs/dsrxlwwQ
         AaFkNuyi2dk5vPcoxQjrCmhIwmjdsvdy6FJ0LVJUddmn9k8CfdJSvMc0+j+RTK6oSJ+7
         LvdVqkL3sHh9uJBYjZLg6Ssv9MDkUPuoaAO2c=
Received: by 10.205.122.138 with SMTP id gg10mr635955bkc.94.1326347101454;
 Wed, 11 Jan 2012 21:45:01 -0800 (PST)
Received: by 10.204.66.77 with HTTP; Wed, 11 Jan 2012 21:44:30 -0800 (PST)
In-Reply-To: <7v1ur54ikk.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188430>

2012/1/12 Junio C Hamano <gitster@pobox.com>:
> Thanks, but I am curious about two (and a half) things.
>
> =C2=A0- The "max_depth" option has perfectly good and natural "invali=
d"
> =C2=A0 sentinel values (i.e. 0 or negative). Why do we need a separat=
e
> =C2=A0 bitfield?

We want infinite recursion by default, by max_depth default value is
0, which is non-recursive.

> =C2=A0- Special casing the non-recursive mode of diff-tree is perfect=
ly
> =C2=A0 acceptable, but nonrecursive_diff_tree does not sound like a v=
ery good
> =C2=A0 name for it for two reasons. Perhaps there may be other users =
that want
> =C2=A0 the "surface only" behaviour, so having "diff_tree" in the nam=
e limits
> =C2=A0 its future (re)use. Also an option that is named negatively in=
evitably
> =C2=A0 invites "if (!opt->non_whatever)" double negative. Can we come=
 up with
> =C2=A0 a better name, perhaps "onelevel_only" or something?

I'm bad at naming, any other names are welcome. onelevel_only sounds go=
od.

> =C2=A0- Shouldn't "onelevel_only" be the same as limiting to a single=
 depth
> =C2=A0 with "max_depth"?

I thought of that but not sure it's equivalent to max_depth =3D=3D 1 or
max_depth =3D=3D 0, so I separated it for safety and clarity. max_depth
feature is driven by git-grep and there were a few interpretations how
it should behave last time, so I'm not sure if its behavior may change
in future.
--=20
Duy
