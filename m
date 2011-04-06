From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: blobs (once more)
Date: Wed, 6 Apr 2011 10:14:35 -0400
Message-ID: <BANLkTi=03mrHzfcVhgF9woWhsWb3wenxMQ@mail.gmail.com>
References: <BANLkTim3kg1ycGkgWsqaZiqMY9LTKV6DBw@mail.gmail.com> <alpine.DEB.1.00.1104061121000.2040@bonsai2>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Pau Garcia i Quiles <pgquiles@elpauer.org>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Apr 06 16:15:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q7TVd-0007bq-81
	for gcvg-git-2@lo.gmane.org; Wed, 06 Apr 2011 16:15:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756159Ab1DFOO4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 6 Apr 2011 10:14:56 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:50395 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755986Ab1DFOOz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 Apr 2011 10:14:55 -0400
Received: by gyd10 with SMTP id 10so582146gyd.19
        for <git@vger.kernel.org>; Wed, 06 Apr 2011 07:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=wUIGngUKLk6717IYzb4E0aqX8pnn12SyPuhXmbW2soo=;
        b=MLTm9kbl4rh3uxnKlO2bfgtauOh4aNG0s2prZWOqIkrIls7W3332EY8y8NJ41CHgVo
         B6CliU2vbT+aSl7ZXSG3AipxfKfIGFXoDo2Qt6DyB0oTB+NtdAV7R9YMtKdl9kDwtlds
         3F9tMMPeX6LDb+2rBXE7e9pdhz8f3QFDuNm8U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=fHowLeGKyPpVFBZlC4gbF5qLV03QqNPuuIpESok5CSL57XBZGDtXOc/DLQOZUYpHnJ
         ipP4GzGhQmlWQiZAQ0VosiXZBmorW7z4++vYq++V8H5fZUrrZ0o40P5Q8Kg22VIODP7k
         VySjLjQEVtrfXIaXk+DJhSayNWLE03PjTQa/I=
Received: by 10.91.199.16 with SMTP id b16mr1919055agq.3.1302099295106; Wed,
 06 Apr 2011 07:14:55 -0700 (PDT)
Received: by 10.90.103.15 with HTTP; Wed, 6 Apr 2011 07:14:35 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.1104061121000.2040@bonsai2>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170977>

On Wed, Apr 6, 2011 at 5:25 AM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> I understand. The problem in your case might not be too bad, after al=
l.
> The problem only arises when you have big files that are compressed. =
If
> you check in multiple versions of an uncompressed .dll file, Git will
> usually do a very good job at compressing them.

Except when they are very large; in that case git tends to OOM. But
just yesterday Junio posted a proposed patch to honour a max file size
for compression (search the archive for 'Git exhausts memory' and
'core.bigFileThreshold'.

So Pau might be in luck with current git + Junio's patch + enough RAM
on the workstations. Pau, I definitely suggest you try it out.

If it still consumes too much memory with the largest filest (ie: the
VM images you mention), the fedpkg approach (discussed in this thread)
is good too. It's a Python wrapper around git, which tracks a text
file listing the hashes of the large files, and fetches them (or
uploads them) via SCP. You only need to use it when dealing with the
large files -- most of the time you're just using git.

The fedpkg code is quite readable, and I've already "stolen" some of
its code for my local needs. Recommended.

cheers,


m
--=20
=A0martin.langhoff@gmail.com
=A0martin@laptop.org -- Software Architect - OLPC
=A0- ask interesting questions
=A0- don't get distracted with shiny stuff=A0 - working code first
=A0- http://wiki.laptop.org/go/User:Martinlanghoff
