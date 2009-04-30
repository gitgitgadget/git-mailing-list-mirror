From: "Wesley J. Landaker" <wjl@icecavern.net>
Subject: Re: [PATCH] Documentation: Fix description of archive "--prefix"
Date: Wed, 29 Apr 2009 20:33:01 -0600
Organization: icecavern.net
Message-ID: <200904292033.03899.wjl@icecavern.net>
References: <20090429134236.GU36958498@CIS.FU-Berlin.DE> <20090429154941.GB33221014@CIS.FU-Berlin.DE>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Holger =?utf-8?q?Wei=C3=9F?= <holger@zedat.fu-berlin.de>
X-From: git-owner@vger.kernel.org Thu Apr 30 04:33:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LzM5Q-0000Si-1N
	for gcvg-git-2@gmane.org; Thu, 30 Apr 2009 04:33:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753341AbZD3CdN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 29 Apr 2009 22:33:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753200AbZD3CdM
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Apr 2009 22:33:12 -0400
Received: from rinoa.icecavern.net ([92.243.7.152]:53985 "EHLO icecavern.net"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752334AbZD3CdM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 29 Apr 2009 22:33:12 -0400
Received: from chocobo.localnet (c-76-113-110-228.hsd1.nm.comcast.net [76.113.110.228])
	by icecavern.net (Postfix) with ESMTPSA id 9BAD936599;
	Wed, 29 Apr 2009 20:33:07 -0600 (MDT)
User-Agent: KMail/1.11.2 (Linux/2.6.28-11-generic; KDE/4.2.2; i686; ; )
In-Reply-To: <20090429154941.GB33221014@CIS.FU-Berlin.DE>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117986>

On Wednesday 29 April 2009 09:49:41 Holger Wei=C3=9F wrote:
> * Holger Wei=C3=9F <holger@zedat.fu-berlin.de> [2009-04-29 15:42]:
> > The description of the "--prefix" option suggested that a slash wou=
ld
> > automatically be appended to the specified <prefix>, which is not t=
he
> > case.
>
> Nonsense, it's telling the user that appending a slash to the <prefix=
>
> is mandatory.  Scratch my patch.

I just tried not using a slash; it doesn't give an error or internally =
add=20
one, instead it makes a worthless archive:

$ git archive --prefix=3Dnoslash HEAD | tar tv | head
-rw-rw-r-- root/root        51 2009-04-28 01:46 noslash.gitattributes
-rw-rw-r-- root/root      2416 2009-04-28 01:46 noslash.gitignore
-rw-rw-r-- root/root      2519 2009-04-28 01:46 noslash.mailmap
-rw-rw-r-- root/root     18787 2009-04-28 01:46 noslashCOPYING
drwxrwxr-x root/root         0 2009-04-28 01:46 noslashDocumentation/
-rw-rw-r-- root/root        17 2009-04-28 01:46=20
noslashDocumentation/.gitattributes
-rw-rw-r-- root/root        91 2009-04-28 01:46=20
noslashDocumentation/.gitignore
-rw-rw-r-- root/root      4868 2009-04-28 01:46=20
noslashDocumentation/CodingGuidelines
-rw-rw-r-- root/root      9028 2009-04-28 01:46 noslashDocumentation/Ma=
kefile
-rw-rw-r-- root/root      1255 2009-04-28 01:46=20
noslashDocumentation/RelNotes-1.5.0.1.txt

Should this be fixed by automatically adding a slash if there wasn't on=
e given?=20
I can't image anyone would want an archive made of mangled filenames li=
ke this,=20
so if we don't want that behavior, it seems like it should at least giv=
e an=20
error.
