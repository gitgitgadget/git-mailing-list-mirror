Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-23.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBC70C433E0
	for <git@archiver.kernel.org>; Tue, 30 Mar 2021 00:05:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3C5661922
	for <git@archiver.kernel.org>; Tue, 30 Mar 2021 00:05:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230366AbhC3AEh (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Mar 2021 20:04:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230364AbhC3AEG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Mar 2021 20:04:06 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF325C061762
        for <git@vger.kernel.org>; Mon, 29 Mar 2021 17:04:05 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id 11so10909387pfn.9
        for <git@vger.kernel.org>; Mon, 29 Mar 2021 17:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Vsmc8EezcNhRCMlRMKh5CBY0rm9j9MOtOtu9UTFx1jQ=;
        b=OcdU7ZBvDW6MXuZ0etmprnpU0316MVgDXGzxfVZQTSVuI+ZtNSTrPiILdnHYlXz9++
         OUyyWRu5kUtRfuFQH7b/UsFfLn/JWhTsMiqLsmCGcwTSJOLbuCjLo6I704dn+7nKNwn3
         MKmZr2UfNFR/lPnfkcEj4In7HaKHcS6XvSEsDePzSAY3Xv/cyxyVuruNAK4G4M2/6ie0
         9g+1EWhId93UdTBxdLfSFfTE4CZo6Qzd167JkzE8yr4E3TG3B5ugOvzDfb3w5PgNuy9B
         1epPJCPRTbg8OoBn4lGMgrXe05+pPbyFTkECgLpQNrwiPwrmkrxEZs3NkqAXgBzAZ/PJ
         VT2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Vsmc8EezcNhRCMlRMKh5CBY0rm9j9MOtOtu9UTFx1jQ=;
        b=VDmjLBmOv6krQJfns0X9LkV6aJIvWa0FJzQXo/wvKJGqaXWVxsvE84/IY2TIrKjdjR
         1O9BFV+bvHygUSegbmBCTDvpiIoAhvAJARWMBKz1MWggCvr/shIa9j0gRp39GuUTAibI
         RFPmKNkvBTQ2gPKMfLcYf6GkK0tYv2y4f6nzTzb2vlX9rs+2Ulckmzsj7P1UhVKqf1JB
         hWvh5Q8sGbe2aDptUJkTh6Y4v1PFDDaSWDL1CM5qomDG5bQareQZA5VDxovuMFq0H11h
         lXomipPkL5pKCKC/jn9j945LQtnhNilIvu9FyttbCslF+9y8JDe3T9vvtiwLe/oTAkeL
         iauA==
X-Gm-Message-State: AOAM533IUJ8aZ/hL6KHhHogGJa72PVRO5+OZT2cM0lgkOOFc2IoIj+HC
        IR+4GBvxt7Tod5UAa7To3aVJfnoiy4p/nA==
X-Google-Smtp-Source: ABdhPJxuJjCLUYZPteYyxYsOQXKsyVmt4KBEceKqloXvwdisy28QfmCBXqfWbCk8HTW49yy3D/TDTA==
X-Received: by 2002:aa7:85c1:0:b029:1f4:4fcc:384d with SMTP id z1-20020aa785c10000b02901f44fcc384dmr27858400pfn.10.1617062644912;
        Mon, 29 Mar 2021 17:04:04 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:282c:288a:2054:f194])
        by smtp.gmail.com with ESMTPSA id f65sm10743283pgc.19.2021.03.29.17.04.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Mar 2021 17:04:04 -0700 (PDT)
Date:   Mon, 29 Mar 2021 17:03:58 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v8 35/37] git-send-email: use 'git hook run' for
 'sendemail-validate'
Message-ID: <YGJq7gRx152w4N8E@google.com>
References: <20210311021037.3001235-1-emilyshaffer@google.com>
 <20210311021037.3001235-36-emilyshaffer@google.com>
 <87y2esg22j.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87y2esg22j.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 12, 2021 at 10:21:08AM +0100, Ævar Arnfjörð Bjarmason wrote:
> 
> 
> On Thu, Mar 11 2021, Emily Shaffer wrote:
> 
> > By using the new 'git hook run' subcommand to run 'sendemail-validate',
> > we can reduce the boilerplate needed to run this hook in perl. Using
> > config-based hooks also allows us to run 'sendemail-validate' hooks that
> > were configured globally when running 'git send-email' from outside of a
> > Git directory, alongside other benefits like multihooks and
> > parallelization.
> >
> > Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
> > ---
> >  git-send-email.perl   | 21 ++++-----------------
> >  t/t9001-send-email.sh | 11 +----------
> >  2 files changed, 5 insertions(+), 27 deletions(-)
> >
> > diff --git a/git-send-email.perl b/git-send-email.perl
> > index 1f425c0809..73e1e0b51a 100755
> > --- a/git-send-email.perl
> > +++ b/git-send-email.perl
> > @@ -1941,23 +1941,10 @@ sub unique_email_list {
> >  sub validate_patch {
> >  	my ($fn, $xfer_encoding) = @_;
> >  
> > -	if ($repo) {
> > -		my $validate_hook = catfile(catdir($repo->repo_path(), 'hooks'),
> > -					    'sendemail-validate');
> > -		my $hook_error;
> > -		if (-x $validate_hook) {
> > -			my $target = abs_path($fn);
> > -			# The hook needs a correct cwd and GIT_DIR.
> > -			my $cwd_save = cwd();
> > -			chdir($repo->wc_path() or $repo->repo_path())
> > -				or die("chdir: $!");
> > -			local $ENV{"GIT_DIR"} = $repo->repo_path();
> > -			$hook_error = "rejected by sendemail-validate hook"
> > -				if system($validate_hook, $target);
> > -			chdir($cwd_save) or die("chdir: $!");
> > -		}
> > -		return $hook_error if $hook_error;
> > -	}
> > +	my $target = abs_path($fn);
> > +	return "rejected by sendemail-validate hook"
> > +		if system(("git", "hook", "run", "sendemail-validate", "-a",
> > +				$target));
> 
> I see it's just moving code around, but since we're touching this:
> 
> This conflates the hook exit code with a general failure to invoke it,
> Perl's system().
> 
> Not a big deal in this case, but there's two other existing system()
> invocations which use the right blurb for it:
> 
> 
> 	system('sh', '-c', $editor.' "$@"', $editor, $_);
> 	if (($? & 127) || ($? >> 8)) {
> 		die(__("the editor exited uncleanly, aborting everything"));
> 	}
> 
> Makes sense to do something similar here for consistency. See "perldoc
> -f system" for an example.

Oh cool, thanks. I'll do that.

> 
> >  
> >  	# Any long lines will be automatically fixed if we use a suitable transfer
> >  	# encoding.
> > diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
> > index 4eee9c3dcb..456b471c5c 100755
> > --- a/t/t9001-send-email.sh
> > +++ b/t/t9001-send-email.sh
> > @@ -2101,16 +2101,7 @@ test_expect_success $PREREQ 'invoke hook' '
> >  	mkdir -p .git/hooks &&
> >  
> >  	write_script .git/hooks/sendemail-validate <<-\EOF &&
> > -	# test that we have the correct environment variable, pwd, and
> > -	# argument
> > -	case "$GIT_DIR" in
> > -	*.git)
> > -		true
> > -		;;
> > -	*)
> > -		false
> > -		;;
> > -	esac &&
> > +	# test that we have the correct argument
> 
> This and getting rid of these Perl/Python/whatever special cases is very
> nice.

I thought so too :D :D

 - Emily
