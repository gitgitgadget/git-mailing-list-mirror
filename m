From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Add Gitweb support for LZMA compressed snapshots
Date: Sat, 1 Aug 2009 13:10:58 +0000
Message-ID: <94a0d4530908010610n31261414yc08060f3de9c115f@mail.gmail.com>
References: <E0C39B59-E2C5-4C28-9570-D33FEA2A44EB@uwaterloo.ca>
	 <m3r5vy1siq.fsf@localhost.localdomain>
	 <alpine.DEB.1.00.0907301042300.7467@intel-tinevez-2-302>
	 <94a0d4530907310845k51dbafbfy8e240467113dfc16@mail.gmail.com>
	 <alpine.DEB.1.00.0908011431060.8306@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>,
	Mark A Rada <marada@uwaterloo.ca>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Aug 01 15:11:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MXEMf-0005eD-PA
	for gcvg-git-2@gmane.org; Sat, 01 Aug 2009 15:11:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751572AbZHANLA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 1 Aug 2009 09:11:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751567AbZHANLA
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Aug 2009 09:11:00 -0400
Received: from fg-out-1718.google.com ([72.14.220.153]:25504 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751547AbZHANK7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 1 Aug 2009 09:10:59 -0400
Received: by fg-out-1718.google.com with SMTP id e21so756840fga.17
        for <git@vger.kernel.org>; Sat, 01 Aug 2009 06:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=x3ZKFV7CHPNCjEE+eQwL6+0VUtWystaefCgv/gD1rrk=;
        b=Z8820TtORSivU50Nww3xxQUZM3TEJ8EB98etVK7Ey+eUoEYfNvBjVo2uxr250ZFxMV
         GDHSjTXFcjpeGp4hMBTJNp7pESprbaleCOt7ZpU7SUNMa1BeaVL9FIFUObJS0Cqc1yHx
         F/eydLVQ0Nvv+EQ4ZyFZedmN7z2+wkPzZck44=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=kbuoMj2cBZ4dEjqKWlJDNK4RFWnuZWXIHVcTqPByvcaTp2SaCFGJo5eP5YjGvrzV2a
         Ysyukd8hK0vXExg9Z/wVvRWDk/S0SMpE8qt5KLg6FCoBXrKrqXnY3vuMLcCMRPyuvMBs
         w0n4x1D7rad4oHqA6iSHatmNPTrAmLg4vqi9s=
Received: by 10.86.74.15 with SMTP id w15mr1299349fga.26.1249132259054; Sat, 
	01 Aug 2009 06:10:59 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0908011431060.8306@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124621>

On Sat, Aug 1, 2009 at 12:34 PM, Johannes
Schindelin<Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Fri, 31 Jul 2009, Felipe Contreras wrote:
>
>> On Thu, Jul 30, 2009 at 8:43 AM, Johannes
>> Schindelin<Johannes.Schindelin@gmx.de> wrote:
>> > Hi,
>> >
>> > On Thu, 30 Jul 2009, Jakub Narebski wrote:
>> >
>> >> BTW. I wonder if it would be good idea to add support for this fo=
rmat
>> >> directly to git-archive... =C2=A0OTOH it would mean additional de=
pendency.
>> >
>> > I don't think it would be a good idea; we do not have bzip2 suppor=
t
>> > either.
>>
>> bzip2 has no advantages whatsoever.
>
> Bzzzzt. =C2=A0Wrong. =C2=A0Just because you cannot see them does not =
mean it has no
> advantages.

All right, most the time you compress once, and multiple people
uncompress multiple times. Therefore the path that should be optimized
is the decompression, that leaves bzip2 out of the picture.

You can think of advantages of bzip2 in more esoteric cases where the
compression time is also important. I don't think that's the case
here. Actually it might be if gitweb is not caching the tarballs, but
if that's the case I wouldn't say it's an advantage of bzip2.

>> AFAIK xz is superior to other formats and it would be nice to see gi=
t
>> make a technological stance encouraging xz.
>
> Bzzzt. Wrong again. =C2=A0Git's mission in life is not to encourage o=
ne
> compression over another.

Git's mission in life is not promoting asciidot either, but it's doing
that unintentionally by merely using it.

> If at all, the only compression Git actually does promote in a sense =
is
> zlib compression.
>
>> > The only reason we have inbuilt gzip and zip support is because th=
e
>> > format is so similar to Git's own compression.
>>
>> Personally I don't see the point of having zip support.
>
> Personally, I see the point of having zip support. =C2=A0It makes thi=
ngs easy
> for Windows users. =C2=A0And it's an established format, much more so=
 than
> tar.gz.

Windows can't extract .tar.gz?

--=20
=46elipe Contreras
