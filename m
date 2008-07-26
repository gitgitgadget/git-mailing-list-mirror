From: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: PATCH 6/6] archive: convert,to parse_options() [was: [PATCH 5/6]
 archive: allow --exec and --remote without equal sign]
Date: Sat, 26 Jul 2008 09:09:24 +0200
Message-ID: <488ACDA4.4010404@lsrfire.ath.cx>
References: <1216982486-5887-1-git-send-email-rene.scharfe@lsrfire.ath.cx> <1216982486-5887-2-git-send-email-rene.scharfe@lsrfire.ath.cx> <1216982486-5887-3-git-send-email-rene.scharfe@lsrfire.ath.cx> <1216982486-5887-4-git-send-email-rene.scharfe@lsrfire.ath.cx> <1216982486-5887-5-git-send-email-rene.scharfe@lsrfire.ath.cx> <1216982486-5887-6-git-send-email-rene.scharfe@lsrfire.ath.cx> <7vmyk5pjsy.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jul 26 09:10:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMdvB-0007sL-8Y
	for gcvg-git-2@gmane.org; Sat, 26 Jul 2008 09:10:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752158AbYGZHJ3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 26 Jul 2008 03:09:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752086AbYGZHJ3
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Jul 2008 03:09:29 -0400
Received: from india601.server4you.de ([85.25.151.105]:48292 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751810AbYGZHJ3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Jul 2008 03:09:29 -0400
Received: from [10.0.1.200] (p57B7E6C1.dip.t-dialin.net [87.183.230.193])
	by india601.server4you.de (Postfix) with ESMTPSA id B2B152F8028;
	Sat, 26 Jul 2008 09:09:27 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.16 (Windows/20080708)
In-Reply-To: <7vmyk5pjsy.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90189>

Junio C Hamano schrieb:
>>  archive.c |  110 +++++++++++++++++++++++++++++++++++++-------------=
----------
>>  1 files changed, 68 insertions(+), 42 deletions(-)
>=20
> Hmph, somewhat dubious.
>=20
> The real point of parse-options was to make the code smaller, easier =
to
> maintain and command line handling more consistent.  At least this pa=
tch
> seems to fail on the two out of three counts.

Well, if we hid away the compression level handling in a macro defined
in parse-options.h, we could save sixteen lines of code.  The patch
makes the four modes of running archive more explicit, adding three
usage lines.  Three empty lines are added -- they don't really increase
the code's size.

Handling --exec and --remote takes six lines; we didn't do that before
at this place, but have to now, since we want them to show up in the
usage.  We have to handle --no-format and --no-prefix, which adds four
lines.

So I don't think the bigger size make this patch dubious, but of course
I'm biased.  Disallowing --no-format (using a new OPT_STRING_NONEG?) an=
d
adding an OPT__COMPRESSION helper might be a good idea (reducing line
count in archive.c by seventeen).

Having parse-options provide a way to make --exec and --remote appear i=
n
the usage but to reject them (OPT_UNKNOWN?) is a bit too strange, thoug=
h.

> All of the other patches made obvious sense to me and are queued for =
-rc1
> but I'd like to backburner this one.

=46air enough.

Ren=E9
