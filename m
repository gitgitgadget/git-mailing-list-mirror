From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git rebase --abort of an --onto run does not checkout the
 originating branch
Date: Fri, 22 Oct 2010 12:15:03 -0700
Message-ID: <7vlj5qkpjc.fsf@alter.siamese.dyndns.org>
References: <4CC1C34E.8090203@workspacewhiz.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>
To: Joshua Jensen <jjensen@workspacewhiz.com>
X-From: git-owner@vger.kernel.org Fri Oct 22 21:15:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P9N5M-0005TK-JH
	for gcvg-git-2@lo.gmane.org; Fri, 22 Oct 2010 21:15:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759360Ab0JVTPQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Oct 2010 15:15:16 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:52744 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759718Ab0JVTPO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Oct 2010 15:15:14 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 71ECDE17C5;
	Fri, 22 Oct 2010 15:15:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=IlovukVP+G+NTK1ZGAotkgvwztI=; b=G4JKSn
	qh1ta6xFlz463FCjJwf2U5fmNgXdeES0i5hH8TlmAFVdkLErN9LYFGlGgQ5RCDEh
	UtLPatV5XYV9VHfmCOxkrxcfGWZ71ZJY3ff9mXqtQ6ZKNhBX6DNCgjd+6DXK9jbU
	lMoG/k6JkS8PlDK5ZpfRO1hWfkvVNAVmxB+SM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DxMpX25k3QYkrJRrAg3k+pZMhV774Uut
	eURG8bQOT4dGxcJrARyIwlw9PnwqVlfPshIoimNzrh5uhEzkaArHUehWh4KMdwZF
	adj1dzBDbSXx3JfIJv8hiZ2+vtC7I77qNMyBs0b8HzGc1juIHsWsTw9plxl0kx4v
	f+0qSH9a5IQ=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 4D53AE17C4;
	Fri, 22 Oct 2010 15:15:08 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 884EEE17C3; Fri, 22 Oct
 2010 15:15:05 -0400 (EDT)
In-Reply-To: <4CC1C34E.8090203@workspacewhiz.com> (Joshua Jensen's message of
 "Fri\, 22 Oct 2010 11\:01\:02 -0600")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: AF18EF32-DE10-11DF-9264-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159734>

Joshua Jensen <jjensen@workspacewhiz.com> writes:

> git rebase --onto mybranch START_SHA END_SHA
>
> In the middle, I decide to run 'git rebase --abort'.
>
> Just as the documentation states, it performs a checkout of END_SHA as
> the restored branch.  END_SHA has nothing to do with the originating
> branch, and confusion ensues.
>
> Is there a reason why 'git rebase' should not store off the
> originating branch and use that for an --abort, instead of <branch>
> which is END_SHA?

When END_SHA is an actual branch name (which by the way is almost always
how I use --onto in my attempts to transplant my topics), and when I found
out that the conflicts I see while rebasing the topic to a different
starting point (i.e. --onto) is too much to handle for too little gain, I
would not appreciate if --abort took me to the --onto branch, which is
totally uninteresting for the purpose of what I was attempting to do,
namely, to deal with the topic.

If the command took me back to the tip of the topic that I failed to
rebase, I can continue attempting to whip it in shape using different
strategies from there (e.g. merging an older part of upstream into the
topic before merging the topic back to the upstream).
