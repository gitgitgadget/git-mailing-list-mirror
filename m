From: Carlos =?ISO-8859-1?Q?Mart=EDn?= Nieto <cmn@elego.de>
Subject: Re: [PATCH] valgrind: ignore SSE-based strlen invalid reads
Date: Wed, 16 Mar 2011 21:44:11 +0100
Message-ID: <1300308252.7214.62.camel@bee.lab.cmartin.tk>
References: <20110316112547.GA15739@elie>
	 <1300275961-5798-1-git-send-email-cmn@elego.de>
	 <7vr5a67rb7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 16 21:44:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PzxZv-0003Ua-F6
	for gcvg-git-2@lo.gmane.org; Wed, 16 Mar 2011 21:44:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753181Ab1CPUoT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 16 Mar 2011 16:44:19 -0400
Received: from mx0.elegosoft.com ([88.198.54.133]:54348 "EHLO
	mx0.elegosoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753028Ab1CPUoS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Mar 2011 16:44:18 -0400
Received: from localhost (localhost [127.0.0.1])
	by mx0.elegosoft.com (Postfix) with ESMTP id 7F63F1B4B16;
	Wed, 16 Mar 2011 21:44:17 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at mx0.elegosoft.com
Received: from mx0.elegosoft.com ([127.0.0.1])
	by localhost (mx0.elegosoft.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dJlLNHV4ygPU; Wed, 16 Mar 2011 21:44:12 +0100 (CET)
Received: from [192.168.1.16] (brln-4dbc728c.pool.mediaWays.net [77.188.114.140])
	by mx0.elegosoft.com (Postfix) with ESMTPSA id 1A3EB1B4B15;
	Wed, 16 Mar 2011 21:44:12 +0100 (CET)
In-Reply-To: <7vr5a67rb7.fsf@alter.siamese.dyndns.org>
X-Mailer: Evolution 2.91.92 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169191>

On mi=C3=A9, 2011-03-16 at 13:18 -0700, Junio C Hamano wrote:
> Carlos Mart=C3=ADn Nieto <cmn@elego.de> writes:
>=20
> > Some versions of strlen use SSE to speed up the calculation and loa=
d 4
> > bytes at a time, even if it means reading past the end of the
> > allocated memory. This read is safe and when the strlen function is
> > inlined, it is not replaced by valgrind, which reports a
> > false-possitive.
> >
> > Tell valgrind to ignore this particular error, as the read is, in
> > fact, safe. Current upstream-released version 2.6.1 is affected. So=
me
> > distributions have this fixed in their latest versions.
> >
> > Signed-off-by: Carlos Mart=C3=ADn Nieto <cmn@elego.de>
> > ---
> >
> >>>  I think 3.6.1 doesn't need it, as Debian's 1:3.5.0+3.6.0svn20100=
609-1
> >>> version is reportedly fixed.
> >>
> >>Ah, nice.  A phrase like "some versions of valgrind before 3.6.1"
> >>would be fine with me fwiw. :)
> >
> > I just downloaded and compiled the upstream release 2.6.1 and it's
> > still affected (it does fix some other related
> > false-positives). Fedorea rawhide has the fix in, according to thei=
r
> > bug tracker. I haven't tested the reportedly-fixed version in Debia=
n
> > yet.
>=20
> I take it that you meant 3.6.1 in both places above?
>=20

 Yeah, I blame the kernel ;)

> This somehow reminds me of my past life where I saw a buggy implement=
ation
> of strlen() in the C library loaded one word too many from memory, an=
d
> segfaulted even when the string ended before the end of a mapped page=
 when
> the next page was unmapped.
>=20
> Anyway, nice digging.

 If all else fails, google will point you to the bug tracker :)
