From: Carlos =?ISO-8859-1?Q?Mart=EDn?= Nieto <cmn@elego.de>
Subject: Re: [PATCH] valgrind: ignore SSE-based strlen invalid reads
Date: Wed, 16 Mar 2011 11:41:33 +0100
Message-ID: <1300272098.7214.5.camel@bee.lab.cmartin.tk>
References: <1300267874-15365-1-git-send-email-cmn@elego.de>
	 <20110316095632.GA8277@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 16 11:41:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PzoAq-0003Pl-V9
	for gcvg-git-2@lo.gmane.org; Wed, 16 Mar 2011 11:41:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751853Ab1CPKls convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 16 Mar 2011 06:41:48 -0400
Received: from mx0.elegosoft.com ([88.198.54.133]:40778 "EHLO
	mx0.elegosoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751315Ab1CPKlr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Mar 2011 06:41:47 -0400
Received: from localhost (localhost [127.0.0.1])
	by mx0.elegosoft.com (Postfix) with ESMTP id 1EBA61B4B15;
	Wed, 16 Mar 2011 11:41:46 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at mx0.elegosoft.com
Received: from mx0.elegosoft.com ([127.0.0.1])
	by localhost (mx0.elegosoft.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OgX2UmexopKV; Wed, 16 Mar 2011 11:41:38 +0100 (CET)
Received: from [10.10.10.234] (i59F7870A.versanet.de [89.247.135.10])
	by mx0.elegosoft.com (Postfix) with ESMTPSA id 37F911B4B14;
	Wed, 16 Mar 2011 11:41:38 +0100 (CET)
In-Reply-To: <20110316095632.GA8277@elie>
X-Mailer: Evolution 2.91.92 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169133>

On mi=C3=A9, 2011-03-16 at 04:56 -0500, Jonathan Nieder wrote:
> Hi Carlos,
>=20
> Carlos Mart=C3=ADn Nieto wrote:
>=20
> > The C library uses SSE instructions to make strlen (among others)
> > faster, loading 4 bytes at a time and reading past the end of the
> > allocated memory. This read is safe and when the strlen function is
> > inlined, it is (obviously) not replaced by valgrind, which reports =
a
> > false-possitive.
>=20
> It would be GCC rather than the C library if the strlen is inlined, I
> think.  Is this a distinct bug from

 The strlen definition comes from the C library, as far as I know, but
I'll amend to say it's the GNU C Library that's doing weird things.

> <http://bugs.kde.org/show_bug.cgi?id=3D266961>?  Has it been filed
> with the valgrind maintainers?

 It looks like the same issue, which should also be
https://bugzilla.redhat.com/show_bug.cgi?id=3D518247 and
http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D590640 which have
patches available. Newer versions of valgrind do not have this "bug".

   cmn
