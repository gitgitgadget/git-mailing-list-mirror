From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Subject: Re: [PATCH v2 3/3] http-backend: spool ref negotiation requests to buffer
Date: Mon, 25 May 2015 22:07:50 -0400
Message-ID: <CAMwyc-Tn+Sw67z9zTPsPU7SQP7PDzJhoJn30utQ0OWhKe_xbuA@mail.gmail.com>
References: <20150520073526.GA16784@peff.net>
	<20150520073709.GC9818@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Dennis Kaarsemaker <dennis@kaarsemaker.net>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue May 26 04:07:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yx4He-0008Ox-G9
	for gcvg-git-2@plane.gmane.org; Tue, 26 May 2015 04:07:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751143AbbEZCHx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 25 May 2015 22:07:53 -0400
Received: from mail-yh0-f48.google.com ([209.85.213.48]:33201 "EHLO
	mail-yh0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751057AbbEZCHv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 May 2015 22:07:51 -0400
Received: by yhcb70 with SMTP id b70so26805946yhc.0
        for <git@vger.kernel.org>; Mon, 25 May 2015 19:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=VoqlWEVy/MkjZvRNT1SSSMiE8gbx3oRLSOONDQKpwIU=;
        b=HNBD3eHO0wZU5OhvLtlfikuv6/sTyZae2kTQ7/pqx50iw9PS6Ohz0/UVEEYz2kIlHL
         5LEcp7dkVn1MNTiUO1VaeGPqAkQlTsrZeO+Yyg4OHeNwV9OMavqu77rDVUIae+xoc37j
         a1yYDotNPsop6hbHr2cmWPEoJ+n3au7uP4t5A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=VoqlWEVy/MkjZvRNT1SSSMiE8gbx3oRLSOONDQKpwIU=;
        b=aA5OgJ/5ouu/puBx3a/rObpWZGOSySMQb4aIcyTsY/Z3WY7d3UxMYt4YXEL/sMlcI/
         EHW+3QGok6Qe0XWG3JDUnRXEs3f2TqO2jFqs7rUU0Q7flP90aJ+wcOuEF+GNR8WbJFD0
         t7ZChMGc2luPvTld+YKBDuVmiOdE5QL1W0IQgyCCP/eea3m6LJMdKnqr+CuuKRZCM7hu
         /v90bKIAoIlR5UZVtxgqBfC2UHdZfGgR2TfTCCRjFPQFKMviVgoLewmvMrmWC2UWJF91
         KMwAz9fak3F9FqKo/vDLbSXRfCVQ6Fjs3TEuk+/hJbySjzoMsZ2dzj0Na15102EAao7t
         qhpg==
X-Gm-Message-State: ALoCoQleJq+myWJTuSh1RHqGE6IRmtNXBsDZlvkywgTVqx6pes8kh9DzmK6+riw5uD+mTlfNptQZ
X-Received: by 10.236.110.163 with SMTP id u23mr22090944yhg.50.1432606071058;
 Mon, 25 May 2015 19:07:51 -0700 (PDT)
Received: by 10.129.129.5 with HTTP; Mon, 25 May 2015 19:07:50 -0700 (PDT)
In-Reply-To: <20150520073709.GC9818@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269920>

On 20 May 2015 at 03:37, Jeff King <peff@peff.net> wrote:
> +               /* partial read from read_in_full means we hit EOF */
> +               len +=3D cnt;
> +               if (len < alloc) {
> +                       *out =3D buf;
> +                       warning("request size was %lu", (unsigned lon=
g)len);
> +                       return len;
> +               }

Jeff:

This patch appears to work well -- the only complaint I have is that I
now have "warning: request size was NNN" all over my error logs. :) Is
it supposed to convey an actual warning message, or is it merely a
debug statement?

Best,
--=20
Konstantin Ryabitsev
Sr. Systems Administrator
Linux Foundation Collab Projects
541-224-6067
Montr=C3=A9al, Qu=C3=A9bec
