From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t7300: repair filesystem permissions with test_when_finished
Date: Wed, 02 Jul 2014 13:06:36 -0700
Message-ID: <xmqq38ejh6er.fsf@gitster.dls.corp.google.com>
References: <20140702184429.GA32538@sigill.intra.peff.net>
	<20140702190159.GC5816@google.com>
	<20140702190331.GA9869@sigill.intra.peff.net>
	<xmqq7g3vh6h1.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jul 02 22:06:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X2Qno-0001qe-3F
	for gcvg-git-2@plane.gmane.org; Wed, 02 Jul 2014 22:06:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758004AbaGBUGo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jul 2014 16:06:44 -0400
Received: from smtp.pobox.com ([208.72.237.35]:55829 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754511AbaGBUGn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jul 2014 16:06:43 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id F076623FE0;
	Wed,  2 Jul 2014 16:06:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=OyB8Mtf23uq1Jf4Vyr4RRZWudCA=; b=ScAQ7n
	5T3KWYYRT65kZ+fmAhBJrW7URKw7xiU89JS/p8EIbC1AydjganWqEnKJueYoaTDH
	2DfRGfWams6gAOfsI0P+88kfqfkuys4q7bm+OimCpuTDevZUpFTgwqP6H3TmGHmT
	2V4ryvlf9lQjaYy9vHL2z8TDb8ZqVTs4tjO+M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ezT/6p16F5WN4/7gJkybE96Jp1sgpVOt
	6sNQCh0W8vRSTK/uRNX2w1kyBzexhl5Q78xiW2KRu2SrMoHWtGNinrRTC624vEsg
	F+qeyOeJ44EBGK7i0uXvIDACuTam+DGuebzlSydqyoOeEi9YK924ljvBDZrgP3GI
	XVqeNi8M+es=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E4A7823FDF;
	Wed,  2 Jul 2014 16:06:31 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 064DC23FD6;
	Wed,  2 Jul 2014 16:06:26 -0400 (EDT)
In-Reply-To: <xmqq7g3vh6h1.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Wed, 02 Jul 2014 13:05:14 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 596D1090-0224-11E4-A175-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252837>

Junio C Hamano <gitster@pobox.com> writes:

> It tests that "clean -d" is happy if a blind rmdir(2) removes the
> directory.  If it fails for whatever reason (e.g. add "exit(0)" at
> the beginning of cmd_clean(), for example) to remove the directory,
> we do leave an empty unreadable directory behind.
>
> But as long as that directory is empty, that will not cause us to
> remove the trash directory at the end, so we should be OK.

s/remove/fail to &/; sorry for the noise.
