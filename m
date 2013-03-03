From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Revert "graph.c: mark private file-scope symbols as
 static"
Date: Sun, 03 Mar 2013 13:08:50 -0800
Message-ID: <7vk3pob38d.fsf@alter.siamese.dyndns.org>
References: <50e7b3316fadbb550bea098ae92a0942a4429647.1362228122.git.john@keeping.me.uk>
 <87haktwr2a.fsf@pctrast.inf.ethz.ch> <20130303102946.GH7738@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org,
	Johan Herland <johan@herland.net>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Sun Mar 03 22:09:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UCG9q-0001hz-5s
	for gcvg-git-2@plane.gmane.org; Sun, 03 Mar 2013 22:09:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754264Ab3CCVIz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Mar 2013 16:08:55 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48190 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753795Ab3CCVIy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Mar 2013 16:08:54 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 293B6A231;
	Sun,  3 Mar 2013 16:08:53 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=12NiY7IhUvpal5QHEHUigllxAMI=; b=OJKXoz
	HWvt8zhPlc3/9gzgKibyfUYhRKicq4NSMXo60/Y57tqq87bf0txa5Jql2FHsYBe1
	PiaqVR/R58QoBXGjY9MNMsX5yDj3DLx9HYw3aX5GNQTvSIr1j9fwIGLRL0tCgPRJ
	eE+YLdDJHsxlp8g3AQt2TXB+d7xMmhfchmgwQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DEY35Zv8nPsWBJizrzZ3SikRWZC0pb+4
	CLIFQdbUDm1x/ILigWfKrf/FZfu+PI00cfWBVyqOYBdNTHboAs+XEFHkYap6oXDN
	KA9w+3Cl/nL0NihEVie21pWrKMk5u1+uvyyH8sXmG3EGIUcvNmihAIiU/O6zVZjM
	0iiDyGrynj4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1D741A230;
	Sun,  3 Mar 2013 16:08:53 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7F0BCA211; Sun,  3 Mar 2013
 16:08:52 -0500 (EST)
In-Reply-To: <20130303102946.GH7738@serenity.lan> (John Keeping's message of
 "Sun, 3 Mar 2013 10:29:46 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8D2765F0-8446-11E2-B65E-7FA22E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217359>

John Keeping <john@keeping.me.uk> writes:

> On Sat, Mar 02, 2013 at 08:16:13PM +0100, Thomas Rast wrote:
>> John Keeping <john@keeping.me.uk> writes:
>> 
>> > This reverts commit ba35480439d05b8f6cca50527072194fe3278bbb.
>> >
>> > CGit uses these symbols to output the correct HTML around graph
>> > elements.  Making these symbols private means that CGit cannot be
>> > updated to use Git 1.8.0 or newer, so let's not do that.
>> >
>> > Signed-off-by: John Keeping <john@keeping.me.uk>
>> > ---
>> >
>> > I realise that Git isn't a library so making the API useful for outside
>> > projects isn't a priority, but making these two methods public makes
>> > life a lot easier for CGit.
>> >
>> > Additionally, it seems that Johan added graph_set_column_colors
>> > specifically so that CGit should use it - there's no value to having
>> > that as a method just for its use in graph.c and he was the author of
>> > CGit commit 268b34a (ui-log: Colorize commit graph, 2010-11-15).
>> 
>> Perhaps you could add a comment in the source to prevent this from
>> happening again?
> ...
> I would hope that having this message in the history should be enough to
> prevent this changing in the future....

Given how it happened in the first place, I do not think anything
short of in-code comment would have helped.  There wouldn't be any
hint to look into the history without one.
