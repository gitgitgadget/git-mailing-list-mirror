From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 16/18] fsck: support demoting errors to warnings
Date: Tue, 23 Dec 2014 09:14:54 -0800
Message-ID: <xmqqa92e47ap.fsf@gitster.dls.corp.google.com>
References: <cover.1418055173.git.johannes.schindelin@gmx.de>
	<cdd5730d0003a7220f659804e9e286e77619b57c.1418055173.git.johannes.schindelin@gmx.de>
	<xmqqzjavgym5.fsf@gitster.dls.corp.google.com>
	<alpine.DEB.1.00.1412222319370.21312@s15462909.onlinehome-server.info>
	<xmqq38878gao.fsf@gitster.dls.corp.google.com>
	<alpine.DEB.1.00.1412222344250.21312@s15462909.onlinehome-server.info>
	<xmqqtx0n710m.fsf@gitster.dls.corp.google.com>
	<alpine.DEB.1.00.1412222356400.21312@s15462909.onlinehome-server.info>
	<xmqqppbb6zx9.fsf@gitster.dls.corp.google.com>
	<alpine.DEB.1.00.1412231049250.21312@s15462909.onlinehome-server.info>
	<xmqqmw6e499u.fsf@gitster.dls.corp.google.com>
	<alpine.DEB.1.00.1412231736490.21312@s15462909.onlinehome-server.info>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Dec 23 18:15:05 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y3T32-00009G-45
	for gcvg-git-2@plane.gmane.org; Tue, 23 Dec 2014 18:15:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755073AbaLWRO7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Dec 2014 12:14:59 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:52029 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754789AbaLWRO5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Dec 2014 12:14:57 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2957C28562;
	Tue, 23 Dec 2014 12:14:56 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=l+d0qkaUVziicI1iyd/A+DSoLrQ=; b=wY9fYe
	gDQgv6UJ+IiqP3cFz+L4EsdtgLzfIPbWmHqCj+3zIZ6sDXPCiL+ZyKdMzryb7w78
	B/FL5CPgD+QKiVG0CsK2V/vgbUiM/9s0dPtnN2pqRZGMVtFp8sP8mCcaDiPujqdU
	7WhLC96lByWgG/cmfkEr18Y63eAOF1k92WohQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=PPoo4zkfhy9jqRk9wKsAEAJ5+XndP7FU
	H4WZZ9fkMIxaoAgM5IqSB27PD+uFBhU+3wtcDTxsEHtaM8ZwAGQ4WeuDP3Zua7wa
	1U/RuzWT1siuLKANaSczrF3VFDpbNw/YYJvMbhczRA2XZ+wUO6iSfXC3x2GAIXVn
	cKVlX0swUWE=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 20A3F28560;
	Tue, 23 Dec 2014 12:14:56 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 94F6B2855F;
	Tue, 23 Dec 2014 12:14:55 -0500 (EST)
In-Reply-To: <alpine.DEB.1.00.1412231736490.21312@s15462909.onlinehome-server.info>
	(Johannes Schindelin's message of "Tue, 23 Dec 2014 17:47:07 +0100
	(CET)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 37247524-8AC7-11E4-B001-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261744>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> The parser I wrote actually accepts both versions, allowing me to skip the
> tedious step to convert the camelCased config setting into a
> lower-case-dashed version to pass to `index-pack` or `unpack-objects`,
> only to be parsed by the same parser as `fsck` would use directly.
>
> So I am rather happy with the fact that the parser handles both camelCased
> and lower-case-dashed versions.

That is myopic view of the world that ignores maintainability and
teachability, doing disservice to our user base.

What message does it send to an unsuspecting new user that
fsck.random-error is silently accepted (because we will never
document it) as an alias for fsck.randomError, while most of the
configuration variables will not take such an alias?

>> I suspect that it would be much better if the configuration variables
>> were organized the other way around, e.g.
>> 
>> 	$ git config fsck.warn missingTagger,someOtherKindOfError
>
> I had something similar in an earlier version of my patch series, but it
> was shot down rightfully: if you want to allow inheriting defaults from
> $HOME/.gitconfig, you have to configure the severity levels individually.

Hmmm.  What's wrong with "fsck.warn -missingTagger" that overrides
the earlier one, or even "fsck.info missingTagger" after having
"fsck.warn other,missingTagger,yetanother", with the usual "last one
wins" rule?

Whoever shot it down "rightfully" is wrong here, I would think.

>> But the proposed organization to use one variable per questionable
>> event type (as opposed to one variable per severity level) would
>> lead to a one-shot override of this form, e.g.
>> 
>> 	$ git fsck --missing-tagger=warn --some-other-kind-of-error=warn
>> 
>> which I think is insane to require us to support unbound number of
>> dashed options.
>
> The intended use case is actually *not* the command-line, but the config
> file, in particular allowing /etc/gitconfig, $HOME/.gitconfig *and*
> .git/config to customize the settings.

But we do need to worry about one-shot override from the command
line.  A configuration that sticks without a way to override is a
no-no.

>> Or are you saying that we allow "git config core.file-mode true"
>> from the command line to set core.fileMode configuration?
>
> I do not understand this reference.

I was puzzled by your "command line" and wondering if you meant
"from the command line, aVariable can be spelled a-variable".

> I did not suggest to change `git
> config`, did I? If I did, I apologize; it was definitely *not* my
> intention to change long-standing customs.

Then fsck.missing-tagger is definitely out.  Long standing customs
is that a multi-word token at the first and the last level is not
dashed-multi-word.
