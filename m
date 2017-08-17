Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 93A1D1F667
	for <e@80x24.org>; Thu, 17 Aug 2017 06:25:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751151AbdHQGZG (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Aug 2017 02:25:06 -0400
Received: from mout.web.de ([217.72.192.78]:49366 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750957AbdHQGZF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Aug 2017 02:25:05 -0400
Received: from localhost ([195.198.252.176]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MHGil-1dmqn90J3j-00E2Bj; Thu, 17
 Aug 2017 08:24:52 +0200
Date:   Thu, 17 Aug 2017 08:24:50 +0200
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, asottile@umich.edu
Subject: Re: [PATCH/FIXUP 6/2] apply: clarify read_old_data() is about
 no-index case
Message-ID: <20170817062450.GA28592@tor.lan>
References: <xmqq4ltpsn42.fsf@gitster.mtv.corp.google.com>
 <20170813085106.1731-1-tboegi@web.de>
 <xmqqbmnfl5tm.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqbmnfl5tm.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Provags-ID: V03:K0:KHWI6oT6m8z8hCgiVtmW1T+l9txMK/yO25Fl1l42Le/Kg681upl
 yhG1wKDy4TG04y4BNmn4Und/+a1nFRIdyRQJA76LkXHk54R36nYBvxXb7yY0gy4UDjfbVNm
 LDvXC2tFpX/zpnCXJ4XljbBy75puMR3PVt4HFELK2C8P8je7Q7mebpyhX/sJb28rtVvzInp
 cuV4RZOePYLjiWW3baGgQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:FLy+Jmtzp6k=:RO19DQBPNSMC9+o4FPcBQu
 qesb6rxRoy0mhwSuwC86zKZ1Rshus2S/qBvrA8JR4M/pFeLqKAjr9bUJcwSgk/IcvjkeUVnks
 A/wpyxMBLI7Mh/9QWco4l62T487Npun0Atf5o1vPaAf4sbSif0ezOj2OuDMIWWKzBoNrnhCa9
 HWIHcy7Aqe/zlUweiD3cNAky7J++5gPNu3dsZ2cekfwBIYphlbQ+6rmuMuKtNhZefu9jqpG/7
 UxxYjmcNZ16TjClxK/c6WpE6qx9eAP8iW2a6kPXGJQ8VYTtD4UkMcEKPKMGT49M3A7144cScT
 t7tCRHLx86sKr3vTcQGZHuSEEkrmgUYXBM76bgRgqTQwUIstYE2Kvp0cT2jabkAjg8/gBh2wr
 G38YuJKmnMkwipmg9Sl+/JIflIgMb6kL38UEdSyRAiIS0FZfiIrELOwCfDhk6kTxro8jVjS2g
 45fvv8V0mSMqDefwPR4iMiNHts90Ny1TrGJXoJBSIFC4Lt9bMScyna6Wtc6LVSYfeBssnQaqm
 5OCvxj+KxizyxtcWz0QHVKU3/TdPd1okFgXbuMUr4LVcSSr7vCLfcgJwaEA8KKoMFfPQ6Z7ry
 eGrn713CEtZE/xQajrprDnUUUqqLrYLJ0l4T0YxtunW06mpZ+O8qaJlMJPTBc+p7+0N3ReUMt
 qVLTBSSSL3qzCqkpNFAgZsE8/8M7LMGVimJ4iXNEcuTf3W3ykSFexn4nO5zq+HzzEABD/ELYS
 npc/0Az5pdZ1snXzm+8LqmRPAq5+qVfhxZj7lDScUZ1v6BSthUY3V2BdupMKHgJnmb0abAkvr
 EOR4GPYiK3/fc9scjV4ctI4wcsjEg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 16, 2017 at 11:34:45AM -0700, Junio C Hamano wrote:
> With the previous fixes to CRLF handling in place, read_old_data()
> knows what it wants convert_to_git() to do with respect to CRLF.  In
> fact, this codepath is about applying a patch to a file in the
> filesystem, which may not exist in the index, or may exist but may
> not match what is recorded in the index, or in the extreme case, we
> may not even be in a Git repository.  If convert_to_git() peeked at
> the index while doing its work, it *would* be a bug.
> 
> Pass NULL instead of &the_index to the function to make sure we
> catch future bugs to clarify this.

Thanks for the work, and now our emails crossed.

Calling convert_to_git(NULL,...) makes Git crash today, see t4124, my
latest version, "LF in repo, CRLF in working tree)
Unless we re-define the meaning of "NULL" into "don't do CRLF conversions,
like SAFE_CRLF_KEEP_CRLF does.
The combination of convert_to_git(NULL,...,SAFE_CRLF_KEEP_CRLF) is OK,
but all others must supply an &index.

At a very first glance the end result may look like this:
- Take my changes in convert.[ch]
- Take your changes/commit in apply.c (except the NULL, see above)
- Take my changes in t4124.

I don't have time to look at this today or tomorrow,
please give a hint if you are working further.
