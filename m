From: Luke Kenneth Casson Leighton <luke.leighton@gmail.com>
Subject: usage for git-p2p (was: git pack/unpack over bittorrent - works!)
Date: Sat, 4 Sep 2010 12:54:54 +0100
Message-ID: <AANLkTin0-Zjy7Chvntf2pNj5iCQ-4Y5u=bu8r7DSejeu@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Nicolas Pitre <nico@fluxnic.net>, "Ted Ts'o" <tytso@mit.edu>,
	Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
To: Artur Skawina <art.08.09@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 04 13:55:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OrrKo-0005aC-5a
	for gcvg-git-2@lo.gmane.org; Sat, 04 Sep 2010 13:55:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752051Ab0IDLy5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Sep 2010 07:54:57 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:53347 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751733Ab0IDLy4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Sep 2010 07:54:56 -0400
Received: by vws3 with SMTP id 3so2059388vws.19
        for <git@vger.kernel.org>; Sat, 04 Sep 2010 04:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:cc:content-type;
        bh=Kwn69O8BKU2x1+MlK0URMsyFd9eruqEfoz36AC2DKB4=;
        b=P0VhtK+5ZEhgIGKFxt/mVTLxF7dCsL4y9LdpdeeJnhdEQ6CRzRtZJRb72fRljpUP0p
         Gf3u0mV07PnEbFwU1pYVOEljKCk1LRMu27riPg58NC9yStep5CRdpeoWjcSNzI04aF6b
         zaMZyHOdau6rkF6UH7Rr5NwC9TsPaULgqYhPY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        b=US6/r3bAccQBQYnep8vlCOlTvl1wC1QvnfbubyEsaQrb7Qfz+E59SUaZefrpds7Ex9
         2mBgpR0ypNsj94WAXIdEL7Kd036tCp0NO82C6mDmrfGRF16EixhWQTlJhzqDMCjeRIqZ
         f8XoOKc4rt/Xnhu0YNP/8vHm5pP3igIguLAAU=
Received: by 10.220.127.21 with SMTP id e21mr147699vcs.228.1283601294856; Sat,
 04 Sep 2010 04:54:54 -0700 (PDT)
Received: by 10.220.98.8 with HTTP; Sat, 4 Sep 2010 04:54:54 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155317>

On Sat, Sep 4, 2010 at 2:52 AM, Artur Skawina <art.08.09@gmail.com> wrote:
> Hmm, taking a few steps back, what is the expected usage of git-p2p?
> Note it's a bit of a trick question; what i'm really asking is what _else_,
> other than pulling/tracking Linus' kernel tree will/can be done with it?

 i'm _so_ glad you asked :)  please note - for all of these i'm keenly
aware that GPG signing is required (and nicolas has pointed out that
you only need a 20-byte hash to be securely transferred by some OOB
mechanism)

 * distribution of large mailing lists and reduction of load on SMTP
servers by adding in a firebreak layer where the SMTP data goes into a
git repository first, then is extracted on the other side.  users may
choose to download the mailing list using git over a peer-to-peer
network and then use the exact same software that the mailing list
server is running, thus reducing the load on the web front-end.  if
you then choose also to allow users to GPG-sign commits to the same
git repository, you have the possibility of reducing the load on the
SMTP servers *as well*.  _and_ a group of users can operate in
"offline" mode whilst still being able to collaborate (by sharing the
git repo between themselves on an isolated LAN) _and_ when one of them
goes back "online", all their commits sync up, and the rest of the
world becomes aware of that group's offline discussion.

 * distributed wikis.  there are lots of wikis now using git: ikiwiki
is one, and moinmoin can also be configured to use git.  so, wikis
have already solved the "conflict" problem, in particular i know that
joey is a smart bunny and has solved conflict resolution in ikiwiki.
that makes it possible to simply turn an "ordinary" wiki into a
"peer-to-peer" wiki by merely inserting git-p2p underneath.

 * distributed bugtrackers.  the one that i know of which i believe
would work straight away is the ikiwiki "bug" plugin.  the rest i need
to investigate: i know of at least one that's based on git that i
haven't looked at for a loong while (ditrack) - but the principle is
very straightforward: create bugs by UUID, commit, distribute.  if you
want a "central" numbering scheme then all that's needed is for a
"central" service to allocate a "central" number - a symlink to the
UUID would do - and you're done.

 * of course there's source management for other projects other than
linux-2.6 :)

there's plenty more ideas out there, but the primary ones i'm
interested in are the ones where "traditional" software development
tools are being used which are utterly dependent on the client-server
paradigm.  for reasons i won't explain as it's not relevant to this
technical discussion list, this is making me feel a bit twitchy [free
software development being dependent on the client-server paradigm,
that is].

l.
