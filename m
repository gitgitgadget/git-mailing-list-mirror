From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH] Technical details about the index file format.
Date: Wed, 1 Sep 2010 08:12:03 +1000
Message-ID: <AANLkTiktRqX+fhFW3mN_b5tnbKzDJY86fLpKVth7RpY9@mail.gmail.com>
References: <1202711335-12026-1-git-send-email-robin.rosenberg@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster <gitster@pobox.com>, git <git@vger.kernel.org>
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Wed Sep 01 00:12:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OqZ42-0003DS-7S
	for gcvg-git-2@lo.gmane.org; Wed, 01 Sep 2010 00:12:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753934Ab0HaWMH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 31 Aug 2010 18:12:07 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:43184 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753273Ab0HaWMG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 31 Aug 2010 18:12:06 -0400
Received: by wyb35 with SMTP id 35so8409146wyb.19
        for <git@vger.kernel.org>; Tue, 31 Aug 2010 15:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=kJbjG04JZM+cfOAgh2cLFdBk9NadnwdGmPCIxRFBVLY=;
        b=tGrU5rbsFNJS9wmC9gFiOPJjNsooUklCASSdRFUOkCmxRoPN25WDne6o7308Fudt2g
         Vay41CEEAqge3Y43djGf1wd3RZ/LkJAqoPsceTd5Wn0WeFVIDUZR74qU1kMCZF5Tm8pM
         XfanFhmI0YMpASh/h79GWoKrWsDOn1YEbxWBM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=EGvVnMiFSt93gTf76dOPgz1NGSBRF8LHvXhdIqyieM5urfLt9TcqsGOycprCDXo6A3
         zEVdlQopcaB8Vgi2wEHqji+G71gurizFl+/gjV9ePDEl5uMSi1x3dWVt5mTQnkPvhuwA
         Y1R21f8xo/2Uk93ssFgGy9gyaLU3sk2kYhOvQ=
Received: by 10.216.174.7 with SMTP id w7mr7025628wel.21.1283292724395; Tue,
 31 Aug 2010 15:12:04 -0700 (PDT)
Received: by 10.216.184.17 with HTTP; Tue, 31 Aug 2010 15:12:03 -0700 (PDT)
In-Reply-To: <1202711335-12026-1-git-send-email-robin.rosenberg@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154988>

On Mon, Feb 11, 2008 at 5:28 PM, Robin Rosenberg
<robin.rosenberg@dewire.com> wrote:
> + =C2=A0 =C2=A0 4 byte version number:
> + =C2=A0 =C2=A0 =C2=A0 The current version is 2

The version could be 3 if extended flags are used.

> + =C2=A0 =C2=A0 A 16-bit field split into (high to low bits)
> +
> + =C2=A0 =C2=A0 =C2=A0 1-bit assume-valid flag
> +
> + =C2=A0 =C2=A0 =C2=A0 1-bit update-needed flag

I think this bit is CE_EXTENDED, an indication that this entry has
extended flags

> +
> + =C2=A0 =C2=A0 =C2=A0 2-bit stage (during merge)
> +
> + =C2=A0 =C2=A0 =C2=A0 12-bit name length

     A 16-bit field additional flags (high to low bits), only
applicable to version 3

       1-bit reserved for future

       1-bit skip-worktree flag

       1-bit intent-to-add flag (aka "git add -N")

> + =C2=A0- Extensions
> +
> + =C2=A0 =C2=A0The only know index extension today is a tree cache.

There's also "REUC" extension from read-cache.c. I personally have
never touched it, so no comments.
--=20
Duy
