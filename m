From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [PATCH 2/2] push: better error messages for detached HEAD and "no destination"
Date: Mon, 28 Feb 2011 17:48:04 -0500
Message-ID: <AANLkTim7O4O2UUWzZOrZOWN1zp2iruLYf3+3WMFTi8_5@mail.gmail.com>
References: <1298927645-2716-1-git-send-email-Matthieu.Moy@imag.fr> <1298927645-2716-3-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Mon Feb 28 23:48:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PuBtQ-0003Hx-4L
	for gcvg-git-2@lo.gmane.org; Mon, 28 Feb 2011 23:48:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753156Ab1B1Wsf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 Feb 2011 17:48:35 -0500
Received: from mail-iw0-f174.google.com ([209.85.214.174]:57750 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752696Ab1B1Wse convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Feb 2011 17:48:34 -0500
Received: by iwn34 with SMTP id 34so3553788iwn.19
        for <git@vger.kernel.org>; Mon, 28 Feb 2011 14:48:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=u0dmNr/hrLbpLTrsByis2H4nU+eA01aDhYtNcQzJcAU=;
        b=nkqxl7mS9nKnX3U4O5taI/wmlocoVYl5ppTR/8wvbCEd7ZhfiGXkiTpA4Pestk+tdw
         VnJnkK2VzHPEFatna0JStkcJp3coz1QBSTYLGYi9jckXbfPddWLztcfTeIaZ3VeSDc2U
         KYHL4zSuyks9evgNzFUhrA0Cdey0RO90SVUmQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=V4wySFVuTrJZkEO4Rq5eOOQfaloIXZWDZxDpQU/J272beF5lVzaEY8B0kLNAe59Q01
         gktQP7hXa2HQTKOh+1gjI+mlUcopw0JWU1c38pvkFQTHN3zxfWl0U8qm+gZ43eERQNyw
         BOoLjKmabf7FhKWpodEechhpNBqzKZmPJV/o8=
Received: by 10.231.20.68 with SMTP id e4mr5759727ibb.194.1298933314159; Mon,
 28 Feb 2011 14:48:34 -0800 (PST)
Received: by 10.231.40.2 with HTTP; Mon, 28 Feb 2011 14:48:04 -0800 (PST)
In-Reply-To: <1298927645-2716-3-git-send-email-Matthieu.Moy@imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168158>

On Mon, Feb 28, 2011 at 4:14 PM, Matthieu Moy <Matthieu.Moy@imag.fr> wr=
ote:

> ---
> =C2=A0builtin/push.c | =C2=A0 12 ++++++++++--
> =C2=A01 files changed, 10 insertions(+), 2 deletions(-)
>
> @@ -152,7 +153,14 @@ static int do_push(const char *repo, int flags)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!remote) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (repo)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0die("bad repository '%s'", repo);
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 die("No destinatio=
n configured to push to.");
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 die("No destinatio=
n configured to push to.\n"

The dangling preposition is awkward. How about:

  No configured push destination.

Or

  Push destination not configured.

> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 "Eit=
her specify the URL from the command line or configure a remote reposit=
ory using\n"

Maybe "Either specify the URL explicitly or configure..."

> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 "\n"
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 " =C2=
=A0 =C2=A0git remote add <name> <url>\n"
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 "\n"
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 "and=
 then push using the remote name like\n"

s/like//

> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 "\n"
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 " =C2=
=A0 =C2=A0git push <name>\n");

Well, I just bikeshedded that 3 different colors, didn't I? You're welc=
ome. :-)

j.
