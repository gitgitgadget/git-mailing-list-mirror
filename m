From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] test: set the realpath of CWD as TRASH_DIRECTORY
Date: Tue, 28 Aug 2012 23:06:53 -0700
Message-ID: <7vmx1exmde.fsf@alter.siamese.dyndns.org>
References: <5030F0BF.2090500@alum.mit.edu>
 <f58965733e604a9fe6ed72384d0307062403b478.1346043214.git.worldhello.net@gmail.com> <7vk3wktiph.fsf@alter.siamese.dyndns.org> <503D973D.8040402@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jiang Xin <worldhello.net@gmail.com>,
	Git List <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Aug 29 08:07:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T6bQd-0007gI-Sz
	for gcvg-git-2@plane.gmane.org; Wed, 29 Aug 2012 08:07:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751620Ab2H2GG4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Aug 2012 02:06:56 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59741 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750986Ab2H2GGz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Aug 2012 02:06:55 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6A5346F3D;
	Wed, 29 Aug 2012 02:06:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=1GPpfJRt9g1ecCYcXTh/bwa+D58=; b=DZXDV3
	ZRnfC+ozISzdv4SVvzVawWGNT0U6Fblx1aEdBKaXWfvhL17ijf1r/UGtVoF9IgdV
	D1/uVMoPMsw+Svxm+6fB6pzrxsFsN6SPDko7P5ygb7hyEbsdbhsPyf7LC9G1J7hM
	4Ddj0ORRBuXC82+GCZbf/EkCgVMM0yexItso4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vXc4EXsHB1L/DIV2e9VmFYJu7DoGHYeA
	Nm1gdD1eouI/KnSI13DqsS65dyJy8kWnTDY8mn3V1I9+uxKwwsWq+xPIiZj2zRPG
	upqrLBWeefc8MhBMB3gT8O6cLyfkhiz3E44ZFlVHo41qSgz4JevS4s6hBFUGGznt
	4pIMFUEg6r8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 571B26F3C;
	Wed, 29 Aug 2012 02:06:55 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B3F5B6F3B; Wed, 29 Aug 2012
 02:06:54 -0400 (EDT)
In-Reply-To: <503D973D.8040402@alum.mit.edu> (Michael Haggerty's message of
 "Wed, 29 Aug 2012 06:14:53 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BB9B7AB4-F19F-11E1-883B-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204463>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> But it also changes almost 600 *other* tests from "succeed even in the
> presence of symlinks" to "never tested in the presence of symlinks", and
> I think that is surrendering more ground than necessary.

Ouch.  I did not know have 600+ tests that cares about CEILING.

> I would rather
> see one of the following approaches:
>
> *If* the official policy is that GIT_CEILING_DIRECTORIES is not reliable
> in the presence of symlinks, then (a) that limitation should be
> mentioned in the documentation; (b) the affected tests should either be
> skipped in the case of symlinked directories or they (alone!) should
> take measures to work around the problem.

What exactly is broken in CEILING?

I somehow thought that Jiang's patch was to make sure any variables
that contain pathnames (and make sure future paths we might grab out
of $(pwd)) are realpath without symlinks early in the test set-up,
and with that arrangement, no symlink gotcha should come into
picture, with or without CEILING.

Perhaps the setting of the CEILING has not been correctly converted
with the patch?

Or is there something fundamentally broken, even if we do not have
any symlinks involved, with CEILING check?

Puzzled..
