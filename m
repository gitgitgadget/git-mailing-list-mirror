From: Tor Arvid Lund <torarvid@gmail.com>
Subject: Re: why is my repo size ten times bigger than what I expected?
Date: Wed, 9 Mar 2011 22:06:19 +0100
Message-ID: <AANLkTimYE8qCz98u3r2HRmeCx7k0wd_cWp-tR+tSoKbD@mail.gmail.com>
References: <AANLkTimi+OnpdX+Y7jx1JaOmGbZc_XEgJFeK0PKLpu2o@mail.gmail.com>
	<AANLkTi=V3nEamocowbHovvV0U69nZgD70fysu1CQOwrR@mail.gmail.com>
	<AANLkTikuuzHZ897kOY2u0Sv=0JTDffo0UhcxkyynVQAZ@mail.gmail.com>
	<AANLkTikxPPo4pGqrvo4rdDUOwp1PYYEdcERVfXfLnsVh@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Ruben Laguna <ruben.laguna@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 09 22:07:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PxQbb-00036W-Kd
	for gcvg-git-2@lo.gmane.org; Wed, 09 Mar 2011 22:07:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752610Ab1CIVHe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 Mar 2011 16:07:34 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:57352 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752318Ab1CIVHd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 9 Mar 2011 16:07:33 -0500
Received: by fxm17 with SMTP id 17so920189fxm.19
        for <git@vger.kernel.org>; Wed, 09 Mar 2011 13:07:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=YcAQz/Pn+LjORIuFbv+4Er25OCBtw8+gRGq4opnEljE=;
        b=CnTWPR0AX3Tuh+MkEqRckl3R/Iz3GucvnAzFCwRcAIPO7wKTE49k1VJPKKZJQs/PMX
         iH3FeSXPbJl8gtMj0KQCdN+Du8dmKM1UINB/a3lXzMvtsGZVA3NVpulLkCSkJE8Ep+hh
         ckhcBjTVCElGVFUZ0JuykFURytJjMgDaPyBdI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=cpH69cpxDPpRHqYWZJrgfkOFHIScYXNItwq33lvhHgLQLgwqPvGgO18Ogai2wuPXXz
         /cOV1gNEdJqM73/9nJ7Zj40CONgb7DNSxMVBrJvi0lswAfT1FAubaPJUEtWgxc6hqTtq
         QLI6X+K/FOj8HiUKkdvlHg3fuSDBRDNLG34tY=
Received: by 10.223.145.143 with SMTP id d15mr4039509fav.62.1299704779781;
 Wed, 09 Mar 2011 13:06:19 -0800 (PST)
Received: by 10.223.151.16 with HTTP; Wed, 9 Mar 2011 13:06:19 -0800 (PST)
In-Reply-To: <AANLkTikxPPo4pGqrvo4rdDUOwp1PYYEdcERVfXfLnsVh@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168761>

On Wed, Mar 9, 2011 at 5:35 PM, Ruben Laguna <ruben.laguna@gmail.com> w=
rote:
>> I just thought I'd mention that the git-remove-history script that y=
ou
>> mention does filter-branch on HEAD, and not using the --all paramete=
r.
>> I thought --all was the best way to "catch all" branches in one go..=
=2E
>>
>> =C2=A0 =C2=A0-- Tor Arvid
>>
>
> Much faster this way, thanks Tor,
>
> But it still gives the same result 88MB
>
>
> $ git branch -a
> * develop
> =C2=A0master
> =C2=A0remotes/origin/HEAD -> origin/develop
> =C2=A0remotes/origin/develop
> =C2=A0remotes/origin/experimental
> =C2=A0remotes/origin/gh-pages
> =C2=A0remotes/origin/master
>
> Finally I have deleted my public repo on github, created a new one an=
d
> pushed master and develop to the new empty one.

Ah, that's why I got only 3.6M when i cloned just now ;)

=46WIW (if you still want to figure it out...) - Whatever refs that you=
r
origin branches point to - their history and objects will *not* get
deleted by git gc/prune/whatever. So if they point to commits which
have these big jars in the history, that may be the cause. Also, when
I do filter-branch, it saves the old refs in .git/refs/original so
that I can revert it all those times when I screw it up ;)

Basically - since your "new" repo is so small, there is something in
your original repo that refers to your large objects.

Have a good night.

    -- Tor Arvid
