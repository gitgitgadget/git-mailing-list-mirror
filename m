From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] diff: run arguments through precompose_argv
Date: Wed, 06 Apr 2016 10:27:31 -0700
Message-ID: <xmqq60vuy7ek.fsf@gitster.mtv.corp.google.com>
References: <1459802325-22056-1-git-send-email-alex@fournova.com>
	<1459802325-22056-2-git-send-email-alex@fournova.com>
	<xmqqzit80yov.fsf@gitster.mtv.corp.google.com>
	<57040EE0.40503@kdbg.org>
	<C52E38F0-B0F2-4769-A2C7-798D0CD99B47@fournova.com>
	<5704BF14.9060100@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Alexander Rinass <alex@fournova.com>, Johannes Sixt <j6t@kdbg.org>,
	git@vger.kernel.org
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Wed Apr 06 19:27:44 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1anrF0-00080S-OK
	for gcvg-git-2@plane.gmane.org; Wed, 06 Apr 2016 19:27:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752675AbcDFR1h convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 6 Apr 2016 13:27:37 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:52625 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752572AbcDFR1g convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 Apr 2016 13:27:36 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1F40353361;
	Wed,  6 Apr 2016 13:27:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=HZZ1kAANkUmY
	114FBM4buNyjeEE=; b=yTPcRFoffDBpDM0Y3dY+GGCXc+L/8+SbDUeeXaUJmWp1
	Uza1W086MWdrYe4tAqhkSEy/YE7mqCTpyfGnmz7zgxlA9b85iQx8EODHKyMGhbr4
	lp3Zf+OMzBUOI6kX45pyW81GTS6AaJZLpI4BVsVlPNZn/W1lzOwmulLB7BECR/c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=PIXa6M
	zAOQuGKVqmGmCRGhh0fwm9fCwgBDO8NoxNQEWM8uaBasFk+KZ/K1qf+Hw9w5iGou
	knD9j3GFINLRXXEDSypVFG8klph6ruTifWWNua+EOJnFD9CVZYQdMxqRJSNMafBL
	PmRpbI2f3Ljud/uLkqnMKCh2bxJLRLisvI7cQ=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 14DBE53360;
	Wed,  6 Apr 2016 13:27:34 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 7E68E5335F;
	Wed,  6 Apr 2016 13:27:33 -0400 (EDT)
In-Reply-To: <5704BF14.9060100@web.de> ("Torsten =?utf-8?Q?B=C3=B6gershaus?=
 =?utf-8?Q?en=22's?= message of
	"Wed, 6 Apr 2016 09:47:32 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: D90AB174-FC1C-11E5-B083-45AF6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290857>

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

> May be something like this, (but this is highly a personal taste ques=
tion)

My observation was not a suggestion to rewrite the log message, but
primarily about describing the change in behaviour.

I didn't mean to nitpick the phrasing but let me think aloud about
it, using this as a template.  I rewrapped overlong lines from the
original.

> When running diff commands, file paths containing decomposed
> unicode code points are not converted to precomposed unicode form
> under Mac OS X.
>
> As a result, no diff is displayed.

Add ", but we normalize the paths in the index and the history to
precomposed form on that platform." at the end of the first sentence, t=
o
make sure you mention both causes of "As a result" that follows.
Also, these are better to be a single paragraph.  I.e.

    When running diff commands, a pathspec containing decomposed
    unicode code points is not converted to precomposed unicode form
    under Mac OS X, but we normalize the paths in the index and the
    history to precomposed form on that platform.  As a result, the
    pathspec would not match and no diff is shown.

> Opposite to most builtin commands, the diff builtin is missing the
> parse_options call, which internally runs arguments through the
> precompose_argv call, which ensures all arguments are in precomposed
> unicode form.
>
> Fix the problem by adding a precompose_argv call to diff,
> diff-index, diff-files and diff-tree.

Perhaps it is just me but I found "Opposite to most" harder to grok
for some reason.

And the "backward compatibility note" is missing.  I'd write these
two paragraphs like this if I were doing this patch.

    Unlike many builtin commands, the "diff" family of commands do
    not use parse_options(), which is how other builtin commands
    indirectly call precompose_argv() to normalize argv[] into
    precomposed form on Mac OSX.  Teach these commands to call
    precompose_argv() themselves.

    Note that precomopose_argv() normalizes not just paths but all
    command line arguments, so things like "git diff -G $string"
    when $string has the decomposed form would first normalized into
    the precomposed form and would stop hitting the same string in
    the decomposed form in the diff output with this change.  It is
    not a problem per-se, as "log" family of commands already use
    parse_options() and call precompose_argv()--we can think of it
    as making the "diff" family of commands behave in a similar way
    as the commands in the "log" family.
