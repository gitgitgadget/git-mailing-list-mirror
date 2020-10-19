Return-Path: <SRS0=jQhj=D2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F8F8C433DF
	for <git@archiver.kernel.org>; Mon, 19 Oct 2020 11:36:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E258922257
	for <git@archiver.kernel.org>; Mon, 19 Oct 2020 11:36:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=talktalk.net header.i=@talktalk.net header.b="JltoZUkh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726336AbgJSLgt (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Oct 2020 07:36:49 -0400
Received: from smtp-out-1.talktalk.net ([62.24.135.65]:58307 "EHLO
        smtp-out-1.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725799AbgJSLgs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Oct 2020 07:36:48 -0400
X-Greylist: delayed 487 seconds by postgrey-1.27 at vger.kernel.org; Mon, 19 Oct 2020 07:36:43 EDT
Received: from [192.168.1.240] ([146.90.45.13])
        by smtp.talktalk.net with SMTP
        id UTL7kB3gdsiDnUTL8kmUFq; Mon, 19 Oct 2020 12:28:35 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1603106915;
        bh=Z7xtkso69x7rbeKvGQwyYiuBCncZ/8YMbO5zL+I6yas=;
        h=Reply-To:Subject:To:References:From:Date:In-Reply-To;
        b=JltoZUkh7sOE6jtIoDJjsHz3okoEh4BfLezsy7mZDeiiuB71qX7vJbt2Jm/3uo6Rr
         d4AB4Dnlez0wJhRKxY+Q0uhqaz34CyXIm5H9AhMuhCqZn7LIm2UVbM3bGmnZ0rcDaY
         rEVFHbAeS5k0Cfs2hXlaFFAGrrb1L4BGUHxgDSc8=
X-Originating-IP: [146.90.45.13]
X-Spam: 0
X-OAuthority: v=2.3 cv=T5nysMCQ c=1 sm=1 tr=0 a=Lw6dPfHrQipfodWqfcGnZw==:117
 a=Lw6dPfHrQipfodWqfcGnZw==:17 a=IkcTkHD0fZMA:10 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=CjxXgO3LAAAA:8 a=P5wrnlEIAAAA:8 a=W1Dq9srIZMRZX2WmoPsA:9
 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22 a=aoaxo0Z0h-rxbPFMW5aL:22
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [OUTREACHY][PATCH v1] t7006: Use test_path_is_* functions in test
 script
To:     Joey S <jgsal@protonmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
References: <ERmIkC3rLZ3BAyv2Nq_GK0CjWvEQw6ejl8V-HVvwCsyIv0guQV67nO8KMLi7eA9qO5mo_ZJ8XB360uP_LtP-LY1xsaRBXHsc0F1uSID-KPE=@protonmail.com>
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <ff9619cd-8a31-9ce4-f0e9-c7291a4141d2@talktalk.net>
Date:   Mon, 19 Oct 2020 12:28:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <ERmIkC3rLZ3BAyv2Nq_GK0CjWvEQw6ejl8V-HVvwCsyIv0guQV67nO8KMLi7eA9qO5mo_ZJ8XB360uP_LtP-LY1xsaRBXHsc0F1uSID-KPE=@protonmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfP8kI4TQKeGUFmYgkw2fZ53Vj546sJR2IjGzMme85XpZvjOlmIZ/W1sjKGerYYJxay3mFZIZr3HC3ZFNdpqfLn16NpLeRAkTOow8Xa4zfiuPhtT5dbRT
 33GlBt6s0xDPDp1yxroJBtr8TDDk3dtI2LFIReQCcQBTstc61ELoKKz/L2CveAwQk6hcaYTKMIWbTt1wqNgzt2OZI9R2Dh7oUgo=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Joey

On 19/10/2020 05:26, Joey S wrote:
> Hi everyone,
> 
> This is my first contribution to Git's public repo and, after using Git for several years, I'm very looking forward to becoming an active member of the community.

Welcome to the list

> In this patch for test t7006-pager, I have:
> 
>    - ensured the guidelines[1] were followed
>    - used the helper function 'test_path_is_file()' to replace all found instances of 'test -e'
> 
> Please find the output of 'git format-patch' below.
> 
> Thank you all, looking forward to your feedback and observations,
> 
> Joey
> 
> [1] lore.kernel.org/git/CAPig+cQpUu2UO-+jWn1nTaDykWnxwuEitzVB7PnW2SS_b7V8Hg@mail.gmail.com/
> 

All this text above is useful context for reviewers but appears as part 
of the commit message which is not what you want. If you add notes after 
the `---` line below then they will not end up in the commit message.

> Modernized the test by replacing 'test -e' instances with
> test_path_is_file helper functions.

s/Modernized/Modernize/

I've got some comments about the conversions of `! test -e` below


> Signed-off-by: JoeyS <jgsal@yahoo.com>
> ---
>   t/t7006-pager.sh | 84 ++++++++++++++++++++++++------------------------
>   1 file changed, 42 insertions(+), 42 deletions(-)
> 
> diff --git a/t/t7006-pager.sh b/t/t7006-pager.sh
> index 00e09a375c..1d0f75e34e 100755
> --- a/t/t7006-pager.sh
> +++ b/t/t7006-pager.sh
> @@ -19,7 +19,7 @@ test_expect_success 'setup' '
>   test_expect_success TTY 'some commands use a pager' '
>   	rm -f paginated.out &&
>   	test_terminal git log &&
> -	test -e paginated.out
> +	test_path_is_file paginated.out
>   '

This and all the other conversions of `test -e` look fine

>   test_expect_failure TTY 'pager runs from subdir' '
> @@ -65,49 +65,49 @@ test_expect_success !MINGW,TTY 'LESS and LV envvars set by git-sh-setup' '
>   test_expect_success TTY 'some commands do not use a pager' '
>   	rm -f paginated.out &&
>   	test_terminal git rev-list HEAD &&
> -	! test -e paginated.out
> +	! test_path_is_file paginated.out

It would be better to replace `! test -e` this with 
`test_path_is_missing` as the modified test will pass if paginated.out 
exists but is not a file. `test_path_is_missing` will print an 
appropriate diagnostic message as well.

Best Wishes

Phillip

>   '
> 
>   test_expect_success 'no pager when stdout is a pipe' '
>   	rm -f paginated.out &&
>   	git log | cat &&
> -	! test -e paginated.out
> +	! test_path_is_file paginated.out
>   '
> 
>   test_expect_success 'no pager when stdout is a regular file' '
>   	rm -f paginated.out &&
>   	git log >file &&
> -	! test -e paginated.out
> +	! test_path_is_file paginated.out
>   '
> 
>   test_expect_success TTY 'git --paginate rev-list uses a pager' '
>   	rm -f paginated.out &&
>   	test_terminal git --paginate rev-list HEAD &&
> -	test -e paginated.out
> +	test_path_is_file paginated.out
>   '
> 
>   test_expect_success 'no pager even with --paginate when stdout is a pipe' '
>   	rm -f file paginated.out &&
>   	git --paginate log | cat &&
> -	! test -e paginated.out
> +	! test_path_is_file paginated.out
>   '
> 
>   test_expect_success TTY 'no pager with --no-pager' '
>   	rm -f paginated.out &&
>   	test_terminal git --no-pager log &&
> -	! test -e paginated.out
> +	! test_path_is_file paginated.out
>   '
> 
>   test_expect_success TTY 'configuration can disable pager' '
>   	rm -f paginated.out &&
>   	test_unconfig pager.grep &&
>   	test_terminal git grep initial &&
> -	test -e paginated.out &&
> +	test_path_is_file paginated.out &&
> 
>   	rm -f paginated.out &&
>   	test_config pager.grep false &&
>   	test_terminal git grep initial &&
> -	! test -e paginated.out
> +	! test_path_is_file paginated.out
>   '
> 
>   test_expect_success TTY 'configuration can enable pager (from subdir)' '
> @@ -122,107 +122,107 @@ test_expect_success TTY 'configuration can enable pager (from subdir)' '
>   		test_terminal git bundle unbundle ../test.bundle
>   	) &&
>   	{
> -		test -e paginated.out ||
> -		test -e subdir/paginated.out
> +		test_path_is_file paginated.out ||
> +		test_path_is_file subdir/paginated.out
>   	}
>   '
> 
>   test_expect_success TTY 'git tag -l defaults to paging' '
>   	rm -f paginated.out &&
>   	test_terminal git tag -l &&
> -	test -e paginated.out
> +	test_path_is_file paginated.out
>   '
> 
>   test_expect_success TTY 'git tag -l respects pager.tag' '
>   	rm -f paginated.out &&
>   	test_terminal git -c pager.tag=false tag -l &&
> -	! test -e paginated.out
> +	! test_path_is_file paginated.out
>   '
> 
>   test_expect_success TTY 'git tag -l respects --no-pager' '
>   	rm -f paginated.out &&
>   	test_terminal git -c pager.tag --no-pager tag -l &&
> -	! test -e paginated.out
> +	! test_path_is_file paginated.out
>   '
> 
>   test_expect_success TTY 'git tag with no args defaults to paging' '
>   	# no args implies -l so this should page like -l
>   	rm -f paginated.out &&
>   	test_terminal git tag &&
> -	test -e paginated.out
> +	test_path_is_file paginated.out
>   '
> 
>   test_expect_success TTY 'git tag with no args respects pager.tag' '
>   	# no args implies -l so this should page like -l
>   	rm -f paginated.out &&
>   	test_terminal git -c pager.tag=false tag &&
> -	! test -e paginated.out
> +	! test_path_is_file paginated.out
>   '
> 
>   test_expect_success TTY 'git tag --contains defaults to paging' '
>   	# --contains implies -l so this should page like -l
>   	rm -f paginated.out &&
>   	test_terminal git tag --contains &&
> -	test -e paginated.out
> +	test_path_is_file paginated.out
>   '
> 
>   test_expect_success TTY 'git tag --contains respects pager.tag' '
>   	# --contains implies -l so this should page like -l
>   	rm -f paginated.out &&
>   	test_terminal git -c pager.tag=false tag --contains &&
> -	! test -e paginated.out
> +	! test_path_is_file paginated.out
>   '
> 
>   test_expect_success TTY 'git tag -a defaults to not paging' '
>   	test_when_finished "git tag -d newtag" &&
>   	rm -f paginated.out &&
>   	test_terminal git tag -am message newtag &&
> -	! test -e paginated.out
> +	! test_path_is_file paginated.out
>   '
> 
>   test_expect_success TTY 'git tag -a ignores pager.tag' '
>   	test_when_finished "git tag -d newtag" &&
>   	rm -f paginated.out &&
>   	test_terminal git -c pager.tag tag -am message newtag &&
> -	! test -e paginated.out
> +	! test_path_is_file paginated.out
>   '
> 
>   test_expect_success TTY 'git tag -a respects --paginate' '
>   	test_when_finished "git tag -d newtag" &&
>   	rm -f paginated.out &&
>   	test_terminal git --paginate tag -am message newtag &&
> -	test -e paginated.out
> +	test_path_is_file paginated.out
>   '
> 
>   test_expect_success TTY 'git tag as alias ignores pager.tag with -a' '
>   	test_when_finished "git tag -d newtag" &&
>   	rm -f paginated.out &&
>   	test_terminal git -c pager.tag -c alias.t=tag t -am message newtag &&
> -	! test -e paginated.out
> +	! test_path_is_file paginated.out
>   '
> 
>   test_expect_success TTY 'git tag as alias respects pager.tag with -l' '
>   	rm -f paginated.out &&
>   	test_terminal git -c pager.tag=false -c alias.t=tag t -l &&
> -	! test -e paginated.out
> +	! test_path_is_file paginated.out
>   '
> 
>   test_expect_success TTY 'git branch defaults to paging' '
>   	rm -f paginated.out &&
>   	test_terminal git branch &&
> -	test -e paginated.out
> +	test_path_is_file paginated.out
>   '
> 
>   test_expect_success TTY 'git branch respects pager.branch' '
>   	rm -f paginated.out &&
>   	test_terminal git -c pager.branch=false branch &&
> -	! test -e paginated.out
> +	! test_path_is_file paginated.out
>   '
> 
>   test_expect_success TTY 'git branch respects --no-pager' '
>   	rm -f paginated.out &&
>   	test_terminal git --no-pager branch &&
> -	! test -e paginated.out
> +	! test_path_is_file paginated.out
>   '
> 
>   test_expect_success TTY 'git branch --edit-description ignores pager.branch' '
> @@ -232,8 +232,8 @@ test_expect_success TTY 'git branch --edit-description ignores pager.branch' '
>   		touch editor.used
>   	EOF
>   	EDITOR=./editor test_terminal git -c pager.branch branch --edit-description &&
> -	! test -e paginated.out &&
> -	test -e editor.used
> +	! test_path_is_file paginated.out &&
> +	test_path_is_file editor.used
>   '
> 
>   test_expect_success TTY 'git branch --set-upstream-to ignores pager.branch' '
> @@ -242,13 +242,13 @@ test_expect_success TTY 'git branch --set-upstream-to ignores pager.branch' '
>   	test_when_finished "git branch -D other" &&
>   	test_terminal git -c pager.branch branch --set-upstream-to=other &&
>   	test_when_finished "git branch --unset-upstream" &&
> -	! test -e paginated.out
> +	! test_path_is_file paginated.out
>   '
> 
>   test_expect_success TTY 'git config ignores pager.config when setting' '
>   	rm -f paginated.out &&
>   	test_terminal git -c pager.config config foo.bar bar &&
> -	! test -e paginated.out
> +	! test_path_is_file paginated.out
>   '
> 
>   test_expect_success TTY 'git config --edit ignores pager.config' '
> @@ -257,33 +257,33 @@ test_expect_success TTY 'git config --edit ignores pager.config' '
>   		touch editor.used
>   	EOF
>   	EDITOR=./editor test_terminal git -c pager.config config --edit &&
> -	! test -e paginated.out &&
> -	test -e editor.used
> +	! test_path_is_file paginated.out &&
> +	test_path_is_file editor.used
>   '
> 
>   test_expect_success TTY 'git config --get ignores pager.config' '
>   	rm -f paginated.out &&
>   	test_terminal git -c pager.config config --get foo.bar &&
> -	! test -e paginated.out
> +	! test_path_is_file paginated.out
>   '
> 
>   test_expect_success TTY 'git config --get-urlmatch defaults to paging' '
>   	rm -f paginated.out &&
>   	test_terminal git -c http."https://foo.com/".bar=foo \
>   			  config --get-urlmatch http https://foo.com &&
> -	test -e paginated.out
> +	test_path_is_file paginated.out
>   '
> 
>   test_expect_success TTY 'git config --get-all respects pager.config' '
>   	rm -f paginated.out &&
>   	test_terminal git -c pager.config=false config --get-all foo.bar &&
> -	! test -e paginated.out
> +	! test_path_is_file paginated.out
>   '
> 
>   test_expect_success TTY 'git config --list defaults to paging' '
>   	rm -f paginated.out &&
>   	test_terminal git config --list &&
> -	test -e paginated.out
> +	test_path_is_file paginated.out
>   '
> 
> 
> @@ -392,7 +392,7 @@ test_default_pager() {
>   			export PATH &&
>   			$full_command
>   		) &&
> -		test -e default_pager_used
> +		test_path_is_file default_pager_used
>   	"
>   }
> 
> @@ -406,7 +406,7 @@ test_PAGER_overrides() {
>   		PAGER='wc >PAGER_used' &&
>   		export PAGER &&
>   		$full_command &&
> -		test -e PAGER_used
> +		test_path_is_file PAGER_used
>   	"
>   }
> 
> @@ -432,7 +432,7 @@ test_core_pager() {
>   		export PAGER &&
>   		test_config core.pager 'wc >core.pager_used' &&
>   		$full_command &&
> -		${if_local_config}test -e core.pager_used
> +		${if_local_config}test_path_is_file core.pager_used
>   	"
>   }
> 
> @@ -464,7 +464,7 @@ test_pager_subdir_helper() {
>   			cd sub &&
>   			$full_command
>   		) &&
> -		${if_local_config}test -e core.pager_used
> +		${if_local_config}test_path_is_file core.pager_used
>   	"
>   }
> 
> @@ -477,7 +477,7 @@ test_GIT_PAGER_overrides() {
>   		GIT_PAGER='wc >GIT_PAGER_used' &&
>   		export GIT_PAGER &&
>   		$full_command &&
> -		test -e GIT_PAGER_used
> +		test_path_is_file GIT_PAGER_used
>   	"
>   }
> 
> @@ -489,7 +489,7 @@ test_doesnt_paginate() {
>   		GIT_PAGER='wc >GIT_PAGER_used' &&
>   		export GIT_PAGER &&
>   		$full_command &&
> -		! test -e GIT_PAGER_used
> +		! test_path_is_file GIT_PAGER_used
>   	"
>   }
> 
> --
> 2.29.0.rc2
> 

