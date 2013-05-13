From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/6] stash: introduce 'git stash store'
Date: Mon, 13 May 2013 08:49:42 -0700
Message-ID: <7v61ymop61.fsf@alter.siamese.dyndns.org>
References: <1368449154-21882-1-git-send-email-artagnon@gmail.com>
	<1368449154-21882-5-git-send-email-artagnon@gmail.com>
	<7vbo8fosd9.fsf@alter.siamese.dyndns.org>
	<CALkWK0kMj6q1rppzfxGWrthub4K_+C+jnvF=K4m2Fhk0pAnt7A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 13 17:49:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ubv0X-0007oh-JY
	for gcvg-git-2@plane.gmane.org; Mon, 13 May 2013 17:49:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754581Ab3EMPtp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 May 2013 11:49:45 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61811 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751643Ab3EMPto (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 May 2013 11:49:44 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6A8121E8CC;
	Mon, 13 May 2013 15:49:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Mo5d+SDcwqd8wiZyI+Gkv7LmMDw=; b=fiwGkp
	a0jNS/hc+kVKrewkcfi8VWR80AfK17KGkVzOgjfWyErG7b4GDyXGmWM3V1Hh+0QD
	AjS8/g8G5cZk+3zm7Ue98qmurfkt06sVY5aUc4fO6EEh8ValbeRoDfc7XPot8U6K
	0TDF1u7nnMw7wKCmSxCDsbxmbT0yno+0Nf3AM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=iFW+Jl37XjE8u4vBFx+Yyqyu7VYYMWdP
	fqEWV4u56FpAe6nKVYlQYtznRueCDXYBXyKC5v6FXCbY1ewZz/4Fg5hFGVHQzA5o
	Jixnh/71gVX+hCdO2tjDmOFonsXlrMd3OidR9NDlYELP+LsU/l1kimlfQOQBDuDz
	hDQe755p3is=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 620301E8CB;
	Mon, 13 May 2013 15:49:44 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C82781E8CA;
	Mon, 13 May 2013 15:49:43 +0000 (UTC)
In-Reply-To: <CALkWK0kMj6q1rppzfxGWrthub4K_+C+jnvF=K4m2Fhk0pAnt7A@mail.gmail.com>
	(Ramkumar Ramachandra's message of "Mon, 13 May 2013 20:32:38 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BAF7ACB2-BBE4-11E2-B163-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224174>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Junio C Hamano wrote:
>>  - The error message store_stash() gives should not be hardcoded in
>>    that function.
>>
>>    Save-stash may want to keep saying 'the current status' as it
>>    said before, but a caller like your rebase-autostash will not be
>>    saving the "current" status and would want to have a different
>>    message.
>
> Makes sense.

I think it is fine to have a "default" message to be used when
store_stash shell function is not given an optional error message.

The command line for it may become:

	git stash store [-m <message>] [-e <error message>] $stash_sha1

or something like that.
