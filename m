From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: git-svn url-encodes ~ when it should not
Date: Sat, 18 Oct 2008 23:39:19 +0200
Message-ID: <20081018213919.GC3107@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Sat Oct 18 23:40:49 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KrJXT-0005t9-3f
	for gcvg-git-2@gmane.org; Sat, 18 Oct 2008 23:40:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750966AbYJRVjZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 18 Oct 2008 17:39:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750958AbYJRVjY
	(ORCPT <rfc822;git-outgoing>); Sat, 18 Oct 2008 17:39:24 -0400
Received: from mail.gmx.net ([213.165.64.20]:54235 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750952AbYJRVjY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Oct 2008 17:39:24 -0400
Received: (qmail invoked by alias); 18 Oct 2008 21:39:21 -0000
Received: from i577AC07F.versanet.de (EHLO atjola.local) [87.122.192.127]
  by mail.gmx.net (mp065) with SMTP; 18 Oct 2008 23:39:21 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX18xkpdjvKcxVl6cyqhQvQZtWkhcuBBk83kQDQOgVg
	AYED7+K9ZFYYUs
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.62
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98574>

Hi,

Jose Carlos Garcia Sogo reported on #git that a git-svn clone of this
svn repo fails for him:
https://sucs.org/~welshbyte/svn/backuptool/trunk

I can reproduce that here with:
git-svn version 1.6.0.2.541.g46dc1.dirty (svn 1.5.1)

The error message I get is:
Apache got a malformed URI: Unusable URI: it does not refer to this
repository at /usr/local/libexec/git-core/git-svn line 4057

strace revealed that git-svn url-encodes ~ while svn does not do that.

=46or svn we have:
write(5, "<S:update-report send-all=3D\"true\" xmlns:S=3D\"svn:\">
<S:src-path>https://sucs.org/~welshbyte/svn/backuptool/trunk</S:src-pat=
h>...

While git-svn shows:
write(7, "<S:update-report send-all=3D\"true\" xmlns:S=3D\"svn:\">
<S:src-path>https://sucs.org/%7Ewelshbyte/svn/backuptool/trunk</S:src-p=
ath>...

Bj=F6rn
