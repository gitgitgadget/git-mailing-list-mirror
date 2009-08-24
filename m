From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] import-tars: Allow per-tar author and commit message.
Date: Mon, 24 Aug 2009 11:54:24 -0700
Message-ID: <7vab1pf3fj.fsf@alter.siamese.dyndns.org>
References: <20090823203640.B195D189B12@perkele>
 <4A91B8BB.1030906@vilain.net>
 <alpine.DEB.2.00.0908241659380.16576@perkele.intern.softwolves.pp.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nanako Shiraishi <nanako3@lavabit.com>,
	Sam Vilain <sam@vilain.net>, git@vger.kernel.org
To: Peter Krefting <peter@softwolves.pp.se>
X-From: git-owner@vger.kernel.org Mon Aug 24 20:54:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mfegv-0000hy-UE
	for gcvg-git-2@lo.gmane.org; Mon, 24 Aug 2009 20:54:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753254AbZHXSyo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Aug 2009 14:54:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753235AbZHXSyn
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Aug 2009 14:54:43 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:45372 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753221AbZHXSyn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Aug 2009 14:54:43 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 1B64136C4B;
	Mon, 24 Aug 2009 14:54:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=V/YiwSDz1dJp2ZA+joYCSw2qJwI=; b=KrFlxw1LXYv+HBp1KP0UFxy
	l0PLclLxbZTkXZJ6eMG0pUqW6pXFU1kDi7aiQRfgOEozQOpFhoiLzfNFA9uABljl
	hcberT+bw0wtoAh3+MoljZoWQPaBVStmFZ7MwpsJ9xoYp/8B3FUasEEzN/UjzqXD
	M05ydYMiOV+lp84YB+70=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=bq/hUMaJOMZ364KlQlDT52UZvJdPSt0k0g8IewuBxJk1cE5iN
	HHWpfcmviFk9uniddjNYkbqAfxXDT8FpllL2snoRYeycGm0D8jMPC7zmHDVgDndK
	27Fq6p1YTVRIS6AKFFobNmus8j6Sh4bSbnJM45AVbHevC7kAVjbP3KgCIA=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D7FFB36C3E;
	Mon, 24 Aug 2009 14:54:34 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 9EE9336C36; Mon, 24 Aug 2009
 14:54:25 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 90C14B9E-90DF-11DE-A76C-8B19076EA04E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126957>

Peter Krefting <peter@softwolves.pp.se> writes:

> Nanako Shiraishi:
>
>> Instead of requiring the user to have millions of separate files,
>> how about reading a single metainfo file that may look like this?
>
> The advantage of having one (or more) files per tarball is that I can
> use the shell's tab completion to make sure I spell the name of the
> archive correctly. And that it makes it a lot easier to parse.
>
>
> Sam Vilain:
>
>> Also I wonder if there isn't a nicer interface for users.  Why not allow
>> the file to specify From:, Committer: etc as header lines
>
> Good idea.

That sounds like a sensible thing to do.

I however am a bit uneasy to see that the patch didn't seem to (and the
rerolled one does not seem to, either) allow any way to forbid reading of
the .msg files, other than an obvious workaround of running "find | xargs
rm" beforehand.  Unlike your "import-directories" that is a brand new
program without any existing users, you are touching code that other
people have already used, and you do not want to change the behaviour for
them only because they happen to have unrelated files in the same
directory.
