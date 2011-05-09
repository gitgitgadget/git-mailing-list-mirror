From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: RFC: a plugin architecture for git extensions?
Date: Mon, 9 May 2011 18:45:56 +1000
Message-ID: <BANLkTimKRo_36Ce2aFWWXdM1a+EgQ-u77Q@mail.gmail.com>
References: <7vhb986chl.fsf@alter.siamese.dyndns.org>
	<BANLkTi=+emhzqfiGxGbnJ=bm3oL7SvjhBw@mail.gmail.com>
	<7vbozg4eqw.fsf@alter.siamese.dyndns.org>
	<BANLkTi=zrWR0GAm6n1Gs9XDCR6kXtjDW0A@mail.gmail.com>
	<20110506065601.GB13351@elie>
	<BANLkTimVjZgOJk1ik7fbhQvW21Fo9eZoXg@mail.gmail.com>
	<20110506172334.GB16576@sigill.intra.peff.net>
	<BANLkTikDVBgOqd1U=qSL99U3K8EtLVTxtw@mail.gmail.com>
	<20110509073535.GA5657@sigill.intra.peff.net>
	<BANLkTi=tfxPN=WLmfn=d+jrHV3U-Rp8T=A@mail.gmail.com>
	<20110509081219.GB6205@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	David Aguilar <davvid@gmail.com>, Andreas Ericsson <ae@op5.se>,
	Joey Hess <joey@kitenet.net>,
	Git Mailing List <git@vger.kernel.org>,
	"david@lang.hm" <david@lang.hm>,
	Pau Garcia i Quiles <pgquiles@elpauer.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon May 09 10:46:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJM6O-0005uB-0Z
	for gcvg-git-2@lo.gmane.org; Mon, 09 May 2011 10:46:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753431Ab1EIIp6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 9 May 2011 04:45:58 -0400
Received: from mail-vx0-f174.google.com ([209.85.220.174]:62526 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750959Ab1EIIp5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 May 2011 04:45:57 -0400
Received: by vxi39 with SMTP id 39so5513858vxi.19
        for <git@vger.kernel.org>; Mon, 09 May 2011 01:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=oT6ZGJyU8dUxwhdbfxbkfrjkERxNNCvjinXeHh+KRTo=;
        b=XHe8FQ9P6uLrlMuxf4PlJ5TkaFqTMRZkslfW+2NrpOt0Np0KuoBfA1d5nA4mfAigMY
         iTi3FrEXdBvuS8WcKbVwkCN2JQfcv1TZiKWAiMP1wO8RNmZ+X+cF+ZldDYyWURlkTAC3
         1q+2AEZ8RSOe6HTMBCe70mBy1yLZ6s4NZkcqg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=EGchEBmd/k/60J7IsBVI8AISd318g3YiykR/M12YW0nezJ4iewxqX9vKXD5iiMQM94
         XyZJGjOFkwutVSrJOhzq9X/aD4Vtje/DVuyUP/iWntAUmlomJduuJczLmtl4igAMC7Vk
         y5EXanHegrRWl5X9WkbU2b7V8C6XrEpc4WaU4=
Received: by 10.52.180.164 with SMTP id dp4mr2527657vdc.119.1304930756422;
 Mon, 09 May 2011 01:45:56 -0700 (PDT)
Received: by 10.52.160.66 with HTTP; Mon, 9 May 2011 01:45:56 -0700 (PDT)
In-Reply-To: <20110509081219.GB6205@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173211>

On Mon, May 9, 2011 at 6:12 PM, Jeff King <peff@peff.net> wrote:
> On Mon, May 09, 2011 at 05:49:27PM +1000, Jon Seymour wrote:
>
>> Yep, that was part of the motivation for the suggestion - something
>> that works consistently, assuming only a working git installation.
>>
>> Per one of my other notes, my initial inclination is to provide a
>> patch that implements support for
>>
>> =C2=A0 =C2=A0 =C2=A0git --system-extensions-dir
>>
>> which would:
>> =C2=A0 =C2=A0- provide the caller with location that extensions coul=
d be
>> installed in (assuming the caller can acquire write privileges)
>> =C2=A0 =C2=A0- provide a guarantee that $(git --system-extensions-di=
r)/bin will
>> be on the path set up by the git wrapper and $(git
>> --system-extensions-dir)/man will be in the MANPATH searched by git
>> help
>>
>> Extensions could then use this information, together with git
>> --html-path to install themselves into these places using whatever
>> mechanism seems appropriate (either a POSIX shell script or a
>> make/install script).
>
> But is the system extension dir always the right place to do so? If I=
'm
> not root, then that probably won't be writable (or even if I am, I ma=
y
> want to install the extension only for the root user).
>
> If your proposal is for the user to decide on one of:
>
> =C2=A0unzip -d "$(git --system-extension-dir)" git-foo.zip
>
> or
>
> =C2=A0unzip -d "$HOME/.gitplugins" git-foo.zip

>
> then they can make that decision. But if you're proposing that the
> extension-writer distribute a script, then it's more complicated. The=
y
> would probably need to provide a "--user" versus "--system" option.
>

I am starting to think that deploy-via-zip/tar is unworkable for the
case where the extension wants to supply html, since I think an
attempt has to be made to deploy HTML in the path reported by git
--html-path for reasons of HTML  linkability from extension back to
the pages from git-core.

Now, this might not always work, and the install script can either
fail (to be re-run under sudo at users discretion) or degrade
gracefully (install what it can, and warn).

> It would also be tempting to write something like:
>
> =C2=A0install_dir() {
> =C2=A0 =C2=A0if test "`id -u`" =3D "0"; then
> =C2=A0 =C2=A0 =C2=A0git --system-extension-dir
> =C2=A0 =C2=A0else
> =C2=A0 =C2=A0 =C2=A0echo $HOME/.gitplugins
> =C2=A0 =C2=A0fi
> =C2=A0}
>
> but that is:
>
> =C2=A01. Not portable.
>
> =C2=A02. Does not allow for user-only installation by root.
>
> But all of this is a packaging best-practices issue, not an issue of
> what git needs to do to support it (you _could_ address the portabili=
ty
> issue by having "git --preferred-extension-path" that did the
> appropriate platform-specific UID check, but that still doesn't addre=
ss
> the second point).

So, suppose we call it --preferred-extension-path*, then if the user
(root or otherwise) defines

    git config core.preferrred-extension-path ${HOME}/.gitplugins

then they get to choose where the installer next run will install exten=
sions.

Also, this would only be a default - installation scripts could have a
mechanism to specify an override on the command line. Of course, if
they supply the override and it is not consistent with
--preferred-extensions-path/core.preferred-extensions-path then they
need to take steps to install that the bin directory is in the PATH,
but that's a decision they take themselves as an alternative to
acquiring the privileges required to modify the directory reported by
git --preferred-extensions-path

The idea is for core to provide extension installers with just enough
information that their installs will work and be discoverable by the
core and enough control for distributions to determine the preferred
location for such extensions.

* I would prefer --preferred-extension-dir rather than
--preferred-extension-path, since I think this name should specify a
single directory and not a list (otherwise the choice of destination
would be ambigiuous). I realise this creates an inconsistency with
--html-path and if consistency is preferred (or I have misinterpreted
what path normally means), I am happy to use
--preferred-extension-path.

jon.
