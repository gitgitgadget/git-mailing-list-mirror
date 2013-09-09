From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] Teach git to change to a given directory using -C option
Date: Mon, 09 Sep 2013 09:32:02 -0700
Message-ID: <xmqqtxhu3qil.fsf@gitster.dls.corp.google.com>
References: <20130903115944.GA29542@gmail.com>
	<xmqq8uzdplqv.fsf@gitster.dls.corp.google.com>
	<CAEY4ZpN4xgt+gJSVeTfDNC--xt3N+M7vVLFBC7FTWBQtjvN8tw@mail.gmail.com>
	<20130904122020.GA25538@gmail.com>
	<CAPig+cRt9o=6Amhx6qTkzfk5R9aQfRZ=357BOVELm_hPsWE3WQ@mail.gmail.com>
	<CAEY4ZpNEae1UprRcpC8XUPP4XBQ89bDXP1A7yVcFdW405HZr0w@mail.gmail.com>
	<CAPig+cTNeqNhGwD-EZ3uszh5vJ4JeJ6L0RXdTsveb1FgXE5t3Q@mail.gmail.com>
	<20130909134743.GA11335@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Nazri Ramliy <ayiehere@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 09 18:32:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJ4Nu-00023Y-KG
	for gcvg-git-2@plane.gmane.org; Mon, 09 Sep 2013 18:32:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754731Ab3IIQcO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Sep 2013 12:32:14 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51573 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754340Ab3IIQcN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Sep 2013 12:32:13 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 271D23ECE1;
	Mon,  9 Sep 2013 16:32:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=aXJj3K2tTFrVEWsvyHmOOiVK7KI=; b=aLSD4t
	MVbfKLM3R2pD1A75c7kdAtqNY1h9nCmCH7dZ2CzkVCcTXt/WcNgS25zGuHMCle7O
	z8ZDdqAgwH7Fh2V1eq0ebJ14aA6xdUHYPCFgbU1qVgl4d0sjATeXRqa7GESHhVdn
	ue72w+/XijSa53lMTvH8ND+7CAyYSnET2HyW4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MRrWj8yFZG8D3g+/TmWqUpmfa5EpICp2
	UEnsGiLiekK+1CLAFj+W/6ICABwCC10ydXFFID3jD+eAGfilBgz7ysH+Q7A82DSN
	M0VzZbXgudFcgm5dIF08o95kG/tXhzU8tVPtYsVs+5vUasSKNCCtEPktdCZJo99N
	3IalKLcnm6g=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B30973ECDC;
	Mon,  9 Sep 2013 16:32:11 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 807C53ECD2;
	Mon,  9 Sep 2013 16:32:10 +0000 (UTC)
In-Reply-To: <20130909134743.GA11335@gmail.com> (Nazri Ramliy's message of
	"Mon, 9 Sep 2013 21:47:43 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 60207A4E-196D-11E3-B61A-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234350>

Nazri Ramliy <ayiehere@gmail.com> writes:

> Subject: git: run in a directory given with -C option
>
> This is similar in spirit to to "make -C dir ..." and "tar -C dir ...".

The doubled-"to to" which I locally fixed when I queued the last one
(together with other rewording to make it more agreeable and easier
to read) somehow came back ;-) Will fix locally again.

> +-C <path>::
> +	Run as if git was started in '<path>' instead of the current working
> +	directory.  When multiple '-C' options are given, each subsequent

I think this should be `-C` to typeset it as "typed literally".

> +	non-absolute `-C <path>` is interpreted relative to the preceding `-C
> +	<path>`.
> ++
> +This option affects options that expect path name like '--git-dir' and
> +'--work-tree' in that their interpretations of the path names would be

Likewise for `--git-dir` and `--work-tree`.

> +made relative to the working directory caused by the '-C' option. For

and here.

> diff --git a/t/t0056-git-C.sh b/t/t0056-git-C.sh
> new file mode 100755
> index 0000000..c0006da
> --- /dev/null
> +++ b/t/t0056-git-C.sh
> @@ -0,0 +1,82 @@
> +#!/bin/sh
> +
> +test_description='"-C <path>" option and its effects on other path-related options'
> +
> +. ./test-lib.sh
> +
> +test_expect_success '"git -C <path>" runs git from the directory <path>' '
> +	test_create_repo dir1 &&
> +	echo 1 >dir1/a.txt &&
> +	(cd dir1 && git add a.txt && git commit -m "initial in dir1") &&

Curious why this does not use -C here.

> +	echo "initial in dir1" >expected &&
> +	git -C dir1 log --format=%s >actual &&
> +	test_cmp expected actual
> +'
> +
> +test_expect_success 'Multiple -C options: "-C dir1 -C dir2" is equivalent to "-C dir1/dir2"' '
> +	test_create_repo dir1/dir2 &&
> +	echo 1 >dir1/dir2/a.txt &&
> +	git -C dir1/dir2 add a.txt &&

Because "a.txt" exists in both dir1 and dir1/dir2, this has less
chance of catching a bug (if somebody breaks the feature to run it
in dir1 not dir1/dir2, "add" will happily say "Oh, I found something
to add", instead of saying "Huh? there is no such path".

If you used b.txt instead, you would catch such a breakage.

Remember, tests are not about demonstrating how cool the new feature
is and/or how well it works in an expected setting.  Imagine ways
other people can break your spiffy new feature in later patches, and
design tests that are more likely to catch them.

The same comment applies throughout the remainder of this script.

> +	echo "initial in dir1/dir2" >expected &&
> +	git -C dir1/dir2 commit -m "initial in dir1/dir2" &&

to reduce possibilities of breaking this test in the future due to
typos (e.g. somebody may want to say "initial commit in dir1/dir2"),
doing this may be a better idea:

	msg="initial in dir1/dir2" &&
        echo "$msg" >expected &&
        git -C dir1/dir2 commit -m "$msg" &&

The same comment applies to the previous one.
