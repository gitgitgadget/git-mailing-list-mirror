From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Find the size of git push in pre-receive hook
Date: Sun, 06 Nov 2011 21:42:37 -0800
Message-ID: <7vboso4hf6.fsf@alter.siamese.dyndns.org>
References: <1320398420796-6962141.post@n2.nabble.com>
 <7vaa8bdax2.fsf@alter.siamese.dyndns.org>
 <CAFx4vfb-ssFXFEy9We7U+5+Fi+QsbcckNOEh1eXbMiqNfkU7jQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Manigandan S <etc.mani@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 07 06:42:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RNHyp-0005rg-5e
	for gcvg-git-2@lo.gmane.org; Mon, 07 Nov 2011 06:42:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751489Ab1KGFmm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Nov 2011 00:42:42 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45912 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751227Ab1KGFml (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Nov 2011 00:42:41 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CFD2D19B7;
	Mon,  7 Nov 2011 00:42:39 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=wz3W7kWmMOQJmUp0bvGByCBZiVQ=; b=LCFuMw
	KeFajuEo85aYtnMQI0999OATLAfK+Th2VKfuoqORMSaq6YQmaU92nQuX85GlwKWw
	baxGKlFIhQJStSTIf6ik1gdAlK8ogcXE05ufKbCfCXohKMnLdSnAdD4sXQGEvvq7
	aVJqSeGJaWd9i5HoqY2V9PaCATiPoS7hQ1XU0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DbHzx2LpSRqF21HAgu9/lm5qYUcWnJcZ
	AMFmxjtMDC0H5H7rXnzLulpOpIFG1Pcx8SP8nYyb4pWXy5jy7ch09piAe6qLSrEh
	Sni1CNpnYV2SQwdjIx+QVxUAcZxf11K1We6NhCuV20s6DsKo4TZbgWc8IDBYx0a9
	e2hJZTsBODE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C086319B6;
	Mon,  7 Nov 2011 00:42:39 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5141A19B5; Mon,  7 Nov 2011
 00:42:39 -0500 (EST)
In-Reply-To: <CAFx4vfb-ssFXFEy9We7U+5+Fi+QsbcckNOEh1eXbMiqNfkU7jQ@mail.gmail.com>
 (Manigandan S.'s message of "Mon, 7 Nov 2011 10:35:05 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4DD8D420-0903-11E1-8F4F-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184949>

Manigandan S <etc.mani@gmail.com> writes:

> Let me explain it in detail, if I was not clear.

Do not top-post on this list.

You said you wanted to restrict the size of a push, but what you are
trying is to restrict the size of a repository after a push. If accepting
this push will result in your repository go over the quota, the push will
be denied. Otherwise the push will be accepted.

If that is the case, how much the resulting repository weighs is what you
are trying to measure, not the size of _this_ push, i.e. the amount of
additional data this push will introduce, and "du -s" for the repository
inside pre-receive-hook is the way to do so.
