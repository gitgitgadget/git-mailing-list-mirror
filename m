From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Configuring a third-party git hook
Date: Thu, 20 Mar 2014 09:53:18 -0700
Message-ID: <xmqqwqfozu9t.fsf@gitster.dls.corp.google.com>
References: <CAPTjJmomAnrjjyfSvDJijBP2pUN_kqVCRr+UbZkQHQy295A85A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Chris Angelico <rosuav@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 20 17:53:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQgDg-0000rA-Dw
	for gcvg-git-2@plane.gmane.org; Thu, 20 Mar 2014 17:53:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752354AbaCTQxY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Mar 2014 12:53:24 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56075 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750960AbaCTQxY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Mar 2014 12:53:24 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9557D74353;
	Thu, 20 Mar 2014 12:53:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=YDfqhS9bf6h7xc0KOx9yoylcys4=; b=L8czLA
	Jcy0gSnTxl133FmtoXmkgpIt5sVXxLR1S35Gv+5qaevpX995U2ofaT2VsyZBcyD4
	4trUUtBSLekhE35ouA2Jp5gsgaam83hXdGp71vbTM/adAX/2eW0pV4a3tj5cyCI0
	c3zh4wLSboFtez6UxFg6Gd9Ef82dyVCGkHP6Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=N8D5u9UMN/IYi+Q3paJ58OmZ0iQi01Y5
	GUykiE+L+gf6PE5a+PH29O949XsClhAIyt4jQ4rm3HHIzYgStGhgGb3JtJWTwX9l
	eCQf5e349APihqwXZYQk5ubF0aC32ANlZGKEQqjFuGb+IsytSSDJ+C3E06Gk+S0d
	23e8SzXuyiw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 84C6374352;
	Thu, 20 Mar 2014 12:53:23 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C2F4E74350;
	Thu, 20 Mar 2014 12:53:22 -0400 (EDT)
In-Reply-To: <CAPTjJmomAnrjjyfSvDJijBP2pUN_kqVCRr+UbZkQHQy295A85A@mail.gmail.com>
	(Chris Angelico's message of "Wed, 19 Mar 2014 22:16:51 +1100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 25B9EBE0-B050-11E3-9C8A-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244557>

Chris Angelico <rosuav@gmail.com> writes:

> file. It doesn't really care about the full history, and wants to be
> reasonably fast (as the user is waiting for it). It's just a
> convenience, so correctness isn't a huge issue. The easiest way to
> keep it moving through quickly is to limit the search:
>
> $ git log ...other options... HEAD~100 some-file.pike
>
> The problem with this is that it doesn't work if HEAD doesn't have 100
> great-great-...-grandparents

Did you really mean that you are *not* interested in what happened
to the most recent 100 commits?  Or is it a typo of "HEAD~100.."?

"git log -100" should traverse from the HEAD and stop after showing
at most 100 items, even if you only had 20 in the history.
