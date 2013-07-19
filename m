From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 00/19] Index-v5
Date: Fri, 19 Jul 2013 11:25:46 -0700
Message-ID: <7vehauwgnp.fsf@alter.siamese.dyndns.org>
References: <1373650024-3001-1-git-send-email-t.gummerer@gmail.com>
	<CACsJy8AhmYBjzqPtF3f9Gk8hq2bk8-PtFCto9_4AkRePomvhAQ@mail.gmail.com>
	<87ehb0cgqt.fsf@gmail.com>
	<CACsJy8AiRCRvGmj4ZV+sc68d1z=S7YrRgPtPgEK+-zzNg7HcsA@mail.gmail.com>
	<87oba1siz6.fsf@gmail.com> <7v7ggo68o9.fsf@alter.siamese.dyndns.org>
	<87vc46lacn.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Thomas Rast <trast@inf.ethz.ch>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Robin Rosenberg <robin.rosenberg@dewire.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Thomas Gummerer <t.gummerer@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 19 20:25:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V0FNJ-0007Jv-UT
	for gcvg-git-2@plane.gmane.org; Fri, 19 Jul 2013 20:25:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759986Ab3GSSZu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Jul 2013 14:25:50 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47557 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751330Ab3GSSZt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jul 2013 14:25:49 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0DC2032822;
	Fri, 19 Jul 2013 18:25:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/C58vG7F5FZP8Xz3UIBtPDIMJA4=; b=tSA8XE
	ZQRJkDh4SLWQ6v1rg8rASp3aGv8fpqgYQbcjrILGrMn8aBqDubJvwSk/VzPHOEH7
	BwK6ABtVvMr6rw5FGmrqQ6DM9hR14zS4aARe6jgPSeusWgkGmDx/OXE2MT3oFhBW
	GE3X2jaW4EjqiL6n2Nls0onS7bRGXuCi/jY2A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gl7Q+oP7VNtcmEURBg25heKLQGU8R7OQ
	yVt56a3OONkE2rL7++7yS0/qhXFNwxMYug5T3dBTT9OSdAxVYovzUI8KmWB2aaTV
	pdyNYg/o/H8Q4hKtRxGGCFmH2gAeQLPSLO/W1ESYeLGIIiceyvO6mXmCrIDV3e5E
	OOdPFKF4gg4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 01B2D32821;
	Fri, 19 Jul 2013 18:25:49 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4775832820;
	Fri, 19 Jul 2013 18:25:48 +0000 (UTC)
In-Reply-To: <87vc46lacn.fsf@gmail.com> (Thomas Gummerer's message of "Fri, 19
	Jul 2013 19:37:28 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A24E60C0-F0A0-11E2-92E9-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230837>

Thomas Gummerer <t.gummerer@gmail.com> writes:

> What I currently did is add a environment variable GIT_INDEX_VERSION
> that is used only if there is no index yet, to make sure existing
> repositories aren't affected and still have to be converted explicitly
> by using git update-index.
>
> For the tests I simply did export GIT_INDEX_VERSION in test-lib.sh to
> allow the addition of GIT_INDEX_VERSION in config.mak.  Should I rename
> that to GIT_INDEX_VERSION_TEST and do something like
>
> set_index_version() {
>         export GIT_INDEX_VERSION=$GIT_INDEX_VERSION_TEST
> }
>
> in test-lib-functions.sh instead, does that make sense?

Mostly Yes ;-).  You have to write it in a valid POSIX shell, i.e.

	set_index_version () {
		GIT_INDEX_VERSION=$TEST_GIT_INDEX_VERSION
                export GIT_INDEX_VERSION
	}
