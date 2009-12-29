From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH RFC v2] builtin-push: add --delete as syntactic sugar for
  :foo
Date: Tue, 29 Dec 2009 08:58:29 -0800
Message-ID: <7vvdfpg1je.fsf@alter.siamese.dyndns.org>
References: <20091109130935.2bea7771@perceptron>
 <7v8wefy6pi.fsf@alter.siamese.dyndns.org>
 <20091109192044.605e50ba@perceptron>
 <20091229200523.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jan =?utf-8?Q?Kr=C3=BCger?= <jk@jk.gs>,
	Git ML <git@vger.kernel.org>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Tue Dec 29 17:58:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NPfPF-0004fR-Ou
	for gcvg-git-2@lo.gmane.org; Tue, 29 Dec 2009 17:58:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752183AbZL2Q6l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Dec 2009 11:58:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752110AbZL2Q6l
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Dec 2009 11:58:41 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:58296 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751916AbZL2Q6k (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Dec 2009 11:58:40 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 04E1A8C530;
	Tue, 29 Dec 2009 11:58:40 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=3/L+e7FPs7gzLuhI5ZFFCzclv88=; b=Sy89Wv7ie8WxlzvSG2gBZfE
	YYXAzHrp+mqpDXsG3LosbxPuYryAWojywZYA6vHEpfGf5Z8vTzdPYXhwuF1FNoHs
	q8Mcc4ZaVBv02eCTMg5LmgXn5yHzBdwDjBNt9lFWF9pWHXIMXaPRHOMg29Rh2Jag
	CMxMoDtSaLYOkHw8XlhA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=nZ+/ztHO9L9wXrpuVdC/Q5ZIzHBQGIyhZCjJH1ahWcJp446OE
	IbiKxn/uUQX1sMzRn6HT9XDOjYIrT7/6lK/jJh/P9fADB0MlOboHYSAKPA1ilnX4
	utAmn6YEDDNAGDXskXf5P6FAMRlHsNm9v+2ri/RnyFA5O/hmWucRc7u88A=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B8B368C52F;
	Tue, 29 Dec 2009 11:58:35 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CBFC88C52E; Tue, 29 Dec
 2009 11:58:30 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 67422C3C-F49B-11DE-B2B3-9D59EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135812>

Nanako Shiraishi <nanako3@lavabit.com> writes:

> Junio, could you tell us what happened to this thread?
>
> The patch implements "git push repo --delete branch" and rejects
> --delete used with other options like --all and --tags, as suggested in
> the initial review.  I think it makes sense, but nothing happens after
> that.

Sverre cited an old discussion and the discussion stalled.  I just re-read
the thread, and think the "this is a wrong idea" objection was primarily
about allowing --delete with non-delete kinds of refspecs, so in that
sense Jan's patch is a perfected form of the Sverre's patch from that old
discussion.

As a summary of the lesson learned and concensus from the old discussion,
I agree with this from Sverre:

  http://article.gmane.org/gmane.comp.version-control.git/125901

namely, (1) barf and abort if src:dst is given; (2) touch only refs given
from the command line, "push there --delete" without any refspec is an
error; (3) be careful about "git push there tag v1.0.0" form.

So if Jan or Sverre want to resurrect the topic, I am all for it.
