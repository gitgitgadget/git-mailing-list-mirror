From: Michael Horowitz <michael.horowitz@ieee.org>
Subject: Re: git alias question
Date: Sat, 31 Dec 2011 16:31:18 -0500
Message-ID: <CAFLRborAuoWKxOeHtPRujSYbQPk67RCxTiVBavtWDeh-Byfa2w@mail.gmail.com>
References: <CAFLRbopjqW7OEWN4kxy+6Gb828h4zBC_h=4WiP-q1__LeezxUw@mail.gmail.com>
	<CAD0k6qTp9sKCb==Jh1vuLuZoxx99Kt2Z=VAbjYbGaUE7nbOxdQ@mail.gmail.com>
	<CAJDDKr5a8TB82h4ULWtamLOVu_4Fv+cGw1YfEL987gM3yM4TMg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Dave Borowitz <dborowitz@google.com>, git <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Sat Dec 31 22:31:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rh6WS-0007rV-Ja
	for gcvg-git-2@lo.gmane.org; Sat, 31 Dec 2011 22:31:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753335Ab1LaVbU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 31 Dec 2011 16:31:20 -0500
Received: from mail-pw0-f46.google.com ([209.85.160.46]:47348 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753071Ab1LaVbT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 31 Dec 2011 16:31:19 -0500
Received: by pbdu13 with SMTP id u13so7724522pbd.19
        for <git@vger.kernel.org>; Sat, 31 Dec 2011 13:31:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=ksY9jyEpNS36kbhy0jYz/BH1FNIPZpjigS4Cycg3PzA=;
        b=pwEg3MJWonREztZ6Aj8ritYdqM6qa0WniTW9F3JsjdOwi6rVzQq7YJECSfU8CCzpW5
         Wl8K9z1oWLJjOLY7yGZpbW8jwpZeVK0Lw2J/SZgIac9wAFeeM006XctsEuQ8CdXguhxG
         HvH4EZ4n6r/ZIKuYhfL4Gu3DJpC0z4oU8iMp4=
Received: by 10.68.190.65 with SMTP id go1mr106743627pbc.7.1325367078718; Sat,
 31 Dec 2011 13:31:18 -0800 (PST)
Received: by 10.142.102.16 with HTTP; Sat, 31 Dec 2011 13:31:18 -0800 (PST)
In-Reply-To: <CAJDDKr5a8TB82h4ULWtamLOVu_4Fv+cGw1YfEL987gM3yM4TMg@mail.gmail.com>
X-Google-Sender-Auth: YWcvWo8wM_0Jwy_uExxdRmIOTv0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187817>

The log operation does seem to make the most sense as the mechanism to
search for the results.  Making it work with difftool would work...
Not sure if "--log" to difftool or some other options as suggested in
the other thread would be most consistent UI-wise as stated, but
either would work for me.

On a separate note, some environment variable like GIT_PREFIX with the
CWD would make the alias functionality more flexible.

Mike

On Thu, Dec 29, 2011 at 8:59 PM, David Aguilar <davvid@gmail.com> wrote=
:
>
> On Thu, Dec 29, 2011 at 9:08 AM, Dave Borowitz <dborowitz@google.com>=
 wrote:
> > On Wed, Dec 28, 2011 at 17:27, Michael Horowitz
> > <michael.horowitz@ieee.org> wrote:
> >> ldiff =3D "!git diff `git rev-list --reverse -n 2 HEAD -- $1` -- $=
1"
> >
> > FWIW, you can also do this as:
> > =A0ldiff =3D log -p -1 --format=3Dformat: --
> >
> >> ldifft =3D "!git difftool `git rev-list --reverse -n 2 HEAD -- $1`=
 -- $1"
> >
> > I don't know that you can do something equivalent with difftool. I
> > suppose you could do the above with "GIT_EXTERNAL_DIFF=3D<some diff=
tool
> > wrapper> git ldiff", but that's not very helpful.
>
> difftool cannot be driven by log right now. =A0It is something we
> thought would be helpful in the past:
>
> http://thread.gmane.org/gmane.comp.version-control.git/114269/focus=3D=
114367
>
> On 2009-03-23 Junio C Hamano <gitster <at> pobox.com> wrote:
> > Perhaps we would want a convenient way for "log -p" or "show -p" to=
 drive
> > difftool as a backend?
>
> I think that's exactly it. =A0difftool wraps diff; a log equivalent
> would be quite helpful.
>
> One idea is for difftool to learn a "--log" option to make it wrap lo=
g
> instead. =A0I don't know if a diff-like command having a "--log" opti=
on
> is ideal from a consistency-of-user-interface POV so I'm open to
> ideas. =A0It is convenient, though. =A0It does seem like difftool wou=
ld be
> a good place to expose this feature.
>
> I'd be interested in the "teach log / show -p about GIT_EXTERNAL_DIFF=
"
> route, if that sounds like a good idea.
> --
> =A0 =A0 =A0 =A0 =A0 =A0 David
