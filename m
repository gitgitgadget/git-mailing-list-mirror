From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC v2 3/4] fetch-pack: test cases for the new --stdin
 option
Date: Tue, 27 Mar 2012 10:40:46 -0700
Message-ID: <7v4ntaj61t.fsf@alter.siamese.dyndns.org>
References: <loom.20120318T083216-96@post.gmane.org>
 <m3fwd550j3.fsf@localhost.localdomain>
 <20120318190659.GA24829@sigill.intra.peff.net>
 <CACsJy8BNT-dY+wDONY_TgLnv0135RZ-47BEVMzX6c3ddH=83Zw@mail.gmail.com>
 <20120319024436.GB10426@sigill.intra.peff.net> <4F69B5F0.2060605@gmx.net>
 <CAJo=hJu0H5wfXB_y5XQ6=S0VJ9t4pxHWkuy_=rehJL_6psf00g@mail.gmail.com>
 <20120321171423.GA13140@sigill.intra.peff.net> <4F715CF7.5070903@gmx.net>
 <4F715DBF.6030909@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Shawn Pearce <spearce@spearce.org>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Ivan Todoroski <grnch@gmx.net>
X-From: git-owner@vger.kernel.org Tue Mar 27 19:41:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCaO8-0005bX-EM
	for gcvg-git-2@plane.gmane.org; Tue, 27 Mar 2012 19:40:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754597Ab2C0Rku (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Mar 2012 13:40:50 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61585 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753459Ab2C0Rku (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Mar 2012 13:40:50 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 38AC1605F;
	Tue, 27 Mar 2012 13:40:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=e4xbPlqqQ5n3DZJ8Mu6stS2hu+k=; b=jEiFXH
	0QqyTeGJJpQy94zX1JMfgZE9VQvxld0qsMBi0TSv0rgEB1bHvMFHZhxxu9E8NMgI
	7Ut2O6O45SKJjgQAzmR7qcy60mj/FImNX0oNECQkmNGYQW8ar5u2KIMyNgroupfX
	pnv69EJFo/cybuRsKkrD/mpzgbMeodfSN5VO8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=irLgKYY7U+0MLs7Jhk4uf00WXtEXLb1j
	wpULU0+3d6eLZkxYbXwaRLnuYnQr5W5cOUcg1H9zdPeLEeBHIKuS7b61vF65g9qn
	H4qdT41jCyqCm0xzKtWFIekSQFi3JaL9hsEVRXYU/V7RcQq0c90c94o9QwrEQ7zS
	K9sepQkShVA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2F7B1605E;
	Tue, 27 Mar 2012 13:40:49 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 72522605D; Tue, 27 Mar 2012
 13:40:48 -0400 (EDT)
In-Reply-To: <4F715DBF.6030909@gmx.net> (Ivan Todoroski's message of "Tue, 27
 Mar 2012 08:27:11 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FD380A5E-7833-11E1-B262-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194061>

Ivan Todoroski <grnch@gmx.net> writes:

> These test cases focus only on testing the parsing of refs on stdin,
> without bothering with the rest of the fetch-pack machinery. We pass in
> the refs using different combinations of command line and stdin and then
> we watch fetch-pack's stdout to see whether it prints all the refs we
> specified and in the same order as we specified them.

Thanks for writing what it does concisely and clearly.  It makes it very
pleasant to review the patch.

It is sensible to expect that we see all the refs we told it to fetch, but
I do not think it is sensible to require they come in the same order as we
have given them to the command.

> For the --stateless-rpc tests we cannot easily execute fetch-pack to the
> end because that would require simulating the remote protocol. We settle
> for only checking 2 cases:
>
> 1) Whether fetch-pack correctly fails to parse the refs if they are not
> terminated by a flush packet
>
> 2) Whether fetch-pack finishes parsing the refs without error when they
> are correctly terminated by a flush packet
>
> The fetch-pack invocation fails in both cases due to the missing remote
> side of the protocol, but it fails in different ways which allows us to
> determine how the refs parsing ended by inspecting the different error
> messages.

Ick.

> ---
>  t/t5500-fetch-pack.sh |  100 +++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 100 insertions(+)
>
> diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
> index 9bf69e9a0f..f4de7d07c1 100755
> --- a/t/t5500-fetch-pack.sh
> +++ b/t/t5500-fetch-pack.sh
> @@ -248,4 +248,104 @@ test_expect_success 'clone shallow object count' '
>  	grep "^count: 52" count.shallow
>  '
>  
> +
> +cat >stdin.exp <<EOF
> +refs/heads/C
> +refs/heads/A
> +refs/heads/D
> +refs/tags/C
> +refs/heads/B
> +refs/tags/A
> +refs/heads/E
> +refs/tags/B
> +refs/tags/E
> +refs/tags/D
> +EOF
> +
> +test_expect_success 'setup tests for --stdin' '
> +	for head in C D E F; do
> +		add $head
> +	done &&
> +	for head in A B C D E F; do
> +		git tag $head $head
> +	done
> +'

Drop ";" and write "do" on its own line with proper indentation.

> +
> +test_expect_success 'fetch refs from cmdline, make sure it still works OK' '
> +	cd client &&
> +	git fetch-pack --no-progress .. $(cat ../stdin.exp) |
> +	cut -d " " -f 2 > ../stdin.act &&
> +	cd .. &&
> +	test_cmp stdin.exp stdin.act
> +'

 - Do not chdir around without being in a subprocess ();

 - Do not place the command you are testing that might crash on the
   upstream of the pipe;

 - style;

i.e.

	(
		cd client &&
                git fetch-pack --no-progress .. $(cat ../stdin.exp) >../stdin.raw
	) &&
        cut -d " " -f 2 <stdin.raw | sort >stdin.act &&
	test_cmp stdin.exp stdin.act

Note that I lifted the "in the same order" requirement, which should not
be there.  You may need to adjust the hardcoded stdin.exp to be sorted.

> +test_expect_success 'fetch refs from stdin' '
> +	cd client &&
> +	cat ../stdin.exp |
> +	git fetch-pack --stdin --no-progress .. |
> +	cut -d " " -f 2 > ../stdin.act &&
> +	cd .. &&
> +	test_cmp stdin.exp stdin.act
> +'

In addition to the comments on the previous one:

 - Do not pipe output from cat.

i.e.

	(
		cd client &&
                git fetch-pack ... <../stdin.exp >stdin.raw
	) &&
	cut -d " " -f 2 <stdin.raw | sort >stdin.act &&
	test_cmp stdin.exp stdin.act

By the way, why are these not called "expect" and "actual" like most other
tests?

> +test_expect_success 'fetch mixed refs from cmdline and stdin in right order' '
> +	cd client &&
> +	tail -n +5 ../stdin.exp |
> +	git fetch-pack --stdin --no-progress .. $(head -n 4 ../stdin.exp) |
> +	cut -d " " -f 2 > ../stdin.act &&
> +	cd .. &&
> +	test_cmp stdin.exp stdin.act
> +'

Ditto.

Do we want to have a separate test to see what happens when there are dups
in the input?

> +# remove final newline and insert random spaces, NULs, and empty lines
> +head -c -1 stdin.exp | sed -e '
> +	1i
> +	2s/^\|$/   /g
> +	4s/^/    /
> +	6s/$/    /
> +	8s/$/\n     /
> +	9s/$/Ztrailing garbage/
> +	9s/^\|$/    /g
> +' | tr "Z" "\000" > stdin.spaces

Somebody may want to try this sed expression on Macs and BSDs, but more
importantly...

> +test_expect_success 'ignore leading/trailing spaces, empty lines and NULs' '
> +	cd client &&
> +	cat ../stdin.spaces |
> +	git fetch-pack --stdin --no-progress .. |
> +	cut -d " " -f 2 > ../stdin.act &&
> +	cd .. &&
> +	test_cmp stdin.exp stdin.act
> +'

... it is unclear why it is a good thing to let the input with garbage
produce a result instead of erroring out.

The rest of the patch skimmed but not thoroughly reviewed; seems to have
similar issues as already have been pointed out above.
