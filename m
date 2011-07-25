From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] commit: allow partial commits with relative paths
Date: Mon, 25 Jul 2011 12:32:29 -0700
Message-ID: <7v4o2arwaa.fsf@alter.siamese.dyndns.org>
References: <CAOnWdohKfwEOMx=wr_PKiW+ucYBK2ZWykm_7dqr7hy4xGRM02A@mail.gmail.com>
 <19b908142567fcfafe4da3d0fd60b134d30c613a.1311579663.git.git@drmicha.warpmail.net> <7v8vrmrxok.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Reuben Thomas <rrt@sc3d.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon Jul 25 21:32:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QlQtL-0000zg-Ol
	for gcvg-git-2@lo.gmane.org; Mon, 25 Jul 2011 21:32:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752731Ab1GYTcf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Jul 2011 15:32:35 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44908 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751666Ab1GYTce (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jul 2011 15:32:34 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6F4F64215;
	Mon, 25 Jul 2011 15:32:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=HcLElDVaSnUDzUwOHB7JyV5N4lI=; b=JcMPfn
	IBeda8Ogbft4F/+yfmlf9WmqykTTsaupAa+f/hkjF7TQj1mAgs14/CiIOakMbjji
	MqV7r+Rq4H4akjAm2SCo9cNWddYF9mm7m1ciEeeyjP8ITia2kWH+ZrIfljVuL8Ym
	yzOdjHfzR0fGdakUZEPw7pdm2DTXD4kJjWoto=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=weck+jvxIaNDHZ7GloXJo0T93861qsSZ
	yxSJzA/hVd5ZojAeHYvnbbfLG+03+63CiaawyE+4SBfRvX52Et0y/KklGjLgcT/1
	HVTnTZz+N/tH4YzIbntJO1F+XqKcFk9fBUb2t39ISSZhVHEmCoREnohTU/k7p+a4
	tmrT1+hkejY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 661AD4214;
	Mon, 25 Jul 2011 15:32:31 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CD2954210; Mon, 25 Jul 2011
 15:32:30 -0400 (EDT)
In-Reply-To: <7v8vrmrxok.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Mon, 25 Jul 2011 12:02:19 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D68648AE-B6F4-11E0-A100-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177809>

Junio C Hamano <gitster@pobox.com> writes:

> Michael J Gruber <git@drmicha.warpmail.net> writes:
>
>> RFC because lack of test, and also because I'm not sure we want this, and
>> what to do about git add which has the same problem, but would need a
>> different fix.
>
> The reason you doubt we would want *this* is...?  Also what is the "same
> problem"?
>
> Perhaps it would become clearer if you supported *this* with a sample
> workflow?

Having said that, I think your change to avoid restricting the overlay to
the current subdirectory makes sense, as long as we allow paths outside
the current subdirectory to be given to the command. I suspect that this
call was relied on an earlier behaviour to error out when paths outside
the current directory were given to the command.

Although I do not know offhand if there are other places in the codepath
with the same issue (i.e. for whatever reason they do not expect to be fed
a relative path, and were relying on the early abort), I think what
your tries to do is taking us in the right direction.
