From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] git-send-email.perl: Add sendmail aliases support
Date: Thu, 21 May 2015 17:05:27 -0400
Message-ID: <CAPig+cQFana40n=SCBOC0P2v4Ss7Via3eS6Ms2rU=M9_V_3Osg@mail.gmail.com>
References: <3f1091c3de6e4e62037bc3c84c69026e33ee9707.1432229888.git.allenbh@gmail.com>
	<xmqqioblisyk.fsf@gitster.dls.corp.google.com>
	<CAJ80satMSCGydLRb5k=xpSqxXSBL=_T7nsHEz3jsuFV9MdmmtA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Allen Hubbe <allenbh@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 21 23:05:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YvXem-00084k-RG
	for gcvg-git-2@plane.gmane.org; Thu, 21 May 2015 23:05:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756511AbbEUVF2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 May 2015 17:05:28 -0400
Received: from mail-ig0-f170.google.com ([209.85.213.170]:33651 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754853AbbEUVF1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 May 2015 17:05:27 -0400
Received: by igbpi8 with SMTP id pi8so21090062igb.0
        for <git@vger.kernel.org>; Thu, 21 May 2015 14:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=i8NFnVuUe3nb8vFIfKeR+/ANBCI0z9MlbpXi+guinK8=;
        b=v9MmntU6AeB/VeiF5R6O0af+ruYf6aAIU2yw1PQszboS6pwV3THpNU+lFDFZj37G2K
         5AOJJ9ASke9SunplnJihRMaKnuwsE1fMYuJPDIWyaAH8EkcRrTnH5y/qPq9+/zMi9g3/
         cqz1Lv7/RX1GsFA1cyGzq5rAkkRXBJvBTXOS4Is7GalHrOVKZuCZmCRxyFduy68Tg86I
         TN0oIS2nU2D6Q78pTcWfZ9CeJUfoY2EBNdwrJcLAk47U2zr+H2hjYFfG+z2hcsrwn8+S
         +xf7olMwjX6VhvGiJm0kM+oNw5E+hqZBGzfzSXIIkopEDUVbtBgLc56eM/GWEY6/vK8H
         E9qA==
X-Received: by 10.107.151.75 with SMTP id z72mr6079905iod.46.1432242327251;
 Thu, 21 May 2015 14:05:27 -0700 (PDT)
Received: by 10.107.28.132 with HTTP; Thu, 21 May 2015 14:05:27 -0700 (PDT)
In-Reply-To: <CAJ80satMSCGydLRb5k=xpSqxXSBL=_T7nsHEz3jsuFV9MdmmtA@mail.gmail.com>
X-Google-Sender-Auth: ljUDXEKvWJp0wfEX4Kt9xm-R4Mg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269661>

On Thu, May 21, 2015 at 4:48 PM, Allen Hubbe <allenbh@gmail.com> wrote:
> My motivation for this patch was not really to support the sendmail
> aliases file directly.  The commit message may therefore be
> misleading.  So, I could also rewrite the commit message to say
> something like, "loosely based on" the sendmail aliases format, if the
> exceptions to the format in the current message are not enough.

That probably would be a good idea. After reading the 'aliases' man
page you cited[1], I was wondering why your parser diverged from it in
so many ways. In addition to lack of support for folded lines, your
format:

* only recognizes comment lines when '#' is the first character,
whereas [1] allows whitespace before '#'

* only recognizes zero-length lines as empty, whereas [1] more loosely
interprets a whitespace-only line as empty

* doesn't support quoting the 'name' part of "name: value" as [1] does

> Really, I just prefer the simpler <alias>: <email|alias> syntax
> instead of the ones for mutt, elm, etc, and that is why I wrote this
> patch.

Your patch is missing a documentation update
(Documentation/git-send-email.txt) and new tests
(t/t9001-send-email.sh).

[1] http://www.postfix.org/aliases.5.html
