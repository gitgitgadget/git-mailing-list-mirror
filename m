From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] t4010: match_pathspec_depth() and trailing slash after submodule
Date: Thu, 23 Jan 2014 13:09:08 -0800
Message-ID: <xmqqa9emtngr.fsf@gitster.dls.corp.google.com>
References: <2550653.GHkhBQDSTk@localhost.localdomain>
	<1390483326-32258-1-git-send-email-pclouds@gmail.com>
	<1390483326-32258-2-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, pawel.sikora@agmk.net, Jens.Lehmann@web.de
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 23 22:09:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W6RWe-00041U-PN
	for gcvg-git-2@plane.gmane.org; Thu, 23 Jan 2014 22:09:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753177AbaAWVJS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 23 Jan 2014 16:09:18 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53758 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751939AbaAWVJQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 Jan 2014 16:09:16 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0F0D364831;
	Thu, 23 Jan 2014 16:09:16 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=8tah35hV9wmv
	aueYbmkOoYg1x+E=; b=lRjtURtfqR6Bg92F7f9197s2BenYOxUacjReCngjQD0z
	qNMNnhYV8o4p3/XWaUaWakxKARhV2AMERAgY6f06OBq22ovfWvdM+BdKzcyQLEG+
	qlrmxYvXNINLuEka4P1LzpeE6GnwYR0YA2wQvFTupVkf2FmYTJsvzefmSrpmOOA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=H9zyao
	2yPtu+DFSk8clRj2s2g2MKT7aG2F6WJTGXFrpUeLve8CGuVNjg/R/WZ04qtRcqNu
	S6TnGTCqWqQeQYE+v/r+/12zm7qTrJmIeF5PSA0hunKKws7EBIrHXqKpSS3qu6IY
	PeePBLPiK3HcZ9KgMDZdCH2GiYwVFAYz/mn00=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E14166482E;
	Thu, 23 Jan 2014 16:09:15 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 90BF76482A;
	Thu, 23 Jan 2014 16:09:14 -0500 (EST)
In-Reply-To: <1390483326-32258-2-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Thu, 23
 Jan 2014 20:22:06 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 9CFA20D0-8472-11E3-88E3-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240952>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> When you do "git diff HEAD submodule/", "submodule" from the index is
> picked out and match_pathspec_depth() in charge of matching it with
> the pathspec "submodule/".

Is "... is called" or something missing at the end of this sentence?

> Unlike tree_entry_interesting(), match_pathspec_depth() has no
> knowledge about entry mode to realize "submodule" is a directory and
> treat the trailing slash specially. And it does not have too, mostly,

s/too/to/, I think.

> because the index only contains files, not directories (not until
> submodules come)
>
> I have no solutions for it (no, stripping '/' at pathspec
> preprocessing phase seems like a workaround than a solution). So let'=
s
> mark it. Maybe I or somebody else could revisit it later.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  t/t4010-diff-pathspec.sh | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/t/t4010-diff-pathspec.sh b/t/t4010-diff-pathspec.sh
> index 15a4912..b54251a 100755
> --- a/t/t4010-diff-pathspec.sh
> +++ b/t/t4010-diff-pathspec.sh
> @@ -127,4 +127,10 @@ test_expect_success 'diff-tree ignores trailing =
slash on submodule path' '
>  	test_cmp expect actual
>  '
> =20
> +test_expect_failure 'diff-cache ignores trailing slash on submodule =
path' '
> +	git diff --name-only HEAD^ submod >expect &&
> +	git diff --name-only HEAD^ submod/ >actual &&

I actually doubt that the second line is expecting the right
behaviour in the first place.  As far as the top-level project is
concerned, "submod" is the name it wants, as there is nothing
underneath it.  Even if asked to recurse infinite levels, the caller
shouldn't be feeding paths like "submod/a/b/c" to
match_pathspec_depth() in the first place, no?



> +	test_cmp expect actual
> +'
> +
>  test_done
