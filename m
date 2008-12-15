From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: "git gc" doesn't seem to remove loose objects any more
Date: Mon, 15 Dec 2008 09:07:39 -0800 (PST)
Message-ID: <m3vdtlcqp6.fsf@localhost.localdomain>
References: <808wqhzjl9.fsf@tiny.isode.net>
	<237967ef0812150538n671c22b8gaf7a7b5dcaf68433@mail.gmail.com>
	<20081215140834.GA3684@atjola.homenet>
	<20081215155610.GA11502@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?iso-8859-15?q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>,
	Mikael Magnusson <mikachu@gmail.com>,
	Bruce Stephens <bruce.stephens@isode.com>, git@vger.kernel.org
To: Theodore Tso <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Mon Dec 15 18:09:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LCGwH-00066z-7D
	for gcvg-git-2@gmane.org; Mon, 15 Dec 2008 18:09:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754115AbYLORHn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 15 Dec 2008 12:07:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754083AbYLORHn
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Dec 2008 12:07:43 -0500
Received: from nf-out-0910.google.com ([64.233.182.185]:38523 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753954AbYLORHm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 15 Dec 2008 12:07:42 -0500
Received: by nf-out-0910.google.com with SMTP id d3so467909nfc.21
        for <git@vger.kernel.org>; Mon, 15 Dec 2008 09:07:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding:date;
        bh=8bKmqE4/OFucWVzuvsYbm2x2dTwUD+SYnWbrDmSfZck=;
        b=Zn7hPSS24j6WsiPn9pfCyttODVB8YFSXUOyajqLffWCi7G6gKzZT2IebT1We+EMzk+
         4PhU3peNp4+66T8ObEoq3vowYfRyTeS7KEizGEV+1fSnba4iW8ipTrpu/SEz8zzxdhJS
         9KQTMVHCqOsDtkbUGo4BCSCj+OAiYKqo4BXUY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding:date;
        b=qzg0/5JWf3s/gLOu2UpU9T3m+e0vZShDJd1gwBI+1lDSi+P/AG7pIFJiQpfbjPxCWp
         g9kp89S5Urfn2yUnXnknkOWAjKTsFZ8AoFnapHB2XhHSaWkz+1vGYFAaqEPQRoddwwls
         fIWIipWFw0xggoy07qtuZrjn0uZlvUbDPEUC4=
Received: by 10.210.51.18 with SMTP id y18mr7983959eby.103.1229360859971;
        Mon, 15 Dec 2008 09:07:39 -0800 (PST)
Received: from localhost.localdomain (abva128.neoplus.adsl.tpnet.pl [83.8.198.128])
        by mx.google.com with ESMTPS id b30sm12268981ika.19.2008.12.15.09.07.37
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 15 Dec 2008 09:07:39 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id mBFH7awp003652;
	Mon, 15 Dec 2008 18:07:36 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id mBFH7YF9003649;
	Mon, 15 Dec 2008 18:07:34 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <20081215155610.GA11502@mit.edu>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103185>

Theodore Tso <tytso@mit.edu> writes:
> On Mon, Dec 15, 2008 at 03:08:34PM +0100, Bj=F6rn Steinbrink wrote:

> > To clarify that a bit more: git gc keeps unreachable objects unpack=
ed,
> > so that git prune can drop them. And git gc invokes git prune so th=
at
> > only unreachable objects older than 2 weeks are dropped.
>=20
> To be even more explicit, "git gc" will **unpack** objects that have
> become unreachable and were currently in packs.  As a result, the
> amount of disk space used by a git repository can actually go **up**
> dramatically after a "git gc" operation, which could be surprising fo=
r
> someone who is running close to full on their filesystem, deletes a
> number of branches from a tracking repository, and then does a "git
> gc" may get a very unpleasant surprise.
>=20
> A really good repository which shows this is linux-next, since it is
> constantly getting rewound, and old branches are reserved via a tag
> such as next-20081204.  If you update the your local copy of the
> linux-next repository every day, you will accumulate a large number o=
f
> these old branch tags.  If you then delete a whole series of them, an=
d
> run git-gc, the operation will take quite a while, and the number of
> blocks and inodes used will grow significantly.  They will disappear
> after a "git prune", but when I do this housekeeping operation, I've
> often wished for a --yes-I-know-what-I-am-doing-and-it's-unsafe-but-
> just-drop-the-unreachable-objects-cause-this-is-just-a-tracking-repos=
itory
> option to "git gc".

There was an idea to have "git gc --prune" run "git prune"
unconditionally, i.e. without grace period for dangling loose objects.

--=20
Jakub Narebski
Poland
ShadeHawk on #git
