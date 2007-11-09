From: Kristian =?ISO-8859-1?Q?H=F8gsberg?= <krh@redhat.com>
Subject: Re: [PATCH] builtin-commit: Refresh cache after adding files.
Date: Fri, 09 Nov 2007 12:13:32 -0500
Message-ID: <1194628412.30909.7.camel@hinata.boston.redhat.com>
References: <1194626427-2419-1-git-send-email-krh@redhat.com>
	 <Pine.LNX.4.64.0711091702190.4362@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Nov 09 18:14:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqXRI-0001F2-EB
	for gcvg-git-2@gmane.org; Fri, 09 Nov 2007 18:14:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753727AbXKIROY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 9 Nov 2007 12:14:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753475AbXKIROY
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Nov 2007 12:14:24 -0500
Received: from mx1.redhat.com ([66.187.233.31]:52841 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753196AbXKIROX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Nov 2007 12:14:23 -0500
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.8/8.13.1) with ESMTP id lA9HDcu1009216;
	Fri, 9 Nov 2007 12:13:38 -0500
Received: from pobox.corp.redhat.com (pobox.corp.redhat.com [10.11.255.20])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id lA9HDc46016944;
	Fri, 9 Nov 2007 12:13:38 -0500
Received: from [192.168.1.105] (dhcp83-9.boston.redhat.com [172.16.83.9])
	by pobox.corp.redhat.com (8.13.1/8.13.1) with ESMTP id lA9HDbiQ009190;
	Fri, 9 Nov 2007 12:13:37 -0500
In-Reply-To: <Pine.LNX.4.64.0711091702190.4362@racer.site>
X-Mailer: Evolution 2.11.90 (2.11.90-4.fc8) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64221>

On Fri, 2007-11-09 at 17:05 +0000, Johannes Schindelin wrote:
> Hi,
>=20
> On Fri, 9 Nov 2007, Kristian H=C3=B8gsberg wrote:
>=20
> > This fixes the race in the last test int t3700.
>=20
> Well, it is not a race.  My fault.  I thought it was.
>=20
> What you basically did was to make sure that the index is up-to-date =
after=20
> adding the files.  You might even want to say that in the commit mess=
age,=20
> and only then say that it fixes t3700, too.

OK, I guess what I was wondering was why write_cache() doesn't write ou=
t
an up-to-date index.  I'll send an updated patch.  Do we need a call to
refresh_cache() when we update the user cache but commit an index
created from read_tree+add_files?  I.e. after the add_files_to_index()
call on line 97?  The shell script doesn't do this, it only runs
update-index --refresh for the index that gets committed.

Kristian
