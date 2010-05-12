From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] ls-remote: print URL when no repo is specified
Date: Tue, 11 May 2010 22:50:44 -0700
Message-ID: <7veihh8y8b.fsf@alter.siamese.dyndns.org>
References: <1273416140-5044-1-git-send-email-rctay89@gmail.com>
 <1273598423-3156-1-git-send-email-rctay89@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Git Mailing List" <git@vger.kernel.org>
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 12 07:51:01 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OC4qQ-0005Mr-Df
	for gcvg-git-2@lo.gmane.org; Wed, 12 May 2010 07:50:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752619Ab0ELFux (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 May 2010 01:50:53 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:40676 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751729Ab0ELFuw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 May 2010 01:50:52 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 1E4F9B245F;
	Wed, 12 May 2010 01:50:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=iOaZUcaQB7ZL5DeNmfZiI8cui/w=; b=joeACF
	3lgpzhXcSSTD22lBNX/osFMAZiW9V9YxXYLZ/wi3oCWNY5gaA1zDTf6DETaaebG4
	zf0hAktZnB6dmN/ohfxNrg/uXH4puyTVWocgWjuPIqhEzVoDHTIBWJA7xWrCB3ch
	0v05rrPIjnHYBy06JH1SwyiXK1wl1Zr/438SQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=yWN7duRY0PYFjF7YEfiFfEyyvHmij7Xr
	UXf3pd1jEhVVI2Agsd3JqH0n1FrKrj4tQfuPF4K24YiFEQt5O3n/5xOug8WAnonS
	aIdLxEH2iss7nZO09EHZxS/xN4S323YHvuumYyv9fDOiKXhUZ3eVfIwK0CDXyBzy
	fW+hDB6Cuiw=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id EC05FB245E;
	Wed, 12 May 2010 01:50:48 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 57014B245D; Wed, 12 May
 2010 01:50:46 -0400 (EDT)
In-Reply-To: <1273598423-3156-1-git-send-email-rctay89@gmail.com> (Tay Ray
 Chuan's message of "Wed\, 12 May 2010 01\:20\:23 +0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 50F31196-5D8A-11DF-9964-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146920>

Tay Ray Chuan <rctay89@gmail.com> writes:

> After 9c00de5 (ls-remote: fall-back to default remotes when no remote
> specified), when no repository is specified, ls-remote may use
> the URL/remote in the config "branch.<name>.remote" or the remote
> "origin"; it may not be immediately obvious to the user which was used.

I cannot convince myself that this is a good change, as I've always
thought "ls-remote" output as something people want to let their scripts
read and parse.  9c00de5 may have given an enhancement to these scripts in
the sense that they can now respond to an empty input from the end user,
but this patch forces them to change the way they parse the output from
the command.

I also think this patch is solving a wrong problem.

When an end user does not know which remote ls-remote would be talking to
by default, what else does he *not* know?  Probably which remote "pull"
would be fetching from and what branch it would be merging with?  Doesn't
he have a better command to use to learn that information to reorient
himself when he is lost that way?
