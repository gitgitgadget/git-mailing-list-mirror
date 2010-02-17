From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [RFC PATCH v2 11/11] filter-branch: learn how to filter notes
Date: Wed, 17 Feb 2010 20:59:26 +0100
Message-ID: <4B7C4A9E.9030906@kdbg.org>
References: <cover.1266361759.git.trast@student.ethz.ch> <a1bdef42de198dec4ec59c0d2b8b67e8656192d1.1266361759.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Johan Herland <johan@herland.net>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Wed Feb 17 20:59:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nhq3m-0005fY-Dp
	for gcvg-git-2@lo.gmane.org; Wed, 17 Feb 2010 20:59:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754161Ab0BQT7l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Feb 2010 14:59:41 -0500
Received: from bsmtp4.bon.at ([195.3.86.186]:50158 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754048Ab0BQT7k (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Feb 2010 14:59:40 -0500
Received: from [77.118.62.16] (77.118.62.16.wireless.dyn.drei.com [77.118.62.16])
	by bsmtp.bon.at (Postfix) with ESMTP id 34B741001C;
	Wed, 17 Feb 2010 20:59:30 +0100 (CET)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <a1bdef42de198dec4ec59c0d2b8b67e8656192d1.1266361759.git.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140257>

Thomas Rast schrieb:
> +--notes-filter <command>::
> +	This filter rewrites the notes (see linkgit:git-notes[1]).  It
> +	gets the old notes on standard input, and its standard output
> +	is written as the new note (overwriting any existing notes).
> ++
> +Defaults to doing nothing, unless the `notes.rewrite.filter-branch`
> +option is set, in which case it copies the notes (i.e., defaults to
> +`cat`).
> ++
> +In addition to the usual variables, GIT_NEW_COMMIT is set to the
> +result of the rewriting so that the filter can get at the existing
> +notes, if any.

I think that this form of --notes-filter is not flexible enough.

1. There is no possibility for the filter to decide whether the note 
should be attached to the rewritten commit or not.

2. The implementation is not concerned about different notes namespaces 
(IIUC).

3. There is probably more.

One use-case that comes to mind is to move notes from one particular 
namespace to a different one (and I mean move, not just copy). Don't know 
if 'git notes' itself has such a feature.

I am not a 'git notes' user at this time, nor do I know anything about the 
implementation, nor did I follow any discussions about notes, hence, I'm 
not in the position to judge what --notes-filter could be useful for. I 
know I talked you into implementing it, but that is just because I dislike 
that filter-branch calls a post-rewrite hook (that just doesn't sound 
right to me, given the one-shot nature of filter-branch), and your 
intention obviously was to transfer notes.

-- Hannes
