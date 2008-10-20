From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Usability of git stash
Date: Sun, 19 Oct 2008 22:29:39 -0700
Message-ID: <7vmygz4yws.fsf@gitster.siamese.dyndns.org>
References: <87wsg9acfv.fsf@cup.kalibalik.dk>
 <nKimSsYZj6xfGNCQS3i5cRwnWQfbHrtUrwdGB2zGWVfMOcfZMwJDKg@cipher.nrlssc.navy.mil> <86vdvsg4up.fsf@lola.quinscape.zz> <vCcONcOJu3QKQyRgPdT5Dws3F2P25RNAFOgM5GX6FWWKJe40papCRw@cipher.nrlssc.navy.mil> <87prly5k5r.fsf@cup.kalibalik.dk> <20081019184029.GF14786@spearce.org> <20081020003644.GA10412@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Anders Melchiorsen <mail@cup.kalibalik.dk>,
	Brandon Casey <casey@nrlssc.navy.mil>,
	David Kastrup <dak@gnu.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Oct 20 14:45:12 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KrnMN-0000Sf-KQ
	for gcvg-git-2@gmane.org; Mon, 20 Oct 2008 07:31:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750958AbYJTF37 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Oct 2008 01:29:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750911AbYJTF37
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Oct 2008 01:29:59 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:58473 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750755AbYJTF36 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Oct 2008 01:29:58 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 72D56715AD;
	Mon, 20 Oct 2008 01:29:56 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id EB231715A0; Mon, 20 Oct 2008 01:29:46 -0400 (EDT)
In-Reply-To: <20081020003644.GA10412@coredump.intra.peff.net> (Jeff King's
 message of "Sun, 19 Oct 2008 20:36:44 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 215DFFBE-9E68-11DD-829D-9CEDC82D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98662>

Jeff King <peff@peff.net> writes:

>   git checkout next ;# which is where I usually am anyway
>   hack hack hack
>   # oops, I have been building this directly on top of next and it
>   # really needs to be a feature-branch on maint
>   git stash
>   git checkout -b jk/maint-fix-whatever origin/maint
>   git stash apply
>
> The equivalent non-stash commands would be "commit -m wip" and
> "cherry-pick". But the stash saves me the trouble later of having to
> delete the wip cruft on top of next.

The equivalent would be:

	git checkout -m -b jk/maint-fix-whatever origin/maint

no need for stash, wip-commit, nor cherry-pick.

The advantage of using "stash then stash apply" (not "stash pop") or
"wip-commit with cherry-pick" is that you can reset, take a deep breath,
and redo it, when the resulting merge conflict gets too hairy.

> I disagree. I think the strength of stash is that it is divorced from
> the history. So it is more like a cherry-pick (or diff | apply, which is
> what it was intended to replace).

I agree with you; it really is the "diff saved somewhere, later applied".
