From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [GSoC] Designing a faster index format
Date: Thu, 19 Apr 2012 17:49:47 +0700
Message-ID: <CACsJy8ChA2ko0ox730iqP5W17U6ybm7s-CDMnEkce9J4R2o+5A@mail.gmail.com>
References: <F9D452C3-B11E-4915-A0F2-B248F92CE5DE@gmail.com>
 <CACsJy8CKqv2P2Co9MKpePfOTwe4fu-wxAYiigbYt3YHTxZ6wWQ@mail.gmail.com>
 <8D287169-1AD9-4586-BDBC-F820220328FC@gmail.com> <CACsJy8D2RwG-Nr5btcQj0f9=JACvH6mf7LNi=Jnb_y+j4_2u0A@mail.gmail.com>
 <871uomrubl.fsf@thomas.inf.ethz.ch> <8901F6B5-7396-44E1-9687-20BF95114728@gmail.com>
 <871uomq64c.fsf@thomas.inf.ethz.ch> <BDFA27C9-C999-4C95-8804-5E7B3B3D1BFD@gmail.com>
 <878virfx11.fsf@thomas.inf.ethz.ch> <2A61C352-5C71-4EDF-9DBE-01CC09AE03A5@gmail.com>
 <87r4we9sfo.fsf@thomas.inf.ethz.ch> <5CE5AEC7-22C8-4911-A79E-11F2F3D902A2@gmail.com>
 <7vk423qfps.fsf@alter.siamese.dyndns.org> <CACsJy8Ag9yvGwKE_oiW8T+hR2hN_fzXvGCdOJ_H44DCOm9RF0Q@mail.gmail.com>
 <1604FE70-8B77-4EC1-823A-DC1F0334CD3A@gmail.com> <4F7ABA19.7040408@alum.mit.edu>
 <C15BAB9A-EAFA-4EA4-85B2-0E0C5FF473E9@gmail.com> <alpine.DEB.2.02.1204031313170.10782@asgard.lang.hm>
 <D97085E6-2B9F-42C5-A06D-B53422034071@gmail.com> <87r4w1vofu.fsf@thomas.inf.ethz.ch>
 <878vi18eqd.fsf@thomas.inf.ethz.ch> <83571955-9256-4032-9182-FA9062D28B9D@gmail.com>
 <8D2805A4-9C5F-43A9-B3ED-0DB77341A03C@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Rast <trast@student.ethz.ch>, david@lang.hm,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	"Shawn O.Pearce" <spearce@spearce.org>,
	David Barr <davidbarr@google.com>
To: Thomas Gummerer <t.gummerer@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 19 12:50:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SKowW-000706-Br
	for gcvg-git-2@plane.gmane.org; Thu, 19 Apr 2012 12:50:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753765Ab2DSKuT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 19 Apr 2012 06:50:19 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:49372 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753539Ab2DSKuS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Apr 2012 06:50:18 -0400
Received: by wgbdr13 with SMTP id dr13so8486362wgb.1
        for <git@vger.kernel.org>; Thu, 19 Apr 2012 03:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=L7vemFcRQaO34ZnXAbe8YYHiEQb/HySU/ImDKsySW3s=;
        b=gNuNQb7dZbAagQbq7jk5zqrcjbG3w5BISmqBsHrOIw2EKkAWv/YEi2nf66RXx9czcU
         jVsQQPVusJ9E4JflBgYFoHWfa5KkA/Ki33En8iy0m1iRVeE4duBO5+rZemrcc2mo2ac4
         3CIfmyy05PDto61dEaIAl5mx7DU6INcXnoYAMvBTY1n7CRVn0JyW/pKcriI2qwn3zZZb
         MQdXPk+fZu4MSmYLK1cmoTtS0bhtG5J+xbqvBFyyIDlwFqLEGsoa805/v3DHmhqERzYM
         3KrkPko/w5HR/MWjiaQLqelmcchwEx7fIC6RoPRYV6MOrwd00puq/ytLnWatwDb5KLDt
         6SHA==
Received: by 10.180.24.7 with SMTP id q7mr25294383wif.11.1334832617260; Thu,
 19 Apr 2012 03:50:17 -0700 (PDT)
Received: by 10.223.16.194 with HTTP; Thu, 19 Apr 2012 03:49:47 -0700 (PDT)
In-Reply-To: <8D2805A4-9C5F-43A9-B3ED-0DB77341A03C@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195934>

On Thu, Apr 19, 2012 at 5:25 PM, Thomas Gummerer <t.gummerer@gmail.com>=
 wrote:
> As Thomas Rast pointed out on IRC today, it would be better to first
> =C2=A0implement a simple converter of the old index to the new format=
,
> and then implement a faster reader for the midterm, so we have a
> "future-proof" index format at the midterm and a fast reader.

You can skip the old-index reading code in the converter by writing a
git test command and  reuse git code. It's really simple: modify
Makefile, add your command name, say test-index-converter, to
TEST_PROGRAMS_NEED_X, then create test-index-converter.c with this:

#include "cache"

int main(int ac, char **av)
{
    setup_git_directory();
    read_cache();
    for (i =3D 0; i < cache_nr; i++) {
        struct cache_entry *ce =3D active_cache[i];
        /* process the entry and produce new format here */
    }
    return 0;
}

"make test-index-converter" will give you the command.

Of course it also comes at a cost because C may be slower to write
than Python for new-index constructing code. Or just output something
easy to parse in Python and write the Python converter from there.
--
Duy - Python ignorant

>  The new
> =C2=A0writing algorithm will then be implemented in the second part o=
f the
> Summer of Code.
>
> I'll just post the update on the timeline and the midterm evaluation =
here.
>
> -- Timeline --
> 24/04 - 01/05: Document the new index format.
> 02/05 - 11/05: Create a converter of the old index format to the new =
format in
> python.
> 12/05 - 18/06: Parse the index from disk to the current in-memory for=
mat. The
> old index format shall still be readable.
> 19/06 - 09/07: Implement the re-reading of a single record, if the cr=
c32 doesn't
> match (Meaning the record has been changed under the reader).
> - Midterm evaluation -
> 10/07 - 21/07: =C2=A0Map the current internal structure to the new in=
dex format.
> 22/07 - 31/07: Change the current in-memory structure to keep track o=
f the
> changed files.
> 01/08 - 13/08: Write the index to disk in both the old and the new fo=
rmat
> depending on the choice of the user and make sure only the changed pa=
rts are
> really written to disk in the new format.
> 11/08 - 13/08: Test the new index and profile the gains compared to t=
he old
> format.
> /* Development work will be a bit slower from 18/06 to 21/07 because =
at my
> =C2=A0* University there are exams in this period. I probably will on=
ly be able to
> =C2=A0* work half the hours. I'll be back up to full speed after that=
=2E */
>
> -- Midterm evaluation --
> At the midterm, there will be a python prototype for the conversion o=
f the old
> index format to the new "future-proof" index format and a faster read=
er for the
> new format. The native write part will be completed in the second par=
t of the
> Summer of Code.
