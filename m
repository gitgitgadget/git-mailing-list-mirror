From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v5 3/3] cat-file: add --follow-symlinks to --batch
Date: Tue, 12 May 2015 19:34:04 +0200
Message-ID: <5552398C.20700@kdbg.org>
References: <1431384645-17276-1-git-send-email-dturner@twopensource.com> <1431384645-17276-4-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: David Turner <dturner@twitter.com>
To: dturner@twopensource.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 12 19:34:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YsE4K-0004KW-Lm
	for gcvg-git-2@plane.gmane.org; Tue, 12 May 2015 19:34:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933490AbbELReI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 May 2015 13:34:08 -0400
Received: from bsmtp4.bon.at ([195.3.86.186]:53531 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S933492AbbELReG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 May 2015 13:34:06 -0400
Received: from dx.site (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTPSA id 3lmR7x0ckLz5tlJ;
	Tue, 12 May 2015 19:34:04 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.site (Postfix) with ESMTP id B908C2A9E;
	Tue, 12 May 2015 19:34:04 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.6.0
In-Reply-To: <1431384645-17276-4-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268862>

Am 12.05.2015 um 00:50 schrieb dturner@twopensource.com:
> +# Tests for git cat-file --follow-symlinks
> +test_expect_success 'prep for symlink tests' '
> +	echo_without_newline "$hello_content" >morx &&
> +	test_ln_s_add morx same-dir-link &&
> +	test_ln_s_add ../fleem out-of-repo-link &&
> +	test_ln_s_add .. out-of-repo-link-dir &&
> +	test_ln_s_add same-dir-link link-to-link &&
> +	test_ln_s_add nope broken-same-dir-link &&
> +	mkdir dir &&
> +	test_ln_s_add ../morx dir/parent-dir-link &&
> +	test_ln_s_add .. dir/link-dir &&
> +	test_ln_s_add ../../escape dir/out-of-repo-link &&
> +	test_ln_s_add ../.. dir/out-of-repo-link-dir &&
> +	test_ln_s_add nope dir/broken-link-in-dir &&
> +	mkdir dir/subdir &&
> +	test_ln_s_add ../../morx dir/subdir/grandparent-dir-link &&
> +	test_ln_s_add ../../../great-escape dir/subdir/out-of-repo-link &&
> +	test_ln_s_add ../../.. dir/subdir/out-of-repo-link-dir &&
> +	test_ln_s_add ../../../ dir/subdir/out-of-repo-link-dir-trailing &&
> +	test_ln_s_add ../parent-dir-link dir/subdir/parent-dir-link-to-link &&
> +	echo_without_newline "$hello_content" >dir/subdir/ind2 &&
> +	echo_without_newline "$hello_content" >dir/ind1 &&
> +	test_ln_s_add dir dirlink &&
> +	test_ln_s_add dir/subdir subdirlink &&
> +	test_ln_s_add subdir/ind2 dir/link-to-child &&
> +	test_ln_s_add dir/link-to-child link-to-down-link &&
> +	test_ln_s_add dir/.. up-down &&
> +	test_ln_s_add dir/../ up-down-trailing &&
> +	test_ln_s_add dir/../morx up-down-file &&
> +	test_ln_s_add dir/../../morx up-up-down-file &&
> +	test_ln_s_add subdirlink/../../morx up-two-down-file &&
> +	test_ln_s_add loop1 loop2 &&
> +	test_ln_s_add loop2 loop1 &&
> +	git add morx dir/subdir/ind2 dir/ind1 &&
> +	git commit -am "test"

Broken && chain.

> +	echo $hello_sha1 blob $hello_size >found
> +'

-- Hannes
