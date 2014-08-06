From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Subtree with submodule inside?
Date: Wed, 06 Aug 2014 10:51:50 -0700
Message-ID: <xmqqk36lmrpl.fsf@gitster.dls.corp.google.com>
References: <CAHd499CaCeHYGZSQeY8MRVnnjXBTgDy=OUqBYqNd1e5GiKre_A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git <git@vger.kernel.org>
To: Robert Dailey <rcdailey.lists@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 06 19:52:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XF5Nl-00007O-T7
	for gcvg-git-2@plane.gmane.org; Wed, 06 Aug 2014 19:52:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753300AbaHFRwC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Aug 2014 13:52:02 -0400
Received: from smtp.pobox.com ([208.72.237.35]:64097 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752027AbaHFRwA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Aug 2014 13:52:00 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id F1AB82F1FA;
	Wed,  6 Aug 2014 13:51:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4IXH5rd4WChjzRK6+/ra/N88N7g=; b=i9Vw6G
	IPnbprc0uksOTkOyUl74jh3qqRrPVxoa57Jy/lWjJpThoPK51vIUvEcQf98u0rjh
	Nki+mb/ypJmx85VnKxbWvH00SFuPjP8ftTX+y24bYKXnBAcm6/vIOWhTjai3S6ID
	R0QHoOblnU0tGOOhAT/p5CwuQF3SrVpIDO/MI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nxvMiDXT8xvBwRyrwbPUwQZ4T4wjitNf
	83XKoh/qFNZZjdIzGV3Xi2HIjTpicaTef8hBX8utbXI+hiIr6cEFJOOubB3n9CZr
	rGxaF8s0pNU44wERi9ea3Xm+bUsgUPZ6mXcV/CXCyaEu+GKvdRdJ0dZoYPZXQ4Qr
	QqFxKZVp0Uo=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E1DB22F1F9;
	Wed,  6 Aug 2014 13:51:59 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 40A5C2F1E8;
	Wed,  6 Aug 2014 13:51:53 -0400 (EDT)
In-Reply-To: <CAHd499CaCeHYGZSQeY8MRVnnjXBTgDy=OUqBYqNd1e5GiKre_A@mail.gmail.com>
	(Robert Dailey's message of "Wed, 6 Aug 2014 12:20:26 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 598C2FC8-1D92-11E4-BF5A-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254883>

Robert Dailey <rcdailey.lists@gmail.com> writes:

> Is this even possible? The .gitmodule file has to be at the root of
> the repository, AFAIK. So if the subtree is inherently not at the
> root, how does it manage its own submodules?
>
> Basically I have a common library that also keeps a submodule of third
> party dependencies (binaries). Each super project that depends on this
> common library (each super project has its own repository) will add it
> as a subtree. So what happens to the submodule with this setup?

My knee-jerk reaction would be "subtree would break submodules
badly, don't use it" ;-).

After all, I invented subtree merge as an ugly interim workaround
before submodule subsystem got into a usable shape, hoping that new
projects can use submodules without resorting to subtree merges.
