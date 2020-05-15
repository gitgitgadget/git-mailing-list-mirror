Return-Path: <SRS0=YoUm=65=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 041C1C433E0
	for <git@archiver.kernel.org>; Fri, 15 May 2020 16:38:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D566D2078C
	for <git@archiver.kernel.org>; Fri, 15 May 2020 16:38:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="C8bTzVvY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726221AbgEOQiL (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 May 2020 12:38:11 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:53305 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726185AbgEOQiL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 May 2020 12:38:11 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 92EE2CD0FF;
        Fri, 15 May 2020 12:38:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=VYJPZmpeaqtM
        K7tXTAvnWOAgs9s=; b=C8bTzVvYqvoNY/EPBtBmunHnjL8lLMvtqUxjR6lcSm31
        i2RKkAmsf1zxe1WvicfwDCMn8ueB9euAYSg1E40YdMoeQh+kj55QF0PkOdWGbEe5
        oFZMaGvfe8V1ruL569v0ziESu0LHKraxy1R20fENR6p1bD3+gpNSnYQDLEKsMn8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=C7rMyW
        eXpwAi20LAEv19wNbf8c4mPjmp75SciWEddzxfox+x/ITrZG6wxTfo4PfDeFTgC3
        yWhdg6GFRKQpa94GKJ3fxltb7L4IUPFTkZnul1ljJXp9DjCH5Eg7DgMY4pUhSbNg
        aAFnVInHWuUyxCtW/TfZf2XCMdQxODpXWPze0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 88ACDCD0FE;
        Fri, 15 May 2020 12:38:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id BD1ABCD0FC;
        Fri, 15 May 2020 12:38:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>
Cc:     git@vger.kernel.org, alban.gruin@gmail.com, congdanhqx@gmail.com,
        johannes.schindelin@gmx.de
Subject: Re: [RFC PATCH] t: move metadata into TAP test description
References: <5b373748-d986-1aec-670f-7ac1502e7052@gmail.com>
        <20200515150041.22873-1-carenas@gmail.com>
Date:   Fri, 15 May 2020 09:38:06 -0700
In-Reply-To: <20200515150041.22873-1-carenas@gmail.com> ("Carlo Marcelo
 Arenas
        =?utf-8?Q?Bel=C3=B3n=22's?= message of "Fri, 15 May 2020 08:00:41 -0700")
Message-ID: <xmqqpnb5m9w1.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 74F387AE-96CA-11EA-9A4A-B0405B776F7B-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Carlo Marcelo Arenas Bel=C3=B3n  <carenas@gmail.com> writes:

> 662f9cf154 (tests: when run in Bash, annotate test failures with file
> name/line number, 2020-04-11) adds metadata to the TAP output to help
> identify the location of the failed test, but does it in a way that
> break the TAP format and therefore confuses prove.
>
> Move the metadata to the description to workaround the issue and
> change the regex from 676eb0c1ce (ci: add a problem matcher for GitHub
> Actions, 2020-04-11) to match.
>
> Reported-by: Alban Gruin <alban.gruin@gmail.com>
> ---
>  ci/git-problem-matcher.json | 10 +++++-----
>  t/test-lib.sh               |  6 +++---
>  2 files changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/ci/git-problem-matcher.json b/ci/git-problem-matcher.json
> index 506dfbd97f..e10e88bba1 100644
> --- a/ci/git-problem-matcher.json
> +++ b/ci/git-problem-matcher.json
> @@ -4,11 +4,11 @@
>              "owner": "git-test-suite",
>              "pattern": [
>                  {
> -                    "regexp": "^([^ :]+\\.sh):(\\d+): (error|warning|i=
nfo):\\s+(.*)$",
> -                    "file": 1,
> -                    "line": 2,
> -                    "severity": 3,
> -                    "message": 4
> +                    "regexp": "^(.*)(error|warning|info):\\([^ :]+\\.s=
h):(\\d+)\\)$",

Do we ever run our tests in ci environments with a shell other than
bash?  Would we still work fine without the "error:<F>:<L>:" suffix?
I guess we just live with degraded output in such a case, and is
much better than breaking TAP when tests are run under bash.

The tail part of this pattern (starting at error/warn/info) is tight
enough that the overly loose (.*) for the message part may still
match the "rest of the message that has arbitrary string" just fine,
but it might be less error prone to add an unusual letter (e.g. "|")
in the output between "not ok $test_count - $1" and the output from
the file_lineno() helper to make sure that we won't end up eating a
word "error" etc. at the end of the test title.  I dunno.

> +                    "file": 3,
> +                    "line": 4,
> +                    "severity": 2,
> +                    "message": 1
>                  }
>              ]
>          }
> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index baf94546da..d5f59ab3bf 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -682,8 +682,8 @@ file_lineno () {
>  		for i in ${!BASH_SOURCE[*]}
>  		do
>  			case $i,"${BASH_SOURCE[$i]##*/}" in
> -			0,t[0-9]*.sh) echo "t/${BASH_SOURCE[$i]}:$LINENO: ${1+$1: }"; retur=
n;;
> -			*,t[0-9]*.sh) echo "t/${BASH_SOURCE[$i]}:${BASH_LINENO[$(($i-1))]}:=
 ${1+$1: }"; return;;
> +			0,t[0-9]*.sh) echo "(${1+$1:}t/${BASH_SOURCE[$i]}:$LINENO)"; return=
;;
> +			*,t[0-9]*.sh) echo "(${1+$1:}t/${BASH_SOURCE[$i]}:${BASH_LINENO[$((=
$i-1))]})"; return;;
>  			esac
>  		done
>  	'
> @@ -734,7 +734,7 @@ test_failure_ () {
>  		write_junit_xml_testcase "$1" "      $junit_insert"
>  	fi
>  	test_failure=3D$(($test_failure + 1))
> -	say_color error "$(file_lineno error)not ok $test_count - $1"
> +	say_color error "not ok $test_count - $1$(file_lineno error)"
>  	shift
>  	printf '%s\n' "$*" | sed -e 's/^/#	/'
>  	test "$immediate" =3D "" || { finalize_junit_xml; GIT_EXIT_OK=3Dt; ex=
it 1; }
