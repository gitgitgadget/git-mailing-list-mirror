Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D62831F404
	for <e@80x24.org>; Fri, 30 Mar 2018 14:02:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751203AbeC3OCM (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Mar 2018 10:02:12 -0400
Received: from mout.gmx.net ([212.227.15.15]:55733 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750794AbeC3OCL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Mar 2018 10:02:11 -0400
Received: from [192.168.0.129] ([37.201.195.115]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Lg0wl-1eDEeD13Rj-00pZJD; Fri, 30
 Mar 2018 16:01:58 +0200
Date:   Fri, 30 Mar 2018 16:01:56 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@dscho.gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Thomas Rast <tr@thomasrast.ch>, Phil Haack <haacked@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Stefan Beller <sbeller@google.com>,
        Jason Frey <jfrey@redhat.com>,
        Philip Oakley <philipoakley@iee.org>
Subject: Re: [PATCH 8/9] git_config_set: use do_config_from_file() directly
In-Reply-To: <20180330131456.GB29568@sigill.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.1803301558360.5026@qfpub.tvgsbejvaqbjf.bet>
References: <cover.1522336130.git.johannes.schindelin@gmx.de> <e3032300946eb5962878341f7796f5872c4d138d.1522336130.git.johannes.schindelin@gmx.de> <20180329213823.GH2939@sigill.intra.peff.net> <nycvar.QRO.7.76.6.1803301500560.5026@qfpub.tvgsbejvaqbjf.bet>
 <20180330131456.GB29568@sigill.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:wB7gvjrh2ZUYJ5wUKO4v3PlKD/Gvv/0tY82BHfrLNaOBvroNntV
 trq5E4mGwPGUoRiMi8HNIybvF2DrHHNT+XPfXlljIe8+ASvUb5Al+b1E8b20i88sqby6/PE
 4Dej9km+zJiV5CtktoingYXKdYfkrF56z9Y2+Ey+00+pjlyl0681DQVtn3789vkShBrocZI
 ++b5Euhy/VOYjzkd/hOvA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:RMH0QKKILds=:RqI/oOiIRzV4GVsZ8T+WO6
 UTiGW4oMsd35FaDKfTkCaK7bGYxoRCAtuCpXMz95kTuDFiR0agDz5yZwfpxKbUb5ulQ7l7tEr
 wmWsW7dRWhQNzVY2Ix2/gfKmBfyP21PjMLeSZfxdp+m6jkz0hidcwZaZk91HKNplcrIOOa778
 TUhGSwB3IaTejTyGlX6mlquT2EiX4okM4FdC5UboAzJ6Q7Dde5JAlHsui0PSN/a4e96/It6Ne
 dY2WO4xHr/BKN5v+68lASHSYWAsrDsLqsuQ3mIm9SKSTbZepSZAbJbnYoYzEJUp+n4Pq+VXX3
 3Hu9im925j+Ct21V/4a7KIVLgEeWHRzo1w63XN5TnrEqhXyPjUlSjTSf0ImoRI6BFYBKJX7va
 zJ9RN7cu5vsuY2GdU4jMA0ANZcCaSEf4Hm3MTOqZsJYUcCkwgchlT7TE4u3sWdS7wqEc1UgxU
 KFqqoZ9A0uxgHrhKAHCqf0WiRQ7iEAVlkag9OBIfNOu/Ke4JYuY8aOK413QL11yLh8xFxHyA0
 mY/s+Yt8ObrlgJ0nOAb/2W4JKTFgZR9bzBVhp2MvBZjEkXfIgWhQnhUQ6SLlS4tkf0Q/90cKp
 /oqcvcP4oKLRcSZP3UunAer8q++WSxFkWBZU35dblkgwhnxo2JWK0OTdMBI8Fy6fM12bN4w73
 fS7F1Pdnc4+ae9/1CMXmpkXW/ziWHwvPVyivvkIM5OWMkhKO/31FY+5knikFsA5C/OD+8YC8o
 Gxf7jFmiFa6tAY1np38iS0garjYLfaLCyxeI59aGIeSZCaSQD78l+bQdvflEcE97pWpC35FnZ
 83YtJxFym9ru7iXaGvAnQ9H1dBmto6842nUe6likB9wUTetn4IZLwWdjYGZA7zf7R2yWv/Y
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Fri, 30 Mar 2018, Jeff King wrote:

> On Fri, Mar 30, 2018 at 03:02:00PM +0200, Johannes Schindelin wrote:
> 
> > > I'm not sure I understand that last paragraph. What does flockfile() have
> > > to do with stdin/stdout?
> > > 
> > > The point of those calls is that we're locking the FILE handle, so that
> > > it's safe for the lower-level config code to run getc_unlocked(), which
> > > is faster.
> > > 
> > > So without those, we're calling getc_unlocked() without holding the
> > > lock. I think it probably works in practice because we know that we're
> > > single-threaded, but it seems a bit sketchy.
> > 
> > Oops. I misunderstood the purpose of flockfile(), then. I thought it was
> > only about multiple users of stdin/stdout.
> > 
> > Will have a look whether flockfile()/funlockfile() can be moved into
> > do_config_from_file() instead.
> 
> In a sense stdin/stdout are much more susceptible to this because
> they're global variables, and any thread may touch them. For the config
> code, we open our own handle that we don't expose elsewhere. So probably
> it would be fine just to use the unlocked variants even without locking.
> 
> But IMHO it's good practice to always flockfile() before using the
> unlocked variants. My reading of POSIX is that it's OK to use the
> unlocked variants without holding the lock (if you know there won't be
> contention), but if it's not hard to err on the side of safety, I'd
> prefer it.

You know what is *really* funny?

-- snip --
static int git_config_from_stdin(config_fn_t fn, void *data)
{
        return do_config_from_file(fn, CONFIG_ORIGIN_STDIN, "", NULL, stdin, data, 0);
}

int git_config_from_file(config_fn_t fn, const char *filename, void *data)
{
        int ret = -1;
        FILE *f;

        f = fopen_or_warn(filename, "r");
        if (f) {
                flockfile(f);
                ret = do_config_from_file(fn, CONFIG_ORIGIN_FILE, filename, filename, f, data, 0);
                funlockfile(f);
                fclose(f);
        }
        return ret;
}
-- snap --

So the _stdin variant *goes out of its way not to flockfile()*...

But I guess all this will become moot when I start handing down the config
options. It does mean that I have to change the signatures in header
files, oh well ;-)

But then I can drop this here patch and we can stop musing about
flockfile()  ;-)

Ciao,
Dscho
