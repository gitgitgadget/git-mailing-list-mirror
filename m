From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 07/13] remote-hg: redirect buggy mercurial output
Date: Tue, 02 Apr 2013 12:58:38 -0700
Message-ID: <7vehesd7rl.fsf@alter.siamese.dyndns.org>
References: <1364929382-1399-1-git-send-email-felipe.contreras@gmail.com>
 <1364929382-1399-8-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Max Horn <max@quendi.de>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 02 21:59:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UN7MM-00023q-4C
	for gcvg-git-2@plane.gmane.org; Tue, 02 Apr 2013 21:59:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933174Ab3DBT6l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Apr 2013 15:58:41 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58464 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932700Ab3DBT6l (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Apr 2013 15:58:41 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C90D3120BE;
	Tue,  2 Apr 2013 19:58:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=rftuZUDrJnpJtzbj9qh6XuloeRc=; b=TuTDS7
	Al3S78n7XGhRvssSLQagsKBjd3212Nb/HQTxy3IsMokdPQUKmIZ0OwJZyM9WYWcr
	jKE9Vxh/HNmyQ79pKKVL6A//PDm/WW5I3J6fxJNnp4qcx0+WA5sU1YdW0dY7sflk
	dPuEDXU9vFZrHywn4hjId9P3a0YRdI892JAgU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=t548kyUfLcaZ7nBWi8VKahpdejDs3B0M
	uxVbWl6rrvEb+hMd3z8uPXMclYTvEN1l4nkpo0z22WGC09vjmrFUodpkDutpqcul
	Hk5fk4cl7NBFr5vCOaGmv/K5jfIxSYLBDirfyFecMAOaY0bzK2mKUC8hW5NxKnJt
	W9HIRRxOM6Y=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BDC01120BD;
	Tue,  2 Apr 2013 19:58:40 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2B3FD120BB; Tue,  2 Apr
 2013 19:58:40 +0000 (UTC)
In-Reply-To: <1364929382-1399-8-git-send-email-felipe.contreras@gmail.com>
 (Felipe Contreras's message of "Tue, 2 Apr 2013 13:02:56 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B6CBAAA6-9BCF-11E2-92AA-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219872>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> We can't use stdout for that in remote helpers.
>
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---

You may want to clarify "buggy output" a bit.  Will mercurial
forever be broken?  Some versions of Hg emit [[[it is unclear for
Junio to tell what it is to fill this blank]]] to its output that
we want to ignore?

>  contrib/remote-helpers/git-remote-hg | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/contrib/remote-helpers/git-remote-hg b/contrib/remote-helpers/git-remote-hg
> index b200e60..874ccd4 100755
> --- a/contrib/remote-helpers/git-remote-hg
> +++ b/contrib/remote-helpers/git-remote-hg
> @@ -271,6 +271,7 @@ def get_repo(url, alias):
>  
>      myui = ui.ui()
>      myui.setconfig('ui', 'interactive', 'off')
> +    myui.fout = sys.stderr
>  
>      if hg.islocal(url):
>          repo = hg.repository(myui, url)
