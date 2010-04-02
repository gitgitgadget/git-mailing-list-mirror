From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Makefile: update defaults for modern Cygwin
Date: Thu, 01 Apr 2010 23:47:42 -0700
Message-ID: <7vaatmmju9.fsf@alter.siamese.dyndns.org>
References: <1270161834-9597-1-git-send-email-eblake@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, jon.seymour@gmail.com, jrnieder@gmail.com
To: Eric Blake <eblake@redhat.com>
X-From: git-owner@vger.kernel.org Fri Apr 02 08:47:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nxafe-0004Po-Qt
	for gcvg-git-2@lo.gmane.org; Fri, 02 Apr 2010 08:47:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758790Ab0DBGry (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Apr 2010 02:47:54 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:59721 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758193Ab0DBGrx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Apr 2010 02:47:53 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id C484AA787F;
	Fri,  2 Apr 2010 02:47:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=U8pXbkIw2UXXEVjjYhyZGyjbIZ8=; b=UX/oUj
	yG0Xxo1a31AqSFB+sTB8oBfVcQn0okA71MVNr2UK45UomBhVQAJFYqraEcio4oFK
	r+dImiqvudtmqjAlws0fqm6ok/BtA3CBjRg1NdWzOESVoIwZ/0qBv8yXB6+ZQEsl
	ChDkdXcPUR0nrFcZekiOF8j2ux4bWc2pnTJlE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=JTPIv2njIgL/c7t3pmx3sjO/DhYpInbA
	eQ4Naaf9RTfWE2uMlChw93EvMa9eWsegtL+rlGBH1Qm9iuVmGiyorglnPV1MG8AH
	Ci3MZWwbTXsuEyLbyBlidgUpofe/t/QBXqfuK0Fsebr1N5TZcwXzmHofxOnGEo2G
	ddWGPg4VWK0=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 8198EA7876;
	Fri,  2 Apr 2010 02:47:48 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9E78DA7875; Fri,  2 Apr
 2010 02:47:43 -0400 (EDT)
In-Reply-To: <1270161834-9597-1-git-send-email-eblake@redhat.com> (Eric
 Blake's message of "Thu\,  1 Apr 2010 16\:43\:54 -0600")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: A6A47FF2-3E23-11DF-A9BE-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143780>

Eric Blake <eblake@redhat.com> writes:

> Now that Cygwin 1.7.x has enabled lots of new features, and Cygwin 1.5
> is no longer actively supported by the Cygwin mailing lists, we might
> as well update the defaults to cater to those new features.
>
> NO_TRUSTABLE_FILEMODE is only necessary on FAT drives; the Cygwin
> community recommends NTFS drives, but there is still too much use
> for FAT to switch the default.  Likewise, UNRELIABLE_FSTAT is probably
> file-system specific, but worth keeping unchanged.
>
> This commit does not change the default for NO_MMAP, although definitive
> proof of whether this option is necessary is lacking.
>
> Signed-off-by: Eric Blake <eblake@redhat.com>

Thanks; as I lack Cygwin environment to test this myself, I'll apply this
directly on 'master' and see if anybody screams ;-)

> +	ifneq ($(wordlist 1, 2, $(subst ., ,$(uname_R))),1 7)

Do we need to update this part when Cygwin 1.8 is released?  Replacing
this with "ifeq(... ,1 5)" may not be an improvement either, unless we are
sure that nobody is using 1.4 or older, but I wonder if somebody else have
better ideas?
