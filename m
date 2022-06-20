Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 238FBC43334
	for <git@archiver.kernel.org>; Mon, 20 Jun 2022 20:34:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242633AbiFTUeN (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Jun 2022 16:34:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235181AbiFTUeK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Jun 2022 16:34:10 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4AD718E18
        for <git@vger.kernel.org>; Mon, 20 Jun 2022 13:34:08 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id lw20so981169ejb.4
        for <git@vger.kernel.org>; Mon, 20 Jun 2022 13:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=w7MOdxWTJvv69s3DEQCJmho6BYsMA4ywAo/a6H+oP2w=;
        b=RyGXd1tUTyKPleQc07N4TuoGDSlE2CW03hi/Jy3ZtmuR4eNXC/+2mBlRuBTi3sKBoT
         bA+BexO8zc9SRZQJQANwprHKFBo/BIYS7k8Rovn6xgWldwTrwqvb57I25a7Ze8uIo+pe
         Rgwucyu3TQ/MFlt571D/nIOyuZzD9Nf7AtkpUMatftSHelotTcsGvpVfwAIEaf+ojmn5
         V3b/laJdrdM8OhVWKA/0bOwRUTbh8K8di3gbp4iS0cYQNvORLqls2zoh8GQTqsENf6+/
         OXvE4LAAb81y1/rGMkYRUW/W6SxURTf3z7Imjs/CL08AlQWESfOE+oHcvnZBYcOAbUxm
         ZUHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=w7MOdxWTJvv69s3DEQCJmho6BYsMA4ywAo/a6H+oP2w=;
        b=C9XHfhFsvQNEn2OF72Rnon/5kzZlYxjRd4wFrOzDqbDECy/JUiwSK8kS1JIERKP283
         MPftcjD5fJRhc/zg6H/AhCRGvZgCcRliALvRm723Ne3u13fkjm1yPFr5Ae70UegI6KkP
         GXHjxvZaOAEVfviD7MvJUBUmOTsv6ayA+mrU6v1clhlatYrdvSlBh6QKdWnP3GCowuOk
         xP1zIWAX0t1dy7LNmBAEYXYbgjjcetWbMfJS2tey5Ghl3O1HQH3P4XPHFMa2kHQypSgF
         GqEXSZvpZbamgFgZWR6xVrFtzsBaoYFlm48OBd9KZJ0WagQdKXrczndLZ+eb8LrAdgy/
         ptTg==
X-Gm-Message-State: AJIora/yaX8QHQju3GHG3wm3aHYsHRtyHboYlk4irJRDH6zeKSU9fSE0
        geP6ais4e7LCm6ktd0ShmeI=
X-Google-Smtp-Source: AGRyM1thqAeBfcoN4uNpNBbUe6zYsl05lx1ZSIy1TKKnmB20ymORpCiRZaj+yKuKjRSEHphWJ5jfMA==
X-Received: by 2002:a17:906:9b96:b0:711:d21c:1b0b with SMTP id dd22-20020a1709069b9600b00711d21c1b0bmr22766119ejc.365.1655757246917;
        Mon, 20 Jun 2022 13:34:06 -0700 (PDT)
Received: from localhost (78-131-14-143.pool.digikabel.hu. [78.131.14.143])
        by smtp.gmail.com with ESMTPSA id la5-20020a170907780500b006f3ef214de7sm6563504ejc.77.2022.06.20.13.34.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jun 2022 13:34:06 -0700 (PDT)
Date:   Mon, 20 Jun 2022 22:34:05 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     rsbecker@nexbridge.com, 'Junio C Hamano' <gitster@pobox.com>,
        git@vger.kernel.org, avarab@gmail.com
Subject: Re: Test Failure t5510,t5562 - was RE: [ANNOUNCE] Git v2.37.0-rc1
Message-ID: <20220620203405.GC1689@szeder.dev>
References: <00a401d884d0$32885890$979909b0$@nexbridge.com>
 <8d2a0a36-1d2f-c723-db1e-8978e5d03d1d@github.com>
 <00b501d884d7$d8ed1200$8ac73600$@nexbridge.com>
 <495bd957-43dc-f252-657d-2969bb7ad5f3@github.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <495bd957-43dc-f252-657d-2969bb7ad5f3@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 20, 2022 at 04:00:03PM -0400, Derrick Stolee wrote:
> On 6/20/22 2:59 PM, rsbecker@nexbridge.com wrote:
> > On June 20, 2022 2:46 PM, Derrick Stolee wrote:
> 
> >> The issue is this line (some tabs removed):
> >>
> >>  new_cmdline=$(printf "%s" "$cmdline" | perl -pe
> >> 's[origin(?!/)]["'"$remote_url"'"]g')
> >>
> >> At this point, $remote_url contains the file path including the @ symbol. However,
> >> this perl invocation is dropping everything starting at the @ to the next slash.
> >>
> >> I'm not sure of a better way to accomplish what is trying to be done here (replace
> >> 'origin' with that specific url) without maybe causing other issues.
> >>
> >> This line was introduced by e1790f9245f (fetch tests: fetch <url> <spec> as well as
> >> fetch [<remote>], 2018-02-09).
> > 
> > How about using sed instead of perl for this?
> 
> I wasn't sure if using sed would create a different kind of replacement
> problem, but using single-quotes seems to get around that kind of issue.

In a 'sed s/regexp/replacement/' command the replacement part has a
few characters with special meaning, and if those characters happen to
appear in the path of the trash directory, then:

  $ ./t5510-fetch.sh --root='/tmp/foo\1/'
  ok 64 - name prune fetch.prune=unset remote.origin.prune=unset fetch.pruneTags=unset remote.origin.pruneTags=unset --no-prune; branch:kept tag:kept
  sed: -e expression #1, char 62: invalid reference \1 on `s' command's RHS
  sed: -e expression #1, char 62: invalid reference \1 on `s' command's RHS
  ok 65 - link prune fetch.prune=unset remote.origin.prune=unset fetch.pruneTags=unset remote.origin.pruneTags=unset --no-prune; branch:kept tag:kept
  ok 66 - name prune fetch.prune=unset remote.origin.prune=unset fetch.pruneTags=unset remote.origin.pruneTags=unset --prune; branch:pruned tag:kept
  sed: -e expression #1, char 62: invalid reference \1 on `s' command's RHS
  sed: -e expression #1, char 62: invalid reference \1 on `s' command's RHS
  not ok 67 - link prune fetch.prune=unset remote.origin.prune=unset fetch.pruneTags=unset remote.origin.pruneTags=unset --prune; branch:pruned tag:kept
  [...]
  # failed 28 among 183 test(s)

> Please see the patch below. I'm currently running CI in a GGG PR [1]
> 
> [1] https://github.com/gitgitgadget/git/pull/1267
> 
> Thanks,
> -Stolee
> 
> 
> --- >8 ---
> 
> >From 1df4fc66d4a62adc7087d7d22c8d78842b4e9b4d Mon Sep 17 00:00:00 2001
> From: Derrick Stolee <derrickstolee@github.com>
> Date: Mon, 20 Jun 2022 15:52:09 -0400
> Subject: [PATCH] t5510: replace 'origin' with URL more carefully
> 
> The many test_configured_prune tests in t5510-fetch.sh test many
> combinations of --prune, --prune-tags, and using 'origin' or an explicit
> URL. Some machinery was introduced in e1790f9245f (fetch tests: fetch
> <url> <spec> as well as fetch [<remote>], 2018-02-09) to replace
> 'origin' with this explicit URL. This URL is a "file:///" URL for the
> root of the $TRASH_DIRECTORY.
> 
> However, if the current build tree has an '@' symbol, the replacement
> using perl fails. It drops the '@' as well as anything else in that
> directory name.
> 
> You can verify this locally by cloning git.git into a "victim@03"
> directory and running the test script.
> 
> To resolve this issue, replace the perl invocation with two sed
> commands. These two are used to ensure that we match exactly on the
> whole word 'origin'. We can guarantee that the word boundaries are
> spaces in our tests. The reason to use exact words is that sometimes a
> refspec is supplied, such as "+refs/heads/*:refs/remotes/origin/*" which
> would cause an incorrect replacement. The two commands are used because
> there is not a clear POSIX way to match on word boundaries without
> getting extremely pedantic about what possible characters we could have
> at the boundaries.
> 
> Reported-by: Randall Becker <rsbecker@nexbridge.com>
> Signed-off-by: Derrick Stolee <derrickstolee@github.com>
> ---
>  t/t5510-fetch.sh | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
> index 4620f0ca7fa..8ca3aa5e931 100755
> --- a/t/t5510-fetch.sh
> +++ b/t/t5510-fetch.sh
> @@ -853,7 +853,9 @@ test_configured_prune_type () {
>  		then
>  			new_cmdline=$cmdline_setup
>  		else
> -			new_cmdline=$(printf "%s" "$cmdline" | perl -pe 's[origin(?!/)]["'"$remote_url"'"]g')
> +			new_cmdline=$(printf "%s" "$cmdline" | \
> +					sed "s~origin ~'$remote_url' ~g" | \
> +					sed "s~ origin~ '$remote_url'~g")

'sed' can run multiple commands at once, e.g. 'sed -e s/// -e s///'.

>  		fi
>  
>  		if test "$fetch_prune_tags" = 'true' ||
> -- 
> 2.36.1.vfs.0.0
> 
> 
>  
