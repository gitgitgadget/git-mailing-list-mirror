From: Dale Rowley <ddrowley3@juno.com>
Subject: Re: unexpected git-merge result
Date: Sat, 20 Feb 2010 03:45:09 +0000 (UTC)
Message-ID: <loom.20100220T031401-572@post.gmane.org>
References: <loom.20100219T202452-35@post.gmane.org> <7vaav4amjj.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 20 04:45:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NigHp-0001Yh-6v
	for gcvg-git-2@lo.gmane.org; Sat, 20 Feb 2010 04:45:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755291Ab0BTDpk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Feb 2010 22:45:40 -0500
Received: from lo.gmane.org ([80.91.229.12]:55745 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751993Ab0BTDpj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Feb 2010 22:45:39 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1NigHi-0001Vv-Kf
	for git@vger.kernel.org; Sat, 20 Feb 2010 04:45:38 +0100
Received: from 71-212-187-72.hlrn.qwest.net ([71.212.187.72])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 20 Feb 2010 04:45:38 +0100
Received: from ddrowley3 by 71-212-187-72.hlrn.qwest.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 20 Feb 2010 04:45:38 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 71.212.187.72 (Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.5) Gecko/20091212 Gentoo Firefox/3.5.5)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140513>

Junio C Hamano <gitster <at> pobox.com> writes:

> It can happen if F is a cherry-pick of D and G is a revert of F, for
> example.
> 

You're exactly right. I overlooked the cherry-pick, which clears things up a
bit. But the basic problem remains:

A----D---E---H
 \          /
  B--D'----G

G only removed a few of the lines that were brought over in the cherry-pick
(D'), so it was surprising when they re-appeared in H. Intuitively, one would at
least expect a conflict in H since D'+G is asserting that these lines should not
exist, whereas D (on the other branch) is asserting that they should. I can see
how it would be difficult to make git-merge account for this though, so maybe
this is just a subtle gotcha when merging branches? Is there an easy way to
avoid this gotcha?

Dale
