From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] credential-cache--daemon: change to the socket dir on startup
Date: Tue, 23 Feb 2016 13:06:10 -0800
Message-ID: <xmqqfuwjyw59.fsf@gitster.mtv.corp.google.com>
References: <20160223071427.GA7489@sigill.intra.peff.net>
	<20160223071604.GC8395@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jon Griffiths <jon_p_griffiths@yahoo.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Feb 23 22:06:22 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYKA1-0004vF-KT
	for gcvg-git-2@plane.gmane.org; Tue, 23 Feb 2016 22:06:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755419AbcBWVGQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Feb 2016 16:06:16 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:65453 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755279AbcBWVGN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Feb 2016 16:06:13 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 2815F460AF;
	Tue, 23 Feb 2016 16:06:12 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=JgvHjl3rT+hNMHsnA/d6nlQn4QU=; b=ZaDtSZ
	s2DdrejFsfMMPP13aNwcuwIqLx8EVHWgl40QEaIJOUV1ZdGM1WIrhI4InIjx1tOL
	XGJU1wSIY7Xumj5m/2jL+jK96N6IPq3bSLwmdqvsbLJBGRviu16dZziyvuigduVg
	q68Fw0g6xL7o4UbimZ7RBqPVDME7cmaRsHKFE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NGOr5bb+oWwhX2T3SmpUbDKFfsqO97CH
	0xW7KQPZqxTjmBGQ02wlY5v9pW5Ne3xPxGutle6ULTOLsztdXpvrqWO84LEJMmcO
	/qfcPTh7HoR8vutOYSdsoR2iw6C3ESyLDOlk2/4FWDQBYO919ZOvQnKRQKtAYDqC
	75DrEZo65Y4=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 20252460AE;
	Tue, 23 Feb 2016 16:06:12 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 91015460AD;
	Tue, 23 Feb 2016 16:06:11 -0500 (EST)
In-Reply-To: <20160223071604.GC8395@sigill.intra.peff.net> (Jeff King's
	message of "Tue, 23 Feb 2016 02:16:04 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 44431E22-DA71-11E5-8CC4-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287122>

Jeff King <peff@peff.net> writes:

> +	/*
> +	 * We don't actually care what our cwd is; we chdir here just to
> +	 * be a friendly daemon and avoid tying up our original cwd.
> +	 * If this fails, it's OK to just continue without that benefit.
> +	 */
> +	chdir(dir);

I fully do agree with this comment, but my copy of gcc and system
headers doesn't, unfortunately.

credential-cache--daemon.c: In function 'init_socket_directory':
credential-cache--daemon.c:245:7: error: ignoring return value of 'chdir', declared with attribute warn_unused_result [-Werror=unused-result]
  chdir(dir);
       ^
cc1: all warnings being treated as errors
make: *** [credential-cache--daemon.o] Error 1
