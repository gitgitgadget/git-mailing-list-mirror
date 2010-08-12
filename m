From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Low-level repository inspection (Re: Where do I stick
 development documentation?)
Date: Wed, 11 Aug 2010 22:57:33 -0500
Message-ID: <20100812035733.GA19676@burratino>
References: <AANLkTi=dS1DYJ3MB-Du34sVPy8Qw8VNck=Lx54DtSfO0@mail.gmail.com>
 <20100812023922.GB19174@burratino>
 <AANLkTinPUqSywAscEG=VsYdFPwS=x0izM1cw-J1EBDGT@mail.gmail.com>
 <20100812031756.GD19174@burratino>
 <AANLkTikpT=PD0Q8d=6=989N6rxYXH-Le3Go_szAz-t4s@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Thomas Rast <trast@student.ethz.ch>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 12 05:59:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OjOwm-0001e8-K2
	for gcvg-git-2@lo.gmane.org; Thu, 12 Aug 2010 05:59:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759723Ab0HLD7L convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Aug 2010 23:59:11 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:55786 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753985Ab0HLD7I convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Aug 2010 23:59:08 -0400
Received: by yxg6 with SMTP id 6so260543yxg.19
        for <git@vger.kernel.org>; Wed, 11 Aug 2010 20:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=AJxG2pAyxfXClleIs41+fJaXf8U7aHT9gIeB9x9Z9ec=;
        b=Fnezy2mG19F/JVqmSq0+Te3/hVVKHlUZDYfSAjkKdQJBJ7o/MnXGWnLwFnD32pGTOz
         Y6SZBxqnwO4ED1qVx2/VzFfi1sft4hpb5Mf5hX3w/jNohG8TXJupvWGaxhc6h93TQAkP
         4Xt64KtvKObLG8Hnn8YBJalqjorM2r5tk2mDQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=dwGWfdTZ++ajkSm/Sk/xxSUhypQVjzQC71uVWELw9y4DYbTJSxEBkkKNyvzTZU4pt/
         pVg9cIK1sKAZOtOjURXyYZ2d2djrgli3ly8WIM1lB8feRI+GzzPJYClfCo+AATc6b73B
         wJoWEsJLHpKPsd0+98ksr3t3LCvNnvpNdWer8=
Received: by 10.100.108.3 with SMTP id g3mr14891586anc.197.1281585548167;
        Wed, 11 Aug 2010 20:59:08 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id i30sm1359043anh.9.2010.08.11.20.59.07
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 11 Aug 2010 20:59:07 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTikpT=PD0Q8d=6=989N6rxYXH-Le3Go_szAz-t4s@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153336>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> Those are part of the way there, but you often have to tease info out
> of them, e.g. if you want a commit -> commit roundtrip:
>=20
>     $ echo 7980e417 | git cat-file --batch | perl -0777 -pe 's/.*
> commit ([0-9]*).(.*)\n/commit $1\0$2/s'|sha1sum
>     7980e41746bc5de91eea775f9142ce44b1100361  -

hash-object -w (and other =E2=80=9Cmanipulation commands=E2=80=9D)?

> It'd be nice to answer "how are object stored" with something like:
>=20
>     $ echo 7980e417 | git some-thing --pretty=3Draw -
>     commit <SP> 525 <NULL>
>     tree ....

Part of the reason I mention these interfaces is that if people use
them (or something like them --- e.g., JGit) then it becomes a lot
easier for low-level details of git to evolve.

That is part of why git uses zlib instead of gzip for its loose
objects, if I remember correctly.
