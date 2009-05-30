From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] refuse to merge during a merge
Date: Sat, 30 May 2009 03:38:02 -0700 (PDT)
Message-ID: <m34ov2c1wx.fsf@localhost.localdomain>
References: <20090527210410.GA14742@localhost>
	<43d8ce650905280912q71c749bn7146210a5838a453@mail.gmail.com>
	<20090530083721.GA12963@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: John Tapsell <johnflux@gmail.com>, git@vger.kernel.org,
	Dave Olszewski <cxreg@pobox.com>
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Sat May 30 12:38:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MALx9-0003Cf-6M
	for gcvg-git-2@gmane.org; Sat, 30 May 2009 12:38:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758936AbZE3KiF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 30 May 2009 06:38:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754274AbZE3KiE
	(ORCPT <rfc822;git-outgoing>); Sat, 30 May 2009 06:38:04 -0400
Received: from mail-ew0-f176.google.com ([209.85.219.176]:62831 "EHLO
	mail-ew0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753791AbZE3KiC convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 30 May 2009 06:38:02 -0400
Received: by ewy24 with SMTP id 24so6797711ewy.37
        for <git@vger.kernel.org>; Sat, 30 May 2009 03:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=6+9/gTs6utrix02Rv0Az4cxX3brVEQ/0c9ICyBkqAXE=;
        b=rhsIvZTiL0ZStLx2el9HeyZyEqHG0t+y6Xn9GXXK0zNiIPcfU4ODMRNVB7UZJjI9z2
         Ip6YQtRK5htlwZr3AVmdWJJhZaa3Tgan0tKVhGBB+ERYOABQTqRarLfDkXQBCg9DZd9N
         BbMuMAgASkEU8ia9P2bqrfUzPyeFsuJH+6yOM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        b=T0TmesqyURCLR6mQ1amtM35knyDgBsoBBe0fsUmcwapotXtosoiqiyEpna/nHPebwY
         6xMj+Y1Q9SREE5LC4w1HyeeR6wy88sSlw/v/6anwwK7TKAHwIB3Dl3DeMzdsXXkBiZmI
         GWzywzHJ8UD8QY7lGkhdeLSB2DruiyMrZ2qCQ=
Received: by 10.210.33.15 with SMTP id g15mr3717521ebg.63.1243679883212;
        Sat, 30 May 2009 03:38:03 -0700 (PDT)
Received: from localhost.localdomain (abvr167.neoplus.adsl.tpnet.pl [83.8.215.167])
        by mx.google.com with ESMTPS id 24sm4204906eyx.3.2009.05.30.03.38.02
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 30 May 2009 03:38:02 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n4UAbJhC026737;
	Sat, 30 May 2009 12:37:29 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n4UAb2eO026733;
	Sat, 30 May 2009 12:37:02 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <20090530083721.GA12963@localhost>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120346>

Clemens Buchacher <drizzd@aon.at> writes:

> On Thu, May 28, 2009 at 05:12:40PM +0100, John Tapsell wrote:
> > > + =A0 =A0 =A0 if (read_cache_unmerged() || file_exists(git_path("=
MERGE_HEAD")))
> > > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0die("You are in the middle of a co=
nflicted merge.");
> >=20
> > Could the error message also give possible solutions?   "Commit the
> > current merge first with 'git commit', or discard the current merge
> > attempt with 'git reset --hard'" or something.  Or at least a point=
er
> > to where to read for more info.
>=20
> How about this.
>=20
> fatal: You are in the middle of a [conflicted] merge. To complete the=
 merge
> [resolve conflicts and] commit the changes. To abort, use "git reset =
HEAD".
>=20
> The part about resolving changes is only displayed if there are unmer=
ged
> entries. I intentionally left out --hard, because it potentially remo=
ves
> changes unrelated to the merge (if the work tree was dirty prior to t=
he
> merge). The user will find out how to reset the work tree by reading =
the
> docs.

Why not advertise new "git reset --merge HEAD" then?

--=20
Jakub Narebski
Poland
ShadeHawk on #git
