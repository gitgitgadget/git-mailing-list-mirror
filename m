From: Yann Dirson <dirson@bertin.fr>
Subject: Re: [BUG] Cannot push some grafted branches
Date: Mon, 17 Dec 2012 08:52:42 +0100
Organization: Bertin Technologies
Message-ID: <20121217085242.02a77243@chalon.bertin.fr>
References: <20121211153903.7522d6b0@chalon.bertin.fr>
 <7vd2yg8ngk.fsf@alter.siamese.dyndns.org>
 <20121212094432.6e1e48c8@chalon.bertin.fr>
 <7v38zb3ux0.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 17 08:53:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TkVVy-0005vg-Nj
	for gcvg-git-2@plane.gmane.org; Mon, 17 Dec 2012 08:53:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751331Ab2LQHxN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Dec 2012 02:53:13 -0500
Received: from cabourg.bertin.fr ([195.68.26.10]:33612 "EHLO cabourg.bertin.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750768Ab2LQHxM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Dec 2012 02:53:12 -0500
Received: from cabourg.bertin.fr (localhost [127.0.0.1])
	by postfix.imss70 (Postfix) with ESMTP id C0C98A0F6A
	for <git@vger.kernel.org>; Mon, 17 Dec 2012 08:52:40 +0100 (CET)
Received: from yport1.innovation.bertin.fr (yport1.bertin.fr [192.168.1.13])
	by cabourg.bertin.fr (Postfix) with ESMTP id 9085AA0F63
	for <git@vger.kernel.org>; Mon, 17 Dec 2012 08:52:40 +0100 (CET)
Received: from chalon.bertin.fr ([172.16.1.1]) by yport1.innovation.bertin.fr
 (Sun Java System Messaging Server 6.2-8.04 (built Feb 28 2007))
 with ESMTPPA id <0MF600FA40JSTV30@yport1.innovation.bertin.fr> for
 git@vger.kernel.org; Mon, 17 Dec 2012 08:52:40 +0100 (CET)
In-reply-to: <7v38zb3ux0.fsf@alter.siamese.dyndns.org>
X-Mailer: Claws Mail 3.8.1 (GTK+ 2.24.10; i486-pc-linux-gnu)
X-TM-AS-Product-Ver: IMSS-7.0.0.8220-6.8.0.1017-19456.005
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211655>

On Wed, 12 Dec 2012 11:57:47 -0800
Junio C Hamano <gitster@pobox.com> wrote:

> Yann Dirson <dirson@bertin.fr> writes:
> 
> > ....  In this respect, they seem to be
> > lacking a few features, when compared to "replace" refs, but they have different
> > uses, ...
> 
> Not reallyl; grafts were old hack whose use is still supported with
> its original limitations; replace is meant to replace all uses of
> grafts while removing grafts' largest warts.

OK, I'll take this into account.

But this situation should probably be make more clear in the docs.  Currently,
gitrepository-layout.txt describes refs/replace/ (and shallow) by reference to grafts,
and those are not marked as discouraged-use or anything.

And we may still want the bug fixed, or would we just list it as a known bug ?
At least it does not seem to occur with "replace" refs:

git-test$ rm .git/info/grafts 
git-test$ echo "fake merge" | git commit-tree master^{tree} -p master^ -p maint
b821b2aa00973a47936d7cd25c9a5978b1c839c6
git-test$ git replace master b821b2aa00973a47936d7cd25c9a5978b1c839c6
git-test$ git push origin maint
...
   50b03b0..79211fe  maint -> maint

-- 
Yann Dirson - Bertin Technologies
