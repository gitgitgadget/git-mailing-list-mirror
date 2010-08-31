From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH/RFC 00/17] Begin gettextizing Git
Date: Tue, 31 Aug 2010 13:08:32 -0500
Message-ID: <20100831180832.GQ2315@burratino>
References: <1283203703-26923-1-git-send-email-avarab@gmail.com>
 <7v39tveq0j.fsf@alter.siamese.dyndns.org>
 <AANLkTinKgOdgTpORf-NSJ1wpURw9xOkQ3rXZvmV6XtBb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Marcin Cieslak <saper@saper.info>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 31 20:10:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OqVI5-0007za-1z
	for gcvg-git-2@lo.gmane.org; Tue, 31 Aug 2010 20:10:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754808Ab0HaSK0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 31 Aug 2010 14:10:26 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:34854 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754763Ab0HaSKX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 31 Aug 2010 14:10:23 -0400
Received: by vws3 with SMTP id 3so5614829vws.19
        for <git@vger.kernel.org>; Tue, 31 Aug 2010 11:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=9fI7HdMmN8BWagA42jFhtAlq2OUmIOEkbCtXwSQ6Mek=;
        b=KjCvsjRX0z6ZFz6k6FwXBgnYqgAQDXQDZX6Lx4j1J6lOP9KU4H4CaawqR+Hikl7XrJ
         dNJa6P8Sow4/zv7r1Y5wOWV/w4rfQwhntYKYj6eN9yTtJar4qB0J55I7bdfT9J49Ghky
         yb+evY8semkBVItZZcBpp9SwI+3um913PxGAA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=obnO4dfu3clKHDNY2cVVgviergVY6D1KuwRdRl1ID5F+zX8c4lHzK3iQsF01ztCTOD
         /0RUrNCUVzeMipcSr14j0y7jcUtuJbtA3+qhdcJFUionsQ717U5Cw3YBzUcTviRcmLZA
         pNoQWux6YizhI+gvBst4T/RUhI42xABETpjtU=
Received: by 10.220.161.201 with SMTP id s9mr4227459vcx.137.1283278221756;
        Tue, 31 Aug 2010 11:10:21 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id d12sm2981142vcn.38.2010.08.31.11.10.20
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 31 Aug 2010 11:10:21 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTinKgOdgTpORf-NSJ1wpURw9xOkQ3rXZvmV6XtBb@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154952>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> Or: git://github.com/avar/git.git gettextize-git-mainporcelain-v2

Is that against "next"?  For an RFC that's okay, but for a series
that will be part of a release it can be tedious to separate out
(not all topics in "next" necessarily are released, and "next"
traditionally gets rewound after each release).

Comments on the patches:

 Makefile: use variables and shorter lines for xgettext

The -o<whatever> passed to cc isn't usually included in CFLAGS,
and a part of me is similarly uncomfortable with including it in
XGETTEXT_OPTIONS.  Isn't that parameter something that should be
possible to change in the build system independently from the
user's XGETTEXT_OPTIONS preferences?

 gettext.c: work around us not using setlocale(LC_CTYPE, "")

The perror() problem shows up with strerror(), too, of course.
(perror just made for an easier demo.)

 gettext: Make NO_GETTEXT=3DYesPlease the default in releases

Copy-edits for the notes in INSTALL:

> +       - Git includes EXPERIMENTAL support for localization with get=
text
> +         which is currently disabled by default in official Git
> +         releases.

s/EXPERIMENTAL/experimental/?  No need to shout.

I'd also s/currently // since this will not be current after a while.

> +         If you really want to build it you have to specify NO_GETTE=
XT=3D
> +         as a Makefile argument. If you're a downstream distributor
> +         please don't do so without consulting with the Git Mailing =
List
> +         first about the stability of this feature.

Similarly I'd s/really //.  If we want to dissuade people from trying
it out, we should probably do that with more explicit statements.

> +         It's only being included in releases so that source message=
s can
> +         be marked for translation without resulting in painful and
> +         inevitable merge conflicts between Git's pu branch and the
> +         rest. END WARNING.

Not sure what this means.  Maybe:

 The infrastructure is only included in this release to avoid
 complications in building other work on top of it.  If you turn
 it on, expect breakage.

> +         The primary target is GNU libintl, but the Solaris gettext
>           implementation also works.
