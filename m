From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH] fetch: don't output non-errors on stderr
Date: Fri, 25 Jun 2010 21:28:16 +0000
Message-ID: <AANLkTilToJ2ekKVgIeka5qx9_lasw6DKSy8bOhTrP4dC@mail.gmail.com>
References: <AANLkTingtgeWuTrocesTIhTPsVz4dfU8CbwZF1TEl6AI@mail.gmail.com>
	<1277418881-11286-1-git-send-email-avarab@gmail.com>
	<7v1vbvkorf.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 25 23:28:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OSGRk-0007jQ-EN
	for gcvg-git-2@lo.gmane.org; Fri, 25 Jun 2010 23:28:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756232Ab0FYV2T convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 25 Jun 2010 17:28:19 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:36680 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751862Ab0FYV2S convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 25 Jun 2010 17:28:18 -0400
Received: by iwn41 with SMTP id 41so2409712iwn.19
        for <git@vger.kernel.org>; Fri, 25 Jun 2010 14:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=svcv+uEutdY63gIl/aJ6583E/N4taZNDXRHultooFqU=;
        b=jtNNi/N/PaokD06JwHdgnxkB+b4qEq4q2hpSiLIottJPq8DDD6briIlEuUWoBSnYhN
         68qgNXG7JwmznIO58tLYBmOgAQiIuUmFqmxg5LkOZ4OjMFSe3Hh32xQIQlH8VW7i3hKP
         rOsR4ARhdryL7mwhDWfsZqxM4RT/U+0rKjCdE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=XsEkFlOxkOdgaok9RT68bz+KfHyR9Z/0LNGdlIwoNh5sFEZj1e5uXPsO3m8xPXjv6B
         aIrfNLSCQr/Qp+NoSDFs7drZ6EkyzCTKX2Bwu/mqhRrOZBnS9/7j9zqvNRntqL7WDXpr
         h/3YZZV8x12DPgRTiOzQfW6tCNAKT33WLZsv0=
Received: by 10.231.150.2 with SMTP id w2mr1332003ibv.37.1277501297025; Fri, 
	25 Jun 2010 14:28:17 -0700 (PDT)
Received: by 10.231.166.79 with HTTP; Fri, 25 Jun 2010 14:28:16 -0700 (PDT)
In-Reply-To: <7v1vbvkorf.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149709>

On Fri, Jun 25, 2010 at 17:25, Junio C Hamano <gitster@pobox.com> wrote=
:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> Before the change error messages were drowned out by git-fetch's
>> non-error update notices, which didn't need my attention.
>
> I don't understand this part; care to elaborate?

I have a cron job (github-backup) that calls git fetch. Without this
patch I have to run it as '> /dev/null 2>&1' and just rely on the exit
code, with it I can just do '> /dev/null' and not ignore stderr,
because non-error output isn't being sent there anymore.

In short, the current git-fetch breaks the conventional *nix
assumption that stderr only contains errors. With this patch errors go
to stderr and normal output to stdout.
