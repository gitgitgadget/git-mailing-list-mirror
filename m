From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] mailsplit.c: remove dead code
Date: Tue, 12 Aug 2014 14:38:45 -0700
Message-ID: <xmqqvbpx4cd6.fsf@gitster.dls.corp.google.com>
References: <53EA430E.8050905@web.de>
	<1407878487-23530-1-git-send-email-stefanbeller@gmail.com>
	<vpqy4utz8x5.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stefan Beller <stefanbeller@gmail.com>, l.s.r@web.de,
	git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Aug 12 23:38:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XHJmV-00033M-3d
	for gcvg-git-2@plane.gmane.org; Tue, 12 Aug 2014 23:38:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752479AbaHLViz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Aug 2014 17:38:55 -0400
Received: from smtp.pobox.com ([208.72.237.35]:62239 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752456AbaHLViy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Aug 2014 17:38:54 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 3318E31289;
	Tue, 12 Aug 2014 17:38:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=m/Ln7NPDCYOu+ASc9ey4ttpNLSo=; b=ZgS+uy
	iSlbYjAbzeYZ1qmpq9yIpCSszzP8mrIvIcykSntHxHczIkVtUbF/aEW0HlaFK8iG
	PqMgy5e590fJWWrFxjgCY5ycMH+XoTG3LZmXAmxBxnf1Z1lhKa3X82H1Ob292An/
	WUNaTLREMR75Hmyuq55s+Q4iqzx6mKkCmU5EE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=w3HfbihQXRA8XHTr0jBiWnmCYHcrZrp1
	PkdX38ec/luCpF92ts0axDhgEqpp9f+XVi3enNLXlC1SbtUG4VH4iYYtVtRfOLB8
	OZ7dl45N8LqQZFgZ+g5zc03IO2ALN5Xdlhc0EC50D45yJIZvFCYiKIO7GmOmQZtL
	Nn9k7Cnw4ic=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 2A22331288;
	Tue, 12 Aug 2014 17:38:54 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 3105A31282;
	Tue, 12 Aug 2014 17:38:47 -0400 (EDT)
In-Reply-To: <vpqy4utz8x5.fsf@anie.imag.fr> (Matthieu Moy's message of "Tue,
	12 Aug 2014 23:37:26 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 0A9092CA-2269-11E4-89E3-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255168>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Stefan Beller <stefanbeller@gmail.com> writes:
>
>> +	if (is_bare && !allow_bare) {
>> +		unlink(name);
>> +		fprintf(stderr, "corrupt mailbox\n");
>> +		exit(1);
>> +	}
>
> Not directly related to your patch, but shouldn't this be using
>
> die(_("corrupt mailbox"));
>
> instead?

Doesn't the exit status of mailsplit matter to its existing
invokers?
