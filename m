From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] git-send-email: do not double-escape quotes from mutt
Date: Mon, 04 Jan 2016 13:35:36 -0800
Message-ID: <xmqqy4c5m3iv.fsf@gitster.mtv.corp.google.com>
References: <20151227020810.1450-1-normalperson@yhbt.net>
	<vpqsi2dxlht.fsf@anie.imag.fr> <20160104205330.GA6658@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org,
	Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Mon Jan 04 22:36:02 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aGCnG-0001nD-L5
	for gcvg-git-2@plane.gmane.org; Mon, 04 Jan 2016 22:35:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753349AbcADVfv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Jan 2016 16:35:51 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:56387 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752012AbcADVfs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jan 2016 16:35:48 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id BE1A136D6D;
	Mon,  4 Jan 2016 16:35:47 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4jveXVS/mmntExoq7T5LgnbBMyM=; b=H942I0
	LCuddYOv1c6/UmwMd2PpdwP6Gv0qXXzanYadGTKFysXaPqhr3cfHLfo3q+QPRqfU
	s20Xx0wSsZygfwT3xt48QoiEX8tm0hBnaMLQNgtQ8/8KtSPwFrc7hgU9y1H1dB5e
	U8YTilLyLNXC6oLMHCiOeEwnLOgSCo83sOgPs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TiUgDihzKn3g0I8mYnEo0oTfWx+AzHvB
	JKOjyL4CBJR4qRJZh6OVQyeJSrR8OfSz8u0VtIt1PsTBSSVFiYCjrec6FJ8asa8m
	HuJcNJe0V5nkCIit6MSUXiC/R3jPUpjPqh7STHmF6xcaJebPFOiMJOh74IwLPQdg
	gXHXTZqubV8=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B414D36D6C;
	Mon,  4 Jan 2016 16:35:47 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 2A24B36D6B;
	Mon,  4 Jan 2016 16:35:47 -0500 (EST)
In-Reply-To: <20160104205330.GA6658@dcvr.yhbt.net> (Eric Wong's message of
	"Mon, 4 Jan 2016 20:53:30 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 1DEF4B28-B32B-11E5-9686-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283325>

Eric Wong <normalperson@yhbt.net> writes:

> mutt saves aliases with escaped quotes in the form of:
>
> 	alias dot \"Dot U. Sir\" <somebody@example.org>
>
> When we pass through our sanitize_address routine,
> we end up with double-escaping:
>
> 	 To: "\\\"Dot U. Sir\\\" <somebody@example.org>
>
> Remove the escaping in mutt only for now, as I am not sure
> if other mailers can do this or if this is better fixed in
> sanitize_address.
>
> Cc: Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>
> Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
> ---

Forgot to sign-off (I could forge it, though, but anyway)?

>   Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> wrote:
>   > I think you meant "remove the escaping" or simply "unescape", not
>   > "remove them", which I'd understand as "remove the quotes".
>   > 
>   > Other than that, the patch looks good to me, including your proposed
>   > fixup:
>
>   Thanks, updated the comment and squashed my fixup
>
>   > I wouldn't worry too much about corner-cases, but perhaps some people do
>   > use escaped quotes inside escaped quotes. I'd say they get what they
>   > deserve ;-).
>
>   Agreed :)
>
>  git-send-email.perl   |  9 +++++++--
>  t/t9001-send-email.sh | 15 +++++++++++++++
>  2 files changed, 22 insertions(+), 2 deletions(-)
>
> diff --git a/git-send-email.perl b/git-send-email.perl
> index 6caa5b5..d356901 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -524,8 +524,13 @@ my %parse_alias = (
>  		if (/^\s*alias\s+(?:-group\s+\S+\s+)*(\S+)\s+(.*)$/) {
>  			my ($alias, $addr) = ($1, $2);
>  			$addr =~ s/#.*$//; # mutt allows # comments
> -			 # commas delimit multiple addresses
> -			$aliases{$alias} = [ split_addrs($addr) ];
> +			# commas delimit multiple addresses
> +			my @addr = split_addrs($addr);
> +
> +			# quotes may be escaped in the file,
> +			# unescape them so we do not double-escape them later.
> +			s/\\"/"/g foreach @addr;
> +			$aliases{$alias} = \@addr
>  		}}},
>  	mailrc => sub { my $fh = shift; while (<$fh>) {
>  		if (/^alias\s+(\S+)\s+(.*)$/) {
> diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
> index 3c49536..834d91a 100755
> --- a/t/t9001-send-email.sh
> +++ b/t/t9001-send-email.sh
> @@ -1527,6 +1527,21 @@ test_expect_success $PREREQ 'cccover adds Cc to all mail' '
>  	test_cover_addresses "Cc"
>  '
>  
> +test_expect_success $PREREQ 'escaped quotes in sendemail.aliasfiletype=mutt' '
> +	clean_fake_sendmail &&
> +	echo "alias sbd \\\"Dot U. Sir\\\" <somebody@example.org>" >.mutt &&
> +	git config --replace-all sendemail.aliasesfile "$(pwd)/.mutt" &&
> +	git config sendemail.aliasfiletype mutt &&
> +	git send-email \
> +		--from="Example <nobody@example.com>" \
> +		--to=sbd \
> +		--smtp-server="$(pwd)/fake.sendmail" \
> +		outdir/0001-*.patch \
> +		2>errors >out &&
> +	grep "^!somebody@example\.org!$" commandline1 &&
> +	grep -F "To: \"Dot U. Sir\" <somebody@example.org>" out
> +'
> +
>  test_expect_success $PREREQ 'sendemail.aliasfiletype=mailrc' '
>  	clean_fake_sendmail &&
>  	echo "alias sbd  somebody@example.org" >.mailrc &&
