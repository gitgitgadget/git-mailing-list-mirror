From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/5] make "git unpack-file" a built-in
Date: Fri, 22 Jan 2010 10:04:49 -0800
Message-ID: <7vmy06vwvy.fsf@alter.siamese.dyndns.org>
References: <alpine.LFD.2.00.1001220804550.13231@localhost.localdomain>
 <alpine.LFD.2.00.1001220822560.13231@localhost.localdomain>
 <alpine.LFD.2.00.1001220825190.13231@localhost.localdomain>
 <alpine.LFD.2.00.1001220826230.13231@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Jan 22 19:05:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NYNsa-0002XF-I9
	for gcvg-git-2@lo.gmane.org; Fri, 22 Jan 2010 19:05:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756063Ab0AVSFB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Jan 2010 13:05:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756046Ab0AVSFA
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Jan 2010 13:05:00 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:35933 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755019Ab0AVSFA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jan 2010 13:05:00 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id ECD3C91E5A;
	Fri, 22 Jan 2010 13:04:56 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=2lbsLr0RBGc71iI3nSmGuYmcKoc=; b=KM0xNY
	cKjZ/XZn+xpxIIgVFG2ZXRu/rK2MEvR6b9hPlqpqyLbAZ4rWZFYHeZcyZuKDI22d
	U9FtfQ8w0+G4Q4KIdpG9sjSUNHW1xzD9BS1jOR82LY4wtvNrSz03o8YX0CRWDikd
	qs8pXSYs9h3sbrgRd4s+HJYJybIhC2gaaL5To=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bKEOFYpFzBmbXdU1d3/JzKLETjnD6W5x
	NPmhrbNxd7DH3vubbGSyhSxi5gHiDx9rVdc/gd8ZJun1wItTq99+xfHWd8fUgi/k
	4Kmgik6y5giDmykJ+687iXSrLAgnblrcXO8Gg++JOSHDpjfyvtQtzJ2pGFmQ6sjV
	DeC/rilpn6c=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id C36DA91E57;
	Fri, 22 Jan 2010 13:04:54 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EA1D891E56; Fri, 22 Jan
 2010 13:04:50 -0500 (EST)
In-Reply-To: <alpine.LFD.2.00.1001220826230.13231@localhost.localdomain>
 (Linus Torvalds's message of "Fri\, 22 Jan 2010 08\:27\:09 -0800 \(PST\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: A4DED1A6-0780-11DF-8A16-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137769>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> From: Linus Torvalds <torvalds@linux-foundation.org>
> Date: Fri, 22 Jan 2010 07:38:03 -0800
>
> Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
> ---
> Again.. No surprises.
> ...
> diff --git a/unpack-file.c b/builtin-unpack-file.c
> similarity index 89%
> rename from unpack-file.c
> rename to builtin-unpack-file.c
> index e9d8934..608590a 100644
> --- a/unpack-file.c
> +++ b/builtin-unpack-file.c
> @@ -22,18 +22,15 @@ static char *create_temp_file(unsigned char *sha1)
>  	return path;
>  }
>  
> -int main(int argc, char **argv)
> +int cmd_unpack_file(int argc, const char **argv, const char *prefix)
>  {
>  	unsigned char sha1[20];
>  
> -	git_extract_argv0_path(argv[0]);
> -
>  	if (argc != 2 || !strcmp(argv[1], "-h"))
>  		usage("git unpack-file <sha1>");
>  	if (get_sha1(argv[1], sha1))
>  		die("Not a valid object name %s", argv[1]);
>  
> -	setup_git_directory();

This will now require "git unpack-file -h" to be run in a git controlled
directory, so strictly speaking it changes behaviour.

Not that anybody would care that much, though.
