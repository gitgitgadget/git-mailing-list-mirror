Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 837491F453
	for <e@80x24.org>; Mon, 18 Feb 2019 20:57:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729881AbfBRU53 (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Feb 2019 15:57:29 -0500
Received: from p3plsmtpa08-02.prod.phx3.secureserver.net ([173.201.193.103]:52259
        "EHLO p3plsmtpa08-02.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727513AbfBRU53 (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 18 Feb 2019 15:57:29 -0500
Received: from jessie.local ([212.149.203.197])
        by :SMTPAUTH: with ESMTPSA
        id vpyfgGQoxPBgKvpyhgnMqW; Mon, 18 Feb 2019 13:57:29 -0700
Date:   Mon, 18 Feb 2019 22:57:25 +0200
From:   Max Kirillov <max@max630.net>
To:     "Randall S. Becker" <rsbecker@nexbridge.com>
Cc:     'Johannes Schindelin' <Johannes.Schindelin@gmx.de>,
        'Junio C Hamano' <gitster@pobox.com>,
        'Johannes Schindelin via GitGitGadget' 
        <gitgitgadget@gmail.com>, git@vger.kernel.org,
        'Max Kirillov' <max@max630.net>
Subject: Re: [PATCH 0/1] Fix hang in t5562, introduced in v2.21.0-rc1
Message-ID: <20190218205725.GB3373@jessie.local>
References: <pull.126.git.gitgitgadget@gmail.com>
 <005401d4c4b3$147aa8c0$3d6ffa40$@nexbridge.com>
 <xmqqef8a6lnb.fsf@gitster-ct.c.googlers.com>
 <005901d4c4b9$3b9a2a60$b2ce7f20$@nexbridge.com>
 <nycvar.QRO.7.76.6.1902182139490.45@tvgsbejvaqbjf.bet>
 <005001d4c7cb$0cc4ce60$264e6b20$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <005001d4c7cb$0cc4ce60$264e6b20$@nexbridge.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CMAE-Envelope: MS4wfInitIGkb7cAuVQdYenTxvllOqqAraFllOrbUkMAUtU8PwtS6cnbviCkaQyrylxBBGpe/WS9+16NI1hAliSza2NkXpHKppfyX+MO1xieLmxg0ebgIds/
 wDb6gH4eUmYS0R0AiC/q/2MoaL9thWy+wghRrc6TGMlZXKeuWjiMKHu8NMnwhWU28VDaqk1Pi9x8v8+6hpoa9y9ozvf/e76vXHegvLzun6ks7dHy01fk3tUS
 Dcr2gtHJGOZ0ZN24lYZgA6/lyRj/4X/sx899RRMcwm3q6ud4oDrDeJNPvB3uIlYblIOqLNaUyV2oKRNV3Q3J0jQ9+GK+j0dzmSVLu6I2z+U=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 18, 2019 at 03:46:34PM -0500, Randall S. Becker wrote:
> On February 18, 2019 15:41, Johannes Schindelin wrote:
> > So could you try with this patch?
> > 
> > -- snipsnap --
> > diff --git a/http-backend.c b/http-backend.c index d5cea0329a..7c1b4a2555
> > 100644
> > --- a/http-backend.c
> > +++ b/http-backend.c
> > @@ -427,6 +427,7 @@ static void inflate_request(const char *prog_name,
> > int out, int buffer_input, ss
> > 
> >  done:
> >  	git_inflate_end(&stream);
> > +	close(0);
> >  	close(out);
> >  	free(full_request);
> >  }
> 
> In isolation or with the other fixes associated with t5562? Or, which
> baseline commit should I use? 8989e1950a or d92031209a or some other?

As far as I understand, it should be tried instead of 
https://public-inbox.org/git/20181124093719.10705-1-max@max630.net/
