From: Ralf Ebert <ralf@ralfebert.de>
Subject: Re: [PATCH] reset: Better warning message on git reset --mixed
 <paths>
Date: Sun, 15 Aug 2010 23:05:04 +0200
Message-ID: <1281906304.32195.26.camel@lucy.SSG5-Serial-WLAN>
References: <1281814499-11797-1-git-send-email-avarab@gmail.com>
	 <20100814210505.GA2372@burratino> <7vvd7chcj4.fsf@alter.siamese.dyndns.org>
	 <87tymwzjbk.fsf@catnip.gol.com>
	 <AANLkTin3zyPvs3GjOt3=q6dOofFA2ba0sBAzt3=Ka1Wn@mail.gmail.com>
	 <7vr5hzg1u1.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
	Miles Bader <miles@gnu.org>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Ralf Ebert <info@ralfebert.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Aug 15 23:05:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OkkOX-0000GR-FI
	for gcvg-git-2@lo.gmane.org; Sun, 15 Aug 2010 23:05:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750814Ab0HOVFP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 15 Aug 2010 17:05:15 -0400
Received: from wp057.webpack.hosteurope.de ([80.237.132.64]:35415 "EHLO
	wp057.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750802Ab0HOVFJ convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Aug 2010 17:05:09 -0400
Received: from [188.108.115.186] (helo=[192.168.1.22]); authenticated
	by wp057.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	id 1OkkO9-0007Q2-T9; Sun, 15 Aug 2010 23:05:06 +0200
In-Reply-To: <7vr5hzg1u1.fsf@alter.siamese.dyndns.org>
X-Mailer: Evolution 2.30.3 
X-bounce-key: webpack.hosteurope.de;ralf@ralfebert.de;1281906309;f5d15c7c;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153621>

> Regarding the various modes that are forbidden with "reset", I've bee=
n
> wondering if we can do things differently.

After being very happy about finding the
'soft-mixed-hard-path-cheat-sheet' table in 0e5a7fa (mentioned in =C3=86=
vars
message that triggered the discussion)

reset:  --soft  --mixed  --hard  -- <paths>
HEAD       X       X        X        -
index      -       X        X        X
files      -       -        X        -

I was wondering:

Wouldn't the common reset soft/mixed/hard with path/commit operations
become a lot more intuitive by separating the "(1) copy [partially] fro=
m
HEAD to index [to working tree]" operation and the "(2) change HEAD and
do (1)" operation? Just as a very rough scribble of what I mean, like
this:

git wipe [<path>]            # git reset [<file>]; git checkout [<file>=
]
git wipe [<path>] --index-only           # git reset [--mixed] [<path>]

git set-head <commit>                    # git reset --soft [<commit>]
git set-head <commit> --wipe             # git reset --hard [<commit>]
git set-head <commit> --wipe-index-only  # git reset --mixed [<commit>]

(I know that git reset can do more than that, but this is everything I
ever wanted as porcelain-only user from git reset, thought maybe the
idea could be of use without being fully elaborated)

--
Ralf
