From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: [PATCH] git-gui: fix browser with initial path
Date: Fri, 28 Jan 2011 12:04:10 +0100
Message-ID: <AANLkTi=9vwg9mvvyWax0jr1OmAr+JUn7TNt98=9MxR6G@mail.gmail.com>
References: <1290497870-28673-1-git-send-email-bert.wesarg@googlemail.com>
	<AANLkTim8BhN9czr6Jx5J28iNop4XdFDcNKbbjxddW9-i@mail.gmail.com>
	<87sjwdmhrs.fsf@fox.patthoyts.tk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Pat Thoyts <patthoyts@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Fri Jan 28 12:04:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pim7q-00073p-2J
	for gcvg-git-2@lo.gmane.org; Fri, 28 Jan 2011 12:04:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753485Ab1A1LEQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 28 Jan 2011 06:04:16 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:52807 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752195Ab1A1LEP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 28 Jan 2011 06:04:15 -0500
Received: by wyb28 with SMTP id 28so3070031wyb.19
        for <git@vger.kernel.org>; Fri, 28 Jan 2011 03:04:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Tycq2iJhgTOZz2J9IGykPb5MOOc0ZzjVhToRU4tnnT4=;
        b=WHv90DVltB98NrPG7hRu1XaVjfdZOWs62ldH1t7S3SIQ+4s4oc6EeldGUSAgFlRsjP
         Lk5jCxpZStvqFBxi6PGwdfexVoFPEXQGTuKT/YzOpIwvcw1LMWOLLW4VZwEu8aHIEqcA
         y8prDfYu1OlNyMAMqvXtAAlNEDsOBi4fRzEaI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=LIKEJMgAGlnFLCuIpYT8QjqFWOv8yAuhWDms1S1Z+DLKRXrTJ63eQ2B2YvPvfoKydp
         3rc0hBZsuFQ5//4FPAF7jOMowObzLwWVcTaR/XcQ3lOPbacmnpxIgY3e8k/UJKU54Vp5
         Bv4iU8SZZE9yJbZy5hIbEIGE6pq3isnvUxPrE=
Received: by 10.227.180.134 with SMTP id bu6mr2445053wbb.183.1296212653251;
 Fri, 28 Jan 2011 03:04:13 -0800 (PST)
Received: by 10.227.134.14 with HTTP; Fri, 28 Jan 2011 03:04:10 -0800 (PST)
In-Reply-To: <87sjwdmhrs.fsf@fox.patthoyts.tk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165609>

On Fri, Jan 28, 2011 at 11:42, Pat Thoyts
<patthoyts@users.sourceforge.net> wrote:
> The commit comment for this doesn't really reflect whats being
> done. Commit 1ab8628 fixed the [Up To Parent] problem and this just
> fixes the display on the browser title.
>
> So I plan to take this with the commit comment as:
>
> =C2=A0git-gui: fix display of path in browser title
>
> =C2=A0Ensure the browser path is shown on the title with a / suffix a=
nd escape
> =C2=A0any backslashes or newlines in path elements before display.

No, the main problem is, that the path does not end in a slash, but
the browser code expect this, ie. it build sub pathes by just
concatenating '$path' and '$file', or with '$dir/', without a slash
inbetween. Its not only the visual part. Try this without the patch
(int git.git):

git gui browse git-gui/

In the path line there should be now 'master:git-gui'. Than go into
'lib'. You have 'master:git-guilib/'. And than double click about.tcl,
The blame view will get the 'git-guilib/about.tcl'.

Because the browser is itself consistent in this behavior, the only
problem was when the browser was a path given to start with. And this
path needs have a trailing slash. And this patch ensures this.

Bert

>
> =C2=A0Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>
>
> --
> Pat Thoyts =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0http://www.patthoyts.tk/
> PGP fingerprint 2C 6E 98 07 2C 59 C8 97 =C2=A010 CE 11 E6 04 E0 B9 DD
>
>
