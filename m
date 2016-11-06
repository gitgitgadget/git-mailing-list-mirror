Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6B18E2021E
	for <e@80x24.org>; Sun,  6 Nov 2016 14:05:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752082AbcKFOFR (ORCPT <rfc822;e@80x24.org>);
        Sun, 6 Nov 2016 09:05:17 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34300 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751660AbcKFOFQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 Nov 2016 09:05:16 -0500
Received: by mail-wm0-f68.google.com with SMTP id p190so11961926wmp.1
        for <git@vger.kernel.org>; Sun, 06 Nov 2016 06:05:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=GULHPKqI1eyolKZZBWn2KuBd9jQ8B1IzkhKgjfKAGgw=;
        b=HpukyLz6z/28m5zPYYyJVxFNCXVQihOrPs8y+GLge239x/coBGvkinjib6UpKrbj8k
         qVpdE6DWqla0n1lS0odljGcqPqKxY4+kRr7S2PlO59oOA6bPenGj4fBFp6H6/Z/64xXD
         taYpCZzSRTsoj3+brCn66i6HhEOGywooa8v4gqQgnhAUd8WaR1YpY3BeRdFf1f2U6nDz
         CDT2XnC/GAntQ3fot9kiE+/PnHPdeCDQpmloIQ2Hyxs/VfFcEtEC27+BS9lJond1HdBi
         uK79Or3nBXq/4pahvPTe1WnkV3VXlu/HytFGPN1GjUHUHbUmKeM7+AkXSSVJoBEVJXo3
         eZ+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=GULHPKqI1eyolKZZBWn2KuBd9jQ8B1IzkhKgjfKAGgw=;
        b=QrqkZKk4GZUJzoAtkPUXdMdtw7OYiGSbMcfuqvwF1gTyIhSIIqmSEWyu/S4OWemEA6
         TVZurmzk1yBXmF7RBEAA0nxKv8w6Y53BEzSWYXByU+z7D3kw21UunmHjOWWT13RdezNx
         bkPGCLud7pNrDxlDvYewyy26D/LNaIfF25GsLJ1WveAPMXYMOGnLyn6VG/69TA38BpKN
         N+HREIOYMbCw4zNebjWkZ2Y39j0lrzmbbSu5Blisv1LbUdSrvf0Hn3PtZj8eWyDUNa4e
         fUlqoD1WAIbmwgN56t3KbbUuDx6sgoV/kHP6p7UZB71eeTTmZetYyi0kPmc6NPethS/Z
         QgZg==
X-Gm-Message-State: ABUngvc6RpqGzWEzpm46lhxGbqPyvxHyvIhsyqodH7Stk74z/zEcvkD2QfbjPQ9Q/I3fkQ==
X-Received: by 10.28.20.139 with SMTP id 133mr4949891wmu.9.1478441115551;
        Sun, 06 Nov 2016 06:05:15 -0800 (PST)
Received: from slxbook4.fritz.box (p5DDB5D74.dip0.t-ipconnect.de. [93.219.93.116])
        by smtp.gmail.com with ESMTPSA id i10sm25336903wjd.15.2016.11.06.06.05.14
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 06 Nov 2016 06:05:14 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v5 08/27] sequencer: completely revamp the "todo" script parsing
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <c0d106125e1b6ba107b1ef06fb60dd710d184d29.1477052405.git.johannes.schindelin@gmx.de>
Date:   Sun, 6 Nov 2016 15:05:22 +0100
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        =?utf-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        =?utf-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
        Jeff King <peff@peff.net>
Content-Transfer-Encoding: quoted-printable
Message-Id: <D3B8B6CB-D238-42A9-9B94-D135C25B4A63@gmail.com>
References: <cover.1476450940.git.johannes.schindelin@gmx.de> <cover.1477052405.git.johannes.schindelin@gmx.de> <c0d106125e1b6ba107b1ef06fb60dd710d184d29.1477052405.git.johannes.schindelin@gmx.de>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 21 Oct 2016, at 14:24, Johannes Schindelin =
<johannes.schindelin@gmx.de> wrote:
>=20
> When we came up with the "sequencer" idea, we really wanted to have
> kind of a plumbing equivalent of the interactive rebase. Hence the
> choice of words: the "todo" script, a "pick", etc.
>=20
> ...
>=20
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
> sequencer.c | 284 =
++++++++++++++++++++++++++++++++++--------------------------
> 1 file changed, 163 insertions(+), 121 deletions(-)
>=20
> diff --git a/sequencer.c b/sequencer.c
> index 499f5ee..145de78 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -470,7 +470,26 @@ static int allow_empty(struct replay_opts *opts, =
struct commit *commit)
> 		return 1;
> }
>=20
> -static int do_pick_commit(struct commit *commit, struct replay_opts =
*opts)
> +enum todo_command {
> +	TODO_PICK =3D 0,
> +	TODO_REVERT
> +};
> +
> +static const char *todo_command_strings[] =3D {
> +	"pick",
> +	"revert"
> +};
> +
> +static const char *command_to_string(const enum todo_command command)
> +{
> +	if (command < ARRAY_SIZE(todo_command_strings))

With DEVELOPER=3D1 I get this error on macOS when I compile current =
git/next (b27dc33) using clang:

sequencer.c:632:14: error: comparison of constant 2 with expression of =
type 'const enum todo_command' is always true =
[-Werror,-Wtautological-constant-out-of-range-compare]
        if (command < ARRAY_SIZE(todo_command_strings))

Torsten discovered this problem already in v3 and Peff suggested
a working solution [1]. Is there any reason not to use Peff's =
suggestion?


Cheers,
Lars

[1] =
http://public-inbox.org/git/d9f4f658-94fb-cb9e-7da8-3a2fac120a9e@web.de/=
