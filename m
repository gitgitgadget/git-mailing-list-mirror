Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 60CF11F859
	for <e@80x24.org>; Tue, 30 Aug 2016 10:21:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757956AbcH3KVK (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Aug 2016 06:21:10 -0400
Received: from mout.gmx.net ([212.227.17.22]:50775 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757100AbcH3KVG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Aug 2016 06:21:06 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0LzYY2-1b1iTL2DaM-014n6s; Tue, 30 Aug 2016 12:20:49
 +0200
Date:   Tue, 30 Aug 2016 11:09:31 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 08/14] sequencer: lib'ify read_and_refresh_cache()
In-Reply-To: <xmqq7faz9ufi.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1608301106220.129229@virtualbox>
References: <cover.1471968378.git.johannes.schindelin@gmx.de>        <cover.1472219214.git.johannes.schindelin@gmx.de>        <99f3ab3a30a469b271300ff61309ac4c4a8af448.1472219214.git.johannes.schindelin@gmx.de>
 <xmqq7faz9ufi.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:jXa6j4OmbwTUDPc9ZrHu3YjYSsEoN+uMv581RkQgZeOtaUB14vW
 FZo1JCL+QsAlAS+v47T21BT00LGiU/g3ALapgIz95BmTAFlHzB8QxKHJ9ra8zkKqfGtrobD
 OupE8cukEu6gcPY9lrFCqmdj5cGnpiCl/OWR2JZouBsoAGeFmYN+jrmg/T6NVGLREEnwzxR
 WlT0tT+P4xPT6Cq8wstxA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:KgRg3s3dABM=:eIjvZkgSJuj64QyOOrb0Zn
 YFZuIZVb9ELzZbv47/F2TERh+HsXa6nMEuQ+pOinkVRKp4/eTkmLibwlfnSlH0lspcb/TodZF
 5XdSbQxn7j2YliaP/3usdOY7BYjbZF6yPU68r/1O53sRxFMr8raGcGjIu4L3D8a0rW245yDVs
 4K74Q7O7cpElLJiVCi1kZ2R750ov5ZGdpvJNWNYyDLVIA/EpLUPag1Vmpx4ZlLpKF7wBLEzj1
 +MPykW137ZQgobZqRjN9QzBWEpjD/xliMnm4cKGai3QtjfE1Ye+9myZqt5QWb7y9ZfhQZ/p4J
 QgiebbKwO01RA6F/koDn6gUKqqd++pEb4NggZnoh9g0ytIqhlIWYrHPDvbwhyQvz5gGfT4QRB
 gJyi3EHxESqQL7d1jY7j0mZC3kFOKUnvshNjTCXR7gUWnLPuTDOZfUtCWkJYekxpvx/Srzo6U
 FUeL33zE45lShauFRqO1VImFDU1ed+v3/CJCO2ukoZJqzovasQDFA4GRXgq6SObwZpAKnbAwg
 ylEISbYFjs92QgyRYbX+2O4Xed5m+FDtdal8Ice5wPL20hAS/KLOQxLUhrVyihaL90bW2errp
 Zr3MF47a7WaR9G5Ht3QX2F59pVIDm4BKrkSWEyexDAr04pVZtTGO0nxQEnkiT8BvoTQ11eTtL
 qcJxXh3htzJ4wSnSXbmRGAwU0X1GOn4VRyI/7AOHGbE7exdXp/nGIdDwV8aeDxwRnYsuTtMUr
 iBVm+6LT2uhaqkBdSf0qA20Mvb1RBqtRx3C03YLFyzHKz/Hev/ld4z/HMqlqFcrsKFhVI1k4u
 CMK9/Me
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Mon, 29 Aug 2016, Junio C Hamano wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
> > Instead of dying there, let the caller high up in the callchain
> > notice the error and handle it (by dying, still).
> >
> > There are two call sites of read_and_refresh_cache(), one of which is
> > pick_commits(), whose callers were already prepared to do the right
> > thing given an "error" return from it by an earlier patch, so the
> > conversion is safe.
> >
> > The other one, sequencer_pick_revisions() was also prepared to relay
> > an error return back to its caller in all remaining cases in an
> > earlier patch.
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >  sequencer.c | 15 ++++++++++-----
> >  1 file changed, 10 insertions(+), 5 deletions(-)
> >
> > diff --git a/sequencer.c b/sequencer.c
> > index c006cae..e30aa82 100644
> > --- a/sequencer.c
> > +++ b/sequencer.c
> > @@ -640,18 +640,21 @@ static int prepare_revs(struct replay_opts *opts)
> >  	return 0;
> >  }
> >  
> > -static void read_and_refresh_cache(struct replay_opts *opts)
> > +static int read_and_refresh_cache(struct replay_opts *opts)
> >  {
> >  	static struct lock_file index_lock;
> >  	int index_fd = hold_locked_index(&index_lock, 0);
> >  	if (read_index_preload(&the_index, NULL) < 0)
> > -		die(_("git %s: failed to read the index"), action_name(opts));
> > +		return error(_("git %s: failed to read the index"),
> > +			action_name(opts));
> >  	refresh_index(&the_index, REFRESH_QUIET|REFRESH_UNMERGED, NULL, NULL, NULL);
> >  	if (the_index.cache_changed && index_fd >= 0) {
> >  		if (write_locked_index(&the_index, &index_lock, COMMIT_LOCK))
> > -			die(_("git %s: failed to refresh the index"), action_name(opts));
> > +			return error(_("git %s: failed to refresh the index"),
> > +				action_name(opts));
> >  	}
> >  	rollback_lock_file(&index_lock);
> > +	return 0;
> >  }
> 
> With the current set of callers, a caller that notices an error from
> this function will immediately exit without doing any further
> damage.
> 
> So in that sense, this is a "safe" conversion.
> 
> But is it a sensible conversion?  When the caller wants to do
> anything else (e.g. clean-up and try something else, perhaps read
> the index again), the caller can't, as the index is still locked,
> because even though the code knows that the lock will not be
> released until the process exit, it chose to return error without
> releasing the lock.

It depends what the caller wants to do. The case about which I care most
is when some helpful advice should be printed (see e.g. 3be18b4 (t5520:
verify that `pull --rebase` shows the helpful advice when failing,
2016-07-26)). Those callers do not need to care, as the atexit() handler
will clean up the lock file.

However, I am sympathetic to your angle, even if I do not expect any such
caller to arise anytime soon.

> For a file-scope static helper, that probably is sufficient.  But if
> this can be reached from a public entry point in the API, the caller
> of that entry point will find this not-so-useful, I would think.
> 
> I suspect doing the "right thing" to future-proof it may not be too
> much more work.
> 
> 	static int read_and_refresh_cache(struct replay_opts *opts)
>         {
> +        	int retval = 0; /* assume success */
> 		...
>                 if (read_idnex_preload(...) < 0) {
> 			retval = error(...);
>                         goto finish;
> 		}
>                 refresh_index(...);
>                 if (...changed...) {
>                 	if (write_locked_index(...))
>                         	retval = error(...);
> 		}
> +	finish:
>                 rollback_lock_file(&index_lock);
>                 return retval;
> 	}
> 
> or something like that on top?

I settled for rolling back in the if() clauses.

Ciao,
Dscho
