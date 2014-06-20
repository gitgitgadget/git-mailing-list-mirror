From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 2/2] cleanup duplicate name_compare() functions
Date: Fri, 20 Jun 2014 10:15:27 -0700
Message-ID: <xmqqpphw7k4y.fsf@gitster.dls.corp.google.com>
References: <1403230004-11034-1-git-send-email-jmmahler@gmail.com>
	<1403230004-11034-3-git-send-email-jmmahler@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Jeremiah Mahler <jmmahler@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 25 23:30:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WzulV-00059j-13
	for gcvg-git-2@plane.gmane.org; Wed, 25 Jun 2014 23:30:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755848AbaFYV35 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jun 2014 17:29:57 -0400
Received: from smtp.pobox.com ([208.72.237.35]:63353 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755734AbaFYV34 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jun 2014 17:29:56 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D56BB21E11;
	Wed, 25 Jun 2014 17:29:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 s=sasl; bh=Q6BPGx6gt5Sy8TetbVKJvv8KAS4=; b=P14Ka5iKk14VD/8+N1Xo
	oEVSImCzt1V2KPF09XC3suTYhRmJQ+rgefmK/jayJh/WJup4/oaVG067UJ6oOrzu
	XljA5l24ywapW4yUgOIWw7fbJCKuluVAKo52MqHE8tEWDUMMAk2mRkLDsTshqzE2
	qnU5rNB2Hv3k1UA4X0ld7AY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=ITwzhHt2e2PMXg/TTBbLUkoQ4gz6FiP112dHnQtzbFXwwa
	FqSr4o9nSn8WbzcuxIJoVI03xyVZ5CtB6T4AD5AMTuZH9tfJ5U2t/IAjm07FAK81
	kkZ/qWl+UxQtIaAh9eeHmWsXiD6D0FHPHly5KxKtnwzGraFZR1FDo2cIYpK5Y=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id CBF2E21E10;
	Wed, 25 Jun 2014 17:29:49 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 6705B21E08;
	Wed, 25 Jun 2014 17:29:44 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: D336D61A-FCAF-11E3-87A9-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252464>

Jeremiah Mahler <jmmahler@gmail.com> writes:

> We often represent our strings as a counted string, i.e. a pair of the
> pointer to the beginning of the string and its length, and the string
> may not be NUL terminated to that length.
>
> To compare a pair of such counted strings, unpack-trees.c and
> read-cache.c implement their own name_compare() functions identically.
> In addition, the cache_name_compare() function in read-cache.c is nearly
> identical.  The only difference is when one string is the prefix of the
> other string, in which case the former returns -1/+1 to show which one
> is longer and the latter returns the difference of the lengths to show
> the same information.

I think I got the former/latter swapped by mistake when I wrote this
(two name_compare() give us the difference, and cache_name_compare()
gives -1/+1); I'll spell their names out when I queue this patch.

Thanks.
