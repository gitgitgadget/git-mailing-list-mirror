From: Geoff Russell <geoffrey.russell@gmail.com>
Subject: Re: Large pack causes git clone failures ... what to do?
Date: Wed, 1 Sep 2010 07:33:14 +0930
Message-ID: <AANLkTi=O5SbLRttzR0YwrHVEMz5gxtdTo9Z5C6V1yE1e@mail.gmail.com>
References: <AANLkTi=1iLx=-9gxkGzuhrbpA005VPSp0itkAkOG4D4z@mail.gmail.com>
	<20100831180247.GF32601@spearce.org>
Reply-To: geoffrey.russell@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Sep 01 00:03:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OqYvL-0006kq-1o
	for gcvg-git-2@lo.gmane.org; Wed, 01 Sep 2010 00:03:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754982Ab0HaWDR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 31 Aug 2010 18:03:17 -0400
Received: from mail-ww0-f42.google.com ([74.125.82.42]:61585 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751430Ab0HaWDQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 31 Aug 2010 18:03:16 -0400
Received: by wwb39 with SMTP id 39so251881wwb.1
        for <git@vger.kernel.org>; Tue, 31 Aug 2010 15:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:reply-to
         :in-reply-to:references:date:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding;
        bh=PwpDKNbfUbU4Avj68Egbbx90SbySY4ANZ5B7nm2R388=;
        b=Z6+653VjRmK/dj89m9ptfY5C7Fg5KMHUmAjRSewElSUty/TtAmSxt69I9Rmx+ieqXT
         Zgrd0EK8jIuXpUVCCSEJlXFieHlcPD9XJltgYjJLYbDRB0prcP9x6NLrBlmTRNKELE6a
         8ocLpNsDsA7LkT8VXn7B26tRSzOV49GN9PWeg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type:content-transfer-encoding;
        b=akrONbUTpxfOpnGNE/7U2dNjNIn+oehtyZnS9SB9Hd4Xe+/YMUifgI8P6QtBKffNNE
         PgwQdXl2Yrg8yq2pUjMKJgMeQb1a94UajxqLeqv3JNYwpkT27m+a5PYaWaeEYX6ptg72
         BuxAUc1n+ADpsxcD5Ps70sv/V94nFDNZ51UjU=
Received: by 10.227.143.198 with SMTP id w6mr7058074wbu.124.1283292195110;
 Tue, 31 Aug 2010 15:03:15 -0700 (PDT)
Received: by 10.216.164.19 with HTTP; Tue, 31 Aug 2010 15:03:14 -0700 (PDT)
In-Reply-To: <20100831180247.GF32601@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154987>

Thanks Shawn,

On Wed, Sep 1, 2010 at 3:32 AM, Shawn O. Pearce <spearce@spearce.org> w=
rote:
> Geoff Russell <geoffrey.russell@gmail.com> wrote:
>> I did a "git gc" on a repository and ended up with a 4GB pack ... no=
w I
>> can't clone the repository and get the following:
>> ...
>
> Are you on a 32 bit Linux system? =A0Or 64 bit? =A0Git should be auto
> selecting a unit that would allow it to mmap slices of that 4GB pack.

32bit

>
>> I've looked at "git repack --max-pack-size", but which that
>> created new packs it didn't delete the old monster.
>
> You really needed to run:
>
> =A0git repack --max-pack-size=3D.. -a -d
>
> The -d flag tells it to remove the old packs once the new packs
> are ready, and the -a flag tells it to reconsider every object
> in the repository, rather than just those that are loose.

Ok, will try.

>
> But if you can't clone it, you probably can't repack it. =A0Clone wor=
ks

The cloning fails at different points in the process and the server is =
normally
under some load, so perhaps load is a factor.

> by creating a pack file on the server, just like repack does.
> Except it sends the pack out to the network stream instead of to
> local disk.

Does clone from a client take note of the pack.packSizeLimit if I set i=
t
on the server? Or does it use the client value?

Cheers and many thanks, annoying problems like this always happen at re=
ally
inconvenient times :)

Geoff.

>
> --
> Shawn.
>
