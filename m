From: Jeff King <peff@peff.net>
Subject: Re: How do I run tests under Valgrind?
Date: Mon, 17 Sep 2012 14:29:57 -0400
Message-ID: <20120917182957.GF1179@sigill.intra.peff.net>
References: <CALkWK0m_9OsAfG_pF3hUDW+EKCyZCn9NiDKKEW6AEOMmAw=yuA@mail.gmail.com>
 <20120917172022.GA1179@sigill.intra.peff.net>
 <CALkWK0m378ApSwa1xiYUqEjMny5m0wt3KacqdDRU1qt=cw6k8g@mail.gmail.com>
 <20120917173531.GB1179@sigill.intra.peff.net>
 <CALkWK0kDPGY_3v5SLPtyf+azUwA7msvQOvA+MaCgueZ71i2yGw@mail.gmail.com>
 <20120917174439.GD1179@sigill.intra.peff.net>
 <CALkWK0mkBbY7dUyaZAqqKE3ZMfE_xU6em_KCOKM9nsTjUP-9pA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 17 20:30:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TDg5H-00089U-Sn
	for gcvg-git-2@plane.gmane.org; Mon, 17 Sep 2012 20:30:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932343Ab2IQSaE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Sep 2012 14:30:04 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:46709 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757217Ab2IQSaA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Sep 2012 14:30:00 -0400
Received: (qmail 10368 invoked by uid 107); 17 Sep 2012 18:30:25 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 17 Sep 2012 14:30:25 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 17 Sep 2012 14:29:57 -0400
Content-Disposition: inline
In-Reply-To: <CALkWK0mkBbY7dUyaZAqqKE3ZMfE_xU6em_KCOKM9nsTjUP-9pA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205729>

On Mon, Sep 17, 2012 at 11:19:35PM +0530, Ramkumar Ramachandra wrote:

> +./test-lib.sh:477> file=/home/artagnon/src/git/t/../git-instaweb
> +./test-lib.sh:479> make_valgrind_symlink
> /home/artagnon/src/git/t/../git-instaweb
> +make_valgrind_symlink:5> test -x /home/artagnon/src/git/t/../git-instaweb
> make_valgrind_symlink:6: permission denied:
> /home/artagnon/src/git/t/../git-instaweb
> +make_valgrind_symlink:6> test '#!' '=' ''
> +make_valgrind_symlink:7> return

Weird. The line in question is this:

  test "#!" != "$(head -c 2 < "$symlink_target")"

Is there some problem with running "head" on your system? If it were
head failing to open git-instaweb, it would look more like:

  $ head -c 2 /etc/shadow
  head: cannot open `/etc/shadow' for reading: Permission denied

-Peff
