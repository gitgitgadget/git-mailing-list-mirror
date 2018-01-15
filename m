Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 38C1B1F406
	for <e@80x24.org>; Mon, 15 Jan 2018 20:50:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750764AbeAOUuG (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 Jan 2018 15:50:06 -0500
Received: from elephants.elehost.com ([216.66.27.132]:54301 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750714AbeAOUuF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Jan 2018 15:50:05 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from pangea (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id w0FKo27f053665
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 15 Jan 2018 15:50:03 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Thomas Gummerer'" <t.gummerer@gmail.com>
Cc:     <git@vger.kernel.org>
References: <20180114180748.14584-1-randall.s.becker@rogers.com> <20180115204301.GL2641@hank>
In-Reply-To: <20180115204301.GL2641@hank>
Subject: RE: [PATCH] Removed unnecessary void* from hashmap.h that caused compile warnings
Date:   Mon, 15 Jan 2018 15:49:58 -0500
Message-ID: <007801d38e42$6b6df3b0$4249db10$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQJ+6L22/4W3a1sesdo4xNks9eauoAFvA5UDohM66gA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On January 15, 2018 3:43 PM, Thomas Gummerer wrote:
> Thanks for your patch!  A few nitpicks below:
> 
> > Subject: [PATCH] Removed unnecessary void* from hashmap.h that caused
> > compile warnings
> 
> From Documentation/SubmittingPatches:
> 
>     Describe your changes in imperative mood, e.g. "make xyzzy do frotz"
>     instead of "[This patch] makes xyzzy do frotz" or "[I] changed xyzzy
>     to do frotz", as if you are giving orders to the codebase to change
>     its behavior.
> 
> I liked the subject Philip suggested in the other thread: "hashmap.h:
> remove unnecessary void*", or maybe "hashmap.h: remove unnecessary
> variable".
> 
> On 01/14, randall.s.becker@rogers.com wrote:
> > From: "Randall S. Becker" <rsbecker@nexbridge.com>
> >
> > * hashmap.h: Revised the while loop in the
> hashmap_enable_item_counting
> > 	to remove unneeded void* item.
> 
> As above, this should be described in an imperative mood, and describe why
> this is a good change and should be merged.  Maybe something along the
> lines of the below?
> 
>     In 'hashmap_enable_item_counting()', item is assigned but never
>     used.  This causes a warning on HP NonStop.  As the variable is
>     never used, fix this by just removing it.
> 
> > Signed-off-by: Randall S. Becker <rsbecker@nexbridge.com>
> > ---
> >  hashmap.h | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/hashmap.h b/hashmap.h
> > index 7ce79f3..d375d9c 100644
> > --- a/hashmap.h
> > +++ b/hashmap.h
> > @@ -400,7 +400,6 @@ static inline void
> hashmap_disable_item_counting(struct hashmap *map)
> >   */
> >  static inline void hashmap_enable_item_counting(struct hashmap *map)
> > {
> > -	void *item;
> >  	unsigned int n = 0;
> >  	struct hashmap_iter iter;
> >
> > @@ -408,7 +407,7 @@ static inline void
> hashmap_enable_item_counting(struct hashmap *map)
> >  		return;
> >
> >  	hashmap_iter_init(map, &iter);
> > -	while ((item = hashmap_iter_next(&iter)))
> > +	while (hashmap_iter_next(&iter))
> >  		n++;
> >
> >  	map->do_count_items = 1;

I like it. Do you need this resubmitted? Or should I just learn for next
time?

Cheers,
Randall

