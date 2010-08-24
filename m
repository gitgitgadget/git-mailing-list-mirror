From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] git-merge: ignore space support
Date: Tue, 24 Aug 2010 12:01:32 -0700
Message-ID: <7vsk23u96b.fsf@alter.siamese.dyndns.org>
References: <20100823205915.GA4484@ns1.cockos.com>
 <20100824022820.GE17406@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Justin Frankel <justin@cockos.com>, git@vger.kernel.org,
	eyvind.bernhardsen@gmail.com,
	Bert Wesarg <bert.wesarg@googlemail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 24 21:02:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Onykt-0003HW-O7
	for gcvg-git-2@lo.gmane.org; Tue, 24 Aug 2010 21:01:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755147Ab0HXTBq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Aug 2010 15:01:46 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:40936 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755138Ab0HXTBp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Aug 2010 15:01:45 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D9BC7D0B2A;
	Tue, 24 Aug 2010 15:01:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=8HdtYmBmzFKUHNiaJJlNozShEUE=; b=lpRV5mV5tvZdZEBTwC66Qy2
	uvphLO7wZZCitjkrurVkcrfecWNWndxhzc0NTwK9K8WX4iscbbd0FbtAqcYcxk9K
	FBsQDq2j8gsJyoyKv/SxI3QMeFx3ZXnmx3ecOpgcsLU644sbUu+NprszJrYV22cj
	AkKSyaJBRgIEZFH/9hsM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=gtbZ7vgduURHU+o3M82FKTI3szTzL0Ffnnxenl+UxZRc10D6U
	G0QaAKpyZ4HT+9Qz1sznobTTQQ2k8rFCjEDPYoG+MkMU8rb5SbX7YT/gYC1bVGI/
	MuIhZuMVUv6pK2MaoXdz65SENYSEeHfpMFuOWJbbv+MsObby/5gNlWhEqI=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 85F9DD0B24;
	Tue, 24 Aug 2010 15:01:39 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8E82ED0B21; Tue, 24 Aug
 2010 15:01:33 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 06A8DE48-AFB2-11DF-AE5F-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154337>

Jonathan Nieder <jrnieder@gmail.com> writes:

> The flag layout worries me a bit because presumably the next extension
> would get bit 8, and so on.  What happens if xdiff learns another
> whitespace-ignoring mode?
> ...
> This function (like its cousin create_ll_flag) is ugly, as Bert
> noticed before.  I am starting to wonder if it would not be simpler
> to use
>
>  extern int ll_merge(..., const struct ll_merge_options *opts);
>
> treating NULL as a request for the default options.
>
> In other words, how about something like this?

Sounds like a good direction to go.
