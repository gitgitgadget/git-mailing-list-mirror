Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 156DF1F454
	for <e@80x24.org>; Mon, 29 Oct 2018 13:24:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726052AbeJ2WMp (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Oct 2018 18:12:45 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35774 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725920AbeJ2WMp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Oct 2018 18:12:45 -0400
Received: by mail-wm1-f67.google.com with SMTP id q12-v6so5218052wmq.0
        for <git@vger.kernel.org>; Mon, 29 Oct 2018 06:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=6T0sbqczHNjblbfFDNp6a241Et/2YtLCl3hhAY1QsZs=;
        b=dW/HRJ1C2bBnrudye4RrM/YO2+6clVs+ZbnXnbmQ792U4VN+6/Se3A1RTM5Q47T0Nk
         bWAxhmsE8INxRvQHTFi/O7HdwHO7BNDJui+tZgClxeyTne7xKave4ILUERVaQRlJQS0G
         WDuN8Bj9Gz/ktlR8zrAOGbpFoLjIRgPS2NmYzVJsfwG0G7IB/Ki83gPX2IcIHVnFwyTE
         eECYSWkkiDGitAt4XdzU8BpS3sfkfd2x5WZuPe47q1k4AynnVeGDtqtRqLuLa89yv1rH
         DU1M7zrDzIhXCeZdDe51uxQS45uwKIjh4nclehReiRjep+hpSnS5S1qIhR+K6EpNt8Zu
         XAQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=6T0sbqczHNjblbfFDNp6a241Et/2YtLCl3hhAY1QsZs=;
        b=lKmOO6+X22dEbHuiwm49FFKcSxL4DIQitZAulYBCXGwaPmMzYsfI6gUiiCE4M2PBb0
         zLcaNBO0Mg7/hAAnT8tpCzOS/mlCUn2vk9fkRtQxkSLqa2i+81qJHVq3mooCXWrdDniR
         yyGQuEgqBbTohOEVWcmQ5bg4WmC2ik3teZsvEjsfzvv3y+g9CAIcrns0sRUfO1UtMX5a
         ZhtRW+Ys4hZ11CTRevqE7xSZTu1aiCpU9uz5ipwyAYewbA80vWU2NyZ17F5FKcc//yTz
         89FbtaFjB9Xjmz8+KuxNFPWngs64uuEB/6bqk8cogqJmwrtqdn3M00evkcRs6wi7xZkG
         0y+A==
X-Gm-Message-State: AGRZ1gL24Zl32KO6xHntXo6NqKPkShieF4SiFfXEua/Cu1rg7q7mXib2
        zRmvL66IbBOLvZuMY52kZAI=
X-Google-Smtp-Source: AJdET5dbrmwIr84AzgJQ2jnzYlamqmtrbyV5EzpncIRHvGY1xpAjLtRqxeX7sAs8x75bLS4FrrXelw==
X-Received: by 2002:a1c:cb01:: with SMTP id b1-v6mr13258434wmg.42.1540819442712;
        Mon, 29 Oct 2018 06:24:02 -0700 (PDT)
Received: from evledraar (proxy-gw-a.booking.com. [5.57.21.8])
        by smtp.gmail.com with ESMTPSA id u191-v6sm12838167wmd.31.2018.10.29.06.24.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Oct 2018 06:24:01 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        dana@dana.is
Subject: Re: [PATCH] wildmatch: change behavior of "foo**bar" in WM_PATHNAME mode
References: <C16A9F17-0375-42F9-90A9-A92C9F3D8BBA@dana.is> <20181027084823.23382-1-pclouds@gmail.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20181027084823.23382-1-pclouds@gmail.com>
Date:   Mon, 29 Oct 2018 14:24:00 +0100
Message-ID: <87h8h4lwcv.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Oct 27 2018, Nguyễn Thái Ngọc Duy wrote:

> In WM_PATHNAME mode (or FNM_PATHNAME), '*' does not match '/' and '**'
> can but only in three patterns:
>
> - '**/' matches zero or more leading directories
> - '/**/' matches zero or more directories in between
> - '/**' matches zero or more trailing directories/files
>
> When '**' is present but not in one of these patterns, the current
> behavior is consider the pattern invalid and stop matching. In other
> words, 'foo**bar' never matches anything, whatever you throw at it.
>
> This behavior is arguably a bit confusing partly because we can't
> really tell the user their pattern is invalid so that they can fix
> it. So instead, tolerate it and make '**' act like two regular '*'s
> (which is essentially the same as a single asterisk). This behavior
> seems more predictable.
>
> Noticed-by: dana <dana@dana.is>
> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> ---
>  Documentation/gitignore.txt | 3 ++-
>  t/t3070-wildmatch.sh        | 4 ++--
>  wildmatch.c                 | 4 ++--
>  wildmatch.h                 | 1 -
>  4 files changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/Documentation/gitignore.txt b/Documentation/gitignore.txt
> index d107daaffd..1c94f08ff4 100644
> --- a/Documentation/gitignore.txt
> +++ b/Documentation/gitignore.txt
> @@ -129,7 +129,8 @@ full pathname may have special meaning:
>     matches zero or more directories. For example, "`a/**/b`"
>     matches "`a/b`", "`a/x/b`", "`a/x/y/b`" and so on.
>
> - - Other consecutive asterisks are considered invalid.
> + - Other consecutive asterisks are considered regular asterisks and
> +   will match according to the previous rules.
>
>  NOTES
>  -----
> diff --git a/t/t3070-wildmatch.sh b/t/t3070-wildmatch.sh
> index 46aca0af10..891d4d7cb9 100755
> --- a/t/t3070-wildmatch.sh
> +++ b/t/t3070-wildmatch.sh
> @@ -237,7 +237,7 @@ match 0 0 0 0 foobar 'foo\*bar'
>  match 1 1 1 1 'f\oo' 'f\\oo'
>  match 1 1 1 1 ball '*[al]?'
>  match 0 0 0 0 ten '[ten]'
> -match 0 0 1 1 ten '**[!te]'
> +match 1 1 1 1 ten '**[!te]'
>  match 0 0 0 0 ten '**[!ten]'
>  match 1 1 1 1 ten 't[a-g]n'
>  match 0 0 0 0 ten 't[!a-g]n'
> @@ -253,7 +253,7 @@ match 1 1 1 1 ']' ']'
>  # Extended slash-matching features
>  match 0 0 1 1 'foo/baz/bar' 'foo*bar'
>  match 0 0 1 1 'foo/baz/bar' 'foo**bar'
> -match 0 0 1 1 'foobazbar' 'foo**bar'
> +match 1 1 1 1 'foobazbar' 'foo**bar'
>  match 1 1 1 1 'foo/baz/bar' 'foo/**/bar'
>  match 1 1 0 0 'foo/baz/bar' 'foo/**/**/bar'
>  match 1 1 1 1 'foo/b/a/z/bar' 'foo/**/bar'
> diff --git a/wildmatch.c b/wildmatch.c
> index d074c1be10..9e9e2a2f95 100644
> --- a/wildmatch.c
> +++ b/wildmatch.c
> @@ -104,8 +104,8 @@ static int dowild(const uchar *p, const uchar *text, unsigned int flags)
>  					    dowild(p + 1, text, flags) == WM_MATCH)
>  						return WM_MATCH;
>  					match_slash = 1;
> -				} else
> -					return WM_ABORT_MALFORMED;
> +				} else /* WM_PATHNAME is set */
> +					match_slash = 0;
>  			} else
>  				/* without WM_PATHNAME, '*' == '**' */
>  				match_slash = flags & WM_PATHNAME ? 0 : 1;
> diff --git a/wildmatch.h b/wildmatch.h
> index b8c826aa68..5993696298 100644
> --- a/wildmatch.h
> +++ b/wildmatch.h
> @@ -4,7 +4,6 @@
>  #define WM_CASEFOLD 1
>  #define WM_PATHNAME 2
>
> -#define WM_ABORT_MALFORMED 2
>  #define WM_NOMATCH 1
>  #define WM_MATCH 0
>  #define WM_ABORT_ALL -1

This patch looks good to me, but I think it's a bad state of affairs to
keep changing these semantics and not having something like a
"gitwildmatch" doc were we document this matching syntax.

Also I still need to dig up the work for using PCRE as an alternate
matching engine, the PCRE devs produced a bug-for-bug compatible version
of our wildmatch function (all the more reason to document it), so I
think they'll need to change it now that this is in, but I haven't
rebased those ancient patches yet.

Do you have any thoughts on how to proceed with getting this documented
/ into some stable state where we can specify it? Even if we don't end
up using PCRE as a matching engine (sometimes it was faster, sometimes
slower) I think it would be very useful if we can spew out "here's your
pattern as a regex" for self-documentation purposes.

Then that can be piped into e.g. "perl -Mre=debug" to see a step-by-step
guide for how the pattern compiles, and why it does or doesn't match a
given thing.
