Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2BFE92055E
	for <e@80x24.org>; Tue, 31 Oct 2017 17:32:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753929AbdJaRb7 (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Oct 2017 13:31:59 -0400
Received: from mout.gmx.net ([212.227.17.22]:62837 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753918AbdJaRb6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Oct 2017 13:31:58 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LbyUS-1dSWLd1B6C-00jEzn; Tue, 31
 Oct 2017 18:31:53 +0100
Date:   Tue, 31 Oct 2017 18:31:52 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     Alex Vandiver <alexmv@dropbox.com>, git@vger.kernel.org,
        Ben Peart <peartben@gmail.com>
Subject: Re: [PATCH v3 4/4] fsmonitor: Delay updating state until after split
 index is merged
In-Reply-To: <xmqqa80728lo.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.21.1.1710311830330.6482@virtualbox>
References: <20171027232637.30395-1-alexmv@dropbox.com> <4b488da5e0710e9699f92d2dabe5e3352f3eb394.1509146542.git.alexmv@dropbox.com> <5cb81a33c31ffa585861f0d3f5a7c7eef5bd8fe0.1509146542.git.alexmv@dropbox.com> <xmqqa80728lo.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:uuuIHPBZ08kh6/81yHm3pH4Dtg2boLShaF97JA1w5cOVuuKjgjm
 wBVOIwONXySW+O3Z4RbtgSi2+kX83lU6Y10AxcrE5gaqMxCQKxP8uLJS7fatTg/IPBsRUmJ
 ttWNe1pKVaXKqJiB0Aph1g8E4weoncmlLxGmp5cGj3/VfubAtQ9VXVvWMXNdmM5XOWpztPV
 KjkiGL+zdqyWuyXEALw1Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:lkxkdnfCL8k=:C4+ugax6gjwt2wcvvmV4by
 HlUotdA8sbIXPw8wd8vbHXpMsvmqxe96bfBCE4ybi9ovrZMKDLtObw0MqZmKt5Hzlnwt9DuT3
 NWGN/3CA1kKqMrHI9dZjsXwYpo4Xho6eLev0vjwvKErjCxfubVdCLSmdk3AQswAFVraFK0sde
 i2gEv1ZZIyQ9nQtqQh9RV5PHybyW7kfevtkp1Q6LT1LCtXRoY0junySUkvQR7nLTemdQzUZnp
 ZjTR4tYlTO5BRDVeMETYeErRJkkaBsA3wu9eMsKcoTuiclc+DQnBTFHRKu7n7XeESi+g/wqDW
 pMMX6eg2/xzpwv96SEdxTPLGkQMVc6H+S1Ks0Nl9EkX9VWfrh8TkwUbvcCsPQs2pjyuXqGkzH
 UdOUQFoFYRDPimhEokEjofBgRi6OuvoaKT9AqRc3bDDPHAHG4xaT5Nj5ivdLkI4OrIcRONSZO
 V1oCCu2h/t6RRKCJ3oe0lDq+xFeQbOtUXEOmuibmVyJWXVVPdl1Vi0v3Mf0pqranYRE0fo9pC
 Pdt+5DAXRZaPkS23f7OB+ys2i+81cDs0GWX4PrV8DhFpfbfz4A+sm4GAWyi6vhlPDK80PaHQa
 Pfx0HbcI4opzytXNiExICT21wONFsM4EoD7UOo7piZJv4VC5GXueCULH0wNHby9oDi5VKQ7iZ
 GVyzOSH2FlhgkhddfCc1uW25dzQw1GlqCm4Q/9XyW3OynRFqS4zADlDtDa/0gpFHRDeLXykHB
 Zm6IyDYZrMLLpEWbrbUvuBZcGnf/Mwz6kqm2svPp834VyP3D1ik3Bn1bf+Xd6qxgQdLFz/Qh5
 Gi0eUvHoCi1igjM4/+7Z0deD51KBrr8cItPTk9kfxT1cRr9CpxQhQQWbdj8GYmgwQG3Ksp9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Tue, 31 Oct 2017, Junio C Hamano wrote:

> Alex Vandiver <alexmv@dropbox.com> writes:
> 
> > diff --git a/fsmonitor.c b/fsmonitor.c
> > index 4ea44dcc6..417759224 100644
> > --- a/fsmonitor.c
> > +++ b/fsmonitor.c
> > @@ -49,20 +49,7 @@ int read_fsmonitor_extension(struct index_state *istate, const void *data,
> >  		ewah_free(fsmonitor_dirty);
> >  		return error("failed to parse ewah bitmap reading fsmonitor index extension");
> >  	}
> > -
> > -	if (git_config_get_fsmonitor()) {
> > -		/* Mark all entries valid */
> > -		for (i = 0; i < istate->cache_nr; i++)
> > -			istate->cache[i]->ce_flags |= CE_FSMONITOR_VALID;
> > -
> > -		/* Mark all previously saved entries as dirty */
> > -		ewah_each_bit(fsmonitor_dirty, fsmonitor_ewah_callback, istate);
> > -
> > -		/* Now mark the untracked cache for fsmonitor usage */
> > -		if (istate->untracked)
> > -			istate->untracked->use_fsmonitor = 1;
> > -	}
> > -	ewah_free(fsmonitor_dirty);
> > +	istate->fsmonitor_dirty = fsmonitor_dirty;
> 
> This makes local variable "int i;" in this function unused and gets
> compiler warning.

... to which end we introduced the DEVELOPER flag to catch these: if you
call

	make DEVELOPER=1

and compile with GCC or Clang, it will elevate such warnings to errors,
and we highly encourage contributors to build their patched source code
with said flag.

Thanks,
Johannes
