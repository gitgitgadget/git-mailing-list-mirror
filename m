From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] For git-subtree, when installing docs (make
 install-doc), create man1 folder first.
Date: Sat, 15 Dec 2012 10:07:02 -0800
Message-ID: <7vlicztcjd.fsf@alter.siamese.dyndns.org>
References: <1355429376-4192-1-git-send-email-lyager@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "David A. Greene" <greened@obbligato.org>
To: "Jesper L. Nielsen" <lyager@gmail.com>
X-From: git-owner@vger.kernel.org Sat Dec 15 19:07:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tjw90-0001uG-De
	for gcvg-git-2@plane.gmane.org; Sat, 15 Dec 2012 19:07:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752851Ab2LOSHH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Dec 2012 13:07:07 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56753 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751324Ab2LOSHF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Dec 2012 13:07:05 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EA5C9A369;
	Sat, 15 Dec 2012 13:07:04 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/BsgDMmyM+2jjfwyNjR8wyFWRsg=; b=CaMcJq
	HtlRbHu264f9VdKiVGsQHJ/l0FMED2Nxuc/VbxM3eFsEc9v/59A8OrxlKsKszr9a
	X0cihr7YcvfbqwHh7TaSE37ijMyJZhEIJoZgx0MCgh6xLk5GrOJrwA/Os3RxGAMa
	yVKUcbh5G3QwVjH319YTnFpGpvpvmURh8lSew=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Y6u5H+07cU7m+KtgVpV0BBVluEUDhrBz
	Sg6m+/T/MH1g7zUNDHraQIl75FdCA5I7ii6k5gMMrXexeH2ehl/AlC+NHECVhs8E
	LnyFFiRFa/Btq8xpGQ7xaFaZoPIgRkvw6+oCXFg/YzEfOxrf+5EW+jm9uFfW3jzF
	zWMWqfMojQg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D6A8FA368;
	Sat, 15 Dec 2012 13:07:04 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3CCFDA365; Sat, 15 Dec 2012
 13:07:04 -0500 (EST)
In-Reply-To: <1355429376-4192-1-git-send-email-lyager@gmail.com> (Jesper L.
 Nielsen's message of "Thu, 13 Dec 2012 21:09:36 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3B18BE7C-46E2-11E2-97D9-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211551>

"Jesper L. Nielsen" <lyager@gmail.com> writes:

> From: "Jesper L. Nielsen" <lyager@gmail.com>
>
> Hi..
>
> I installed Git subtree and discovered that the if the man1dir doesn't exist the man-page for Git Subtree is just called man1.
>
> So, small patch to create the folder first in the Makefile. Hope everything is right with the patch and submitting of the patch.
>
> Best Regards
> Jesper
>
> Signed-off-by: Jesper L. Nielsen <lyager@gmail.com>
> ---
>  contrib/subtree/Makefile | 1 +
>  1 file changed, 1 insertion(+)

This is a good first step in the right direction, I think.

Shouldn't the install targets take DESTDIR into account like the
main Makefile does, though?

As to the patch submission, everything below "---" line looks sane,
but please check how others write commit log messages by browsing a
handful of entries in "git log --no-merges" output and notice the
difference (the details are found in Documentation/SubmittingPatches).

Thanks.

> diff --git a/contrib/subtree/Makefile b/contrib/subtree/Makefile
> index 05cdd5c..a341cf4 100644
> --- a/contrib/subtree/Makefile
> +++ b/contrib/subtree/Makefile
> @@ -35,6 +35,7 @@ install: $(GIT_SUBTREE)
>  install-doc: install-man
>  
>  install-man: $(GIT_SUBTREE_DOC)
> +	mkdir -p $(man1dir)
>  	$(INSTALL) -m 644 $^ $(man1dir)
>  
>  $(GIT_SUBTREE_DOC): $(GIT_SUBTREE_XML)
