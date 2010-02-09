From: Junio C Hamano <gitster@pobox.com>
Subject: Re: t5401-update-hooks test failure
Date: Tue, 09 Feb 2010 14:44:59 -0800
Message-ID: <7vpr4eyqok.fsf@alter.siamese.dyndns.org>
References: <7vtytrih7b.fsf@alter.siamese.dyndns.org>
 <7vvde7h1mn.fsf@alter.siamese.dyndns.org>
 <20100208213256.GA470@coredump.intra.peff.net>
 <7viqa7cqs9.fsf@alter.siamese.dyndns.org> <20100208223107.GB21718@cthulhu>
 <7vpr4f9wey.fsf@alter.siamese.dyndns.org> <20100209045417.GA15210@cthulhu>
 <7v4olqlva7.fsf@alter.siamese.dyndns.org>
 <20100209175139.GA28936@spearce.org>
 <alpine.LFD.2.00.1002091337421.1681@xanadu.home>
 <20100209192628.GC28936@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@fluxnic.net>,
	Larry D'Anna <larry@elder-gods.org>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Feb 09 23:45:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Neypx-0002OK-D3
	for gcvg-git-2@lo.gmane.org; Tue, 09 Feb 2010 23:45:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753254Ab0BIWpX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Feb 2010 17:45:23 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:38165 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753080Ab0BIWpQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Feb 2010 17:45:16 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 5BB3A981CD;
	Tue,  9 Feb 2010 17:45:13 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=UvODmkZfNwNTgcFATeUnfGde4gs=; b=T4iM/Q
	izff5+RHLKVVwLzUWsRNbPajwMN3jA8UoP77pHmlfxEkep0gW8my/R+F6gmLIJ+1
	9nMGhjs7zSlAaQXb8ONFs2ccXqkUNfAPyY+gs793HPgzWSArldycWUIQbP1M/E0f
	Yqb0qKDw9qYENg9Zv6O6TPIozidvNDYAFOS5A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nZBo3ybYnF6uEGEtgceAXTvAVM1YAVoD
	tNfD9dyyAMMns5hgDAEzuLBfVXd+hYdJUv6PJqWiFDZ5LZ3zJ+wUg3762bPUvrmh
	2hpdP0mKtfszOy2ztXVkmKpIKZVVsBbFVnG4K5v0qN6H+YLYVzYQDsyijGVIUHJv
	4lWKo5EbxNo=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E4680981B8;
	Tue,  9 Feb 2010 17:45:07 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 20E4B981A1; Tue,  9 Feb
 2010 17:45:00 -0500 (EST)
In-Reply-To: <20100209192628.GC28936@spearce.org> (Shawn O. Pearce's message
 of "Tue\, 9 Feb 2010 11\:26\:28 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: C5AE032A-15CC-11DF-83F1-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139455>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> The only way I can see this missing message happening is if the C
> library isn't flushing the stdio buffer before the hook process
> exits.  Given that the hook process is a /bin/sh shell script,
> and its using echo to print its messages... I'm at a loss for how
> to fix that in Git.
>
> Unless its the recv_sideband() somehow skipping a line.  But I
> can't see it doing that.

The detection method of test is fooled by intermixed message.

This is what send.err has, and you grep for '^remote:' in it.

-- >8 --
warning: updating the current branch
warning: Updating the currently cheremote: STDERR pre-receive        
,
warning: as the index and work tree do not reflect changes that are in HEAD.
warning: As a result, you may see the changes you just pushed into it
warning: reverted when you run 'git diff' over there, and you may want
warning: to run 'git reset --hard' before starting to work to recover.
warning: 
warning: You can set 'receive.denyCurrentBranch' configuration variable to
warning: 'refuse' in the remote repository to forbid pushing into its
warning: current branch.
warning: To allow pushing into the current branch, you can set it to 'ignore';
warning: but this is not recommended unless you arranged to update its work
warning: tree to match what you pushed in some other way.
warning: 
warning: To squelch this message, you can set it to 'warn'.
warning: 
warning: Note that the default will change in a future version of git
warning: to refuse updating the current branch unless you have the
warning: configuration variable set to either 'ignore' or 'warn'.
remote: STDOUT update refs/heads/master        
remote: STDERR update refs/heads/master        
remote: STDOUT update refs/heads/tofail        
remote: STDERR update refs/heads/tofail        
error: hook declined to update refs/heads/tofail
remote: STDOUT post-receive        
remote: STDERR post-receive        
remote: STDOUT post-update        
remote: STDERR post-update        
To ./victim/.git
   d4f8e4a..b07e5b8  master -> master
 ! [remote rejected] tofail -> tofail (hook declined)
-- 8< --

But there indeed _is_ some skipping.  "Updating the currently che"
is interrupted by the output from the pre-receive hook, and I do not see
the remainder "cked out branch may cause confusion,\n" anywhere.
