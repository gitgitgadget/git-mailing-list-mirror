From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-p4: Avoid modules deprecated in Python 2.6.
Date: Wed, 26 Aug 2009 11:14:06 -0700
Message-ID: <7vhbvucuj5.fsf@alter.siamese.dyndns.org>
References: <1251305536-25887-1-git-send-email-reillyeon@qotw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Reilly Grant <reillyeon@qotw.net>
X-From: git-owner@vger.kernel.org Wed Aug 26 20:14:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MgN0r-000345-Qe
	for gcvg-git-2@lo.gmane.org; Wed, 26 Aug 2009 20:14:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752575AbZHZSOQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Aug 2009 14:14:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752539AbZHZSOQ
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Aug 2009 14:14:16 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:46803 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752437AbZHZSOP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Aug 2009 14:14:15 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 21FD919AEA;
	Wed, 26 Aug 2009 14:14:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ZGp6XyFPNvGFmXZ4RIdWSEIcB2k=; b=snyQPY
	Zfu2An414T2qNn2SXd9kXcAFo2RgB+eIGeX7N+zI5G6jr5yxuGjDtM8Sf0XSlqtx
	5r34Uf7LSpX5rguvQXDQ5otVF/DsF0YH8MB+4w/5IHIdCFAd+1pWGzg73F59Kwi4
	T8MJ8x0lBZDNJOTh4bDGkFOmEaNVGB0/njjRE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nf35WRGvEQUZ5TPktAtwKztZjHb9vSJH
	o+aCHFvG52awxRjVMYxBdRco7/hka4gavmEIppGX66Bkw/CnATyvWUoJ0JEBVodH
	CgbukIB2MhDGIiBKJh9eYNk3PAM4dJZjWLPMseFx/Poj5uiijcKqIOQpe7CIh7LS
	3OmC9fn2AH8=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id EAB8519AE5;
	Wed, 26 Aug 2009 14:14:10 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4810D19AE3; Wed, 26 Aug
 2009 14:14:08 -0400 (EDT)
In-Reply-To: <1251305536-25887-1-git-send-email-reillyeon@qotw.net> (Reilly
 Grant's message of "Wed\, 26 Aug 2009 09\:52\:16 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 40D07BA8-926C-11DE-8B09-CA0F1FFB4A78-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127111>

Reilly Grant <reillyeon@qotw.net> writes:

> The popen2, sha and sets modules are deprecated in Python 2.6 (sha in
> Python 2.5).  Both popen2 and sha are not actually used in git-p4.
> Replace usage of sets.Set with the builtin set object.

Does the code already rely on a feature not found in Python older than 2.4
before your patch?  Otherwise I would have liked to see the last sentence
like this:

    Replace usage of sets.Set with the builtin set object, which has
    been available since Python 2.4.

    This change makes the script unusable with Python older than 2.4,
    which was released in 2004. Hopefully nobody uses ancient 2.3.

So that I did not have to check myself to get a feel of how safe this
change is.
