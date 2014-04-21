From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/3] remote-helpers: move out of contrib
Date: Mon, 21 Apr 2014 14:22:47 -0700
Message-ID: <xmqqppka8jiw.fsf@gitster.dls.corp.google.com>
References: <1398112633-23604-1-git-send-email-felipe.contreras@gmail.com>
	<1398112633-23604-3-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 21 23:22:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WcLg0-0000Ex-Rf
	for gcvg-git-2@plane.gmane.org; Mon, 21 Apr 2014 23:22:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754473AbaDUVWx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Apr 2014 17:22:53 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43432 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753489AbaDUVWw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Apr 2014 17:22:52 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2AB1E7F278;
	Mon, 21 Apr 2014 17:22:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=p91nZsZNz8hz+K/Mk5ue8RZjSeU=; b=wLG7iP
	5e1lbPFf74GajlByHN6YGLBD50evFPPvL4KilD/UTp032v1hHFxhQAQRJzMpZ6fH
	8yXhYdavOtHHjKKMrIgZZAUfeVsRerUax+WmFm9PS0YvQpIoT3bmuQplPJBFP4IN
	Ud8LuAJdxdNVyS5fwTTH5A58tmuFPJdxyPlRs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=PK5uIPgJec9H7dFY41JlFIj04oThGzcr
	2LflMoRVe/IzZ0z0i2zsjebj4IYBJoumK0OFrzpXdGeky0sGjboPwymW0bKP/U+p
	SLVdf51zbKgRDGX6RQB+mC++05STzzYE/ZBE7qdVZejbbPe89W5/sipEFeVJOw1y
	LEEk2CQDGWI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 15B487F277;
	Mon, 21 Apr 2014 17:22:51 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7B82F7F275;
	Mon, 21 Apr 2014 17:22:49 -0400 (EDT)
In-Reply-To: <1398112633-23604-3-git-send-email-felipe.contreras@gmail.com>
	(Felipe Contreras's message of "Mon, 21 Apr 2014 15:37:12 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 17103B30-C99B-11E3-A8AE-0731802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246643>

Felipe Contreras <felipe.contreras@gmail.com> writes:

>  contrib/remote-helpers/test-bzr.sh                         | 2 +-
>  contrib/remote-helpers/test-hg-bidi.sh                     | 2 +-
>  contrib/remote-helpers/test-hg-hg-git.sh                   | 4 ++--
>  contrib/remote-helpers/test-hg.sh                          | 2 +-
>  contrib/remote-helpers/git-remote-bzr => git-remote-bzr.py | 0
>  contrib/remote-helpers/git-remote-hg => git-remote-hg.py   | 0
>  8 files changed, 9 insertions(+), 5 deletions(-)
>  rename contrib/remote-helpers/git-remote-bzr => git-remote-bzr.py (100%)
>  rename contrib/remote-helpers/git-remote-hg => git-remote-hg.py (100%)
> ...
> diff --git a/contrib/remote-helpers/test-hg-bidi.sh b/contrib/remote-helpers/test-hg-bidi.sh
> index 2b5aa9d..d44ec92 100755
> --- a/contrib/remote-helpers/test-hg-bidi.sh
> +++ b/contrib/remote-helpers/test-hg-bidi.sh
> @@ -17,7 +17,7 @@ then
>  	test_done
>  fi
>  
> -if ! python -c 'import mercurial' > /dev/null 2>&1
> +if ! "$PYTHON_PATH" -c 'import mercurial' > /dev/null 2>&1

Does this change relate to the moving of main scripts, and if so
how?

Ditto for other test-*.sh scripts in the same directory.

>  then
>  	skip_all='skipping remote-hg tests; mercurial not available'
>  	test_done
> diff --git a/contrib/remote-helpers/test-hg-hg-git.sh b/contrib/remote-helpers/test-hg-hg-git.sh
> index 456a07f..d0d186c 100755
> --- a/contrib/remote-helpers/test-hg-hg-git.sh
> +++ b/contrib/remote-helpers/test-hg-hg-git.sh
> @@ -17,13 +17,13 @@ then
>  	test_done
>  fi
>  
> -if ! python -c 'import mercurial' > /dev/null 2>&1
> +if ! "$PYTHON_PATH" -c 'import mercurial' > /dev/null 2>&1
>  then
>  	skip_all='skipping remote-hg tests; mercurial not available'
>  	test_done
>  fi
>  
> -if ! python -c 'import hggit' > /dev/null 2>&1
> +if ! "$PYTHON_PATH" -c 'import hggit' > /dev/null 2>&1
>  then
>  	skip_all='skipping remote-hg tests; hg-git not available'
>  	test_done
> diff --git a/contrib/remote-helpers/test-hg.sh b/contrib/remote-helpers/test-hg.sh
> index 056940a..214c548 100755
> --- a/contrib/remote-helpers/test-hg.sh
> +++ b/contrib/remote-helpers/test-hg.sh
> @@ -17,7 +17,7 @@ then
>  	test_done
>  fi
>  
> -if ! python -c 'import mercurial' > /dev/null 2>&1
> +if ! "$PYTHON_PATH" -c 'import mercurial' > /dev/null 2>&1
>  then
>  	skip_all='skipping remote-hg tests; mercurial not available'
>  	test_done
> diff --git a/contrib/remote-helpers/git-remote-bzr b/git-remote-bzr.py
> similarity index 100%
> rename from contrib/remote-helpers/git-remote-bzr
> rename to git-remote-bzr.py
> diff --git a/contrib/remote-helpers/git-remote-hg b/git-remote-hg.py
> similarity index 100%
> rename from contrib/remote-helpers/git-remote-hg
> rename to git-remote-hg.py
