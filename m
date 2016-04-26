From: Luke Diamand <luke@diamand.org>
Subject: Re: [PATCH 0/2] git-p4: support python3 in the tests
Date: Tue, 26 Apr 2016 08:27:30 +0100
Message-ID: <CAE5ih7_MzKWG+=PDMW8a5uJ28uGGnvh-25-3b4bgnO3VdBiyLA@mail.gmail.com>
References: <1461420826-4416-1-git-send-email-luke@diamand.org>
	<xmqqzishibpz.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Users <git@vger.kernel.org>,
	Lars Schneider <larsxschneider@gmail.com>,
	Vitor Antunes <vitor.hda@gmail.com>,
	Sam Hocevar <sam@hocevar.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 26 09:27:37 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1auxPE-0006oY-MM
	for gcvg-git-2@plane.gmane.org; Tue, 26 Apr 2016 09:27:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752437AbcDZH1c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Apr 2016 03:27:32 -0400
Received: from mail-oi0-f46.google.com ([209.85.218.46]:36269 "EHLO
	mail-oi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752375AbcDZH1b (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Apr 2016 03:27:31 -0400
Received: by mail-oi0-f46.google.com with SMTP id x201so6298961oif.3
        for <git@vger.kernel.org>; Tue, 26 Apr 2016 00:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=YHF8W2VOs3p6TzrHdLhvftTNomrqPlM5OIkLnfG83MI=;
        b=XiqY1FJGaCCy3Sx6iJj4jt5nRRDu1G9g9jxvgey5Ornrr5ziYIIY/MchVRZYyGJF4y
         pZw6qte2H7UgyWwtSYjktPgw3Y0XOcWixSkcs27y+tUr/9U9YM7jMoy+tk+R3iE/Ll/d
         aTFpA3W0E2DYz1DHAvBlzI17H0D/I45qgbvL4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=YHF8W2VOs3p6TzrHdLhvftTNomrqPlM5OIkLnfG83MI=;
        b=K31sDERy7tj7TET8UH6SydemQ/+gvL4wv127vPFkTW2CJ+S+qXlYVZIxUYwNlRrRnN
         Z6DxOHh+pLjIzYq81ItLhG3iT5Qv9hbQlppJ2APXRmDdR4PshWKZY/tWA9pCUhGJ8wDj
         gWuJHWxU5uAqaxkmzqcenPWeqdWKWI/A14e1w5zYpaftcGORSU0wn1oJ/EpEEhdTvVHb
         s7CPwUyYqwUhN8XdD4cRMFNGDe/wVdYifdD3hRzuPY/qjlNOuNNU5XH6NFJuNF+Y7Bif
         ZgArW9L4ojJCO9SXd715l6MTjRiASVGmwPkvoeHEhJP6vW3OREpTJkRzTkFzA/UHda1w
         UZPQ==
X-Gm-Message-State: AOPr4FVsm9CkRxoi+A4Ft4kp9QUwBbr0BGTS1xYWDI02BqaQpsR2kDxGWDBVmN/iBTapX6JdXK8QLPlc9TT0VA==
X-Received: by 10.157.24.41 with SMTP id b38mr350893ote.190.1461655650823;
 Tue, 26 Apr 2016 00:27:30 -0700 (PDT)
Received: by 10.202.75.210 with HTTP; Tue, 26 Apr 2016 00:27:30 -0700 (PDT)
In-Reply-To: <xmqqzishibpz.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292587>

On 25 April 2016 at 23:07, Junio C Hamano <gitster@pobox.com> wrote:
> Luke Diamand <luke@diamand.org> writes:
>
>> This patchset updates the git-p4 tests so that they work with
>> either Python2 or Python3.
>>
>> Note that this does *not* fix git-p4 to work with Python3 - that's
>> a much bigger challenge.
>
> We use Python outside p4 tests (e.g. remote-svn test), and the way
> they invoke the interpreter is to say "$PYTHON_PATH" and avoid
> saying "python" which picks whatever random version of Python
> interpreter happens to be the first on $PATH.  Shouldn't the tests
> touched by this series be doing the same?

Yes, they should. I'll update them accordingly.

But the real reason for doing this is that at some point, git-p4 has
to start working with python3, since python2 is going away (albeit not
until 2020).

Luke
