From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: [PATCH 0/3] more terse push output
Date: Mon, 5 Nov 2007 08:09:59 +0100
Message-ID: <20FFDEF3-5F29-4494-9624-2CE30A585B92@zib.de>
References: <20071105050517.GA6244@sigill.intra.peff.net>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Nicolas Pitre <nico@cam.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Nov 05 08:09:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iow5Q-00027S-HR
	for gcvg-git-2@gmane.org; Mon, 05 Nov 2007 08:09:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753041AbXKEHJN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Nov 2007 02:09:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752561AbXKEHJN
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Nov 2007 02:09:13 -0500
Received: from mailer.zib.de ([130.73.108.11]:41339 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751832AbXKEHJM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Nov 2007 02:09:12 -0500
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id lA578iBW012100;
	Mon, 5 Nov 2007 08:08:44 +0100 (CET)
Received: from [192.168.178.21] ([77.184.61.25])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id lA578dsf001433
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Mon, 5 Nov 2007 08:08:43 +0100 (MET)
In-Reply-To: <20071105050517.GA6244@sigill.intra.peff.net>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63488>


On Nov 5, 2007, at 6:05 AM, Jeff King wrote:

>   - the 'ref is not up-to-date, maybe you need to push' message has  
> gone
>     away in favor of the terse '[rejected] ... (non-fast forward)'. I
>     know there was some discussion recently of enhancing that message.
>     Is this perhaps too terse?

I like the general idea of the terse output.

If we want a suggestion to the user, we could put it as
a summary. If a ref was rejected send-pack could print a
concluding message:

---
To file:///tmp/parent
  + f3325dc...3b91d1c hasforce -> mirror/hasforce (forced update)
    f3325dc..bb022dc  master -> mirror/master
  ! [rejected]        needsforce -> mirror/needsforce (non-fast forward)
  * [new branch]      newbranch -> mirror/newbranch
  * [new tag]         v1.0 -> v1.0
Counting objects: 5, done.
Writing objects: 100% (3/3), done.
Total 3 (delta 0), reused 0 (delta 0)
Unpacking objects: 100% (3/3), done.

warning: some refs were rejected.
  Maybe they are not up-to-date and you want to pull or rebase first?
  Or you may need to force an update?
---

In this way the terse output would not be disrupted and the
suggestion would be given to the user nonetheless.

I propose to use "warning" because it is not a real error. push
updates all other refs as expected. It only rejects some
refs. An error would be appropriate only after push learnt
transactions, that is either completely succeeds or doesn't
update any ref at all.

	Steffen
