Return-Path: <SRS0=CKFy=AO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8C7DC433E0
	for <git@archiver.kernel.org>; Fri,  3 Jul 2020 15:07:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2FD920737
	for <git@archiver.kernel.org>; Fri,  3 Jul 2020 15:07:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="f4U1S7Zq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726310AbgGCPH3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Jul 2020 11:07:29 -0400
Received: from mout.gmx.net ([212.227.17.20]:50361 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726039AbgGCPH3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Jul 2020 11:07:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1593788836;
        bh=UsoEU5Ju3pUB3uUmythLhWWjSKLGzc78ux1gv52GnnI=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=f4U1S7Zqles2rZffDtTslYItoM+hTtyO5He7qEBlwdJMwlXk0sDF9FvQcVWPMWG1m
         fkNvKciVyBLPQJMBI4W7/IorKhbt7tFsRRRWA4zq15ACXxxuqNVbCrnDOkY4/B960E
         d/ltKOnIcmFrREM6PFh5Vju3pTZZ5pMJE4MsdTTQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.28.26.78] ([213.196.213.64]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MIdeX-1jcr5C3Uqz-00EeMN; Fri, 03
 Jul 2020 17:07:15 +0200
Date:   Fri, 3 Jul 2020 17:07:13 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Shourya Shukla <shouryashukla.oo@gmail.com>
cc:     git@vger.kernel.org, christian.couder@gmail.com, gitster@pobox.com,
        liu.denton@gmail.com, kaartic.sivaraam@gmail.com,
        pc44800@gmail.com, sbeller@google.com, pclouds@gmail.com
Subject: Re: [PATCH 3/4] diff: change scope of the function count_lines()
In-Reply-To: <20200702192409.21865-4-shouryashukla.oo@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2007031659580.50@tvgsbejvaqbjf.bet>
References: <20200702192409.21865-1-shouryashukla.oo@gmail.com> <20200702192409.21865-4-shouryashukla.oo@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:y7emFJMpZPEB0D4ohdLn/qqy0FAbHkbzseO6BvoAihf5ACgQSQI
 12UDcrPIX1EjaHPaWdjdCFZTmJKwMyC4ZJjumB/K0k8CfxLc7lrwuY2Jy7mF422ghR5qfjj
 tGUVK0lFUUvTiD0h8GnQP+BXZbFIztJGytWoVhLtxUbow2HIRe14VcUIRLk5dcM+Cl9jxn+
 Yc8tf0ezi0cptnm7Il6HA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:kIKB5jSdJWI=:fVW1oTeUN+rlS9zPLhYW92
 L0SK733pJQvv/nb+NKLXvn16OUA/WoEuuE3rSa1NuthtRqnE4gyDvX+uY+ersHQruD/hK2ib5
 CvzSNiYpx+dPxseXhFq8lWpNwWayfatDr6HRDOSmtAgSyrlshTHUcjscrU6JuwkQ00K9fJTem
 jXnHEcQBr6S+ZD9+BfU8G7UxgKJpad/KoDuAvT3GlqB2LmaGRfQvrkAeV1SCyh2PgaEiRir8Y
 GyUrWWQlJJPtpLsp2FhU5tkNV1la7en6PIdlpX1BGk81AENLhO45DFKJHNj9rzuvB0sgqgMum
 ziyjVq90bgRvGpdqTRzoKHZDPk4TYgwqoWDk4lwCw/i4ABdMOqgjakyRq/WxpL1mID3n874Oe
 R9ccD2wwzyMFgVaV26mlXkBpDLh77m5sriw50NOSLPSfyeaFc5vSsDrsi9KVyIX0JSRqwiBrn
 nBXP4mFVr6lvTCwWZzptZh+HLCfeSSsyKcs5Awk37OV3CSbj/DYQRF7DT/EGcu1yKapEkS4yZ
 w0+X0O7+MpnFMLG7FfCHLYUI0SVyk86t/dDTZt436GCUZaKgncYSLopnHZ8KbzYtU0Bwc8k7W
 kJYq6gDmGE/8jVrGi/oF0I1UFmzizY7PTUkQKlMkQGh7z6Tqu9zMCxGd89J0jsdNdwFsSItJu
 PkncPev4CwKwQXvxuRh1tJeZ5+97NH+sS4g2hEA9sla8TT5n84gwTrPlUeQyTVaYJyH/T7OIe
 g0P2KQE47/nks1I7jHZf175IITEkr7Ym0HfB54Ed8TLZqoMaI7yv8OEhqVMvZDzVSlEffC/M/
 WXV28wQK6w1UnXj17iv3eRgMhGB0SnTqKXC68K69AhefVjsLODA/MNyYcwA8viEgms+53PZPh
 p/QCnkwsblR3cBESGnw0BLWCkpMJnP0smAmChZzoxNDnn7dGOgC3ehxG/YjIBlNT7AAp80OUZ
 YxtFG4Fr5UCzgKniAfDyko2XY0jNaf67oPpa27iTVr4Lab4N30NDQeEYGD6b9oetMfAdLgu+u
 BqqyFTO7azN/+gW/WT1qgeKvKOHUsuw+8wATRJOwc+sYgEUnqexBr8LAuVB8kJ4YjrCE3/Vx5
 qI6+H2v4ujMLrkEpkqBZv1ef6n/v8IGKqTECUts758vVXzy/ZrfdNY6adG8xoxfCrJD2oqgRH
 ljm24vn379VAA5MrPJRDQjVz+9bCnRqEuX+cnwY2AlY90iUW0ZE/zXJ+BjNJSu52yS4GWpHWT
 5wluX2OoQqxerL15o
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Shourya,

On Fri, 3 Jul 2020, Shourya Shukla wrote:

> From: Prathamesh Chavan <pc44800@gmail.com>
>
> Change the scope of function count_lines for allowing the function
> to be reused in other parts of the code as well.

It may be just me, but I'd rather see the word "visibility" instead of
"scope" here. I mistook the subject line to indicate that the function is
changed to serve an (at least slightly) different purpose than before,
which is not actually the case.

Another alternative to "visibility" might be to imitate existing commit
messages, such as e4cb659ebdd (diff: export diffstat interface,
2019-11-13), 22184497a36 (factor out refresh_and_write_cache function,
2019-09-11) or ef283b3699f (apply: make parse_git_diff_header public,
2019-07-11).

In addition, as with all such changes, we need to be careful to consider
whether unrelated function names coming in from system headers might
clash. In this case, I think `count_lines()` is a bit too generic, but
will probably not clash. Personally, I would probably have opted for
`count_lines_in_string()`.

Ciao,
Johannes

>
> Mentored-by: Christian Couder <christian.couder@gmail.com>
> Mentored-by: Stefan Beller <sbeller@google.com>
> Mentored-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
> Signed-off-by: Prathamesh Chavan <pc44800@gmail.com>
> Signed-off-by: Shourya Shukla <shouryashukla.oo@gmail.com>
> ---
>  diff.c | 2 +-
>  diff.h | 1 +
>  2 files changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/diff.c b/diff.c
> index 4a2c631c37..39ddbcf451 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -547,7 +547,7 @@ struct emit_callback {
>  	struct strbuf *header;
>  };
>
> -static int count_lines(const char *data, int size)
> +int count_lines(const char *data, int size)
>  {
>  	int count, ch, completely_empty =3D 1, nl_just_seen =3D 0;
>  	count =3D 0;
> diff --git a/diff.h b/diff.h
> index 9443dc1b00..bd96c8c434 100644
> --- a/diff.h
> +++ b/diff.h
> @@ -495,6 +495,7 @@ void free_diffstat_info(struct diffstat_t *diffstat)=
;
>  int parse_long_opt(const char *opt, const char **argv,
>  		   const char **optarg);
>
> +int count_lines(const char *data, int size);
>  int git_diff_basic_config(const char *var, const char *value, void *cb)=
;
>  int git_diff_heuristic_config(const char *var, const char *value, void =
*cb);
>  void init_diff_ui_defaults(void);
> --
> 2.27.0
>
>
