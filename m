Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4AE551F597
	for <e@80x24.org>; Mon, 30 Jul 2018 15:44:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731700AbeG3RUL (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Jul 2018 13:20:11 -0400
Received: from mout.gmx.net ([212.227.15.18]:46091 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726843AbeG3RUL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Jul 2018 13:20:11 -0400
Received: from [192.168.0.129] ([37.201.193.26]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LgZRV-1gMTqJ2Clp-00nwoG; Mon, 30
 Jul 2018 17:44:26 +0200
Date:   Mon, 30 Jul 2018 17:44:23 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Eric Sunshine <sunshine@sunshineco.com>
cc:     git@vger.kernel.org, Phillip Wood <phillip.wood@talktalk.net>,
        Akinori MUSHA <knu@iDaemons.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] sequencer: fix "rebase -i --root" corrupting author
 header
In-Reply-To: <20180730092929.71114-2-sunshine@sunshineco.com>
Message-ID: <nycvar.QRO.7.76.6.1807301744090.10478@tvgsbejvaqbjf.bet>
References: <20180730092929.71114-1-sunshine@sunshineco.com> <20180730092929.71114-2-sunshine@sunshineco.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:6CGTpmZK0ZH/xAcTGGlaSu+E+hYBr8RIeW+9zM1c70CYRlATPqb
 kY4k0sws08x78jnOSYC3bQ5JN6HWjh8RiFoN3hL3uQ6upSQkgd/KIeDnsLLpZRiHCz/4hNy
 QIrzC4mJXCfX/r7q6+kWVDK8X/UVLoml+zfGXdTmoIFVV9LLUQQydSgtcsA9lbmkBAwCHFL
 uyP8YZRc9Fi3VujUgu45A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:XCVR1Yz0s54=:PMUNrNrlYCPDEHKAsuMGZ1
 uO1KCHulYrRpxJi8N/9PIl1t5hsGgpoXsNpE5l+ZcvbG80Qt3EGQpZ8rYUeEQ0zJ0JWkeO4ZR
 s6kTpNoo1NDxr4no/S43XmqbDePkrMaW7jnfWEqBzIyCsg47wF/LpMJFKhR6j8Gf1Sg8f6qej
 a+eexWFIr4UddbTalk4wjSyDCW48EHLAyNugOTbGn9h1U93Ye/jiArA3DKxTZmWjThd7Ok9qW
 qMXB/5Nw2SIQslA8UZMYZi8R9ga/cwb6GqafCZql+q29RwyKaEANu8ucAv2wHyRHH9cDUBlsh
 Wjtl/S6NClii1H14d2r94Xw4EoCr6/xIJkvegGgEx6OFXtsWX9LYLbXhBX7LBWevw+2+R7lY9
 sa2+Svph+oFkwgTLkDHEj47A6xSROpxOeaB1sI7b8fBIf4/I3wewkTDqup/7KFglQIoZ8UukI
 vQbdB3IlFm2IVyoxQwYOa2yU3lHaRrGQMgqpoUggk10OHPq0H4gn+vNe0c4uJhmGBZKOQnNjP
 jBID237RVjJSf4T65DjlcfEq5pTwvagUEmSamOld9W9NOuSMPb7EYQRXHFIpf1OHrlb3n/f88
 9YHXptRjIL6zKersRdlfCduiKpZrZBqmssC9cd0M6uSMMXzGF0Wx5NdGyXYNYK7v6fK1X+IUP
 9W3PYj1Td04ELizNfetQMOErSLCMIDT7dAC55ScbMKz9LPGcUrbeKYC4wZekP7R4ztpK2HTma
 To9EXpmxJZLU41xgLgNsA8LnE8n/RY4/Eu48I/C2Ce7D5UeoGal0PWgY5YBBnbSmidi3HoPOT
 pVcERjT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Eric,

On Mon, 30 Jul 2018, Eric Sunshine wrote:

> When "git rebase -i --root" creates a new root commit (say, by swapping
> in a different commit for the root), it corrupts the commit's "author"
> header with trailing garbage:
> 
>     author A U Thor <author@example.com> @1112912773 -07000or@example.com
> 
> This is a result of read_author_ident() neglecting to NUL-terminate the
> buffer into which it composes the "author" header.
> 
> (Note that the extra "0" in the timezone is a separate bug which will be
> fixed subsequently.)
> 
> Security considerations: Construction of the "author" header by
> read_author_ident() happens in-place and in parallel with parsing the
> content of "rebase-merge/author-script" which occupies the same buffer.
> This is possible because the constructed "author" header is always
> smaller than the content of "rebase-merge/author-script". Despite
> neglecting to NUL-terminate the constructed "author" header, memory is
> never accessed (either by read_author_ident() or its caller) beyond the
> allocated buffer since a NUL-terminator is present at the end of the
> loaded "rebase-merge/author-script" content, and additional NUL's are
> inserted as part of the parsing process.
> 
> Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>

ACK!

Thanks,
Dscho

> ---
>  sequencer.c                   |  2 +-
>  t/t3404-rebase-interactive.sh | 10 +++++++++-
>  2 files changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/sequencer.c b/sequencer.c
> index 16c1411054..78864d9072 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -744,7 +744,7 @@ static const char *read_author_ident(struct strbuf *buf)
>  		return NULL;
>  	}
>  
> -	buf->len = out - buf->buf;
> +	strbuf_setlen(buf, out - buf->buf);
>  	return buf->buf;
>  }
>  
> diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
> index 01616901bd..8509c89a26 100755
> --- a/t/t3404-rebase-interactive.sh
> +++ b/t/t3404-rebase-interactive.sh
> @@ -1238,7 +1238,7 @@ rebase_setup_and_clean () {
>  		test_might_fail git branch -D $1 &&
>  		test_might_fail git rebase --abort
>  	" &&
> -	git checkout -b $1 master
> +	git checkout -b $1 ${2:-master}
>  }
>  
>  test_expect_success 'drop' '
> @@ -1415,4 +1415,12 @@ test_expect_success 'rebase -i --gpg-sign=<key-id> overrides commit.gpgSign' '
>  	test_i18ngrep "$SQ-S\"S I Gner\"$SQ" err
>  '
>  
> +test_expect_success 'valid author header after --root swap' '
> +	rebase_setup_and_clean author-header no-conflict-branch &&
> +	set_fake_editor &&
> +	FAKE_LINES="2 1" git rebase -i --root &&
> +	git cat-file commit HEAD^ >out &&
> +	grep "^author ..* @[0-9][0-9]* [-+][0-9][0-9]*$" out
> +'
> +
>  test_done
> -- 
> 2.18.0.597.ga71716f1ad
> 
> 
