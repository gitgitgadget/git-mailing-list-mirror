From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 14/15] gettextize: git-revert split up "could not
 revert/apply" message
Date: Tue, 7 Sep 2010 00:34:20 -0500
Message-ID: <20100907053420.GR1182@burratino>
References: <1283638229-14199-1-git-send-email-avarab@gmail.com>
 <1283775704-29440-15-git-send-email-avarab@gmail.com>
 <20100906185547.GF25426@burratino>
 <AANLkTi=V01_OP+6pxrUakF=cTGFL=nOv=9C5meQU2H8C@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jan =?utf-8?Q?Kr=C3=BCger?= <jk@jk.gs>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 07 07:36:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OsqrJ-0001cC-QL
	for gcvg-git-2@lo.gmane.org; Tue, 07 Sep 2010 07:36:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752711Ab0IGFgZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 7 Sep 2010 01:36:25 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:49674 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751162Ab0IGFgY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 7 Sep 2010 01:36:24 -0400
Received: by iwn5 with SMTP id 5so4984904iwn.19
        for <git@vger.kernel.org>; Mon, 06 Sep 2010 22:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=dQJzzy55d4LHCHUqytxRYgR1j/dSM1P9rENl/1jlk50=;
        b=F18yj/O9ajRJZ04mvtKV4cMivOccWHz0GVQ+er8XvzlhMc0l/tBA+blQUS+Q02Gb4W
         Eig8jOwQ4mQJBidVauHgA/0HdkJ4xS22zAtuC5iBosz3GNhq2cp956vb+Ljvd7umj0lC
         NBIZWHrrCjlESFTYlC6gwnDb/OTEj37rbyCww=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=sLjwiGZXqpPUBun04E2EOLuuxM2AS5yOKLXi8Ji1GtGhqsdLh+vS4uhXdo/+cgr0qv
         xZwYvoM+lCf7/illIa9GesGq7EhNxhNN16fgxhXWKUmTwPCd+t+bPHqNFbVpBYbfrfcZ
         4TKwKHgqE0XtPk1Z54z2yV1AIT8dnj9Gc41Vw=
Received: by 10.231.172.75 with SMTP id k11mr7520496ibz.4.1283837783410;
        Mon, 06 Sep 2010 22:36:23 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id z6sm6746752ibc.12.2010.09.06.22.36.22
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 06 Sep 2010 22:36:22 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTi=V01_OP+6pxrUakF=cTGFL=nOv=9C5meQU2H8C@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155678>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> to do this we'd have steal some locale.

Alas.  Thanks for explaining.

> Also, the set of tests we want to skip under POISON (i.e. automated
> garbage) is slightly different from the tests we want to skip under
> TEST_LOCALE=3D, because some of those tests are checking for the %s i=
n
> "file failed: %s". So they'll fail under POISON, but shouldn't fail
> under any translation.

This could be fixable in the long term, no?  e.g., under POISON we
could have something like

 _ () {
	 perl -pe 's/(?<!%)[^%#]*/POISON/g'
 }

to preserve commit message comments and % directives.
