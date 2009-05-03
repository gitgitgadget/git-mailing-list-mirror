From: Ondrej Certik <ondrej@certik.cz>
Subject: Re: git fast-export | git fast-import doesn't work
Date: Sun, 3 May 2009 12:06:36 -0700
Message-ID: <85b5c3130905031206o43fd37d7y6b12eb0f0ba3d80e@mail.gmail.com>
References: <85b5c3130811250844u498fbb97m9d1aef6e1397b8c7@mail.gmail.com>
	 <alpine.DEB.1.00.0811260113140.30769@pacific.mpi-cbg.de>
	 <85b5c3130811260135g4646bf72iaf57f599fdd21a0c@mail.gmail.com>
	 <85b5c3130811260218s7529914eyb56a05ec1ca34b8f@mail.gmail.com>
	 <492D6CC3.2050408@drmicha.warpmail.net>
	 <85b5c3130811260750y2e24436ye2426ccfc2f66071@mail.gmail.com>
	 <492D7AEF.5030908@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun May 03 21:06:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M0h1S-0003zA-My
	for gcvg-git-2@gmane.org; Sun, 03 May 2009 21:06:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754539AbZECTGi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 3 May 2009 15:06:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753972AbZECTGi
	(ORCPT <rfc822;git-outgoing>); Sun, 3 May 2009 15:06:38 -0400
Received: from mail-gx0-f166.google.com ([209.85.217.166]:45388 "EHLO
	mail-gx0-f166.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753069AbZECTGh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 3 May 2009 15:06:37 -0400
Received: by gxk10 with SMTP id 10so6929636gxk.13
        for <git@vger.kernel.org>; Sun, 03 May 2009 12:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        bh=ZHkn5vI/cqCtCvgYan69mrciU7ZSiqlLjzamNsx78ek=;
        b=doBjAKh7/BZZP9N/ldWHWc3M7sGdA4s6ZRKn25glNeDV8NYkL/jNHRkIj7l5MlM3ak
         h4irMUMZ3V6k92Ejtt9R7XR/x6/jOXqiB0FAVb4XTIT9+fhIBJDCQNkENu0B/ytWhLcP
         zI+6zpWE4xVxfxKCEJ3VlIJHN2UkeUT+OSvyA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=mslJ6Mp3NpSMkBr8AhjN8wH0TiVbkaQvN4xAQXmGFU/SigJX7eth47BpmvRHNYcP/C
         l+W7FUqMo5qZlCVVhC4k5n69yVfFopEU9jhZb86oNHzfGz+AJQ1HeOnE6jGpsytIbPvL
         q6i8JtbnAfnx9JLfQWyiKDnKDUhDHZ8nmSspc=
Received: by 10.90.63.6 with SMTP id l6mr4546475aga.39.1241377597002; Sun, 03 
	May 2009 12:06:37 -0700 (PDT)
In-Reply-To: <492D7AEF.5030908@viscovery.net>
X-Google-Sender-Auth: 82d03fd9d3102b51
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118184>

On Wed, Nov 26, 2008 at 9:35 AM, Johannes Sixt <j.sixt@viscovery.net> w=
rote:
> Ondrej Certik schrieb:
>> I am also trying to make the example simpler. I tried to squash the
>> first uninteresting ~1500 commits into one, but "git rebase -i"
>> uterrly fails after squashing about 600 commits. Still investigating=
=2E
>
> Don't use rebase. Set a graft and rewrite the history:
>
> =C2=A0 $ echo $(git rev-parse HEAD) $(git rev-parse HEAD~1500) >> \
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.git/info/graf=
ts
>
> Assuming "first 1500" means the "most recent 1500" commits. But you g=
et
> the idea. You can truncate history as well by omitting the second SHA=
1.
> It's very convenient to keep gitk open and File->Reload after each gr=
aft
> that you set.
>
> When you're done with setting grafts:
>
> =C2=A0 $ git filter-branch -f --tag-name-filter cat -- --all
>
> (You are doing this on a copy of your repository, don't you?)

Thanks for the tip with grafts. I tried that on some other repository
when I needed to truncate the history and it works like a charm.

Ondrej
