From: Junio C Hamano <junio@pobox.com>
Subject: Re: [PATCH 1/3] t/lib-pager.sh: remove unnecessary '^' from 'expr'
 regular expression
Date: Mon, 21 Jun 2010 11:11:00 -0700
Message-ID: <7vd3vki7d7.fsf@alter.siamese.dyndns.org>
References: <__CrpvAIIX9lgHHkBLHB9fuuN7Rspzl7LFSDSwXwVCT6rYs_YOUHNMf7JZQbKaPHRl6AjsJ9dx8@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, johannes.schindelin@gmx.de,
	Brandon Casey <drafnel@gmail.com>
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Mon Jun 21 20:11:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OQlSp-0007ND-6A
	for gcvg-git-2@lo.gmane.org; Mon, 21 Jun 2010 20:11:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753646Ab0FUSLN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jun 2010 14:11:13 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:37916 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752178Ab0FUSLN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jun 2010 14:11:13 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 83E8EDC1;
	Mon, 21 Jun 2010 14:11:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=uE8sW5DujcGmTkCKxxTNyB1da84=; b=X14sxl
	fzZWYvlvoAgfxI2noQoqa68ccFfVcf4IX0Ik66Dba88FY3AOZ8C6Wk5Cxn0E+s6B
	MUve7kMug8HGZ3RftTGiRPBAG2Hk3qxLe5KDKALDMHhx1/mzUFkzDW3q0GOp0ho0
	xrWJG9OgHtQFZo7L9lv8r2OwUZGSGcti9R9vU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=k9U7Fc5MURx6TUF7FG923B9WjMvoSxt1
	a2CzwKHdN/Uo4MGQBSVHcVV9BH1xk+M23dFgscj/cfp6ECSEz+k99lyCK2L3eAEM
	ay64nfB8oKJEm0FKLI1PtvU3PqmyQgHzpf6wTJq8qZV4sRSRBYI1pBgQhFOhrt4I
	pa+k+b8kkFM=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 37F83DBA;
	Mon, 21 Jun 2010 14:11:07 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5BC9ADB4; Mon, 21 Jun
 2010 14:11:02 -0400 (EDT)
In-Reply-To: <__CrpvAIIX9lgHHkBLHB9fuuN7Rspzl7LFSDSwXwVCT6rYs_YOUHNMf7JZQbKaPHRl6AjsJ9dx8@cipher.nrlssc.navy.mil> (Brandon Casey's message of "Mon\, 21 Jun 2010 12\:37\:13 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 5CD119CC-7D60-11DF-B0D0-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149428>

Brandon Casey <casey@nrlssc.navy.mil> writes:

> From: Brandon Casey <drafnel@gmail.com>
>
> Regular expressions matched by 'expr' have an implicit '^' at the beginning
> of them and so are anchored to the beginning of the string.

Oh, of course; I should have caught this earlier.

$ git grep -n -e 'expr .*: .*['\''"]^'
t/lib-pager.sh:12:if expr "$less" : '^[a-z][a-z]*$' >/dev/null
t/t7005-editor.sh:16:if ! expr "$vi" : '^[a-z]*$' >/dev/null
t/t7006-pager.sh:113:   ! expr "$firstline" : "^[a-zA-Z]" >/dev/null

I'll fix the other two; thanks.
