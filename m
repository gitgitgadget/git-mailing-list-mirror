From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v4] checkout: add --progress option
Date: Sun, 1 Nov 2015 15:15:21 -0500
Message-ID: <CAPig+cT-Mbf0cs+5OpPv+za=yrjiqycG5EtZONSrZwy8xL5pSA@mail.gmail.com>
References: <1446400076-9983-1-git-send-email-eantoranz@gmail.com>
	<CAPig+cSLC_xkpXEznzPQdA=FE6GV5VSuwSrFy62Nzybv7jQf1g@mail.gmail.com>
	<20151101191902.GA19594@sigill.intra.peff.net>
	<CAPig+cQvsXMqAzV_59sZdqDEh_SRfOMh+BY3XLmzSPdfWwugdg@mail.gmail.com>
	<CAOc6etb24owGX1KD9b-eYt5TtTKzEzinvnJ-81ev5QK_tKgLPQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>
To: Edmundo Carmona Antoranz <eantoranz@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 01 21:15:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zsz2G-00005Y-RY
	for gcvg-git-2@plane.gmane.org; Sun, 01 Nov 2015 21:15:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752672AbbKAUPX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Nov 2015 15:15:23 -0500
Received: from mail-vk0-f44.google.com ([209.85.213.44]:32973 "EHLO
	mail-vk0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751123AbbKAUPW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Nov 2015 15:15:22 -0500
Received: by vkgy127 with SMTP id y127so74976011vkg.0
        for <git@vger.kernel.org>; Sun, 01 Nov 2015 12:15:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=76UzQrvc0M8+UF7bPB6iQr7E2OexYRDMW9OU9z9UXTo=;
        b=xp2mIcC0EKg23rF6PPdZmksuYXas5XNC8n54XLMvTz9NUzEUw310WYDHTenmVyeosM
         lB4vwf78+sDvlzOzs4Ei4QLUe1YXhRYvkide02WvDO9mI/qadXE2iCOA2KBbjkkDzGh/
         1hBPj/rwthC+yOAqUlzbeeqmjqChLeReT6/tMq9Jgc2tuZds6axvgRA3lQeh4fQwi7UZ
         /3Z18TemCpA6jYZtMffQ0W6vmLTs8eRmKYN2chdIn4GAhZm/5jaGH1Q/pO4SARy5nBHZ
         WCw6nBH1+mpRggKq3Wx9xwaQPhUcX3zsHAWpZYhpHQsaO9RLaU7VN0bwMK+7BcklRwMl
         W0EA==
X-Received: by 10.31.163.85 with SMTP id m82mr11280277vke.19.1446408921640;
 Sun, 01 Nov 2015 12:15:21 -0800 (PST)
Received: by 10.31.159.204 with HTTP; Sun, 1 Nov 2015 12:15:21 -0800 (PST)
In-Reply-To: <CAOc6etb24owGX1KD9b-eYt5TtTKzEzinvnJ-81ev5QK_tKgLPQ@mail.gmail.com>
X-Google-Sender-Auth: bx3j3du6P-Tba17MkuADbLTeOTQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280663>

On Sun, Nov 1, 2015 at 2:35 PM, Edmundo Carmona Antoranz
<eantoranz@gmail.com> wrote:
> On Sun, Nov 1, 2015 at 1:29 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>>>> > +--progress::
>>>> > +       Progress status is reported on the standard error stream
>>>> > +       by default when it is attached to a terminal, unless -q
>>>> > +       is specified. This flag forces progress status even if the
>>>> > +       standard error stream is not directed to a terminal.
>
> Before I send a new full patch, could you guys tell me if you find this ok?
>
> -q::
> --quiet::
> Quiet, suppress feedback messages. Progress can skip this option.
> Read the information about --progress

IMHO, this sort of corner case probably doesn't deserve being called
out specially. Also, since --progress immediately follows --quiet in
the documentation, it's quite easy to discover --progress and read
about its behavior. Thus, I'd leave the description of --quiet as is.

> --[no-]progress::
> Progress status is reported on the standard error stream
> by default when it is attached to a terminal, unless --quiet
> or -q is specified. This flag forces progress status even if the
> standard error stream is not directed to a terminal and overrides
> the --quiet or -q options.

No need to make the description long by mentioning both -q and
--quiet. (My v4 review suggested only that you quote -q or --quiet
with backticks; not that you mention both.) The reader can easily
discover the alias of -q or --quiet, so mentioning one or the other
should be sufficient. A bit shorter and sweeter, perhaps:

    Progress status is reported on the standard error stream by
    default when it is attached to a terminal, unless `--quiet` is
    specified. This flag enables progress reporting even if not
    attached to a terminal, regardless of `--quiet`.
