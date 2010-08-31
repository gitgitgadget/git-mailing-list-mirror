From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH/RFC 00/17] Begin gettextizing Git
Date: Tue, 31 Aug 2010 14:22:47 -0500
Message-ID: <20100831192247.GU2315@burratino>
References: <1283203703-26923-1-git-send-email-avarab@gmail.com>
 <7v39tveq0j.fsf@alter.siamese.dyndns.org>
 <AANLkTinKgOdgTpORf-NSJ1wpURw9xOkQ3rXZvmV6XtBb@mail.gmail.com>
 <20100831180832.GQ2315@burratino>
 <AANLkTikk8nVyvp0hTycMY9bjMub38msxrOHMMLNER_DS@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Marcin Cieslak <saper@saper.info>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 31 21:24:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OqWRl-0007Yh-1s
	for gcvg-git-2@lo.gmane.org; Tue, 31 Aug 2010 21:24:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755045Ab0HaTYg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 31 Aug 2010 15:24:36 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:47400 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754999Ab0HaTYf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 31 Aug 2010 15:24:35 -0400
Received: by wyb35 with SMTP id 35so8242678wyb.19
        for <git@vger.kernel.org>; Tue, 31 Aug 2010 12:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=Y3cGzBBx2pi2/1FzGxKUNUAKLSatyz3UzPjUyq0nu1Q=;
        b=ngFs5Wqk5eGK7ijOhGzyg71prOOW/ytpDf/bmfkSJgWiH9ktA+/x8ByH3W2VRhTXsy
         p7lbmTQaLUgkM6rIOKjFEr/8+z2z+LfsxamvAr3OZSyEA8KmuYozEK1fQRRUhyQKz8uM
         4Vl4vRf2/s4gfhWtTD32JECT+R5ckRVqFcoJs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=g07FVKaSjj0mu9ZsnewYdqAPxfBRyyuI39WRCQiRoE1Zlo8nZmv54otj5cSXaMZ/id
         VmTL/1wHvgdCY7gxxac4NCOZCg9LCH2x1m1FZtUtmKluoOyMMxoUvBJLiY5RhgybVXZ/
         yVhGFmtUZRPNI8t2gT5M8xGtLWGXxlTKFqPVI=
Received: by 10.227.153.15 with SMTP id i15mr6609309wbw.211.1283282674022;
        Tue, 31 Aug 2010 12:24:34 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id w31sm7947773wbd.3.2010.08.31.12.24.31
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 31 Aug 2010 12:24:32 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTikk8nVyvp0hTycMY9bjMub38msxrOHMMLNER_DS@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154971>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> Maybe, but it'll always be --output=3Dpo/git.pot so I saw no reason t=
o
> seperate it. Should it be?

No big deal.  I am vaguely worried about interrupted "make"
invocations.  Don't gettextized packages typically do something like th=
is?

	remove_creation_date() {
		sed '#!/bin/sed -f
			/^"POT-Creation-Date: .*"$/!b
			x
			# Test if the hold space is empty.
			s/P/P/
			ta
			# Yes it was empty. First occurrence. Remove the line.
			g
			d
			bb
			:a
			# The hold space was nonempty. Following occurrences. Do nothing.
			x
			:b'
	}
	(cd po && xgettext --default-domain=3Dgit ...)
	set -e; \
	if test -f po/git.pot &&
		remove_creation_date <po/git.pot >po/git.1po+ &&
		remove_creation_date <po/git.po >po/git.2po+ &&
		cmp po/git.1po+ po/git.2po+; \
	then \
		rm -f po/git.1po+ po/git.2po+ po/git.po; \
	else \
		rm -f po/git.1po+ po/git.2po+ po/git.pot; \
		mv po/git.po po/git.pot; \
	fi

> The -o for the C compiler changes, but the
> "make pot" target will always write to po/git.pot.

In particular, to avoid using a partial .pot file, one might want to wr=
ite to
po/git.pot+, po/git.po, or similar and then rename it.

> Or: git://github.com/avar/git.git gettextize-git-mainporcelain-v3

Looks good.
