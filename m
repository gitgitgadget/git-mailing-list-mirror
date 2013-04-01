From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] remote-bzr: remove stale check code for tests
Date: Mon, 01 Apr 2013 15:46:07 -0700
Message-ID: <7vli91j2ds.fsf@alter.siamese.dyndns.org>
References: <1364850872-21135-1-git-send-email-felipe.contreras@gmail.com>
 <1364850872-21135-3-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 02 00:46:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UMnUu-0005QH-HU
	for gcvg-git-2@plane.gmane.org; Tue, 02 Apr 2013 00:46:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757061Ab3DAWqM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Apr 2013 18:46:12 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63697 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756733Ab3DAWqL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Apr 2013 18:46:11 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3EC0011A28;
	Mon,  1 Apr 2013 22:46:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8vOxht7EpsQLfhL9ZyfaPm4OECs=; b=oUO53L
	ISHLc9xHLR9Pqh39NRtz1AG/eEHu5829QcvBB2gzwaMn422ZGYbfyFq93CRcaiCi
	VycYfOPHZNMaM02rRbRDcAJkvxJvd9I1Uu7IdIIT62KhCss8VWaS/tQ/jnT298kq
	fyNbCxvpTem148UF8oQOqRn0aqWHJljXvtW3g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vqWSHLVt2DFm+ZsIS64kf4UrRRvYk+Mt
	r+v/uwdRfX8rt4RaRyW5qv+CD6MBmNIjTFvjdy9Z4SeXr+OA51YjNy6wWuMESxli
	QgkUaGeuqdPfUaTVUwJyoGzJyCEk4/YPvQwWjsTg1aNpEr4V/Sgxm9dZmxaJJMlC
	5YAbtxY8lHo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3472711A27;
	Mon,  1 Apr 2013 22:46:10 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7FB7F11A26; Mon,  1 Apr
 2013 22:46:09 +0000 (UTC)
In-Reply-To: <1364850872-21135-3-git-send-email-felipe.contreras@gmail.com>
 (Felipe Contreras's message of "Mon, 1 Apr 2013 15:14:31 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F242487C-9B1D-11E2-8B26-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219720>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> The fastimport plugin was only required in the early stage of
> development.

OK, thanks, will queue.

>
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  contrib/remote-helpers/test-bzr.sh | 14 --------------
>  1 file changed, 14 deletions(-)
>
> diff --git a/contrib/remote-helpers/test-bzr.sh b/contrib/remote-helpers/test-bzr.sh
> index 70aa8a0..5dac171 100755
> --- a/contrib/remote-helpers/test-bzr.sh
> +++ b/contrib/remote-helpers/test-bzr.sh
> @@ -17,20 +17,6 @@ if ! "$PYTHON_PATH" -c 'import bzrlib'; then
>  	test_done
>  fi
>  
> -cmd='
> -import bzrlib
> -bzrlib.initialize()
> -import bzrlib.plugin
> -bzrlib.plugin.load_plugins()
> -import bzrlib.plugins.fastimport
> -'
> -
> -if ! "$PYTHON_PATH" -c "$cmd"; then
> -	echo "consider setting BZR_PLUGIN_PATH=$HOME/.bazaar/plugins" 1>&2
> -	skip_all='skipping remote-bzr tests; bzr-fastimport not available'
> -	test_done
> -fi
> -
>  check () {
>  	(cd $1 &&
>  	git log --format='%s' -1 &&
