From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] add: don't complain when adding empty project root
Date: Thu, 26 Dec 2013 10:54:43 -0800
Message-ID: <xmqqtxdvcuj0.fsf@gitster.dls.corp.google.com>
References: <CAEcj5uWHpem+5os+3Mc_a42pk6f30i4UiV=LRPdXkoqiy1jQ_w@mail.gmail.com>
	<1387789361-29036-1-git-send-email-pclouds@gmail.com>
	<20131226172542.GS20443@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org, tfnico@gmail.com
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 26 19:55:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VwG5U-0001jq-4H
	for gcvg-git-2@plane.gmane.org; Thu, 26 Dec 2013 19:55:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753629Ab3LZSyt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Dec 2013 13:54:49 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34087 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753496Ab3LZSys (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Dec 2013 13:54:48 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C7E785A35D;
	Thu, 26 Dec 2013 13:54:47 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=bBues0lH/BrFAbmRYAHeCU9r23Y=; b=S3BUDa
	B2DF1w6uwKYh10wxmbeV9LbjcEsoygyMOVgc0V+HNnrQ563jKaucBsX9mCf/Vh5k
	e6FNkTzJoqxkHwnU5aPUEVoIgJaAWls3IpaG4coz4/s2Tw9df1/SKBNeT8f5gwhS
	SS/0jFNISERkfBYNEIImHbjsMZsqlF4vYv9WE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pidcJKJegzEBA8cKgMPfT3MQPXu09q4g
	nOJOvwvSFEFus2XNYOUvHSRnurhqjDLP8yDBhdfCUNO74hT8hqi65oVsULwSDgOo
	/gC9mFkybg3JNlq+djQw6EYHQn6qkue8IpYPnBOAld5s5djWhGKUSl9OAwMdoPlr
	tlE2mgTB2J4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BA6515A35C;
	Thu, 26 Dec 2013 13:54:47 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2AE0D5A35B;
	Thu, 26 Dec 2013 13:54:47 -0500 (EST)
In-Reply-To: <20131226172542.GS20443@google.com> (Jonathan Nieder's message of
	"Thu, 26 Dec 2013 09:25:42 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 30DAC680-6E5F-11E3-B1DD-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239705>

Jonathan Nieder <jrnieder@gmail.com> writes:

> How about something like the following, for squashing in?
>
> With or without the tweaks below,
> Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks, both.

Regarding "git add --refresh" (no other arguments), it would say
"Nothing specified, nothing added.", and that is unrelated to the
breakage reported and fixed in this thread, I think.  It is the same
message "git add" (no other arguments) gives, which I think is a
mistake.  "git add --refresh" is like "git add -u" in that the
affected paths are determined by the index, and running these
commands while your index is still empty can just be a silent no-op.
