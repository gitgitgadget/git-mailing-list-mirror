From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: Re: [PATCH] Handle UNC paths everywhere
Date: Mon, 25 Jan 2010 21:04:10 +0100
Message-ID: <201001252104.10328.robin.rosenberg@dewire.com>
References: <201001250155.47664.robin.rosenberg@dewire.com> <alpine.DEB.1.00.1001251553150.8733@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>,
	Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jan 25 21:04:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NZVAd-0005QJ-5m
	for gcvg-git-2@lo.gmane.org; Mon, 25 Jan 2010 21:04:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752461Ab0AYUEP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 25 Jan 2010 15:04:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752299Ab0AYUEP
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Jan 2010 15:04:15 -0500
Received: from mail.dewire.com ([83.140.172.130]:21156 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751207Ab0AYUEO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Jan 2010 15:04:14 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id F1F7C147E155;
	Mon, 25 Jan 2010 21:04:12 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id K+q9M6u6+c9b; Mon, 25 Jan 2010 21:04:12 +0100 (CET)
Received: from sleipner.localnet (unknown [10.9.0.2])
	by dewire.com (Postfix) with ESMTP id 7F83980034C;
	Mon, 25 Jan 2010 21:04:12 +0100 (CET)
User-Agent: KMail/1.12.4 (Linux/2.6.31-17-generic; KDE/4.3.4; i686; ; )
In-Reply-To: <alpine.DEB.1.00.1001251553150.8733@intel-tinevez-2-302>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137987>

m=E5ndagen den 25 januari 2010 18.34.01 skrev  Johannes Schindelin:
> I am also not quite sure if you can get away with having the same off=
set
> for both: if I have "C:\blah" and strip off "C:", I always have a
> directory separator to bounce against, whereas I do not have that if =
I
> strip off the two "\\" of a UNC path.  Besides, I maintain that the h=
ost
> name, and maybe even the share name, should not ever be stripped off!

Advices needed:

d:somedir (when cwd=3Dd:\msysgit, =3D=3D /) may be tricky to fix.
Msysgit seems confused by the syntax and treats it as d:\=20

roro@SIENA / (master)
$ cmd
Microsoft Windows [Version 5.2.3790]
(C) Copyright 1985-2003 Microsoft Corp.

D:\msysgit>exit

roro@SIENA / (master)
$ mkdir d:x
mkdir: cannot create directory `d:x': File exist

roro@SIENA / (master)
$ cd d:x

roro@SIENA /d
$ ls -l x
ls: x: No such file or directory

roro@SIENA /d
$

=46rom that I think that even if we try to make git handle d:path, msys
will break regardless. We can fix truly absolute and normal relative pa=
ths.

-- robin
