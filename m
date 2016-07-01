Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-7.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5A48320FD0
	for <e@80x24.org>; Fri,  1 Jul 2016 10:22:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752762AbcGAKWs (ORCPT <rfc822;e@80x24.org>);
	Fri, 1 Jul 2016 06:22:48 -0400
Received: from mout.gmx.net ([212.227.15.18]:64862 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752746AbcGAKWl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jul 2016 06:22:41 -0400
Received: from virtualbox ([37.24.141.253]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0Mg4FJ-1aw8dF1y1l-00NOJB; Fri, 01 Jul 2016 11:23:48
 +0200
Date:	Fri, 1 Jul 2016 11:23:47 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Junio C Hamano <gitster@pobox.com>
cc:	git@vger.kernel.org
Subject: Re: [PATCH 2/9] merge-recursive: clarify code in was_tracked()
In-Reply-To: <xmqq4m8b4zdd.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1607011057180.12947@virtualbox>
References: <cover.1467199553.git.johannes.schindelin@gmx.de> <dd3e2cf842fd5e11e31914aa55b8b995e8d3d75c.1467199553.git.johannes.schindelin@gmx.de> <xmqq4m8b4zdd.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:rEBQkrX9BxBYHr/eoiuwrqKVIqxhdd5WsP5vzZPpfZmpOWi7naG
 lvUpYJkd/eT0bv8dixezLQl7HsZ7ub5J/2szxciXrRReNaV8JpTbj5Ns1x537VMt40hMeMe
 1CsmRmeSdBR1xlu3UGPkSmSVLTXt/OS/ger7zFwRNVY2mDG60Pj6FTi0n5rhmckmcLEFBEB
 yObgU+EamYhsA2k2DPSaQ==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:VJLwkiYbJpg=:hQpiSCryJqCe8Ssj991DX2
 1hHTgV0py7QjX7x4dCFdDz1kEc8hK1nizx0BnlYERShaeVOO1LHeaECr2gLLV2bgsnxR6v+Mh
 1xgZWxDj0LHfd4vKaL2fJ+dxH4ad89qXkZt2VyvUu9z5B2vIGO9ub3p8S9wSGYA0DoL75jyEq
 3zZaB2oQsw6IUXEtbmJcyvQmHBs39tP+dWIRid09oHPLb1cesyadZBLCn67nW+o1qX6KPsgpj
 EJgel2U/EqS8WAWnRg2oLH23azIe/0Nat0YGd8Tp9G0s30SRw1cWeGrnccMJAG8AWelSXzTQy
 khfQITv3Zhi3uSbxSgpGkMZw+mId/INCkTA1uqLW2FkTZSHol+Rbg7urvNhK54HqI2pjYonZv
 8nys8oOCxbz7K7Z/fgTlB5GlkIva21aHQ/lb2/SYBkyJfSC2OigEyJVnrOKVExkz0ru4sF1NX
 oBBVTnpovDg/gd3r/KgPicX54ZbEEWT0hHuBSpGlUUdqY2uRkuHrdgY8aNLQFswBvaZllxCd/
 QYz6eAhd2/kjehTUsje9/MoC9a+O9NswrZiyh6BqjT9p0bJ7JRorNVLXz/ECwTdQHtoH5wBGe
 d0VgYRGtuIV8fDwJbARlmztAF/M8Y00jOeytk1ECIOa3/imtdRqXiJ6pw4Rf3waLkbcQAbFWM
 JrtUXir0igWjeb68W1hYGs+w7M6enCcNhf5RnUeDGaBeIsDLDt8r9iECh88gR+X/rTYEeSGSV
 cUGAG6AzryGw/KSjaybH2+mFSLfVQe0etE8NTLvJzPa65NyrTBiU5V8PDraRiYkb028kA6oUX
 lw1bYpP
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Junio,

On Wed, 29 Jun 2016, Junio C Hamano wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
> > It can be puzzling to see that was_tracked() tries to match an index
> > entry by name even if cache_name_pos() returned a negative value. Let's
> > clarify that cache_name_pos() implicitly looks for stage 0, while we are
> > also okay with finding other stages.
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >  merge-recursive.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/merge-recursive.c b/merge-recursive.c
> > index 98f4632..bcb53f0 100644
> > --- a/merge-recursive.c
> > +++ b/merge-recursive.c
> > @@ -658,6 +658,7 @@ static int was_tracked(const char *path)
> >  {
> >  	int pos = cache_name_pos(path, strlen(path));
> >  
> > +	/* cache_name_pos() looks for stage == 0, so pos may be < 0 */
> 
> It returns >= if found at stage #0, or a negative (counting from -1)
> to indicate where the path would be inserted if it were to be added
> at stage #0.

Right. Please note that nothing in the function call to cache_name_pos()
specifies that we are looking for any particular stage. You are probably
too intimate with the implementation details, so naturally you assume that
cache_name_pos() looks for a precise match *with stage 0*. I am not that
familiar with that part of the implementation, so I *was* puzzled.

> The new comment does not explain how "pos may be < 0" leads to
> "hence pos = -1 - pos is the right thing to do here".  It is
> misleading and we probably are better off without.

I agree that the comment is not very good currently. But I disagree that
we are better off without any comment here.

So maybe a comment is not really enough here. In case the entry is in
stage 0, we will have an exact match, so there is no need to go to the
lengths of a while() loop.

I would like to propose this diff instead (it is larger, but with a net
savings of one line):

-- snipsnap --
diff --git a/merge-recursive.c b/merge-recursive.c
index d5a593c..0eda51a 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -658,24 +658,22 @@ static int was_tracked(const char *path)
 {
 	int pos = cache_name_pos(path, strlen(path));
 
-	if (pos < 0)
-		pos = -1 - pos;
-	while (pos < active_nr &&
-	       !strcmp(path, active_cache[pos]->name)) {
+	if (pos >= 0)
+		return pos < active_nr;
+	/*
+	 * cache_name_pos() looks for stage == 0, even if we did not ask for
+	 * it. Let's look for stage == 2 now.
+	 */
+	for (pos = -1 - pos; pos < active_nr &&
+	     !strcmp(path, active_cache[pos]->name); pos++)
 		/*
 		 * If stage #0, it is definitely tracked.
 		 * If it has stage #2 then it was tracked
 		 * before this merge started.  All other
 		 * cases the path was not tracked.
 		 */
-		switch (ce_stage(active_cache[pos])) {
-		case 0:
-		case 2:
+		if (ce_stage(active_cache[pos]) == 2)
 			return 1;
-		}
-		pos++;
-	}
 	return 0;
 }
 

