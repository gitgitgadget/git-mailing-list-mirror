Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8597220D0A
	for <e@80x24.org>; Fri,  2 Jun 2017 00:49:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751129AbdFBAtl (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Jun 2017 20:49:41 -0400
Received: from mail-lf0-f42.google.com ([209.85.215.42]:34244 "EHLO
        mail-lf0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750851AbdFBAtk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jun 2017 20:49:40 -0400
Received: by mail-lf0-f42.google.com with SMTP id v20so3399070lfa.1
        for <git@vger.kernel.org>; Thu, 01 Jun 2017 17:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=FGNvwsK+j4H07eW5CSU4G90M0jclP6zx874Ki0TLHhI=;
        b=uulthwhNN6UhTQmVuL8donjEath95LVtUbz+2x+G6fixFWiO0sJHl4SkXbtRkPGdfw
         Z0a2LyqT4W4OJwxXVabXty9s1VcO5ll9FtOYD3cWKfcdsGv9kUk9E5bL6bTyWr4eCJWD
         zcmEQBTuVkNTR8UaRaW2ZD0hwSj1410ezUjWqfoJyr7vLp2nHXebKBOVDSfduf+HXaxf
         gslfmn0mnD9Q52iI2dgdllYQyKI42ktT0BLL/my2FcdRTxJPwCg0cLnPoE5m+0iB8S1t
         HAOuUHwSrolvdFJOGCLuekHsAKwozKlhO2SYrtFeaPSaISYkFFqBRVGSw2ChuBDcFg+d
         OFWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=FGNvwsK+j4H07eW5CSU4G90M0jclP6zx874Ki0TLHhI=;
        b=AcgI8FFToR+m5SvjWWJIfI/zo4bQKPzyJ8FSXSrAEllEVd5L0w716VCOiQfZMizo4w
         iWiNOErd2G6Wt67CMGQqvABmd0ULFcnVcJnJk32vB05iZx3wK0mSovOCbclanQ2lPVNX
         3Y4s+IdvJ3Y6Tr2qPsAsgWBNjx7CkCftXGY/gAW71AqyityFV32exnhzVgJH51GMVWFd
         HlrLCoNt+awK1zy7sQesf/gzPZ152Kmzh8TY/olVyXtcK+ZYOtdmPp7L69OIDLRMSvur
         F9mDsVQ6o6Vz/mOug8L9sl/QVZztmu+GxH88r0QjyFVQzBxP6SOTvS9VhkIOk8K1VhCC
         4lBA==
X-Gm-Message-State: AODbwcBhDrKXIwBQ5lmNaVwz3GFV/KH5GTDNbPaWk3H7iLKWEccwrQ5u
        PzvpnC2D180/FGgiINuR87o3UdEQhQ==
X-Received: by 10.46.97.18 with SMTP id v18mr1436246ljb.123.1496364578680;
 Thu, 01 Jun 2017 17:49:38 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.25.32.133 with HTTP; Thu, 1 Jun 2017 17:49:18 -0700 (PDT)
In-Reply-To: <20170602002249.GI25542@zaya.teonanacatl.net>
References: <CA+P7+xr39qk9qHE0=uU3HZE2wOhU9X7rmENoDfP=bp09j9N9Mg@mail.gmail.com>
 <20170601235055.22621-1-jonathantanmy@google.com> <20170602002249.GI25542@zaya.teonanacatl.net>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Thu, 1 Jun 2017 17:49:18 -0700
Message-ID: <CA+P7+xrb-a_UczPkdPSgZN7jW0zBU6v8yJ7Q20maNAROzyKBzA@mail.gmail.com>
Subject: Re: [PATCH] send-email: check for repo before invoking hook
To:     Todd Zullinger <tmz@pobox.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Git mailing list <git@vger.kernel.org>,
        Brandon Williams <bmwill@google.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 1, 2017 at 5:22 PM, Todd Zullinger <tmz@pobox.com> wrote:
> Hi Jonathan,
>
> Jonathan Tan wrote:
>>
>> Thanks for the notification. Here's a patch to fix that. ---
>> git-send-email.perl   | 32 +++++++++++++++++---------------
>> t/t9001-send-email.sh |  8 ++++++++ 2 files changed, 25 insertions(+), 15
>> deletions(-)
>>
>> diff --git a/git-send-email.perl b/git-send-email.perl index
>> f0417f64e..94c54dc5a 100755 --- a/git-send-email.perl +++
>> b/git-send-email.perl @@ -1755,21 +1755,23 @@ sub unique_email_list { sub
>> validate_patch {       my $fn = shift;
>>
>> -       my $validate_hook = catfile(catdir($repo->repo_path(), 'hooks'), -
>> 'sendemail-validate'); -    my $hook_error; -       if (-x $validate_hook) {
>> -              my $target = abs_path($fn); -           # The hook needs a
>> correct cwd and GIT_DIR. -           my $cwd_save = cwd(); -
>> chdir($repo->wc_path() or $repo->repo_path()) -                 or
>> die("chdir: $!"); -          local $ENV{"GIT_DIR"} = $repo->repo_path(); -
>> $hook_error = "rejected by sendemail-validate hook" -                   if
>> system($validate_hook, $target); -           chdir($cwd_save) or die("chdir:
>> $!"); - } -     return $hook_error if $hook_error; +    if ($repo) { +
>> my $validate_hook = catfile(catdir($repo->repo_path(), 'hooks'), +
>> 'sendemail-validate'); +            my $hook_error; +               if (-x
>> $validate_hook) { +                      my $target = abs_path($fn); +
>> # The hook needs a correct cwd and GIT_DIR. +                   my $cwd_save
>> = cwd(); +                 chdir($repo->wc_path() or $repo->repo_path()) +
>> or die("chdir: $!"); +                  local $ENV{"GIT_DIR"} =
>> $repo->repo_path(); +                   $hook_error = "rejected by
>> sendemail-validate hook" +                           if
>> system($validate_hook, $target); +                   chdir($cwd_save) or
>> die("chdir: $!"); +         } +             return $hook_error if
>> $hook_error; +    }
>
>
> Would it be worth doing the $repo test when defining $validate_hook to avoid
> a layer of indentation?  Something like this (with whatever proper
> wrapping/indentation is used for perl, if I have that wildly incorrect, of
> course)?
>

This approach makes more sense to me, but either should fix the bug.
The first approach might be more resilient against future changes
though...?

Thanks,
Jake

> -- >8 --
> diff --git i/git-send-email.perl w/git-send-email.perl
> index f0417f64e7..e78a0a728a 100755
> --- i/git-send-email.perl
> +++ w/git-send-email.perl
> @@ -1755,8 +1755,9 @@ sub unique_email_list {
> sub validate_patch {
>         my $fn = shift;
>
> -       my $validate_hook = catfile(catdir($repo->repo_path(), 'hooks'),
> -                                   'sendemail-validate');
> +       my $validate_hook = $repo ?
> +               catfile(catdir($repo->repo_path(), 'hooks'),
> +                       'sendemail-validate') : '';
>         my $hook_error;
>         if (-x $validate_hook) {
>                 my $target = abs_path($fn);
>
> --
> Todd
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> I have to decide between two equally frightening options.  If I wanted
> to do that, I'd vote.
>    -- Duckman
>
