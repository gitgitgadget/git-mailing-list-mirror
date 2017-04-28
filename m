Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4ECC41FC3E
	for <e@80x24.org>; Fri, 28 Apr 2017 10:59:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1424991AbdD1K66 (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Apr 2017 06:58:58 -0400
Received: from mout.gmx.net ([212.227.15.19]:62083 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1424987AbdD1K65 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Apr 2017 06:58:57 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LfBX6-1dsmd00jjU-00olCi; Fri, 28
 Apr 2017 12:58:50 +0200
Date:   Fri, 28 Apr 2017 12:58:48 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Johannes Sixt <j6t@kdbg.org>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 18/26] fast-export: avoid leaking memory in
 handle_tag()
In-Reply-To: <885f5dbc-b5d0-5113-d2ee-e9bac47c4271@kdbg.org>
Message-ID: <alpine.DEB.2.20.1704281257340.3480@virtualbox>
References: <cover.1493237937.git.johannes.schindelin@gmx.de> <1eda2649781a15264e9995e705d19206185dbbb1.1493237937.git.johannes.schindelin@gmx.de> <885f5dbc-b5d0-5113-d2ee-e9bac47c4271@kdbg.org>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:F98EP6wpO8BNp52mWiadYaL8ZKUi5cYq48ve6+fkoEz2qZG1HcD
 lz0+IIPNeVOiQeUVZ/aA22Nn3nhLOZfw6haoudz+poB4Bi/eRxPokkVTWwqZONbhw+cxchQ
 nKe6jCgdYfevYR0gyQWSHSufKpRMd0cJKBd3txq0fWOz3SrC2u+P/AShbV4WKP4cI1Rq5Db
 pWkdCWB7vA4JCoE7gUhng==
X-UI-Out-Filterresults: notjunk:1;V01:K0:jQlz3NDVYRE=:Iyqj2eYIF9R4i5SL+Y9swf
 eHW03tr/lL0qwMWmmTUonRLDVw9gEkHy2VtD9f+8e6baW/3sgzh+vDsrREzuzr67CObqbujvL
 /3E8hqy+qECEtpN4K9zEsE1F4syX180uOnbsLyhU2xudy2LWIK1UapYhQjHFdLDQvyU0YnYRd
 OWT9yI4rawNvlbKYy8cIvw7akVUo/GGgjGkYgkP5BglcKKR1KSmPIUf0Wtv7IVxEPT2Z5VFC9
 e5RPOIl0Bejfmrl2q/zHnZajvS/5BEkUvK3JBgiw9uX4jnVO2Z8cZy936ZcKpVQAkXEp9sUmc
 GkrG3L005c/R8y4Sn+d1WLA91sopYL/p6Q09xLtAQxrhuhhvP/U1qXd7+mx0IQo/OYZOclaWH
 SK7YeOquRHzkjZKt0kO8kGtWRxVDMw6QsQOIs9u2PhqGMjzJfKF1eXO29ZKUPB0G4vQIPBJi/
 0EHdLmb97AfbnRfxohilyF9rdERhqbZ0AYH68/GQsjUdPp0HLoxacyt6u9XfWUDHcka/ViBfa
 178fGuJUVqaIdVpPOZdSov25NN6G7Z90KKiiF5/yGsWrNDpqn5rYQ1o43DbtIx1G9a8ypr9On
 DAdoxT9tveZpoh9GI2ycgwCKa4eZysldEHpHlGQcHLWFFAcvCcM/ouJ5KoUvv50S1uvyG6b9Y
 /VcFojKfeWi8UfVhm63pR6suSeC8m5kSjTTRf5Q/QnwJ1bd9xYQIluYRVyvl9dJoLMqFLPUDY
 FXeZWsW1ogxQC7gCgkmDg/ydkJALLpAsHTjNziB3NoImPELrZgZZp8xk0D3NHzSsOx2qm70MI
 zhWlL8s
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Hannes,

On Thu, 27 Apr 2017, Johannes Sixt wrote:

> Am 26.04.2017 um 22:21 schrieb Johannes Schindelin:
> > Reported by, you guessed it, Coverity.
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >  builtin/fast-export.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/builtin/fast-export.c b/builtin/fast-export.c
> > index e0220630d00..828d41c0c11 100644
> > --- a/builtin/fast-export.c
> > +++ b/builtin/fast-export.c
> > @@ -765,6 +765,7 @@ static void handle_tag(const char *name, struct tag
> > *tag)
> >          (int)(tagger_end - tagger), tagger,
> >          tagger == tagger_end ? "" : "\n",
> >          (int)message_size, (int)message_size, message ? message : "");
> > +	free(buf);
> >  }
> >
> >  static struct commit *get_commit(struct rev_cmdline_entry *e, char
> >  *full_name)
> >
> 
> There is an early return in the function that is not covered by this patch.

Thanks!

> Look for "case DROP".

Or for "return" ;-)

I briefly looked into simply releasing the memory earlier, but the tagger
variable used just before the inserted free(buf) actually points into the
buffer, so I had to repeat the free(buf) for the early return.

Thank you!
Dscho
