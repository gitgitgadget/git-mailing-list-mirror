Return-Path: <SRS0=y4cH=26=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63298C282DD
	for <git@archiver.kernel.org>; Thu,  9 Jan 2020 21:53:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C3C120656
	for <git@archiver.kernel.org>; Thu,  9 Jan 2020 21:53:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="jH9t9WCg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728817AbgAIVxe (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Jan 2020 16:53:34 -0500
Received: from mout.gmx.net ([212.227.17.20]:51333 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725919AbgAIVxd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Jan 2020 16:53:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1578606811;
        bh=7FsDOMZQ7kenk+kcuwEPZh/IKuCLpBrkfg2Er8WYYUs=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=jH9t9WCgtpMSMpeJn4vTYChbdZ+nB9Kui2GozbPqYAlgvMIKVj6VHJitUuH9n4ov7
         W+UEHdBYLIKFKHIqcNc+6O4rvIIn55AKI45bz/nnGh0HdYe3vlOLSXjDobiQiu74ni
         kiwChB0Yklh1xftlhuSNfsUzAjRblK/om5kEaXFo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.152]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N1fmq-1jrNBb0ZtA-011vxO; Thu, 09
 Jan 2020 22:53:31 +0100
Date:   Thu, 9 Jan 2020 22:53:25 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
cc:     git@vger.kernel.org
Subject: Re: [PATCH] mingw: safeguard better against backslashes in file
 names
In-Reply-To: <pull.690.git.git.1578576634678.gitgitgadget@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2001092252560.46@tvgsbejvaqbjf.bet>
References: <pull.690.git.git.1578576634678.gitgitgadget@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:u8IHUbPs9VmJwVxHu4bJULhLAJceJW4oxXWzOTLcrRDX+j9Q5dF
 aUckrSEnjScwgKSjsqsk+iXvKdp/1+Jk0D4MiDl+7n1p+UYdfmNbUse8mOpjB3/QdFjhopa
 DqO3sSw6FWosKmKuAj4gjTQvNgq4t5CZG89sDV8B86c1BtWjSuDkGHqPLizUMXFKAuCYrXB
 MaNUBHI+JibqL0xAA8GCw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Yko+N+uezy0=:I+ZULx3HCvvg51bb+f03YR
 lKjhKM535bK6RAjxeItvv92yM0g6oj0Y2H++cTN7yPsQ9c6A5dFiclQXJx4jjPnWgbQqPvj9O
 ruTS7t+4bcw5onh4sKvKYTzWDsMjw/CB8zkaVMzhbKZmai090n/ci1VsQ7039T050Dwr+dgEl
 XfOdxdmygBjn8B2r+71GGvczreKszj1cLpLX1eBfT4Jm9Jtq48+uoXx7cWL948OQh560HGTud
 HX2fG0WXGx6jemg98w5zdAeuwRNUhmh8sJT8RGAawsd0zuVnW82UFasMWuxMrFgUeA63X+aa7
 H+ciUVJTesigCdhDyE4i604btcWhhFQvKXC/uyuWt6y4bPHeCbCaW4WBRTPoWKAQvSI6vt9Sz
 CkSC664bfvQrnixM8494k5Kaew2LhHllMHgI9cB0YG5dMJIgkLhh70gRa0jyPeE5r0Lo2Zrpt
 eSme1HvTfPmcZzPzz0qDw719mB5q8tQIJYD1G8HKWjFhal8s7c/PIiqDJT/LgWHwKwSB9eDI4
 3GOoZxGk0+AyQiB5VBEZ3oLPUkkYEO0G6kSF23RZ5oqoDR54gf4KkYVr0HdjuEDdYZ5ihMIQn
 Oiktma/xdb8vGbei/lBt9uq6HnFu8rRuJR5AHranroAU0tkmrn4KKE1Hibha9I/3e6HA/l2Vn
 TS11Y4KGlaU/+/lop706b6jeLkE7uZYgEfO+FOLG6dSEJoZDp8hGO5bkoBwNqdDY1zraA/Ivg
 //C+e6jYp34U8GqTlpYjqOv0s+NHOsbxiyQyakBTbXP5NDdw/T+whfSZhBXlOsM5ZkSzt7jMk
 sKQa4TAXgjVRVpX/mRBhABlvM8VZ9QHBB427NxQBhlNEzFlEFzh+6y5OCbPaS7kHCQZh4aj7O
 qQul8A4i8lvFcJtPTPtMtCtQ1Kz46+68hkwpQp+9/LleNCjcPehN9nw+v+LozkezA1+kju60T
 yh9oyzQKSkjUiMjQr8OUJ5ixesMlbXEfq8NKYeYhjNxkQQyM/lRHtKQMqs3voM91DD1fbi8K0
 3XTBlNdaQta6TtKd4AKcMCwECaYCV7KnJnDzYEqRcE+VIs4B5+1urbZgMyNSqtO56kZHgmd8Q
 mRCF4mJMrc3Y283j9WUCFo237fzKW4lMvyPsTGP96Q8yyUD2KAP2Dwjapit3enDJ9hz40wue8
 TpUONFfyaph0tQ2yjfxUbfAUZoJUnLsX5crYkDGlXe+JBvEVA4OyUjhpGksBfpShH/084MHMB
 Afec81BF7O3BQ/VtO3GZdgtnCA1p2pjpdn/Zejqh3khduHtzqw7VKPW1MAdQ=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I forgot to say that I already included this patch into Git for Windows
v2.25.0-rc2.

Thanks,
Johannes

On Thu, 9 Jan 2020, Johannes Schindelin via GitGitGadget wrote:

> In 224c7d70fa1 (mingw: only test index entries for backslashes, not tree
> entries, 2019-12-31), we relaxed the check for backslashes in tree
> entries to check only index entries.
>
> However, the code change was incorrect: it was added to
> `add_index_entry_with_check()`, not to `add_index_entry()`, so under
> certain circumstances it was possible to side-step the protection.
>
> Besides, the description of that commit purported that all index entries
> would be checked when in fact they were only checked when being added to
> the index (there are code paths that do not do that, constructing
> "transient" index entries).
>
> In any case, it was pointed out in one insightful review at
> https://github.com/git-for-windows/git/pull/2437#issuecomment-566771835
> that it would be a much better idea to teach `verify_path()` to perform
> the check for a backslash. This is safer, even if it comes with two
> notable drawbacks:
>
> - `verify_path()` cannot say _what_ is wrong with the path, therefore
>   the user will no longer be told that there was a backslash in the
>   path, only that the path was invalid.
>
> - The `git apply` command also calls the `verify_path()` function, and
>   might have been able to handle Windows-style paths (i.e. with
>   backslashes instead of forward slashes). This will no longer be
>   possible unless the user (temporarily) sets `core.protectNTFS=3Dfalse`=
.
>
> Note that `git add <windows-path>` will _still_ work because
> `normalize_path_copy_len()` will convert the backslashes to forward
> slashes before hitting the code path that creates an index entry.
>
> The clear advantage is that `verify_path()`'s purpose is to check the
> validity of the file name, therefore we naturally tap into all the code
> paths that need safeguarding, also implicitly into future code paths.
>
> The benefits of that approach outweigh the downsides, so let's move the
> check from `add_index_entry_with_check()` to `verify_path()`.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>     mingw: safeguard better against backslashes in file names
>
>     I investigated again, and I think that there are code paths involvin=
g
>     make_transient_cache_entry() that might be vulnerable again after my
>     recent change in 224c7d70fa1 (mingw: only test index entries for
>     backslashes, not tree entries, 2019-12-31).
>
>     This version should help with keeping Git for Windows' users safe.
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-69=
0%2Fdscho%2Fonly-error-on-backslash-in-index-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-690/d=
scho/only-error-on-backslash-in-index-v1
> Pull-Request: https://github.com/git/git/pull/690
>
>  read-cache.c               | 12 ++++++------
>  t/t7415-submodule-names.sh |  2 +-
>  2 files changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/read-cache.c b/read-cache.c
> index 737916ebd9..aa427c5c17 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -959,7 +959,7 @@ static int verify_dotfile(const char *rest, unsigned=
 mode)
>
>  int verify_path(const char *path, unsigned mode)
>  {
> -	char c;
> +	char c =3D 0;
>
>  	if (has_dos_drive_prefix(path))
>  		return 0;
> @@ -974,6 +974,7 @@ int verify_path(const char *path, unsigned mode)
>  		if (is_dir_sep(c)) {
>  inside:
>  			if (protect_hfs) {
> +
>  				if (is_hfs_dotgit(path))
>  					return 0;
>  				if (S_ISLNK(mode)) {
> @@ -982,6 +983,10 @@ int verify_path(const char *path, unsigned mode)
>  				}
>  			}
>  			if (protect_ntfs) {
> +#ifdef GIT_WINDOWS_NATIVE
> +				if (c =3D=3D '\\')
> +					return 0;
> +#endif
>  				if (is_ntfs_dotgit(path))
>  					return 0;
>  				if (S_ISLNK(mode)) {
> @@ -1278,11 +1283,6 @@ static int add_index_entry_with_check(struct inde=
x_state *istate, struct cache_e
>  	int skip_df_check =3D option & ADD_CACHE_SKIP_DFCHECK;
>  	int new_only =3D option & ADD_CACHE_NEW_ONLY;
>
> -#ifdef GIT_WINDOWS_NATIVE
> -	if (protect_ntfs && strchr(ce->name, '\\'))
> -		return error(_("filename in tree entry contains backslash: '%s'"), ce=
->name);
> -#endif
> -
>  	if (!(option & ADD_CACHE_KEEP_CACHE_TREE))
>  		cache_tree_invalidate_path(istate, ce->name);
>
> diff --git a/t/t7415-submodule-names.sh b/t/t7415-submodule-names.sh
> index 7ae0dc8ff4..f70368bc2e 100755
> --- a/t/t7415-submodule-names.sh
> +++ b/t/t7415-submodule-names.sh
> @@ -209,7 +209,7 @@ test_expect_success MINGW 'prevent git~1 squatting o=
n Windows' '
>  		hash=3D"$(echo x | git hash-object -w --stdin)" &&
>  		test_must_fail git update-index --add \
>  			--cacheinfo 160000,$rev,d\\a 2>err &&
> -		test_i18ngrep backslash err &&
> +		test_i18ngrep "Invalid path" err &&
>  		git -c core.protectNTFS=3Dfalse update-index --add \
>  			--cacheinfo 100644,$modules,.gitmodules \
>  			--cacheinfo 160000,$rev,c \
>
> base-commit: 7a6a90c6ec48fc78c83d7090d6c1b95d8f3739c0
> --
> gitgitgadget
>
