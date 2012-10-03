From: Junio C Hamano <gitster@pobox.com>
Subject: grep.patternType (was: Re: [ANNOUNCE] Git v1.8.0-rc0)
Date: Wed, 03 Oct 2012 13:18:56 -0700
Message-ID: <7v626r48cv.fsf@alter.siamese.dyndns.org>
References: <7vwqz9ak2f.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?Q?Micha=C5=82?= Kiedrowicz <michal.kiedrowicz@gmail.com>,
	J Smith <dark.panda@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 04 23:53:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJtJC-0001DP-Nx
	for gcvg-git-2@plane.gmane.org; Thu, 04 Oct 2012 23:50:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753822Ab2JCUTB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Oct 2012 16:19:01 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37463 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753801Ab2JCUS7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Oct 2012 16:18:59 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0977F8E13;
	Wed,  3 Oct 2012 16:18:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=FNYU1E86HAvXoVoNMVV9JnJQe3w=; b=wpYXPu
	059aR86F1q/2YUIsopgY3XNdEs1XBDdQ+p7gv4NPhnF0OkRBMdszj3g8mty+w59l
	GB1rmjKKCUbouAkh9JkI/rohnBrXGnQPLbj51DG0sVxBZ+lkKdgeRvsCKyQAKJwM
	4bDcCzF2UYaL0wxDd0f87AAiNJZ7Tf/6+Iyoc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=n7LLS8JdVUxY0QZaz25t/cFBZb4emUlj
	7nHRke/yQI8coR3Mxk28XRRbHP1Y5BNzAE1D0HNYKU25j8nLKElLVWeNGil120DR
	Y54/O7Nd8vpffhrlxeQpklQjAmpShFpj6KhvKMBMlvoFy7M45pKxhxpNu77iEVAH
	vY6UkkHvhOY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EBEBB8E12;
	Wed,  3 Oct 2012 16:18:58 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5AF968E11; Wed,  3 Oct 2012
 16:18:58 -0400 (EDT)
In-Reply-To: <7vwqz9ak2f.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Mon, 01 Oct 2012 15:44:56 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9020661A-0D97-11E2-ADAF-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206937>

Junio C Hamano <gitster@pobox.com> writes:

>  * "git grep" learned to use a non-standard pattern type by default if
>    a configuration variable tells it to.

This addition makes

    git grep -e "(integer|buffer)"

work as expected, when grep.patternType is set to "extended".

Should this

    git log --grep="(integer|buffer)"

also honor the same configuration variable?  If not, why not?

One more thing.  Currently you can say

    git log -E --grep="(integer|buffer)"

to ask for the ERE.  Should we also support -P to ask for pcre?  If
not, why not?
