From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/4] rebase -i: add ack action
Date: Mon, 11 Apr 2016 12:48:22 -0700
Message-ID: <xmqqlh4krkop.fsf@gitster.mtv.corp.google.com>
References: <alpine.DEB.2.20.1604111736060.2967@virtualbox>
	<20160411184535-mutt-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, bafain@gmail.com, sunshine@sunshineco.com
To: "Michael S. Tsirkin" <mst@redhat.com>
X-From: git-owner@vger.kernel.org Mon Apr 11 21:48:34 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aphp0-0007Tm-Hn
	for gcvg-git-2@plane.gmane.org; Mon, 11 Apr 2016 21:48:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750971AbcDKTsZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Apr 2016 15:48:25 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:53341 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750719AbcDKTsZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Apr 2016 15:48:25 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1F41454F3C;
	Mon, 11 Apr 2016 15:48:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=BgCtfbnAI3Iz8v+zfJLMfzJic2c=; b=JHgkK6
	S9O/hJazUa9B/7mLnm4Va6zgqs/MPkN/8x+HE+IdmsQlYvO/DRG5xQrq/fuFj+77
	PrkEq5xJGi9FZhDJ8At+MOOiGSOus3HcyXxdrIEbGQyujmIp7K8NubsvoM3aRZF7
	3a1wROvrmgaEWUf23eHMrOf0G0DpBp+PRHr7E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ozLN6PiNu9Q5BmHc4iPHphxcw0X5v67a
	BQa44zGn6yG8yAQC1209sL0ZJ3qt9bNA3Wkszv5oRW5iZH/FmEdeDvLlVHt/z3aC
	la5xq0yJIGaOlJN/xKF1pAh0MzCj4jYVmRy6ySOtNpkVMFAIJkgN2V5oo8uwT3VC
	01JO9ND9cBI=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 16AEF54F3B;
	Mon, 11 Apr 2016 15:48:24 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 830DB54F3A;
	Mon, 11 Apr 2016 15:48:23 -0400 (EDT)
In-Reply-To: <20160411184535-mutt-send-email-mst@redhat.com> (Michael
	S. Tsirkin's message of "Mon, 11 Apr 2016 19:41:49 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 59C04716-001E-11E6-A8F2-45AF6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291230>

"Michael S. Tsirkin" <mst@redhat.com> writes:

> Repost, sorry about the noise.
>
> On Mon, Apr 11, 2016 at 05:36:45PM +0200, Johannes Schindelin wrote:
>> Hi Michael,
>> 
>> On Mon, 11 Apr 2016, Michael S. Tsirkin wrote:
>> 
>> > So far I only see examples of adding footers. If that's all we can think
>> > up, why code in all this genericity?
>> 
>> Because as far as I can see, the only benefitor of your patches would be
>> you.
>> 
>> Ciao,
>> Johannes
>
> This seems unlikely.  Just merging the patches won't benefit me directly
> - I have maintained them in my tree for a couple of years now with very
> little effort.  For sure, I could benefit if they get merged and then
> someone improves them further - that was the point of posting them - but
> then I'm not the only benefitor.
>
> The workflow including getting acks for patches by email is not handled
> well by upstream git right now.  It would surprise me if no one uses it
> if it's upstream, as you seem to suggest.  But maybe most people moved
> on and just do pull requests instead.

I doubt I would use this in its current form myself.

Patch series I receive are all queued on their own separate topic
branches, and having to switch branches only to create a fake empty
commit to record received Acked-by and Reviewed-by is a chore that
serves only half of what needs to be done.  Once I decide to switch
back to the topic branch after receiving Acked-by and Reviewed-by,
I'd rather "rebase -i" to directly record them at that point, with
"reword".

If the "trailers" stuff is packaged into an easier-to-use format to
use with "git commit --amend", I may use that together with "exec"
to automatically add these while doing so, but again, I do not see
any need for fake empty commits out of received e-mails in the
resulting workflow.

That does not at all mean nobody other than Michael would use it,
though.
