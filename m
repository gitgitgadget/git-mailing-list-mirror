From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/6] completion: clarify difftool completion
Date: Mon, 03 Jun 2013 10:29:40 -0700
Message-ID: <7vip1vgl17.fsf@alter.siamese.dyndns.org>
References: <1370181822-23450-1-git-send-email-artagnon@gmail.com>
	<1370181822-23450-6-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 03 19:29:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UjYZo-0005jm-5Y
	for gcvg-git-2@plane.gmane.org; Mon, 03 Jun 2013 19:29:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759376Ab3FCR3p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Jun 2013 13:29:45 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53210 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759346Ab3FCR3n (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Jun 2013 13:29:43 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E1045240C0;
	Mon,  3 Jun 2013 17:29:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+RDaq9KdvQODbttx6arNJyzPg8I=; b=Dn3mRp
	1uIYrlze5JrxwLsw0ixrHwzpCxdRe/jfQEv1jltb5tvOiOBciwf6FSYOis/aI3Y/
	4WQ2+VpIRz133I0utReu+1wR+TTf714QyNsp1Qnc7ybE4oPlOwcFO83Qxn6dxwaY
	zSAAFR8CUAI0Qc3+93QQAuiwNCzk1k6ILew1M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TXdO41rUQbTCmsWJP/BwFNAOfodiUfej
	tAACWc16RIflnRXp9a28MMg5C1gUsQFOCyiG80lUzotBGaygIR40rVhmRazNjg7m
	DVgo6A3OQ8aCh8bjm61rT/LIx9tjl70OLGwxUSBDFbqVRyckpIJUjwHiTe8hNZyb
	zQ0VgPdCE1o=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BA1A7240BF;
	Mon,  3 Jun 2013 17:29:42 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E964B240BD;
	Mon,  3 Jun 2013 17:29:41 +0000 (UTC)
In-Reply-To: <1370181822-23450-6-git-send-email-artagnon@gmail.com> (Ramkumar
	Ramachandra's message of "Sun, 2 Jun 2013 19:33:41 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2CCFC7CC-CC73-11E2-A8C3-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226244>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> 'git difftool' is clearly a frontend to 'git diff' and is used in
> exactly the same way, but it uses a misleading completion function name
> __git_complete_file (aliased to to __git_complete_revlist_file).  Change
> it to use __git_complete_revlist_file, just like 'git diff'.  No
> functional changes.

Makes sense.  The completion helper for both revname and pathname
should not be called __git_complete_file, and this is a step in the
right direction.

If we have a situation where we _know_ we only want to complete
pathname and never revname, we may want to keep __git_complete_file
function.  For example, after seeing "--" on the command line, we
may want to use __git_complete_file (that does not look at revs,
instead of __git_complete_revlist_file function.

Will apply.

Thanks.

>
> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
> ---
>  contrib/completion/git-completion.bash | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index f46964d..8d70c30 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -1305,7 +1305,7 @@ _git_difftool ()
>  		return
>  		;;
>  	esac
> -	__git_complete_file
> +	__git_complete_revlist_file
>  }
>  
>  __git_fetch_options="
