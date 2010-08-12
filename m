From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: Low-level repository inspection (Re: Where do I stick development 
	documentation?)
Date: Thu, 12 Aug 2010 03:40:34 +0000
Message-ID: <AANLkTikpT=PD0Q8d=6=989N6rxYXH-Le3Go_szAz-t4s@mail.gmail.com>
References: <AANLkTi=dS1DYJ3MB-Du34sVPy8Qw8VNck=Lx54DtSfO0@mail.gmail.com>
	<20100812023922.GB19174@burratino>
	<AANLkTinPUqSywAscEG=VsYdFPwS=x0izM1cw-J1EBDGT@mail.gmail.com>
	<20100812031756.GD19174@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Thomas Rast <trast@student.ethz.ch>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 12 05:40:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OjOen-0005PR-OL
	for gcvg-git-2@lo.gmane.org; Thu, 12 Aug 2010 05:40:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758998Ab0HLDkg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Aug 2010 23:40:36 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:46301 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754181Ab0HLDkg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Aug 2010 23:40:36 -0400
Received: by bwz3 with SMTP id 3so550530bwz.19
        for <git@vger.kernel.org>; Wed, 11 Aug 2010 20:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=levv9WyJT6bMkN7g2Mr5hunT6BuQhm/U1s2TFrdR2d8=;
        b=ID2BL99wm7ByKrPksXOuAe4gD6OcATNuL9HGlGCrvbOXj5bTDMaOgSkV49xAmkngY0
         1dDL4Kmt2OTQOY1A58S/SnC5V/PxJ9FWhO3KV7X6WXuBYD5Uaq1ArSsBF540Kjotwvvc
         pPsvIcmZuLAGf57ytzO5L/MiYU6Z7mXRc1LR8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Df5kBHIvqiQ0lIRzondPWKWcTSdATHOl2XOhRd+lvfyfxBAHsM4oLo2hRMbZ1YQN1R
         utp1UyuCuZRFjhOQIpXscjhUfrxuEV58pnt7pjc14x6V0wsxpZrrf8353qXEx5db1eHb
         nRz0Pu6k5a8CeLCCMn38Vm46kF3sihQvPkuYk=
Received: by 10.223.113.12 with SMTP id y12mr21080312fap.36.1281584434544; 
	Wed, 11 Aug 2010 20:40:34 -0700 (PDT)
Received: by 10.223.109.195 with HTTP; Wed, 11 Aug 2010 20:40:34 -0700 (PDT)
In-Reply-To: <20100812031756.GD19174@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153335>

On Thu, Aug 12, 2010 at 03:17, Jonathan Nieder <jrnieder@gmail.com> wro=
te:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>
>> It'd also be very neat if we had tools to print out any object in it=
s
>> raw form, --pretty=3Draw is partly there, but it's more pretty than
>> raw.
>
> How about git cat-file (and other =E2=80=9Cinterrogation commands=E2=80=
=9D listed in
> git.1)?

Those are part of the way there, but you often have to tease info out
of them, e.g. if you want a commit -> commit roundtrip:

    $ echo 7980e417 | git cat-file --batch | perl -0777 -pe 's/.*
commit ([0-9]*).(.*)\n/commit $1\0$2/s'|sha1sum
    7980e41746bc5de91eea775f9142ce44b1100361  -

The raw output from that is:

    $ echo 7980e417 | git cat-file --batch
    7980e41746bc5de91eea775f9142ce44b1100361 commit 525
    tree 782007df51255ab3793e528a4b5c4a69342166f2
    parent 0d0ba03a18a9c6cbc3d55c1b6834b9c3824f823f
    parent b5e233ecc411c8685463333d180a135c6866c50e
    author Junio C Hamano <gitster@pobox.com> 1281551520 -0700
    committer Junio C Hamano <gitster@pobox.com> 1281551520 -0700

    Merge branch 'maint'

    * maint:
      post-receive-email: remove spurious commas in email subject
      fast-import: export correctly marks larger than 2^20-1
      t/lib-git-svn.sh: use $PERL_PATH for perl, not perl from $PATH
      diff: strip extra "/" when stripping prefix

It'd be nice to answer "how are object stored" with something like:

    $ echo 7980e417 | git some-thing --pretty=3Draw -
    commit <SP> 525 <NULL>
    tree ....

And be able to do something similar to see what's stored in an
arbitrary pack file, I've often wished I had something like that when
using git-fsck.

These docs are also an excellent resource, afaict we only hint at
something like this in git, e.g. in the git-cat-file(1) manpage:
http://www-cs-students.stanford.edu/~blynn/gitmagic/ch08.html
