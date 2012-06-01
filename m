From: Junio C Hamano <gitster@pobox.com>
Subject: Re: GIT PULL] ext4 updates for 3.5
Date: Fri, 01 Jun 2012 12:00:57 -0700
Message-ID: <7v4nqu3lhy.fsf@alter.siamese.dyndns.org>
References: <E1SaTSI-0005UV-4B@tytso-glaptop.cam.corp.google.com>
 <CA+55aFwk8oYx8EKWdT=5cMTLK7RDz8GQdGmHk2KXwcCq+Bb8PA@mail.gmail.com>
 <CA+55aFwwfMTN=WGQGmFO7DYeBUOGA7V4_6XueQS4JAzeykwn3Q@mail.gmail.com>
 <20120601174336.GA15778@thunk.org>
 <CA+55aFxgZupkAotfjUuWcfwTzHDYg0Afezme62P17=EX2KN+UQ@mail.gmail.com>
 <7v8vg63lri.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Ted Ts'o" <tytso@mit.edu>, Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Jun 01 21:01:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SaX5u-0008Ch-06
	for gcvg-git-2@plane.gmane.org; Fri, 01 Jun 2012 21:01:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965716Ab2FATBB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Jun 2012 15:01:01 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51936 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933636Ab2FATBA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jun 2012 15:01:00 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6B8638FD5;
	Fri,  1 Jun 2012 15:00:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=iorDLfOmeO553i2BLeHAZgvIam0=; b=OYKiTo
	XYbtjN/85XOYQnW2gqwNPr2ETl9eJUGC22ty3is+Sw1C/3aTOgnv3urWQnpFst4G
	wSNuXItVrGpuHZkMCy+rVa0vMrVpKGBdHJg/4dOkoY9j8rQOA/ftnmyiV/ZnGbLu
	cMJIJqrH6RvPb58uAGCmsGkt+io71QkkRu1fc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Mqz77vHEmfxZ9tAXScC+onvOvAlGJUEI
	+KIogT4bMEFbBiTFr55Nl9iwL+DeaJJrnQnGpMQsOYETq8XjzkqCUBeJsnWZlCcw
	gSXk/TvVdsC0vNSQm9lDxRWMTiiPcOAE9hpEizQYYK9YgOjp4968jAMWiQWSwh1k
	9Ivta32d9y4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 612A88FD4;
	Fri,  1 Jun 2012 15:00:59 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E8AA78FD2; Fri,  1 Jun 2012
 15:00:58 -0400 (EDT)
In-Reply-To: <7v8vg63lri.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Fri, 01 Jun 2012 11:55:13 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1FC1259E-AC1C-11E1-B5FB-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199012>

Junio C Hamano <gitster@pobox.com> writes:

> +# $head is the token given from the command line, and $tag_name, if
> +# exists, is the tag we are going to show the commit information for.
> +# If that tag exists at the remote and it points at the commit, use it.
> +# Otherwise, if a branch with the same name as $head exists at the remote
> +# and their values match, use that instead.
> +#
> +# Otherwise find a random ref that matches $headrev.

It may also be a good idea to add something like:

	if test -n "$tag_name" && test "tags/$tag_name" != "$ref"
        then
		echo "warning: have you really pushed the tag yet???"
	fi

somewhere near we show "cat-file tag $tag_name" information in the
output.
