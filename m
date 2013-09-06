From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/5] branch: Fix --track on a remote-tracking non-branch
Date: Fri, 06 Sep 2013 10:29:34 -0700
Message-ID: <xmqq1u51zwn5.fsf@gitster.dls.corp.google.com>
References: <1378464042-17476-1-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Per Cederqvist <cederp@opera.com>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Fri Sep 06 19:29:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VHzqr-0002ir-BZ
	for gcvg-git-2@plane.gmane.org; Fri, 06 Sep 2013 19:29:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750800Ab3IFR3j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Sep 2013 13:29:39 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55776 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750762Ab3IFR3h (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Sep 2013 13:29:37 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7E2743E705;
	Fri,  6 Sep 2013 17:29:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=pRvHgrUgM/DlCCfbSa7XVKFOFQo=; b=BE/Ow8
	AfCGgPEeI8veYlzEBao0VX4Javbmfu92NZ2WjsIYE8v0QiRY630LddmhmMoiSWXv
	Rcr+K/wz8CkaqhiN94vIqLCG5NcM0MrAF01mYrGxFC9xWplB87oJOVHCm9ufm387
	RHL37hiI9sDZ4X7axKbKW3KMfBpO2W2MNRuTw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=eGGQyqZi8ckUqedqwaTUVZiYa2Da2GZX
	2mkJkWi4Na175eChVJJkQSyvHjfl9kfFzPKcRGA/+o4RSDwS/bRVhyg34E1rETg0
	pGYXjQbRXSZD1X9qBVGz3gD7v6GxpfNFFYXjAXA9HEN2DjX9uzxiNL0rRGbON66X
	rfNMEzPD9zY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6FEC23E703;
	Fri,  6 Sep 2013 17:29:36 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C3ABB3E702;
	Fri,  6 Sep 2013 17:29:35 +0000 (UTC)
In-Reply-To: <1378464042-17476-1-git-send-email-johan@herland.net> (Johan
	Herland's message of "Fri, 6 Sep 2013 12:40:37 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: E6630FBE-1719-11E3-A5EA-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234068>

Johan Herland <johan@herland.net> writes:

> However, in addition to requiring a matching remote/refspec, I also
> (for reasons that are still unclear to me) added a requirement that
> the resulting remote ref name (to be stored into branch.<name>.merge)
> must start with "refs/heads/" (see the last line of
> branch.c:check_tracking_branch()).
>
> Although it is typically the case that an upstream branch is a proper
> (refs/heads/*) branch in the remote repo (which explains why we have
> not noticed this until now), I think it is _wrong_ of Git to _require_
> this when configuring the upstream.

Yeah, I agree.
