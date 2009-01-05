From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [PATCH] Permit a wider range of repository names in jgit daemon requests
Date: Tue, 6 Jan 2009 00:07:43 +0100
Message-ID: <200901060007.43909.robin.rosenberg.lists@dewire.com>
References: <1229992043-1053-1-git-send-email-spearce@spearce.org> <200901040048.01520.robin.rosenberg@dewire.com> <20090105024622.GC20973@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Jan 06 00:09:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LJyZT-00082t-10
	for gcvg-git-2@gmane.org; Tue, 06 Jan 2009 00:09:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751893AbZAEXHu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 5 Jan 2009 18:07:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751493AbZAEXHt
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Jan 2009 18:07:49 -0500
Received: from mail.dewire.com ([83.140.172.130]:3468 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750726AbZAEXHt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 5 Jan 2009 18:07:49 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id E33CB1484F4B;
	Tue,  6 Jan 2009 00:07:45 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5FAj-4nCHOtV; Tue,  6 Jan 2009 00:07:45 +0100 (CET)
Received: from sleipner.localnet (unknown [10.9.0.2])
	by dewire.com (Postfix) with ESMTP id 49876803219;
	Tue,  6 Jan 2009 00:07:45 +0100 (CET)
User-Agent: KMail/1.10.3 (Linux/2.6.27-11-generic; KDE/4.1.3; i686; ; )
In-Reply-To: <20090105024622.GC20973@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104603>

m=E5ndag 05 januari 2009 03:46:22 skrev Shawn O. Pearce:
> The earlier restriction was too narrow for some applications, for
> example repositories named "jgit.dev" and "jgit.test" are perfectly
> valid Git repositories and should still be able to be served by
> the daemon.
>=20
> By blocking out only uses of ".." as a path component and Windows
> UNC paths (by blocking "\") we can reasonably prevent the client
> from escaping the base dirctories configured in the daemon.
>=20
> +		if (name.startsWith("../") || name.contains("/../")
> +				|| name.contains("\\"))

//host/share also works as UNC path (even the DOS commands support it, =
provided
you quote the paths) and if you block // shuldn't '/', and '[A-Z]:' als=
o be blocked?=20
\\ is a UNC-prefix only at the beginning of a path so if / need not be =
filtered, nor=20
does //. Inside a path \\ is the same as \ AFAIK (except directly after=
 the drive letter.
This should probablybe factored out into a utilty so we can have a simp=
le unit test for it.

-- robin
