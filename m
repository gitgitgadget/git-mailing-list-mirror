From: Junio C Hamano <gitster@pobox.com>
Subject: Re: ls-files --exclude broken?
Date: Wed, 15 Sep 2010 16:12:22 -0700
Message-ID: <7v62y661pl.fsf@alter.siamese.dyndns.org>
References: <AANLkTimuTHvA+qjqpmz=VkCpTTiRA7imb5+ZyTVmPwYy@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 16 01:12:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ow19Y-0006QQ-9y
	for gcvg-git-2@lo.gmane.org; Thu, 16 Sep 2010 01:12:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753181Ab0IOXMb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Sep 2010 19:12:31 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:44927 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752393Ab0IOXMa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Sep 2010 19:12:30 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 72C12D6B3C;
	Wed, 15 Sep 2010 19:12:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=K8uM0h4uQ+Mf8xqotLtcHPjAbCk=; b=iwcRuj
	0ADIp+Lh7ZFD0fi9Ae/IbYcKrU9/EtK8pap80X1lHmcfXaEvMVpcNkATHbxvtVZh
	moN+5WWxQObEuHdBlL/Ze5JXqDv0FMcTiG/ho29wzsAOCZGl4hjYNw4Yl2r2EBUs
	J8fkcvb0W0tCQlkWACLtwi8e/y/HhQT/rj+nc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dmIHmA2VF4bttvEsR3KE6byL6xv1DuAx
	WuykGl1HlkrvXsCJZDAKp9u1i7ymleaAWdDwNnJxxHtXIIkldyIH2vqwqpI9CZ7e
	dRPDhmzrG5EW9GJJZpQ3Ltn5NhTOIsVnsrPlcsvpHxfJCFuRkiOYAJV3yzPIaUc1
	MXDnvp9jPEM=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 49BF3D6B3A;
	Wed, 15 Sep 2010 19:12:27 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A0EF5D6B39; Wed, 15 Sep
 2010 19:12:24 -0400 (EDT)
In-Reply-To: <AANLkTimuTHvA+qjqpmz=VkCpTTiRA7imb5+ZyTVmPwYy@mail.gmail.com>
 (Jay Soffian's message of "Wed\, 15 Sep 2010 18\:40\:20 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: B4E877B6-C11E-11DF-8E74-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156269>

Jay Soffian <jaysoffian@gmail.com> writes:

> Am I missing something really obvious here?
>
> kore:~/Repos/git (master)$ git ls-files | wc -l
>     2009

You asked it to show the cached paths (default).  Your project currently
tracks 2009 paths in the index.

> kore:~/Repos/git (master)$ git ls-files -x \* | wc -l
>     2009

You told that '*' is the exclude pattern for carrying out some operation,
but you didn't tell what operation you want.  You are shown the cached
paths (default).

> kore:~/Repos/git (master)$ git ls-files -i -x \* | wc -l
>     2009

You told that '*' is the exclude pattern, you want only paths that match
the exclude pattern, and chose to show files in the index (which again is
the default) by not saying -o.

I've never found -i useful myself (actually I don't find many options the
command has very useful anymore), but the above is how I read the ls-files
manual page.
