Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9F11B1FC3E
	for <e@80x24.org>; Fri, 28 Apr 2017 11:33:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1424933AbdD1Ld2 (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Apr 2017 07:33:28 -0400
Received: from mout.gmx.net ([212.227.15.18]:50133 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1423444AbdD1Ld1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Apr 2017 07:33:27 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MbPLI-1dMq1N259I-00IotA; Fri, 28
 Apr 2017 13:33:21 +0200
Date:   Fri, 28 Apr 2017 13:33:20 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Johannes Sixt <j6t@kdbg.org>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 22/26] add_reflog_for_walk: avoid memory leak
In-Reply-To: <74da6153-2ce4-4224-d8d4-5be7481431ef@kdbg.org>
Message-ID: <alpine.DEB.2.20.1704281311500.3480@virtualbox>
References: <cover.1493237937.git.johannes.schindelin@gmx.de> <aeb46b9436b1f5f54322cb818519db97801b9d7a.1493237937.git.johannes.schindelin@gmx.de> <74da6153-2ce4-4224-d8d4-5be7481431ef@kdbg.org>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:I2TxdwZP7a12TeJNQp97O8xwnWRlwd3+jtOOLo8IN4TRBJJUyBu
 CHkqjmuAjyeEPdeWjPLzzJHJv8+M/4eqAYpjJFhu3QWUnziadmM31e6Gex9LQRadtXPSQww
 LSMHUsTFZ1OfdLDz51+bKEZiQNGZdm8eHC2aMNu+2t/+cEnemtGEuV0lVuvqDIqQHlfhETR
 KV7XrCvp99ssjPUyIt+WQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:jN3qXlct/Mk=:S2t4Z6DPaHyy7mJTa0nKXh
 0x7LHaX8ZSr8IMrTPgHHGe7+3FkMgLuyhh7xJ2SNQnkYHdUL/bcC3TW5jp4WUN8opMW/TQkLV
 Xto7uF5xJsUiqFuQPV+Z65p7oIYoHTIexMQ5rywQqQboqA14prijUBx5fl6e322U4ufXKXeQz
 tSGl/bwQFoib+TWDtob/YbpZwz7TYvPCR6bOi5wkAytZ5/rcln2+7mnJLlWZSjvE3zCTD94/a
 4ltKDuO3G8G2MlUh+NdE7vRjHRysNylDx5wMvu1b7Nv0gd9H3A449WVGX1RqdKtDWyBjRoTN6
 C/4XH9eHsH8SwD3TyBJ/7YKrIUQynwwoObth4IRvTUzpXBCSgHdAG4pwadIH52wX2mbwTGPzA
 63sWrLAHC5QaSDkp9wDoDBZ8TdG6Hj2lP3lFBB3qJcU1qQwLx6J4qMV7f2yDwdFwNW4b3IgNI
 PyDeNGDRH7NYcABY8LHOOHA+TFWsZeK2yGUCuZ3XAJxLFmug3yIRSi61X04gpavVpDXfvYvRq
 EBLfHmzQnBNYE8BkAQMX7rOIjgirIElF7vzUkR8YYRYuIQLkM++I/BG1VNf1DYWRR+4j9ZeXI
 kGTEFjb1tGXKHAq/agJzth7ISXs+PJwPoRZdcNOgYyX+/okm2VhEIyrvaMOEqmKh8Gj4otPKa
 YkkENFf62u7bbG5GARDUZS75gNnVTwkrAMJhs7700PcBsa6Kd+3KTEYJNzdjTK/M8PFSaBydT
 EG5dYEHYzk+0opzLD/KHQBpcKWzjdJMuKCEohIps+QEMbfseOxoop0zIDmZM6W52vZHHTjlUv
 G7JB1o1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Hannes,

On Thu, 27 Apr 2017, Johannes Sixt wrote:

> Am 26.04.2017 um 22:21 schrieb Johannes Schindelin:
> > We free()d the `log` buffer when dwim_log() returned 1, but not when it
> > returned a larger value (which meant that it still allocated the buffer
> > but we simply ignored it).
> >
> > Identified by Coverity.
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >  reflog-walk.c | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/reflog-walk.c b/reflog-walk.c
> > index 99679f58255..ec66f2b16e6 100644
> > --- a/reflog-walk.c
> > +++ b/reflog-walk.c
> > @@ -183,7 +183,11 @@ int add_reflog_for_walk(struct reflog_walk_info *info,
> >    if (!reflogs || reflogs->nr == 0) {
> >     struct object_id oid;
> >     char *b;
> > -			if (dwim_log(branch, strlen(branch), oid.hash, &b) ==
> > 1) {
> > +			int ret = dwim_log(branch, strlen(branch),
> > +					   oid.hash, &b);
> > +			if (ret > 1)
> > +				free(b);
> > +			else if (ret == 1) {
> >      if (reflogs) {
> >       free(reflogs->ref);
> >       free(reflogs);
> >
> 
> Right after this hunk, there is another conditional that looks like it
> forgets to free reflogs.

Thanks! Seems I got too hung up with the line to which Coverity pointed
and failed to see the bigger picture.

It seems that there are plenty of leaks, even further down. For one, the
`branch` variable is not released at the very end of the function! One
might think that read_complete_reflogs() takes custody of it, but no, it
xstrdup()s the refname right at the beginning.

So there was a lot more memory leaking going on in that function...

Ciao,
Dscho
