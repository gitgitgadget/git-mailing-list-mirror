From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 08/14] trailer: add tests for "git interpret-trailers"
Date: Thu, 06 Feb 2014 16:11:56 -0800
Message-ID: <xmqqeh3fwzlf.fsf@gitster.dls.corp.google.com>
References: <20140206194123.325.99451.chriscool@tuxfamily.org>
	<20140206202004.325.20315.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Johan Herland <johan@herland.net>,
	Josh Triplett <josh@joshtriplett.org>,
	Thomas Rast <tr@thomasrast.ch>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Greg Kroah-Hartman <greg@kroah.com>, Jeff King <peff@peff.net>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Fri Feb 07 01:12:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WBZ36-0001vl-O9
	for gcvg-git-2@plane.gmane.org; Fri, 07 Feb 2014 01:12:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751463AbaBGAMA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Feb 2014 19:12:00 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64377 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750968AbaBGAL7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Feb 2014 19:11:59 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2BB266A28D;
	Thu,  6 Feb 2014 19:11:59 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=nJwT5H+51devIZzvpgxWdleH7hs=; b=pxhxAk
	7fp7i1dovHVfCUV5MzVJSk14iEtXy77j6WLyleoTRTllzulEIRtr11QVNiZ4Zg+7
	d7gkhgCqYJEVj891jRC+kMuL2mlMrdnu7QQgCei9hDLMbHKt8oDxJXvlH+/2DA1H
	vImH8nwVhEaoiUKb9vkVI6CezrLRA18ivRhBE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rxWv/aWWr5pm5Jg3VzaLOtK+3E645iCs
	BUIikm05FV1oES2HOVoYSZMK+2mCIeWkWPCUbK2z9ZhLjQYT9HegcZhF+Shm9a0k
	G2TbsMm4lg5JUoRiI8j5g8gfruQhUmiSVBzr7CR0z/O8T3EgXibLm5mbxisIWiN7
	sQl/O64jRZo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 158956A28C;
	Thu,  6 Feb 2014 19:11:59 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5365D6A28B;
	Thu,  6 Feb 2014 19:11:58 -0500 (EST)
In-Reply-To: <20140206202004.325.20315.chriscool@tuxfamily.org> (Christian
	Couder's message of "Thu, 06 Feb 2014 21:19:57 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 75B4E774-8F8C-11E3-90A6-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241753>

Christian Couder <chriscool@tuxfamily.org> writes:

> +
> +cat >basic_message <<'EOF'
> +subject
> +
> +body
> +EOF
> +
> +cat >complex_message_body <<'EOF'
> +my subject
> +
> +my body which is long
> +and contains some special
> +chars like : = ? !
> +
> +EOF
> +
> +# We want one trailing space at the end of each line.
> +# Let's use sed to make sure that these spaces are not removed
> +# by any automatic tool.
> +sed -e 's/ Z$/ /' >complex_message_trailers <<-\EOF
> +Fixes: Z
> +Acked-by: Z
> +Reviewed-by: Z
> +Signed-off-by: Z
> +EOF

Please put things like these inside the first "setup" test.
