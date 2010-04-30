From: =?ISO-8859-1?Q?Herv=E9_Cauwelier?= <herve@itaapy.com>
Subject: Re: Multiblobs
Date: Fri, 30 Apr 2010 11:14:04 +0200
Message-ID: <4BDA9F5C.2080808@itaapy.com>
References: <loom.20100428T164432-954@post.gmane.org> <k2y32541b131004281107u6d15ed4ex54b5e5c138cc0e24@mail.gmail.com> <loom.20100428T204406-308@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 30 19:03:43 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O7tcr-0004GS-H9
	for gcvg-git-2@lo.gmane.org; Fri, 30 Apr 2010 19:03:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758215Ab0D3Q7x convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 30 Apr 2010 12:59:53 -0400
Received: from smtpfb2-g21.free.fr ([212.27.42.10]:49460 "EHLO
	smtpfb2-g21.free.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757806Ab0D3Q7q (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Apr 2010 12:59:46 -0400
Received: from smtp3-g21.free.fr (smtp3-g21.free.fr [212.27.42.3])
	by smtpfb2-g21.free.fr (Postfix) with ESMTP id 4D4CDCA8D35
	for <git@vger.kernel.org>; Fri, 30 Apr 2010 11:13:40 +0200 (CEST)
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 0525F81801E;
	Fri, 30 Apr 2010 11:12:02 +0200 (CEST)
Received: from [192.168.1.3] (lns-bzn-28-82-250-155-237.adsl.proxad.net [82.250.155.237])
	by smtp3-g21.free.fr (Postfix) with ESMTP id DDD0E818093;
	Fri, 30 Apr 2010 11:11:59 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.9) Gecko/20100330 Shredder/3.0.4
In-Reply-To: <loom.20100428T204406-308@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146033>

On 04/28/10 21:13, Sergio Callegari wrote:
> If you store a structured file as a multiblob, you can use a blob for=
 each
> uncompressed element of content.  For instance, when storing an opend=
ocument
> file you could use a blob for manifest.xml, one for content.xml, etc.=
=2E. (try
> unzip -l on an odt or odp file to get an idea). When you edit your fi=
le only a
> few of these change. For instance, if we talk about a presentation, e=
ach slide
> has its own content.xml, so changing one slide only that changes.

I'll obviously let the Git experts answer you, but I can answer about=20
OpenDocument itself.

In a presentation each slide is a <draw:page/> inside a single=20
content.xml. So if you change one slide, the whole XML will serialize=20
with a different SHA.

And maybe you'll add style to that slide, or probably OpenOffice.org=20
will generate an automatic style, so styles.xml will also change. Addin=
g=20
an image also changes manifest.xml, along with storing the image itself=
=2E=20
OOo will surely record the last slide displayed when closing the=20
application, so settings.xml will change too.

So, all in all, for a single slide, 30 to 80 % of the Zip content may=20
change.

Unless you are talking about a dedicated application to store and=20
generate on-the-fly office documents, built on top of Git, you're bette=
r=20
not touching the contents the user is entrusting git to store, and writ=
e=20
a .gitattribute not to compress them in a pack.

You may also be interested in the git-bigfiles project that was=20
mentioned last week.

http://caca.zoy.org/wiki/git-bigfiles

--=20
Herv=E9 Cauwelier - ITAAPY - 9 rue Darwin 75018 Paris
T=E9l. 01 42 23 67 45 - Fax 01 53 28 27 88
http://www.itaapy.com/ - http://www.cms-migration.com
