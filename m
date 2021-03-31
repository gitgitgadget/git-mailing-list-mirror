Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEB66C433C1
	for <git@archiver.kernel.org>; Wed, 31 Mar 2021 04:35:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A35E619A7
	for <git@archiver.kernel.org>; Wed, 31 Mar 2021 04:35:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233578AbhCaEed (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Mar 2021 00:34:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233591AbhCaEdz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Mar 2021 00:33:55 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AE87C061574
        for <git@vger.kernel.org>; Tue, 30 Mar 2021 21:33:55 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id o19so20682726edc.3
        for <git@vger.kernel.org>; Tue, 30 Mar 2021 21:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=bjk41gtyrhMgxoxzhSEy5MXCb08qE59cAowDhzBPh5o=;
        b=FXkHypdhb115PVjINehA9R9pN1eto77BwalV7/UyhPZH5N8exoPIvOc9huCwxzmAbB
         KQZNQQ1PGa+ToDEtzl/Q/AawZHOuXOa5DujfY3BApqjLT5JrdAxZBARSeBFPHCawKYqS
         /KbQ7ETbg6Tz1zNr+R1NYsWJytmjRGA0cbvd5WOfSurS4xsSjhoNIEROBNH8fZEnIUK3
         Yf3YVHQBaWBo0fogER7LNREp96C6g7/T/PYnNcY8ALL7iX197dU1qhFQ6jgZYbPEP4gO
         9ijFoSB4CoVtB0I8XI3OYnUyosJqvRtQqvsK63hZnH18p1rbDQnXbKrCsVZzoEiy1YRE
         DV6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=bjk41gtyrhMgxoxzhSEy5MXCb08qE59cAowDhzBPh5o=;
        b=Fo2wh2TKRly4mNvAwPd0TfhOdhY3h6lbKExxpJK/lP9Ei2dwd1KhS4iGZIneUOeK1Y
         BWPuCCbp9Y7e7lRC7vaaw/Al43Ymr0rsGx2+EgtSj6DpZnyWfWTSrFN+Nr01/+hUgwHz
         L6WZp4f+UZeeEY3i3U3YyC2zrOuiRKmODC/lSfBBrG1UplFwJXmJaYdrS9fUqcK7JZkR
         snJthHUP7b9MQ3Y1Ps7E0YPym0G+yo9RpEnyuTbp5cBuXBVBiSVl1HPdRviDuCHhT+jk
         MnL27+vTJzkKy7dymmTOjW8BPG1SzMxDM3dAWIZhCp1zlxEAzUW4tUJ3m2aXNLdGpfeN
         mYBg==
X-Gm-Message-State: AOAM530uUccQ3U4ITFY/LkdwluYYqiQJ+r3tIr3xsHV+xgwPYpTn+mIV
        dYRNpbJaO+j25magAUdInu89teZREfPy3yZZS3w=
X-Google-Smtp-Source: ABdhPJy2mRKkGD+9W5VyMUCEVoYCbI/9Un3mJU6hKXhGI/2u5KOC5mR/8vF97PEPXNb+8LjwLk1p61HKCkVCNePI9UM=
X-Received: by 2002:a05:6402:5244:: with SMTP id t4mr1323653edd.87.1617165234144;
 Tue, 30 Mar 2021 21:33:54 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1616015337.git.matheus.bernardino@usp.br> <8c83e92445b4131e9b8f8e2aa29b00717b257d13.1616015337.git.matheus.bernardino@usp.br>
In-Reply-To: <8c83e92445b4131e9b8f8e2aa29b00717b257d13.1616015337.git.matheus.bernardino@usp.br>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Wed, 31 Mar 2021 06:33:43 +0200
Message-ID: <CAP8UFD3s3NUpi2eyPWFa5bL4rez1wNtj5-dUpv8dJLo2CKYu9A@mail.gmail.com>
Subject: Re: [PATCH 3/5] parallel-checkout: add configuration options
To:     Matheus Tavares <matheus.bernardino@usp.br>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <git@jeffhostetler.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 17, 2021 at 10:12 PM Matheus Tavares
<matheus.bernardino@usp.br> wrote:

> The above benchmarks show that parallel checkout is most effective on
> repositories located on an SSD or over a distributed file system. For
> local file systems on spinning disks, and/or older machines, the
> parallelism does not always bring a good performance. For this reason,
> the default value for checkout.workers is one, a.k.a. sequential
> checkout.

I wonder how many people are still using HDD, and how many will still
use them in a few years.

I think having 1 as the default value for checkout.workers might be
good for a while for backward compatibility and stability, while
people who are interested can test parallel checkout on different
environments. But we might want, in a few releases, after some bugs,
if any, have been fixed, to use a default, maybe 10, that will provide
significant speedup for most people, and will justify the added
complexity, especially as your numbers still show a small speedup for
HDD when using 10.

> To decide the default value for checkout.thresholdForParallelism,
> another benchmark was executed in the "Local SSD" setup, where parallel
> checkout showed to be beneficial. This time, we compared the runtime of
> a `git checkout -f`, with and without parallelism, after randomly
> removing an increasing number of files from the Linux working tree. The
> "sequential fallback" column bellow corresponds to the executions where

s/bellow/below/

> checkout.workers was 10 but checkout.thresholdForParallelism was equal
> to the number of to-be-updated files plus one (so that we end up writing
> sequentially). Each test case was sampled 15 times, and each sample had
> a randomly different set of files removed. Here are the results:
>
>              sequential fallback   10 workers           speedup
> 10   files    772.3 ms =C2=B1 12.6 ms   769.0 ms =C2=B1 13.6 ms   1.00 =
=C2=B1 0.02
> 20   files    780.5 ms =C2=B1 15.8 ms   775.2 ms =C2=B1  9.2 ms   1.01 =
=C2=B1 0.02
> 50   files    806.2 ms =C2=B1 13.8 ms   767.4 ms =C2=B1  8.5 ms   1.05 =
=C2=B1 0.02
> 100  files    833.7 ms =C2=B1 21.4 ms   750.5 ms =C2=B1 16.8 ms   1.11 =
=C2=B1 0.04
> 200  files    897.6 ms =C2=B1 30.9 ms   730.5 ms =C2=B1 14.7 ms   1.23 =
=C2=B1 0.05
> 500  files   1035.4 ms =C2=B1 48.0 ms   677.1 ms =C2=B1 22.3 ms   1.53 =
=C2=B1 0.09
> 1000 files   1244.6 ms =C2=B1 35.6 ms   654.0 ms =C2=B1 38.3 ms   1.90 =
=C2=B1 0.12
> 2000 files   1488.8 ms =C2=B1 53.4 ms   658.8 ms =C2=B1 23.8 ms   2.26 =
=C2=B1 0.12
>
> From the above numbers, 100 files seems to be a reasonable default value
> for the threshold setting.
>
> Note: Up to 1000 files, we observe a drop in the execution time of the
> parallel code with an increase in the number of files. This is a rather
> odd behavior, but it was observed in multiple repetitions. Above 1000
> files, the execution time increases according to the number of files, as
> one would expect.
>
> About the test environments: Local SSD tests were executed on an
> i7-7700HQ (4 cores with hyper-threading) running Manjaro Linux. Local
> HDD tests were executed on an Intel(R) Xeon(R) E3-1230 (also 4 cores
> with hyper-threading), HDD Seagate Barracuda 7200.14 SATA 3.1, running
> Debian. NFS and EFS tests were executed on an Amazon EC2 c5n.xlarge
> instance, with 4 vCPUs. The Linux NFS server was running on a m6g.large
> instance with 2 vCPUSs and a 1 TB EBS GP2 volume. Before each timing,
> the linux repository was removed (or checked out back to its previous
> state), and `sync && sysctl vm.drop_caches=3D3` was executed.

Thanks for all these tests and details!

> Co-authored-by: Jeff Hostetler <jeffhost@microsoft.com>
> Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>

[...]

> @@ -23,6 +25,19 @@ enum pc_status parallel_checkout_status(void)
>         return parallel_checkout.status;
>  }
>
> +#define DEFAULT_THRESHOLD_FOR_PARALLELISM 100

Using a "static const int" might be a bit better.

> +void get_parallel_checkout_configs(int *num_workers, int *threshold)
> +{
> +       if (git_config_get_int("checkout.workers", num_workers))
> +               *num_workers =3D 1;

I think it's better when an important default value like this "1" is
made more visible using a "static const int" or a "#define".

> +       else if (*num_workers < 1)
> +               *num_workers =3D online_cpus();
> +
> +       if (git_config_get_int("checkout.thresholdForParallelism", thresh=
old))
> +               *threshold =3D DEFAULT_THRESHOLD_FOR_PARALLELISM;
> +}
> +
>  void init_parallel_checkout(void)
>  {
>         if (parallel_checkout.status !=3D PC_UNINITIALIZED)
> @@ -554,11 +569,9 @@ static void write_items_sequentially(struct checkout=
 *state)
>                 write_pc_item(&parallel_checkout.items[i], state);
>  }
>
> -#define DEFAULT_NUM_WORKERS 2

As I say above, it doesn't look like a good idea to have removed this.

> -int run_parallel_checkout(struct checkout *state)
> +int run_parallel_checkout(struct checkout *state, int num_workers, int t=
hreshold)
>  {
> -       int ret, num_workers =3D DEFAULT_NUM_WORKERS;
> +       int ret;
>
>         if (parallel_checkout.status !=3D PC_ACCEPTING_ENTRIES)
>                 BUG("cannot run parallel checkout: uninitialized or alrea=
dy running");
> @@ -568,7 +581,7 @@ int run_parallel_checkout(struct checkout *state)
>         if (parallel_checkout.nr < num_workers)
>                 num_workers =3D parallel_checkout.nr;
>
> -       if (num_workers <=3D 1) {
> +       if (num_workers <=3D 1 || parallel_checkout.nr < threshold) {

Here we check the number of workers...

>                 write_items_sequentially(state);
>         } else {
>                 struct pc_worker *workers =3D setup_workers(state, num_wo=
rkers);

[...]

> @@ -480,7 +483,8 @@ static int check_updates(struct unpack_trees_options =
*o,
>                 }
>         }
>         stop_progress(&progress);
> -       errs |=3D run_parallel_checkout(&state);
> +       if (pc_workers > 1)

...but the number of workers was already checked here.


> +               errs |=3D run_parallel_checkout(&state, pc_workers, pc_th=
reshold);
>         errs |=3D finish_delayed_checkout(&state, NULL);
>         git_attr_set_direction(GIT_ATTR_CHECKIN);
