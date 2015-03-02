From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t5516-fetch-push: Correct misspelled pushInsteadOf
Date: Mon, 02 Mar 2015 11:43:03 -0800
Message-ID: <xmqq385nb2yg.fsf@gitster.dls.corp.google.com>
References: <alpine.DEB.2.10.1502282316150.7008@buzzword-bingo.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Anders Kaseorg <andersk@mit.edu>
X-From: git-owner@vger.kernel.org Mon Mar 02 20:43:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YSWFI-0002Bs-Gd
	for gcvg-git-2@plane.gmane.org; Mon, 02 Mar 2015 20:43:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755366AbbCBTnL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Mar 2015 14:43:11 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:63565 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754320AbbCBTnH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Mar 2015 14:43:07 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id BEF223BEF6;
	Mon,  2 Mar 2015 14:43:06 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=SYdXuCjRmD+9oilHEtp5qrYAyDg=; b=rGw/k1
	nwuA8VVF6C4X8okA2TRBqrJ8XaDkF4Ao5zO2x8j3u2OioUJ/b5ZNFuBh3DR7qJQN
	TPowyAvGwCiAQ+Mqwn0knmt0LplY8fbMfZJqRyLflb/JSKm2g2+PGerGO+KtNVjj
	XWe+sMGGxaS1MM4jsDBnoNgIrYV6BJEDhbBF4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=v/x+pnPpXYAnUb5x48URvf29q5rAiPlL
	9STF/83oRC5JC3ZZkXdEt8VqNUS07oFmQKeIbsvlgCW+XbzdsPa/xjQMAWFlk2vb
	wKDnYH1EwLju6EDT1MRrAIub+kzKngDRx+kuYhpZ/FuKOTiJ+64H3nmXpm4ELDdn
	4PK/OfR0OmM=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B6AB53BEF5;
	Mon,  2 Mar 2015 14:43:06 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 06D7E3BEF4;
	Mon,  2 Mar 2015 14:43:04 -0500 (EST)
In-Reply-To: <alpine.DEB.2.10.1502282316150.7008@buzzword-bingo.mit.edu>
	(Anders Kaseorg's message of "Sat, 28 Feb 2015 23:18:14 -0500 (EST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 582817FC-C114-11E4-936D-29999F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264613>

Anders Kaseorg <andersk@mit.edu> writes:

> Signed-off-by: Anders Kaseorg <andersk@mit.edu>
> ---
>  t/t5516-fetch-push.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
> index 85c7fec..594d7a6 100755
> --- a/t/t5516-fetch-push.sh
> +++ b/t/t5516-fetch-push.sh
> @@ -238,7 +238,7 @@ test_expect_success 'push with pushInsteadOf' '
>  test_expect_success 'push with pushInsteadOf and explicit pushurl (pushInsteadOf should not rewrite)' '
>  	mk_empty testrepo &&
>  	test_config "url.trash2/.pushInsteadOf" testrepo/ &&
> -	test_config "url.trash3/.pusnInsteadOf" trash/wrong &&
> +	test_config "url.trash3/.pushInsteadOf" trash/wrong &&
>  	test_config remote.r.url trash/wrong &&
>  	test_config remote.r.pushurl "testrepo/" &&
>  	git push r refs/heads/master:refs/remotes/origin/master &&

Interesting.

Now an obvious and natural question after seeing this change is how
the original test passed with misspelled configuration.  Is a test
that pushes into "trash/wrong" checking the right outcome?  If the
reason why the existing tests passed without this patch is because
they do not test the right thing, then shouldn't they be corrected
together with the above fix?
