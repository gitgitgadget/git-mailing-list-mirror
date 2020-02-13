Return-Path: <SRS0=eUpu=4B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2A1DC2BA83
	for <git@archiver.kernel.org>; Thu, 13 Feb 2020 13:42:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88245217F4
	for <git@archiver.kernel.org>; Thu, 13 Feb 2020 13:42:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="IThoj12F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730000AbgBMNmt (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Feb 2020 08:42:49 -0500
Received: from mout.gmx.net ([212.227.17.21]:48877 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729966AbgBMNmt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Feb 2020 08:42:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1581601360;
        bh=OWY4YcW22ATKDYur1NyatpBLjkhuq3nqVnEp+7to74g=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=IThoj12FDzSvyGP1BbSaZW6RB7atHLt12kyR3tvjVH7F/Ei6/DXCLSG6zc2Aw61NH
         D81MD9PoLDqMAw2jJaz64EgUVFc6//G6YzEgcQD8vmy3169iOoXISdWVBB3yy9RiJe
         dyA6RR7aoyeKafjXhSt1/jAiunc8z+6KXl//iBqo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.86]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mi2O1-1jfgJN1riT-00e6DI; Thu, 13
 Feb 2020 14:42:40 +0100
Date:   Thu, 13 Feb 2020 14:42:40 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Shourya Shukla <shouryashukla.oo@gmail.com>
cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
        chriscool@tuxfamily.org
Subject: Re: [PATCH 1/1][RFC][GSoC] submodule: using 'is_writing_gitmodules_ok()'
 for a stricter check
In-Reply-To: <20200211170359.31835-2-shouryashukla.oo@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2002131435301.46@tvgsbejvaqbjf.bet>
References: <20200211170359.31835-1-shouryashukla.oo@gmail.com> <20200211170359.31835-2-shouryashukla.oo@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:EvNuzIo/xneQI7XFaV4hkku0UdteYFxkpwQGReN51XoCFxxmbF5
 Z76g5RHIDlIMgBRq/X6/S35O6qHtK/7obn+xJlEsVMitIBL9sHymKgoqQiY1VRpbwPHUWmo
 Ke86CIjc0e+CKBvzSnYl4lGLiC9lcjKO5I86GVk+ssfKEZyS7B6M15PvV0f9Iz85LzmC+ne
 gh0y1/LxABAgGcFWEPLjA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:dM7B0xGTfBA=:3LVz/KK4M6af78XtYPtW3+
 sijBNXksIbQQHbfGSuqmzN2i6Fze5ISe5GqPTrSa2hGufpWknx/GDSI/TyHSHRgool3YqKgtW
 TSfDuPd1mALfuCr8NG6Goeb8hHv+q0sZGpUeEj03/JxJb3LCHyT7qQWaL7w403QqyTLnd8dOc
 f2Kt1LViNx1RWZBmr7TL+0+msz57ATbQKsjsSafhR1TXPbPRvkehKE1C0zPc9OacFwOWcbsAa
 dnk3DRa5aFdAc1on5aZPX4cBJ3GEjJW7EqC5ca+llb5lgqpaBhsZhFO6uBrKeAXLzt7UWeNya
 QkaQAaYb2xxJ6lkR78gTkYCk3SDbsY5I+CWPT8jU2sv/iif3+FZ5FH38b5KR0tiWb3xMNxEU9
 Du3euyJ28jqPdOfjDbw9BtheEZxcL4Hbg8cnItaxtzNMGF4NK1eeoYw/BKMgLWwzUmdKvcgnO
 FTlD1epxbj4TV3n3Od71dn5H2yTP3iQ6XSomH5FoLsItYiMR6nkN3z/eeUCeQaT8bdve7Vqsa
 EuuoAz4nw+FaAL/zAsmfKawF9QvEKvbFKtfMeCMxotYvvAunavyEVtSEYtJS3eI8TwDBQ3vwh
 EEXcvq9EDh7q10UpNu5+lcYw+2u9bI2CHvY6srojRbnTqFwRWmHRA63IgOd+Xbc55/DbGA/dK
 1Bfa2WuPliUe2Fu4Fj2FUh1CR3Ogh2GK52DYk2REBpRq7Wr7DsGZuK5DgH7U7ni+WhPn+lga1
 uwsGUXN0X50itQUBj+WsK3tunTtSGydeiFjhmZjFaXxNctlizXw6NMR0x0dj4luWLhVnPl5v/
 X+PmKPfzLoka7M/0gb5Dls6oIk59bKC7vljtTVthC4R13B3QepHogIzXzqx8YikLxrc7pXedY
 5NDJjSrw8pfVo2/G8cwSgVH46DQvas03eoO8JpcgFHN4pIab4CR5OFq4zpEKWv3V62fTTGysE
 kGSH4RtCjAOFSamAtPNkxjv+/9K4TJHSQhDSX0LqwlRcXTRS3R5e2JxVwhNKvEZGyWduwKuCB
 gBqA4cLYq96C39QjLyfz0lZ6BdwesOlz/eHj8Qw1zTGZPukctpccvbNxqxQz18y9FRHLKHY7f
 FcUlvDkpS5q/taXWTY7j1SdXVXsjx5tLvlYE+MNlW9Dd3HzB73wsXbWiGhlQUALMVo5j+Dvd6
 fDNPN//qJtrncBnHIDUco6rFMkdUhWl+pUV2zLieNd3Xu0Vg07XjAkbD6jGn7Pu7EK+FyHZ0S
 jkFg4uNMdceUK6Kko
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Shourya,

On Tue, 11 Feb 2020, Shourya Shukla wrote:

> The if conditions of the functions 'update_path_in_gitmodules()'
> and 'remove_path_from_gitmodules()' are not catering to every
> condition encountered by the function. On detailed observation,
> one can notice that .gitmodules cannot be changed (i.e. removal
> of a path or updation of a path) until these conditions are satisfied:
>
>     1. The file exists
>     2. The file, if it does not exist, should be absent from
>        the index and other branches as well.

I don't think that other branches matter in this context.

>     3. There should not be any unmerged changes in the file.
>     4. The submodules do not exist or if the submodule name
>        does not match.
>
> Only the conditions 1, 3 and 4 were being satisfied earlier. Now
> on changing the if statement in one of the places, the condition
> 2 is satisfied as well.

Let's see how this is done...

> Signed-off-by: Shourya Shukla <shouryashukla.oo@gmail.com>
> ---
>  submodule.c | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
>
> diff --git a/submodule.c b/submodule.c
> index 3a184b66ab..f7836a6851 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -107,7 +107,13 @@ int update_path_in_gitmodules(const char *oldpath, =
const char *newpath)
>  	const struct submodule *submodule;
>  	int ret;
>
> -	if (!file_exists(GITMODULES_FILE)) /* Do nothing without .gitmodules *=
/
> +	/* If .gitmodules file is not safe to write(update a path) i.e.
> +	 * if it does not exist or if it is not present in the working tree
> +	 * but lies in the index or in the current branch.
> +	 * The function 'is_writing_gitmodules_ok()' checks for the same.
> +	 * and exits with failure if above conditions are not satisfied
> +	*/

Style: we always begin and end multi-line comments with `/*` and `*/` on
their own line.

> +	if (is_writing_gitmodules_ok())

Hmm. This function is defined thusly:

int is_writing_gitmodules_ok(void)
{
	struct object_id oid;
	return file_exists(GITMODULES_FILE) ||
		(get_oid(GITMODULES_INDEX, &oid) < 0 && get_oid(GITMODULES_HEAD, &oid) <=
 0);
}

Aha! So this tries to ensure that the `.gitmodules` file exists on disk,
or if it does not, then it should not exist in the index nor in the
_current_ branch.

But we're in the function called `update_path_in_gitmodules()` which
suggests that we're working on an existing, valid `.gitmodules`.

So I do not think that we can proceed if `.gitmodules` is absent from
disk, even if in case that it is _also_ absent from the index and from the
current branch.

>  		return -1;
>
>  	if (is_gitmodules_unmerged(the_repository->index))
> @@ -136,7 +142,13 @@ int remove_path_from_gitmodules(const char *path)
>  	struct strbuf sect =3D STRBUF_INIT;
>  	const struct submodule *submodule;
>
> -	if (!file_exists(GITMODULES_FILE)) /* Do nothing without .gitmodules *=
/
> +	/* If .gitmodules file is not safe to write(remove a path) i.e.
> +	 * if it does not exist or if it is not present in the working tree
> +	 * but lies in the index or in the current branch.
> +	 * The function 'is_writing_gitmodules_ok()' checks for the same.
> +	 * and exits with failure if above conditions are not satisfied
> +	*/
> +	if (is_writing_gitmodules_ok())

Here, we want to remove a path from `.gitmodules`, so I think that the
same analysis applies as above.

In other words, I think that the existing code is correct and does not
need to be patched.

Ciao,
Johannes

>  		return -1;
>
>  	if (is_gitmodules_unmerged(the_repository->index))
> --
> 2.20.1
>
>
