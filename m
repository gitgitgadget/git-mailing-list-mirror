Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 392C720988
	for <e@80x24.org>; Tue, 18 Oct 2016 12:26:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754507AbcJRM0X (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Oct 2016 08:26:23 -0400
Received: from mout.gmx.net ([212.227.17.20]:53143 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753541AbcJRM0W (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Oct 2016 08:26:22 -0400
Received: from virtualbox ([37.24.142.40]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0LbxQO-1cdXRn1jSm-00jFv9; Tue, 18 Oct 2016 14:26:11
 +0200
Date:   Tue, 18 Oct 2016 14:25:57 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org,
        =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH v4 08/25] sequencer: completely revamp the "todo" script
 parsing
In-Reply-To: <xmqqfunusj1d.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1610181425440.197091@virtualbox>
References: <cover.1476120229.git.johannes.schindelin@gmx.de> <cover.1476450940.git.johannes.schindelin@gmx.de> <a5f5d784fcacc16555237b9750380d612387d0cb.1476450940.git.johannes.schindelin@gmx.de> <xmqqfunusj1d.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:W2PEeVmyd+1nAEFpl6UMFiM4BFZeQ0NZbvu7acFtJaynS+wiLQP
 gwe2s1R9m8+ZSo66r5GToT+uhbx6M5gCjHF/+9c+GCVqcyVrwKh5r2Flol4/9lNb3rlP+xn
 oZNNhGjzJFFA3ztDQ9h+ZKnqO+j/hhclxpxTvE37q6mWaT9jHrWHcKu2mX92hR9mNRzVzI2
 GTSZhFx5119t+YQaGl0KA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:+s/alB8Z5Rg=:9QLx0HxgVFOZpooZ65X9j/
 sHS1SByrrQSqP4vtf2Xm9SnFb00kptpVbcHFUo/T9NNzX5y0KSlQxqltS63BSZTCuZ1F+vMmr
 hLXAcBEaudomo94ocWARUGD6G5cHpdSuCzOkUA7LpOHGGokaf7fNwemRlbkOwygBXHvXiQjlB
 nKOe2A6IrQUeuIILt8ziRhR+E6OXbWxy75CXz9v4LKJ35NcOTIreVXWqpDsL+ZNfM1cUo1Pvu
 U/IM3rP9gqQCn7MqwNYPy+OF4y6JsAvwp6EnKX8Huw9XSTITauvnuRG6Jw/s8wc8Plwp2LKCI
 hVNra5gOspD4Y4cSj5aH75M8jdL1H6RPMYYv7O+NxNv0sx00R+WlFKkiuB87hTaxCzt/yp4zc
 ZxdWatho6MVTC+BWCe3VozKr4Oc9g/oXrMMqRyhMiOkykcHqEr37U0OCR8Hj4blqktvIIBmcV
 k40wga20GCqlk77MefnqgU0qGclZfUVC2w9bNkVzD7zFSScC7c0kScstF/Med28gBusdjRy2m
 CwRFjdwoDdDljsE5lHds3G5wPBuwdl6P5CjAqfryxulJY2p/eUyzX2hKi/4nRwEfudkn3u/DL
 EtRsrJ9GyBwG8K8oKM+ZJ11/b6S+1wKnV8KhyYHGNqa+Ms0lQ8dIBjmkAMwK+a2s8zd8x1J12
 MD9mEvlkoKRp88ESBqiQhg+5b8Xi0hAWu03xmjriGxcC5InFYF3rQ0YZQlwavXHoRraT6LCzm
 dTu8eoH+/SNCq+vngePqkd0lyPCNKxp1xN7F0fErIkiSDMqp0bdSn/MI6iSB8wV69LKXsluvp
 MwnEWet
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Mon, 17 Oct 2016, Junio C Hamano wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
> > -	for (i = 1; *p; i++) {
> > +	for (i = 1; *p; i++, p = next_p) {
> >  		char *eol = strchrnul(p, '\n');
> > -		commit = parse_insn_line(p, eol, opts);
> > -		if (!commit)
> > -			return error(_("Could not parse line %d."), i);
> > -		next = commit_list_append(commit, next);
> > -		p = *eol ? eol + 1 : eol;
> > +
> > +		next_p = *eol ? eol + 1 /* strip LF */ : eol;
> 
> This one was explained as "skip LF" in the previous round, and that
> is more correct than "strip", I think.  The +1 here is not done to
> "strip" the LF out of the end result, but to "skip" one to move to
> the beginning of the next line.

Changed,
Dscho
