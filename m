From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Aug 2009, #05; Wed, 26)
Date: Thu, 27 Aug 2009 10:32:46 -0700
Message-ID: <7vr5uxrwld.fsf@alter.siamese.dyndns.org>
References: <7vfxbeb0mt.fsf@alter.siamese.dyndns.org>
 <SW-k_fUnLrE0kFNXSIYgMIc-pexuL5ykWs1ZdvHAo9_LMxe9ggJtCA@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Thu Aug 27 19:33:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MgiqX-0003IH-1l
	for gcvg-git-2@lo.gmane.org; Thu, 27 Aug 2009 19:33:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751297AbZH0Rc4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Aug 2009 13:32:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751283AbZH0Rc4
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Aug 2009 13:32:56 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:38086 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751189AbZH0Rcz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Aug 2009 13:32:55 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 2EE003929C;
	Thu, 27 Aug 2009 13:32:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=gE4m7/aePwWsmda3z+iF0UKL2a0=; b=gVVZt6
	ga62monLRwHaI89xqLSQZ3ZoTKhCI2pY/oF4x9z/yIbHGA42MGop/zrar7+bW1RZ
	Kq++OoYT16rQtnZ32T5dEkxk4xzlOXmRCG7olIRYHsDOWu3pRKe7GWK8opZRwYEn
	Tw+fb/zr07ixb0cAYxfWyX/kfy6a0OqmnXE1k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gvq/vubVnQO4NQY0DFYuhfKdlAaoFef+
	S040mX6KYaaU3qHw2G+Aqsc+do1WXPGL9xtvWRHvXW0Nig8Hh+rS8vl1VWDQSy0n
	dz6zcRhBn/wnFrI23IspwT3TPWrd1wSqkZN+j0PusM+PDl4e+vkducjZeNAN9rFt
	+9HeS7Q90/4=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 129933929A;
	Thu, 27 Aug 2009 13:32:54 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 325B939299; Thu, 27 Aug 2009
 13:32:47 -0400 (EDT)
In-Reply-To: <SW-k_fUnLrE0kFNXSIYgMIc-pexuL5ykWs1ZdvHAo9_LMxe9ggJtCA@cipher.nrlssc.navy.mil> (Brandon Casey's message of "Thu\, 27 Aug 2009 11\:41\:18 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: A6E02D94-932F-11DE-ACC8-8B19076EA04E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127180>

Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil> writes:

>> This seems to break t9001.  Near the tip of 'pu' I have a iffy
>> workaround.
>
> Can you squash this into your 'iffy' workaround to help platforms
> (Solaris 7, IRIX 6.5) without the 'yes' utility?

Not in this form, for two reasons ;-)

(1) t7610-mergetool.sh,also seems to use "yes".  Perhaps define something
    in test-lib.sh?

(2) The implementation is iffy.

> +yes () {
> +	test -n "$*" && y="$*" || y='y'

Shouldn't it be

	if test $# = 0
        then
        	y=y
	else
        	y="$*"
	fi

so that

	yes ""

would give runs of empty lines?        
