From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-svn: shorten glob error message
Date: Thu, 14 Jan 2016 10:15:49 -0800
Message-ID: <xmqqvb6wjacq.fsf@gitster.mtv.corp.google.com>
References: <1452522358-16943-1-git-send-email-vleschuk@accesssoftek.com>
	<20160113031601.GA28224@dcvr.yhbt.net>
	<20160114040759.GA7671@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, vleschuk@accesssoftek.com,
	Victor Leschuk <vleschuk@gmail.com>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Thu Jan 14 19:16:02 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJmRB-0002TX-07
	for gcvg-git-2@plane.gmane.org; Thu, 14 Jan 2016 19:15:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756502AbcANSPy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jan 2016 13:15:54 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:62493 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756476AbcANSPw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jan 2016 13:15:52 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1CFE83B94A;
	Thu, 14 Jan 2016 13:15:51 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Eb7tT5wOmN00sRNAdFi0+lkU/jE=; b=DTzUWe
	AaN7uGPdCPUBYyMLRFXhDT220ZHh9o6JPd2hdajjqopJ/8sS0Xx/fU4qveXjMxFb
	42CTbB2+MfzAdcmWBL94P4NaqcvZWib2MzX2BQzd2Y5Cc54ZpP8fpVLRyPjrWdlk
	6iogJM3mOH6M2KcxEnxPXMXQSnbBXoHJOWkws=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cm+PiU4kic1/e1uDNSy1dMhUJ/YexGW3
	9rT+KiEoDXR9sk6UxlitIib+8vUfDxzsuJk9JSsGYdn2ySJ9k+yHtu1P0NZsw9/J
	EwDPS7kNKxC5pIx0JZVfbow58h+7JlqzhGJZD2cXrLikU88lhY3nb7uDAhIoZigZ
	q3fHNX4Lahs=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 12D733B949;
	Thu, 14 Jan 2016 13:15:51 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 6B9C53B947;
	Thu, 14 Jan 2016 13:15:50 -0500 (EST)
In-Reply-To: <20160114040759.GA7671@dcvr.yhbt.net> (Eric Wong's message of
	"Thu, 14 Jan 2016 04:07:59 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: D77F9054-BAEA-11E5-B0D2-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284074>

Eric Wong <normalperson@yhbt.net> writes:

> Error messages should attempt to fit within the confines of
> an 80-column terminal to avoid compatibility and accessibility
> problems.  Furthermore the word "directories" can be misleading
> when used in the context of git refnames.
>
> Signed-off-by: Eric Wong <normalperson@yhbt.net>
> ---
>   Eric Wong <normalperson@yhbt.net> wrote:
>   > I also noticed the "Only one set of wildcard directories" error
>   > message is unnecessary long and "wildcard directories" should
>   > probably be shortened to "wildcards" to avoid wrapping in a terminal.
>   > That will probably be a separate patch for me.
>
>   There's likely more instances of this in git-svn, but I figured
>   we'll get this one fixed, first.
>
>   Also pushed to bogomips.org/git-svn.git
>   (commit dc6aa7e61e9d33856f54d63b7acb518383420373)
>   along with Victor's patch.

Thanks.

I am not sure if it is a good idea to show */*/* as an example in
the message (that is an anti-example of 'one set of wildcard' by
having three stars, isn't it?), but that is not a new issue this
change introduces.

>  	my $state = "left";
> -	my $die_msg = "Only one set of wildcard directories " .
> -				"(e.g. '*' or '*/*/*') is supported: '$glob'\n";
> +	my $die_msg = "Only one set of wildcards " .
> +				"(e.g. '*' or '*/*/*') is supported: $glob\n";
>  	for my $part (split(m|/|, $glob)) {
>  		if ($pattern_ok && $part =~ /[{}]/ &&
>  			 $part !~ /^\{[^{}]+\}/) {
> diff --git a/t/t9108-git-svn-glob.sh b/t/t9108-git-svn-glob.sh
> index d732d31..29b363b 100755
> --- a/t/t9108-git-svn-glob.sh
> +++ b/t/t9108-git-svn-glob.sh
> @@ -86,9 +86,12 @@ test_expect_success 'test left-hand-side only globbing' '
>  	test_cmp expect.two output.two
>  	'
>  
> -echo "Only one set of wildcard directories" \
> -     "(e.g. '*' or '*/*/*') is supported: 'branches/*/t/*'" > expect.three
> -echo "" >> expect.three
> +test_expect_success 'prepare test disallow multi-globs' "
> +cat >expect.three <<EOF
> +Only one set of wildcards (e.g. '*' or '*/*/*') is supported: branches/*/t/*
> +
> +EOF
> +	"
>  
>  test_expect_success 'test disallow multi-globs' '
>  	git config --add svn-remote.three.url "$svnrepo" &&
> diff --git a/t/t9109-git-svn-multi-glob.sh b/t/t9109-git-svn-multi-glob.sh
> index c318f9f..d0b79fe 100755
> --- a/t/t9109-git-svn-multi-glob.sh
> +++ b/t/t9109-git-svn-multi-glob.sh
> @@ -135,9 +135,12 @@ test_expect_success 'test another branch' '
>  	test_cmp expect.four output.four
>  	'
>  
> -echo "Only one set of wildcard directories" \
> -     "(e.g. '*' or '*/*/*') is supported: 'branches/*/t/*'" > expect.three
> -echo "" >> expect.three
> +test_expect_success 'prepare test disallow multiple globs' "
> +cat >expect.three <<EOF
> +Only one set of wildcards (e.g. '*' or '*/*/*') is supported: branches/*/t/*
> +
> +EOF
> +	"
>  
>  test_expect_success 'test disallow multiple globs' '
>  	git config --add svn-remote.three.url "$svnrepo" &&
> diff --git a/t/t9168-git-svn-partially-globbed-names.sh b/t/t9168-git-svn-partially-globbed-names.sh
> index a7641dc..8b22f22 100755
> --- a/t/t9168-git-svn-partially-globbed-names.sh
> +++ b/t/t9168-git-svn-partially-globbed-names.sh
> @@ -130,9 +130,10 @@ test_expect_success 'test prefixed globs match just prefix' '
>  	'
>  
>  test_expect_success 'prepare test disallow prefixed multi-globs' "
> -	echo \"Only one set of wildcard directories\" \
> -	     \"(e.g. '*' or '*/*/*') is supported: 'branches/b_*/t/*'\" >expect.four &&
> -	echo \"\" >>expect.four
> +cat >expect.four <<EOF
> +Only one set of wildcards (e.g. '*' or '*/*/*') is supported: branches/b_*/t/*
> +
> +EOF
>  	"
>  
>  test_expect_success 'test disallow prefixed multi-globs' '
