Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3A3FC1FEB3
	for <e@80x24.org>; Tue,  3 Jan 2017 17:26:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759558AbdACRZW (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Jan 2017 12:25:22 -0500
Received: from mout.web.de ([212.227.15.4]:52853 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753318AbdACRZL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Jan 2017 12:25:11 -0500
Received: from [192.168.178.36] ([79.213.118.247]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0McFQF-1c748M0duR-00Jc3C; Tue, 03
 Jan 2017 18:24:41 +0100
Subject: Re: [PATCH] archive-zip: load userdiff config
To:     Jeff King <peff@peff.net>, git@vger.kernel.org
References: <20170102222509.ho7motscnffrtnfh@sigill.intra.peff.net>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <7710c564-6b53-1908-7205-210d80eda59b@web.de>
Date:   Tue, 3 Jan 2017 18:24:39 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.6.0
MIME-Version: 1.0
In-Reply-To: <20170102222509.ho7motscnffrtnfh@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:KW95QnMSU5dShibBvbHIgNjGwTAc4kV7Vi9uN5rQsIkha6k5Cao
 sli9GynQQ02X0emt5ch4sBDNP0sfPVAUv/dRimTskv5Ze9gy/gMAeaSo3wjVMmbGY4IXLw/
 u9Tc/d181BGHc7nO1ZgyxfMwvpEIqboztiOiRk8O+110FH6mmFiYGcm0zbtLWIB4NvJepok
 8CzUvIHeak0FPvP5e6fzQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:BCvylMtJJ/0=:/2y61rd5bxIHJQ12XfiDry
 plDmBVi0v0wY6RB/CzGPzRyCgZs0i1HN1yZd3/mOdoPjKTFQOgHyQ59SR2aZPyr5mZw+f9Jq9
 sByJqD41uko+b5YU9reISZ4JOp2HzMO4MXVNvSgredzEhbzXFs4UFX0X5EhqFjcyJBhZLHLKt
 eK2iQOXav93jNbmsGIn5pVcrvfXD1vXcJZzSiaDftQx8O149zMPnbMw1hLsALmyFQL8ZeHTdK
 f9QylSyTyR/BmjjTtHA4z0+zUfJcTjgESbQ+pF7b0/q9mLYiPcjNTPHzx1FOa1v99wZiZlXpL
 77D5DQgD47g1Ok9MBz1v/BcM/p0R1TcXLMbBhmjG4ZfiHaRsj6n13wRJmJgPXg5xDCeJNSUHi
 5/+1789dW72JbCHCt85abccp2Y1UeWRlQV5Rab0tcYjS0M0Z6bV1x+Dms8qemFEZimfqY7LlF
 dRM6y+wfkMCDju0suJo6vyOQLD3LW5OP3qmgIvE0fbo6XbY93yTpu/5TZQE7k/ovmkZIF5YfB
 Qdu4e0ghd3QEmolHrHHrVmmy1Dcacg53S7Fxsbx4iRwa8d4Wll2hXw9xv9rP0p/UwdKyTbcrY
 RRAIni9faR3Kp/q3H8VsnnLrK5kfW4zO6/wNtD1+B20iwVvEqRJk/XPOphqYFJN+Ho65miDCU
 SY81p7ER7jP/+2uJTvXccMlzXb9np5QWGTja5oDeeRYHqCQkVqK1HMPhtyd843PmzRPxnKUbV
 QUhBchgNqbPq2SeurwUoGAHowwmVrjfCeeo+p1w/sXXm/sMS99LNF7yGjiFsFtaYoQhqOaqzW
 YDcAksi
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 02.01.2017 um 23:25 schrieb Jeff King:
> Since 4aff646d17 (archive-zip: mark text files in archives,
> 2015-03-05), the zip archiver will look at the userdiff
> driver to decide whether a file is text or binary. This
> usually doesn't need to look any further than the attributes
> themselves (e.g., "-diff", etc). But if the user defines a
> custom driver like "diff=foo", we need to look at
> "diff.foo.binary" in the config. Prior to this patch, we
> didn't actually load it.

Ah, didn't think of that, obviously.

Would it make sense for userdiff_find_by_path() to die if 
userdiff_config() hasn't been called, yet?

> I also happened to notice that zipfiles are created using the local
> timezone (because they have no notion of the timezone, so we have to
> pick _something_). That's probably the least-terrible option, but it was
> certainly surprising to me when I tried to bit-for-bit reproduce a
> zipfile from GitHub on my local machine.

That reminds me of an old request to allow users better control over the 
meta-data written into archives.  Being able to specify a time zone 
offset could be a start.

>  archive-zip.c          |  7 +++++++
>  t/t5003-archive-zip.sh | 22 ++++++++++++++++++----
>  2 files changed, 25 insertions(+), 4 deletions(-)
>
> diff --git a/archive-zip.c b/archive-zip.c
> index 9db47357b0..b429a8d974 100644
> --- a/archive-zip.c
> +++ b/archive-zip.c
> @@ -554,11 +554,18 @@ static void dos_time(time_t *time, int *dos_date, int *dos_time)
>  	*dos_time = t->tm_sec / 2 + t->tm_min * 32 + t->tm_hour * 2048;
>  }
>
> +static int archive_zip_config(const char *var, const char *value, void *data)
> +{
> +	return userdiff_config(var, value);
> +}
> +
>  static int write_zip_archive(const struct archiver *ar,
>  			     struct archiver_args *args)
>  {
>  	int err;
>
> +	git_config(archive_zip_config, NULL);
> +

I briefly thought about moving this call to archive.c with the rest of 
the config-related stuff, but I agree it's better kept here.

>  	dos_time(&args->time, &zip_date, &zip_time);
>
>  	zip_dir = xmalloc(ZIP_DIRECTORY_MIN_SIZE);
> diff --git a/t/t5003-archive-zip.sh b/t/t5003-archive-zip.sh
> index 14744b2a4b..55c7870997 100755
> --- a/t/t5003-archive-zip.sh
> +++ b/t/t5003-archive-zip.sh
> @@ -64,6 +64,12 @@ check_zip() {
>  		test_cmp_bin $original/nodiff.crlf $extracted/nodiff.crlf &&
>  		test_cmp_bin $original/nodiff.lf   $extracted/nodiff.lf
>  	"
> +
> +	test_expect_success UNZIP " validate that custom diff is unchanged " "
> +		test_cmp_bin $original/custom.cr   $extracted/custom.cr &&
> +		test_cmp_bin $original/custom.crlf $extracted/custom.crlf &&
> +		test_cmp_bin $original/custom.lf   $extracted/custom.lf
> +	"
>  }
>
>  test_expect_success \
> @@ -78,6 +84,9 @@ test_expect_success \
>       printf "text\r"	>a/nodiff.cr &&
>       printf "text\r\n"	>a/nodiff.crlf &&
>       printf "text\n"	>a/nodiff.lf &&
> +     printf "text\r"	>a/custom.cr &&
> +     printf "text\r\n"	>a/custom.crlf &&
> +     printf "text\n"	>a/custom.lf &&
>       printf "\0\r"	>a/binary.cr &&
>       printf "\0\r\n"	>a/binary.crlf &&
>       printf "\0\n"	>a/binary.lf &&
> @@ -112,15 +121,20 @@ test_expect_success 'add files to repository' '
>  test_expect_success 'setup export-subst and diff attributes' '
>  	echo "a/nodiff.* -diff" >>.git/info/attributes &&
>  	echo "a/diff.* diff" >>.git/info/attributes &&
> +	echo "a/custom.* diff=custom" >>.git/info/attributes &&
> +	git config diff.custom.binary true &&
>  	echo "substfile?" export-subst >>.git/info/attributes &&
>  	git log --max-count=1 "--pretty=format:A${SUBSTFORMAT}O" HEAD \
>  		>a/substfile1
>  '
>
> -test_expect_success \
> -    'create bare clone' \
> -    'git clone --bare . bare.git &&
> -     cp .git/info/attributes bare.git/info/attributes'
> +test_expect_success 'create bare clone' '
> +	git clone --bare . bare.git &&
> +	cp .git/info/attributes bare.git/info/attributes &&
> +	# Recreate our changes to .git/config rather than just copying it, as
> +	# we do not want to clobber core.bare or other settings.
> +	git -C bare.git config diff.custom.binary true
> +'
>
>  test_expect_success \
>      'remove ignored file' \
>

Looks good, thanks!

René
