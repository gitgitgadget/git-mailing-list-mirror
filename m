From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git reset and ctime
Date: Fri, 03 Dec 2010 18:28:00 -0800
Message-ID: <7v62vaxoen.fsf@alter.siamese.dyndns.org>
References: <AANLkTimyYTup+PqJFJ+2g-tVwWXA2bxTT3noonEuKBSu@mail.gmail.com>
 <20101204005131.GB15906@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: ghazel@gmail.com, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Dec 04 03:28:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1POhrF-0002mi-Nu
	for gcvg-git-2@lo.gmane.org; Sat, 04 Dec 2010 03:28:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754137Ab0LDC2K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Dec 2010 21:28:10 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:64287 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752084Ab0LDC2J (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Dec 2010 21:28:09 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 5B2223A27;
	Fri,  3 Dec 2010 21:28:30 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4TXo8C2dXxo/tdJ/Z0YF0dhe1VU=; b=RV8hJs
	Kzw8HvmU8zt7PJD7C9wx0Ehafdq82VGQBibvBooXibb9WjWY6ydzyTB4o7Xsq+pr
	gM0v0LL22gIlJoOW1QoZHlPrTvi84Q8LJs3WVhxXIih7IdZIZS18w+7v1MgbeSdT
	HCVj6e+LxVqTqWyjBS+VVJs3pN4badUXZrTIw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=sIfQ2HDYOhe8lsdyqr+gMM7hDBO/73+y
	pCY0oErRivqTPPJlnJb2vkR2skMCutmx5ujjIAdcy53x6fXSYS149XYWmvYOeWb7
	7kmOlFQikryS9tUNRX4ah4FB/Qt6IptSFsvk96l5B8M3l1ZPivwi1hJxyT+G2z9A
	ySkbDJVAIJs=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 2A8333A26;
	Fri,  3 Dec 2010 21:28:27 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 197333A25; Fri,  3 Dec 2010
 21:28:22 -0500 (EST)
In-Reply-To: <20101204005131.GB15906@burratino> (Jonathan Nieder's message of
 "Fri\, 3 Dec 2010 18\:51\:32 -0600")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 2CF757BE-FF4E-11DF-BFAB-CDEAE6EC64FC-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162881>

Jonathan Nieder <jrnieder@gmail.com> writes:

> That said, I have no strong objection to an implicit refresh in "git
> reset" (performance-sensitive scripts should be using read-tree
> directly anyway).  Have you tried making that change to
> builtin/reset.c?  How does it perform in practice?

I would be more worried about correctness impact such a patch may make
when the index contains unmerged entries.
