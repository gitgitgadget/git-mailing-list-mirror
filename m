From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: Advice for "pseudo public" repository on a USB key for a single 
	contributer project
Date: Sun, 24 Jan 2010 10:17:34 +0800
Message-ID: <be6fef0d1001231817s265dac68v646d71b688e0ed1e@mail.gmail.com>
References: <554f5f781001231027vd322045hf84e2a16208bcc9f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?ISO-8859-1?Q?Maxime_L=E9vesque?= <maxime.levesque@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 24 03:18:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NYs3V-0004r0-Mf
	for gcvg-git-2@lo.gmane.org; Sun, 24 Jan 2010 03:18:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752112Ab0AXCRf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 23 Jan 2010 21:17:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752094Ab0AXCRf
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Jan 2010 21:17:35 -0500
Received: from mail-iw0-f178.google.com ([209.85.223.178]:46215 "EHLO
	mail-iw0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751784Ab0AXCRe convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 23 Jan 2010 21:17:34 -0500
Received: by iwn8 with SMTP id 8so1933075iwn.23
        for <git@vger.kernel.org>; Sat, 23 Jan 2010 18:17:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=F9P2rnVRy7Rhwf6eeHVDYry7EQR0kVbC0Ug9wZqJJZ8=;
        b=BMTU9ENM9NnL1XBeGIQOxBqg53B3HUXOqSMLTLrdmBkWITOZOaL4/LMHlBbQDPHSpt
         6NLRIS6ZPWeUZSzjd/aVSRdz9sX2uKAxAYNMBtru6R7ftE9gyq3mLk/FxuSjD8WYxg1E
         DCedi7FwbdaY6549tXR6rMnlW9UW3oXrDnZu0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=WXQkckX0Bj2C+dajLJ4Qnfoxb1bslkqTyU9LY55yvL0HkCTzrfDkmzT56AWFmmJDoT
         6ihZb/o6q55rrU5I/evsc/a3bIc1NkkzG+wLwrYa4tLZ7lvfbGc6MaJDghxZXHbf+q4W
         VZ/g2kf2//d7avw1xcfPZkAcDNYvYUgdr8gvA=
Received: by 10.231.148.83 with SMTP id o19mr4590000ibv.39.1264299454097; Sat, 
	23 Jan 2010 18:17:34 -0800 (PST)
In-Reply-To: <554f5f781001231027vd322045hf84e2a16208bcc9f@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137882>

Hi,

2010/1/24 Maxime L=E9vesque <maxime.levesque@gmail.com>:
> =A0Since there are no servers involved, I have used pull command
> =A0to move my 'HEAD' around :
>
> =A0after working on machine1 I do :
>
> =A0=A0 commit to machine1Repo
> =A0=A0 machine1Repo=A0 --pull--> USBKeyRepo

I think you mean "push", since what you want is to make the changes in
machine1Repo available in USBKeyRepo.

> =A0when I switch on machine2 I start by bringing it up to date from t=
he key :
>
>
> =A0=A0 machine2Repo=A0 <--pull-- USBKeyRepo
>
> =A0=A0and when I'm finished=A0 :
>
> =A0=A0commit to machine2Repo
> =A0=A0machine1Repo=A0 --pull--> USBKeyRepo

I think you mean "push" here and s/machine1/machine2/ too, so that woul=
d read

  machine2Repo --push--> USBKeyRepo

When you make changes on machine2 and go back to machine1, you need to
fetch/pull in your changes, just like you do for machine2Repo:

  machine1Repo=A0 <--pull-- USBKeyRepo

> =A0=A0From what I have read my USBKey repo is like a public repo,
> =A0so I have tried using a bare repo, because since I never work
> =A0directly on the usb key, the souces on this repo are just
> =A0adding unnecessary complexity. So far I had no success,
> =A0because the pull command doesn't recognize my bare repo,
> =A0it seems that bare repos must me accessed via a daemon process.

What's your config?

Assuming you use master everywhere, I think you could use this in your =
config:

  [remote "USBKeyRepo"]
    url =3D /path/to/repo
    fetch =3D master
  [branch "master"]
    remote =3D USBKeyRepo
    merge =3D master

> =A0Is it wise to use pulls instead of pushes ?

See above. You can't use one "instead of" another - they serve
different purposes and don't replace one another.

> =A0Should I be using a bare repo on my key ?

Definitely, or else you would have a working tree in that repo too but
it never gets updated - not to mention all the warnings git would
show.

--=20
Cheers,
Ray Chuan
