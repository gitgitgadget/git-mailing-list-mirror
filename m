Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C61ED1FF32
	for <e@80x24.org>; Thu, 12 Oct 2017 02:55:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753163AbdJLCzg (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Oct 2017 22:55:36 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50890 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753101AbdJLCzf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Oct 2017 22:55:35 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6ABD39962B;
        Wed, 11 Oct 2017 22:55:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=p3/JVJsNJYj2EpWdMc3ehD2JvxM=; b=qKCXYf
        mn05lTa3VfNOiNB4Ybdap7lwrlRqOjGYGyC8Pobf4v85TlXdsQ6AWBtjJ1F+aTMk
        8uYtc00vh9tJxZ4djY+0AbSBIqgiVvzvn1F6IvIx0awV+d1JEXYWMhe0Ee9IvPwM
        FqFXKFNuPm1o9tvFwdcTBd8WQlgr8byu2lDx0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=KptF6xkMQrYlj5P18OevWe82qsOhBw1V
        lhiIGqWrP8s5OOcVNzuZ6XlSRhlszTGD/B/Q3B+2WGx+xvtOl/1yIgBdAG0Wc9i2
        o+9HsS0jCaMNjbrfV5WL0KwfX6mI/6tOS1UoHQQ+V7fmTY2jHguWg3JqOvax/wkJ
        9drok153DmQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5F6319962A;
        Wed, 11 Oct 2017 22:55:35 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id AC26699627;
        Wed, 11 Oct 2017 22:55:34 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jameson Miller <jameson.miller81@gmail.com>
Cc:     bmwill@google.com, git@vger.kernel.org, jamill@microsoft.com,
        peff@peff.net, sbeller@google.com
Subject: Re: [PATCH v2 2/5] Update documentation for new directory and status logic
References: <20171005205443.206900-1-jameson.miller81@gmail.com>
        <20171011133504.15049-1-jamill@microsoft.com>
        <20171011133504.15049-3-jamill@microsoft.com>
Date:   Thu, 12 Oct 2017 11:55:33 +0900
In-Reply-To: <20171011133504.15049-3-jamill@microsoft.com> (Jameson Miller's
        message of "Wed, 11 Oct 2017 09:35:01 -0400")
Message-ID: <xmqqtvz513dm.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D17D2104-AEF8-11E7-A50C-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jameson Miller <jameson.miller81@gmail.com> writes:

> Signed-off-by: Jameson Miller <jamill@microsoft.com>
> ---
>  Documentation/git-status.txt                      | 21 +++++++++++++++++-
>  Documentation/technical/api-directory-listing.txt | 27 +++++++++++++++++++----
>  2 files changed, 43 insertions(+), 5 deletions(-)
>
> diff --git a/Documentation/git-status.txt b/Documentation/git-status.txt
> index 9f3a78a36c..fc282e0a92 100644
> --- a/Documentation/git-status.txt
> +++ b/Documentation/git-status.txt
> @@ -97,8 +97,27 @@ configuration variable documented in linkgit:git-config[1].
>  	(and suppresses the output of submodule summaries when the config option
>  	`status.submoduleSummary` is set).
>  
> ---ignored::
> +--ignored[=<mode>]::
>  	Show ignored files as well.
> ++
> +The mode parameter is used to specify the handling of ignored files.
> +It is optional: it defaults to 'traditional'.
> ++
> +The possible options are:
> ++
> +	- 'traditional' - Shows ignored files and directories, unless
> +			  --untracked-files=all is specifed, in which case
> +			  individual files in ignored directories are
> +			  displayed.
> +	- 'no'	        - Show no ignored files.
> +	- 'matching'    - Shows ignored files and directories matching an
> +			  ignore pattern.
> ++
> +When 'matching' mode is specified, paths that explicity match an
> +ignored pattern are shown. If a directory matches an ignore pattern,
> +then it is shown, but not paths contained in the ignored directory. If
> +a directory does not match an ignore pattern, but all contents are
> +ignored, then the directory is not shown, but all contents are shown.

Well explained.

> diff --git a/Documentation/technical/api-directory-listing.txt b/Documentation/technical/api-directory-listing.txt
> index 6c77b4920c..7fae00f44f 100644
> --- a/Documentation/technical/api-directory-listing.txt
> +++ b/Documentation/technical/api-directory-listing.txt
> @@ -22,16 +22,20 @@ The notable options are:
>  
>  `flags`::
>  
> -	A bit-field of options (the `*IGNORED*` flags are mutually exclusive):
> +	A bit-field of options:
>  
>  `DIR_SHOW_IGNORED`:::
>  
> -	Return just ignored files in `entries[]`, not untracked files.
> +	Return just ignored files in `entries[]`, not untracked
> +	files. This flag is mutually exclusive with
> +	`DIR_SHOW_IGNORED_TOO`.
>  
>  `DIR_SHOW_IGNORED_TOO`:::
>  
> -	Similar to `DIR_SHOW_IGNORED`, but return ignored files in `ignored[]`
> -	in addition to untracked files in `entries[]`.
> +	Similar to `DIR_SHOW_IGNORED`, but return ignored files in
> +	`ignored[]` in addition to untracked files in
> +	`entries[]`. This flag is mutually exclusive with
> +	`DIR_SHOW_IGNORED`.
>  
>  `DIR_KEEP_UNTRACKED_CONTENTS`:::
>  
> @@ -39,6 +43,21 @@ The notable options are:
>  	untracked contents of untracked directories are also returned in
>  	`entries[]`.
>  
> +`DIR_SHOW_IGNORED_TOO_MODE_MATCHING`:::
> +
> +	Only has meaning if `DIR_SHOW_IGNORED_TOO` is also set; if
> +	this is set, returns ignored files and directories that match
> +	an exclude pattern. If a directory matches an exclude pattern,
> +	then the directory is returned and the contained paths are
> +	not. A directory that does not match an exclude pattern will
> +	not be returned even if all of its contents are ignored. In
> +	this case, the contents are returned as individual entries.
> ++
> +If this is set, files and directories that explicity match an ignore
> +pattern are reported. Implicity ignored directories (directories that
> +do not match an ignore pattern, but whose contents are all ignored)
> +are not reported, instead all of the contents are reported.

Makes me wonder if DIR_SHOW_IGNORED* should be splt out into a short
enum.  We have:

 - Do not show ignored ones (0)

 - Collect ignored ones (DIR_SHOW_IGNORED)

 - Collect ignored and untracked ones separately (DIR_SHOW_IGNORED_TOO)

 - Collect ignored and duntracked ones separately, but limit them to
   those mach exclude patterns explicitly (DIR_SHOW_IGNORED_TOO|...MODE_MATCHING)

so we need two bits to fit a 4-possiblity enum.

Then we do not have to worry about saying quirky things like A and B
are incompatible, and C makes sense only when B is set, etc.

>  `DIR_COLLECT_IGNORED`:::
>  
>  	Special mode for git-add. Return ignored files in `ignored[]` and
