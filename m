From: =?UTF-8?B?TWljaGHFgg==?= Kiedrowicz <michal.kiedrowicz@gmail.com>
Subject: Re: [PATCH/RFC] grep: Add --directories option.
Date: Fri, 10 Jul 2009 18:48:28 +0200
Message-ID: <20090710184828.63d123d0@gmail.com>
References: <1247167228-2466-1-git-send-email-michal.kiedrowicz@gmail.com>
	<4A56EED7.9040008@lsrfire.ath.cx>
	<7vmy7dufdp.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?UmVuw6k=?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 10 18:48:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MPJHH-0003v0-94
	for gcvg-git-2@gmane.org; Fri, 10 Jul 2009 18:48:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754681AbZGJQsf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 10 Jul 2009 12:48:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751376AbZGJQsf
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Jul 2009 12:48:35 -0400
Received: from mail-ew0-f226.google.com ([209.85.219.226]:48075 "EHLO
	mail-ew0-f226.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753485AbZGJQse convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 10 Jul 2009 12:48:34 -0400
Received: by ewy26 with SMTP id 26so1224341ewy.37
        for <git@vger.kernel.org>; Fri, 10 Jul 2009 09:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:in-reply-to:references:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=j+PKFlcvL1DWDAIyWYKobETGi/1R2734blmqaKHEdGY=;
        b=mHEPbxsmXlA2j2A/cnGWAKFMHI3abhG5CEaB9TQiLLv1IlSsX/P8XMp+BEqM+YGKrS
         4minF0jfpNVnb2rrUM7OBfZbDsFxb4ngMV6C+sFAQo0VIL/ehmR1KdhCGuHNMHlZL+Ux
         R097J6JA+xjC9CB/lEZ8WdaM5EJOyJyoHY1y8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer
         :mime-version:content-type:content-transfer-encoding;
        b=JyD/BdDqTPVFCL9QfDWnQj+X53INFbgkDzrZ0+24MoN50lKn5B46eBrd63WFVkSWES
         M+/ZAIHW/fhFj25nRqpHMn/AaMvX2G/hjhlp2TrXBuAbJeNVd2/FV6Tqg7nUOG4e6lay
         fK+Q709cjOjb/LYyiL3jE83R1TxJFRUsnX3Lc=
Received: by 10.211.202.14 with SMTP id e14mr2622274ebq.50.1247244512988;
        Fri, 10 Jul 2009 09:48:32 -0700 (PDT)
Received: from localhost (87-205-51-27.adsl.inetia.pl [87.205.51.27])
        by mx.google.com with ESMTPS id 24sm3024784eyx.33.2009.07.10.09.48.32
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 10 Jul 2009 09:48:32 -0700 (PDT)
In-Reply-To: <7vmy7dufdp.fsf@alter.siamese.dyndns.org>
X-Mailer: Claws Mail 3.7.1 (GTK+ 2.14.7; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123063>

Junio C Hamano <gitster@pobox.com> wrote:

> Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:
>=20
> > It seems your patch still allows recursion, one level deep.
>=20
> I suspect what the patch wants to do may be fundamentally unworkable.
>=20
> Unlike GNU grep that takes its command line arguments literally as
> files and directories, we use them merely as pathspec filters, so...
>=20
> > 	$ git grep -l --directories=3Dskip GNU compat/*
>=20
> ... while I think you should be able to compensate for this kind  of
> "off-by-one" and make it appear to work, I do not think there is a
> good definition of which level it should stop if you run it with
> something like this (notice the single-quote around the pathspec to
> prevent it from getting expanded by the shell):
>=20
> 	git grep GNU 'compat/*/*'
>=20

To makes things simplier (but maybe not correct) I assumed that '*'
matches _any_ string, including '/', so any file in "compat/" (even
in subdirs) should be treated as a file specified on command line.

Micha=C5=82 Kiedrowicz
