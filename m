From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] git-config.txt: properly escape quotation marks in
 example
Date: Sat, 18 Aug 2012 13:43:57 -0700
Message-ID: <7v7gswrkvm.fsf@alter.siamese.dyndns.org>
References: <1345311130-20426-1-git-send-email-mhagger@alum.mit.edu>
 <1345311130-20426-2-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Sat Aug 18 22:44:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T2psM-0004kr-TT
	for gcvg-git-2@plane.gmane.org; Sat, 18 Aug 2012 22:44:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751766Ab2HRUoB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Aug 2012 16:44:01 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46890 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751108Ab2HRUoA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Aug 2012 16:44:00 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 617D99D7B;
	Sat, 18 Aug 2012 16:43:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=oroxgvxa8SAEvMYX7bjQtTqxH14=; b=Izi9g1
	fjQb0Dff7FUY8fIwuaK5oltXXULwzn/yYBgwt6HIX5C73SQkqFhhThFHp0GheS+A
	jftxRelV+yh9KGvuQBeqzAvp1CMSke6A95YAHuaGlAk16SLm7aIInEg5IQws8hUv
	UGMuHrutMErbldTi7aJqyilsVlhEfIpRFSjvc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Fh1k7RSxbxBXML20UkONzTf3zU0qiJna
	Ej3/n9oOzCyXq489sERubYFSZo6f06aLOZMoYJHOnlc8MkTtgT1wSjU30ZKS9yEI
	X/0n+XjZydsUFGL5dA2y0tkIGp8qqshfo9cojS3L4ADVNSus64kEX/gDNUZoYyoS
	7bFcczuxnoQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4F39E9D7A;
	Sat, 18 Aug 2012 16:43:59 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A723D9D78; Sat, 18 Aug 2012
 16:43:58 -0400 (EDT)
In-Reply-To: <1345311130-20426-2-git-send-email-mhagger@alum.mit.edu>
 (mhagger@alum.mit.edu's message of "Sat, 18 Aug 2012 19:32:09 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6F615894-E975-11E1-B8D8-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203698>

mhagger@alum.mit.edu writes:

> From: Michael Haggerty <mhagger@alum.mit.edu>
>
> In the example line as written,
>
>         gitproxy="proxy-command" for kernel.org
>
> the quotation marks are eaten by the config-file parser.  From the
> history, it looks like this example wanted to have quotation marks in
> the actual configured value.  So quote them as required nowadays.
>
> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
> ---
>
> The bigger question is whether this example is improved by including
> quotation marks, or whether they are just a distraction from the main
> point.  I abstain.

Thanks for spelling that bigger question out.  Given that the
example is showing distinction between "X" vs "X for Y", I would say
quotation is a distraction.

If you spelled it as

	[core]
        	gitproxy = sh -c 'proxy-command' for kernel.org

does the do the right thing?  Or do we require the above to be
spelled as

	[core]
        	gitproxy = \"sh -c 'proxy-command'\" for kernel.org

to work correctly?  I suspect that the former would work, and in
that case, the quote around "proxy-command" in the documentation is
indeed a distraction, and removing it will not hurt the readers.

>  Documentation/git-config.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
> index 2d6ef32..46775fe 100644
> --- a/Documentation/git-config.txt
> +++ b/Documentation/git-config.txt
> @@ -267,7 +267,7 @@ Given a .git/config like this:
>  
>  	; Proxy settings
>  	[core]
> -		gitproxy="proxy-command" for kernel.org
> +		gitproxy=\"proxy-command\" for kernel.org
>  		gitproxy=default-proxy ; for all the rest
>  
>  you can set the filemode to true with
