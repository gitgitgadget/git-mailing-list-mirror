From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-new-workdir: support submodules
Date: Wed, 28 Jan 2015 12:18:37 -0800
Message-ID: <xmqqbnlihd5u.fsf@gitster.dls.corp.google.com>
References: <CAGXKyzHoLLgkXk0X4UVtLBEryqsHriKmmO5+2iVWk3mR8y7=Hw@mail.gmail.com>
	<CAGXKyzEwAjCNTxRtjSuFh9b6BzzOYKOQryKtXBGY3_hkkFvyVw@mail.gmail.com>
	<xmqqegqlnelu.fsf@gitster.dls.corp.google.com>
	<CAGXKyzEPWrbRFOhvCBm=2Z50zso85G50z-nLd_wyzyeEADQSmw@mail.gmail.com>
	<xmqqa916nq4p.fsf@gitster.dls.corp.google.com>
	<CAGXKyzEYVsz-nRs52pTKo+6JLBiO9daU_C3qev3H43=Vzuygiw@mail.gmail.com>
	<xmqqtwzem776.fsf@gitster.dls.corp.google.com> <54C7CC6D.80906@web.de>
	<20150128105007.GA761@lanh>
	<CACsJy8C1zBawTbeNcr+JtzTwHupb8jpivL-8Tvr=zjAAUhMLLw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Craig Silverstein <csilvers@khanacademy.org>,
	Git Mailing List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 28 21:18:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YGZ4Y-0001L8-7J
	for gcvg-git-2@plane.gmane.org; Wed, 28 Jan 2015 21:18:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932669AbbA1USm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Jan 2015 15:18:42 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:65529 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755582AbbA1USk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jan 2015 15:18:40 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7BAAB3369C;
	Wed, 28 Jan 2015 15:18:39 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ps80sN0mw31+KVLNXdLDd6yGZqE=; b=cOCcUj
	y3SS7QM1xi6H0dsy1MEMoxniqQHeJ8MC9GhiMu83R9jMWvdD6RDT+lt4L7CGjVS9
	kG+tpbr42omXA+FMShwIpSsarVMZteN/B+/30pdWdTXyhwyP1GkQGWxG186ODUL1
	t3OL2kO+g5ptQ5OB4O8HunbhCHaLh+VzwrQ9c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wEjPZwJe7WXBhpNJOz18+WUEsxf35dPH
	6RAFIPSxNw9kY7oPTM9/nRh+opZnabjPMWP4ZhDvO7EK6xSIBSOX9QiCp8r6jiPb
	Vglq+arZ3zhATVl3QukxlUfSqUcri4+tVyUsptpNRWLqzrSVMXq1l2MCznQb18Ua
	kyvKCCuLEPA=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 717C03369B;
	Wed, 28 Jan 2015 15:18:39 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E56343369A;
	Wed, 28 Jan 2015 15:18:38 -0500 (EST)
In-Reply-To: <CACsJy8C1zBawTbeNcr+JtzTwHupb8jpivL-8Tvr=zjAAUhMLLw@mail.gmail.com>
	(Duy Nguyen's message of "Wed, 28 Jan 2015 17:53:43 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: D878AB82-A72A-11E4-9098-7BA29F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263106>

Duy Nguyen <pclouds@gmail.com> writes:

> On Wed, Jan 28, 2015 at 5:50 PM, Duy Nguyen <pclouds@gmail.com> wrote:
>> For git-new-workdir.sh, perhaps we can teach include.path to make
>> config.local path relative to where the config symlink is, not where
>> the symlink target is.
>
> Ignore this part. I originally wanted to use include.path to load
> config.local, but there was an easier way. With this patch, I think
> config.local is already per worktree that is created by
> git-new-workdir.sh.

I think this may give us a cleaner approach to support a "keep
multiple working trees from the same project that are configured
differently" setting.

I am not sure how well it meshes to call this as ".local" with the
"--local" option of "git config" (read: "local" is a loaded word,
and the way we have used it have been "per repository", but now you
are using it to mean "per working tree" that is finer grained),
though.

I hope that there aren't people that are crazy enough to bind the
same repository to two different places in the top-level project,
and insist that we (re)use the submodule repository ;-).
