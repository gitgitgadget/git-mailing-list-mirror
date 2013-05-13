From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] patch-ids.c: cache patch IDs in a notes tree
Date: Mon, 13 May 2013 06:53:29 -0700
Message-ID: <7vzjvzoujq.fsf@alter.siamese.dyndns.org>
References: <9d9e56d323b40fe9ea2a6484e35f0afcd3a3a85b.1368301939.git.john@keeping.me.uk>
	<CA+55aFyn0+Q4CA6yQZipaCRB0w9cW4YpuL3XuxU2JR5QPp98XQ@mail.gmail.com>
	<20130511214900.GF2299@serenity.lan>
	<CA+55aFzinmXA2HtA3hmN1VVOcLPWedfqJRws0RJMEc1By1VLLg@mail.gmail.com>
	<7v1u9cx5pf.fsf@alter.siamese.dyndns.org>
	<20130512085934.GG2299@serenity.lan>
	<7v1u9bvo1m.fsf@alter.siamese.dyndns.org>
	<20130513075906.GP2299@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Mon May 13 15:53:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UbtC4-0004mt-7P
	for gcvg-git-2@plane.gmane.org; Mon, 13 May 2013 15:53:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753734Ab3EMNxd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 May 2013 09:53:33 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59878 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753712Ab3EMNxc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 May 2013 09:53:32 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AB4021DEF8;
	Mon, 13 May 2013 13:53:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=XDq2k/ruJ9rbk7REoZTE3dpUBik=; b=GJ8vFm
	NXgc7DXwiiGtQ06P4FK9X/vq49C+/dMTNSHc+uoqHwXXko/ZljWM8lfsTuwwI/ua
	tg8vB5Z1LMpjUt3WiGUFRbXusGY4XDiGgT5q7nDoAFKW14vwBdGLHuR6QtTYIrRN
	/6QAORSMBXxKvi/uKH75KHIzAPTpB3yq50iLo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TdyaiXwq8icMfjxPUX0hH4o+AcCynUn5
	zkiJieHPt9LjUSfRALkm0JDogdLJMNhTINHHenIlHP/yzrEXtkUZR/apkV+YnZoW
	RJmvDGYpdQjLkqKz5ad6Dd84M/HU2a4HVjO5SEd/omCVuZvS5ka/TSIFdjZNdzNL
	NLfgRVq8e5U=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9FB4B1DEF3;
	Mon, 13 May 2013 13:53:31 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1FDE01DEF2;
	Mon, 13 May 2013 13:53:31 +0000 (UTC)
In-Reply-To: <20130513075906.GP2299@serenity.lan> (John Keeping's message of
	"Mon, 13 May 2013 08:59:07 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7EEBFC9C-BBD4-11E2-A760-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224142>

John Keeping <john@keeping.me.uk> writes:

> The caching layer could also introduce false positives though, which is
> more serious.  If you cache patch IDs with a pathspec restriction ...

What?  What business does patch-id have with pathspec-limited diff
generation?  You do not rebase or cherry-pick with pathspec, so
unless you are populating the patch-id cache at a wrong point (like,
say whenevern "git show $commit" is run), I am not sure why pathspec
limit becomes even an issue.
