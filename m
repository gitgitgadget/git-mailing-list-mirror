From: Geoff Russell <geoffrey.russell@gmail.com>
Subject: Re: gc getting called on each git command ... what's wrong?
Date: Wed, 15 Jun 2011 10:58:54 +0930
Message-ID: <BANLkTikdP6XKac9t8v2kyUEta3CB+Ue0PQ@mail.gmail.com>
References: <BANLkTi=oUARfwvNFNj-_FvZdwxQgibqPOg@mail.gmail.com>
	<BANLkTiksHRmp102XDJP5+-CLGj8hZXUR=g@mail.gmail.com>
	<m3pqmodzee.fsf@localhost.localdomain>
Reply-To: geoffrey.russell@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 15 03:29:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QWeui-0004m0-S8
	for gcvg-git-2@lo.gmane.org; Wed, 15 Jun 2011 03:29:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754319Ab1FOB2z convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 14 Jun 2011 21:28:55 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:40960 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752837Ab1FOB2z convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 14 Jun 2011 21:28:55 -0400
Received: by ewy4 with SMTP id 4so2278582ewy.19
        for <git@vger.kernel.org>; Tue, 14 Jun 2011 18:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:reply-to:in-reply-to:references
         :date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=H8K+LSGHisZiVP/MvKMRru3HU/Yz9nt/P56kCbjLoW4=;
        b=m1Yepjr9mPTnxAx0USkPJ8Gel6O5T1iU5JoXg1IiPVC4VwBdu7/2zm+cGQZzgiWkRM
         8PWYmEgIKy8wP58DJjcuP0zBkpkKDuThVY1ZgZZ2SCKUGd3Sh0QamV1/GFj7CZU9IDbJ
         U/ffgyyJD7fsPIrMag+IoYmCvICouwIqpA/sY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:content-type:content-transfer-encoding;
        b=UUipj5Gby3cb2QXQJZt2juka1OM5PdGyNxALnIVCea8ImPLgtxXZ/FhZNex1pRbgtU
         ixWHONxI4sRlfCxon46/rpkBP5XoZmMKfWfPf4ApIOxKviW2HITJM6gsraL0M4IZG2CJ
         bMbNdzNofWZXIoPscHepvvdg3CCSp8aBdu/B0=
Received: by 10.14.127.15 with SMTP id c15mr3299086eei.44.1308101334071; Tue,
 14 Jun 2011 18:28:54 -0700 (PDT)
Received: by 10.14.98.205 with HTTP; Tue, 14 Jun 2011 18:28:54 -0700 (PDT)
In-Reply-To: <m3pqmodzee.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175805>

On Thu, Jun 9, 2011 at 2:39 AM, Jakub Narebski <jnareb@gmail.com> wrote=
:
>
> Peter Harris <git@peter.is-a-geek.org> writes:
>
> > On Tue, Jun 7, 2011 at 9:33 PM, Geoff Russell wrote:
> > >
> > > As of today, almost every time I do a git command, gc is getting
> > > invoked.
> >
> > > =A0=A0There are 96 pack files.
> >
> > That's why. See gc.autopacklimit in "git help config" -- by default=
,
> > git will gc if there are more than 50 pack files.

Thanks to everybody. This is exactly what was happening and the problem=
s went
away when I set the packSizeLimit higher ... 3000M

>
> Actually it looks like it is combination of this and packSizeLimit se=
t
> to 30M. =A0Git notices that it has too many packfiles, and tries to
> repack them, but packlimit forces Git to split it into small
> packfiles... and end up with more packfiles than limit anyway.
>
> Perhaps git should notice that it has nonsensical combination of
> options...

That would be nice. It should be reasonably easy to work out that the
packSizeLimit
will guarantee too many pack files after the gc. Disobeying a users
wishes shouldn't
be undertaken lightly, but sometimes we stuff up :)

Cheers,
Geoff.

--
6 Fifth Ave,
St Morris, S.A. 5068
Australia
Ph: 041 8805 184 / 08 8332 5069
http://perfidy.com.au
