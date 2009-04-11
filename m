From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: [PATCH] process_{tree,blob}: Remove useless xstrdup calls
Date: Sat, 11 Apr 2009 15:41:12 +0200
Message-ID: <20090411134112.GA1673@atjola.homenet>
References: <20090408112854.GA8624@atjola.homenet> <alpine.LFD.2.00.0904101517520.4583@localhost.localdomain> <alpine.LFD.2.00.0904101714420.4583@localhost.localdomain> <alpine.LFD.2.00.0904101806340.4583@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nicolas Pitre <nico@cam.org>, Jakub Narebski <jnareb@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>, david@lang.hm,
	Junio C Hamano <gitster@pobox.com>,
	Nicolas Sebrecht <nicolas.s-dev@laposte.net>,
	"Robin H. Johnson" <robbat2@gentoo.org>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sat Apr 11 16:00:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lsdkr-00087o-HL
	for gcvg-git-2@gmane.org; Sat, 11 Apr 2009 16:00:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756017AbZDKNlR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 11 Apr 2009 09:41:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755969AbZDKNlR
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Apr 2009 09:41:17 -0400
Received: from mail.gmx.net ([213.165.64.20]:53138 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755792AbZDKNlR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Apr 2009 09:41:17 -0400
Received: (qmail invoked by alias); 11 Apr 2009 13:41:14 -0000
Received: from i59F5409B.versanet.de (EHLO atjola.local) [89.245.64.155]
  by mail.gmx.net (mp041) with SMTP; 11 Apr 2009 15:41:14 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX1/p5RBioXHp+V4xQEPzFvX9navl9r6otsTCrD96nc
	mBIjfUGrBC0ox3
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.0904101806340.4583@localhost.localdomain>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.57
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116297>

On 2009.04.10 18:15:26 -0700, Linus Torvalds wrote:
> It obviously goes on top of my previous patch.

Gives some nice results for the "rev-list --all --objects" test on the
gentoo repo says (with the old pack):

     | With my patch | With your patch on top
-----|---------------|-----------------------
VSZ  |       1667952 | 1319324
RSS  |       1388408 | 1126080
time |       1:48.99 | 1:42.24

Testing a full repack, it feels slower during the "Compressing objects"
part, but I don't have any hard numbers on that, and maybe I've just
been more patient the last week, when I did the first repack on that
repo. I can just tell that it took about 13 minutes for the "Compressin=
g
objects" part, and 18 minutes in total, on my Core 2 Quad 2.83GHz with
4G of RAM.

The new pack is slightly worse than the old one (window=3D250, --depth=3D=
250):
Old: 759662467
New: 759720234

But that's seems totally negligible, and at least the performance of th=
e
(stupid) rev-list test is not affected by the different pack layout.

Bj=F6rn
