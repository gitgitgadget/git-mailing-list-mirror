Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A570E1F97E
	for <e@80x24.org>; Wed, 10 Oct 2018 22:55:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726034AbeJKGTq (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Oct 2018 02:19:46 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:39531 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725968AbeJKGTq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Oct 2018 02:19:46 -0400
Received: by mail-ed1-f66.google.com with SMTP id d15-v6so6456253edq.6
        for <git@vger.kernel.org>; Wed, 10 Oct 2018 15:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z1284AfIm5YNFXJETe6v9GvTgh09VV847ug+A+f4urc=;
        b=az9NFztri0OIe+vU4uGhImbYDKBlTqBxA44QVj9fYrbG+LqsZBaDTJKRixO3K2iAkk
         XiDHPXt1qMx/cwOvjf7eNtBn/y77luProAhD3L3ldwJ24HCDiKFlnpqaxZxh+7/kr91h
         QrIN+VhnfEo/GzTKi5wXeLDhG6+dLCjVr0956aB4vF0Mj/hWY3OR5eVBVevmWE6daIO8
         rQkCwtR1ShT/MjVeaKIuraHzQR8HCFxpjVnSFo0zSA3rHewT9MKwAvVbV5G1pWupla8/
         q0H/sTxUVBKRHGstVLWJxBeRf1SyR1WhZxW7XNhDZa2fo7pM3sIX6UgCkpOioqjVuY1s
         sYsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z1284AfIm5YNFXJETe6v9GvTgh09VV847ug+A+f4urc=;
        b=NXk3vcfgea0JduJZxMt4xl6KYIHKAaRmJad0tiGhlGFZPpw2He0Jj1GsWG5hHvu8jS
         1Ho1JNG/fu8vGi9+l3Uf9fH+gamnNWRKfLhC0CIfzNyheR4Y+0/huKbYuTHPh5zWxSig
         szizwM0lPWqSvyS7IzjmS8KW+moFQ3mFD8Byp5veqdNBwemTJBe4D+5nJ72xZvEL0o+v
         nUwzeSZ/jmY6w3cKKWhVcFsRU9UthfMHLsZWtIOxdZawGCMrWs8ao31RvpTUVkyZOI2V
         tRWP5XMpcMdhTIVcL099P5Xx02TmlK7wqU7NaWej/exHpsQFlmKwbASXZDUFLOykzYZ2
         mLZg==
X-Gm-Message-State: ABuFfohn104nQx5saSZZPYpLRgiU2qL35+VhI3rk/c3OCKyVuNNSrPdQ
        TvJOrRMfVv3Yw3csbBZeBiJ0zRKCSYCsYnIfZcSn4w==
X-Google-Smtp-Source: ACcGV63t331SOYAs4O0oVLd/qFSCNuGb4h5JhMShhBwEKe4qQQyVQqtZcKXqqEhMqoW8MEG8yXLNlaWUTJhnCFWmBAE=
X-Received: by 2002:a50:9931:: with SMTP id k46-v6mr44285591edb.85.1539212126836;
 Wed, 10 Oct 2018 15:55:26 -0700 (PDT)
MIME-Version: 1.0
References: <20181005130601.15879-1-ao2@ao2.it> <20181005130601.15879-10-ao2@ao2.it>
 <CAGZ79kZTQB29SuB52Efk-j7jX11BRU_RFiX+znttvP2tFRaNvg@mail.gmail.com> <20181010205645.e1529eff9099805029b1d6ef@ao2.it>
In-Reply-To: <20181010205645.e1529eff9099805029b1d6ef@ao2.it>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 10 Oct 2018 15:55:15 -0700
Message-ID: <CAGZ79kZ5HRcTsfWRbOW-kQg2UFBf6suc+7px_FbCSPwcOE5w3g@mail.gmail.com>
Subject: Re: [PATCH v6 09/10] submodule: support reading .gitmodules when it's
 not in the working tree
To:     Antonio Ospite <ao2@ao2.it>
Cc:     Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 10, 2018 at 11:56 AM Antonio Ospite <ao2@ao2.it> wrote:
>
> On Mon, 8 Oct 2018 15:19:00 -0700
> Stefan Beller <sbeller@google.com> wrote:
>
> > > +test_expect_success 'not writing gitmodules config file when it is not checked out' '
> > > +        test_must_fail git -C super submodule--helper config submodule.submodule.url newurl
> >
> > This only checks the exit code, do we also want to check for
> >
> >     test_path_is_missing .gitmodules ?
> >
>
> OK, I agree, let's re-check also *after* we tried and failed to set
> a config value, just to be sure that the code does not get accidentally
> changed in the future to create the file. I'll add the check.
>
> > > +test_expect_success 'initialising submodule when the gitmodules config is not checked out' '
> > > +       git -C super submodule init
> > > +'
> > > +
> > > +test_expect_success 'showing submodule summary when the gitmodules config is not checked out' '
> > > +       git -C super submodule summary
> > > +'
> >
> > Same for these, is the exit code enough, or do we want to look at
> > specific things?
> >
>
> Except for the "summary" test which was not even exercising the
> config_from_gitmodule path,  checking exist status should be sufficient
> to verify that "submodule--helper config" does not fail, but we can
> surely do better.
>
> I will add checks to confirm that not only the commands exited without
> errors but they also achieved the desired effect, to validate the actual
> high-level use case advertised by the test file. This should be more
> future-proof.
>
> And I think I'll merge the summary and the update tests.
>
> > > +
> > > +test_expect_success 'updating submodule when the gitmodules config is not checked out' '
> > > +       (cd submodule &&
> > > +               echo file2 >file2 &&
> > > +               git add file2 &&
> > > +               git commit -m "add file2 to submodule"
> > > +       ) &&
> > > +       git -C super submodule update
> >
> > git status would want to be clean afterwards?
>
> Mmh, this should have been "submodule update --remote" in the first
> place to have any effect, I'll take the chance and rewrite this test in
> a different way and also check the effect of the update operation, and
> the repository status.
>
> I'll be something like this:
>
> ORIG_SUBMODULE=$(git -C submodule rev-parse HEAD)
> ORIG_UPSTREAM=$(git -C upstream rev-parse HEAD)
> ORIG_SUPER=$(git -C super rev-parse HEAD)
>
> test_expect_success 're-updating submodule when the gitmodules config is not checked out' '
>         test_when_finished "git -C submodule reset --hard $ORIG_SUBMODULE;
>                             git -C upstream reset --hard $ORIG_UPSTREAM;
>                             git -C super reset --hard $ORIG_SUPER;
>                             git -C upstream submodule update --remote;
>                             git -C super pull;
>                             git -C super submodule update --remote" &&
>         (cd submodule &&
>                 echo file2 >file2 &&
>                 git add file2 &&
>                 test_tick &&
>                 git commit -m "add file2 to submodule"
>         ) &&
>         (cd upstream &&
>                 git submodule update --remote &&
>                 git add submodule &&
>                 test_tick &&
>                 git commit -m "Update submodule"
>         ) &&
>         git -C super pull &&
>         # The --for-status options reads the gitmdoules config

gitmodules

>         git -C super submodule summary --for-status >actual &&
>         cat >expect <<-\EOF &&
>         * submodule 951c301...a939200 (1):

hardcoding hash values burdens the plan to migrate to another
hash function,

    rev1=$(git -C submodule rev-parse --short HEAD^)
    rev2=$(git -C submodule rev-parse --short HEAD)

and then use ${rev1}..${rev2} ?


>           < add file2 to submodule
>
>         EOF
>         test_cmp expect actual &&
>         # Test that the update actually succeeds
>         test_path_is_missing super/submodule/file2 &&
>         git -C super submodule update &&
>         test_cmp submodule/file2 super/submodule/file2 &&
>         git -C super status --short >output &&
>         test_must_be_empty output
> '
>
> Maybe a little overkill?

Wow, very thorough! You might call it overkill, but now that you have it...

> The "upstream" repo will be added in test 1 to better clarify the roles
> of the involved repositories.
>
> The commit ids should be stable because of test_tick, shouldn't they?

Yes, but see
Documentation/technical/hash-function-transition.txt
that a couple people are working on. Let's be nice to them. :-)

Stefan
