Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 924F4205C9
	for <e@80x24.org>; Sun,  8 Jan 2017 20:14:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934669AbdAHUOb (ORCPT <rfc822;e@80x24.org>);
        Sun, 8 Jan 2017 15:14:31 -0500
Received: from mout.web.de ([212.227.15.3]:63870 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754473AbdAHUOa (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Jan 2017 15:14:30 -0500
Received: from localhost ([195.198.252.176]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LsNpI-1cbH8b3LRY-01241S; Sun, 08
 Jan 2017 21:14:17 +0100
Date:   Sun, 8 Jan 2017 20:14:15 +0000
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     larsxschneider@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, e@80x24.org,
        jnareb@gmail.com
Subject: Re: [PATCH v1] convert: add "status=delayed" to filter process
 protocol
Message-ID: <20170108201415.GA3569@tb-raspi>
References: <20170108191736.47359-1-larsxschneider@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170108191736.47359-1-larsxschneider@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Provags-ID: V03:K0:DDkyijP6TKjlPuTSlg5Z8m9/4x73na3H/7o7er8otKHqyBFC96y
 Rawvi6XbCK+3F/fdwwb6jvKIeODUt22NXrgLOWhrT2hIyGb2UqAKfJ0lDwEXVKFMBP8jWhu
 /LkGnjOpI5PAv0OEMguAzctIcUMiJp+VVYeE7BdUgJ59uZ1s1OdY/nBcdTTAnvghOq7xNhn
 fUDNZQzcyCK6PknInVB7w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:IA6E5mCXjXA=:JcF/85acl/EJyGYsgocMec
 9ZQTcrd+egOvLmardnxB/txvlH15P2bCxZcPFCiwtDh5oO2GXZqOqCtCUBHQjxignTm+KGH56
 EAbpsLbHgxsDK3cNZ+eqZIhJXxc+GG2GBhchJ/b2XruKUkqGDES62bOkYj89BgRqWHwLymcyx
 xLP8bsZNCBE9sXFKlmapV6LEW+IVaef1EODDPv6ltJmatjnPXcCcz/YWXD1X8E1v91pQtkjNu
 bz5xViWFD7FGY/MIwO0uT+gDx2i5QvHRl2mLaa/yfVmzUlaAHQkVE7/yJwkxahRHshG7YdCGz
 WGlWhYw2FqiCitvDegdTDwKz0GlvGcCKQ+WTKeBdyQKZCQGX6nvYqQsXOjCBwFOawWhOjnrXs
 7hRbQXOS4UlG7asr9JuW4E9H5Sn7fneQiZxmxekYjMcAqszgIpXioymvOcc3TvQQdMYIhncBZ
 WHcDkZkU6OsovEHPaIHqKphpRd4/tggEUUSqfUTZWPa2GjgV0XCjnT7xRdxAnGRkjPztavZUc
 r471kUT8i/uEg+HgedEgcUxddDjepxRiSqhxtx1M2eFahqyRLv3IUOb2Xp94BY0Z5JsFg9bPx
 EDbiJPPdtkc+EUHjyLcBEiAsXS1EiH+9pZxCLksMy+U6v7xl/KXuPJ6bvtY/kiQv8UPGbrny1
 069M8xdoDPjhdJv2qG+zVFJZqIUxnDDx5pxheAwmQ8MM5XymmDGN78yu1pucVUTdS6KgZqTKQ
 F7yf/DUpMrcI9Lv1w8YF0kA2JnY25ilEDFhqfoDE4tiCt01U0vRzQb/n/3o=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jan 08, 2017 at 08:17:36PM +0100, larsxschneider@gmail.com wrote:
> From: Lars Schneider <larsxschneider@gmail.com>
> 
> Some `clean` / `smudge` filters might require a significant amount of
> time to process a single blob. During this process the Git checkout
> operation is blocked and Git needs to wait until the filter is done to
> continue with the checkout.
> 
> Teach the filter process protocol (introduced in edcc858) to accept the
> status "delayed" as response to a filter request. Upon this response Git
> continues with the checkout operation and asks the filter to process the
> blob again after all other blobs have been processed.
> 
> Git has a multiple code paths that checkout a blob. Support delayed
> checkouts only in `clone` (in unpack-trees.c) and `checkout` operations.
> 
> Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
> ---
> 

Some feeling tells me that it may be better to leave convert_to_working_tree() as it is.
And change convert_to_working_tree_internal as suggested:

int convert_to_working_tree(const char *path, const char *src, size_t len, struct strbuf *dst)
 {
-	return convert_to_working_tree_internal(path, src, len, dst, 0);
+	return convert_to_working_tree_internal(path, src, len, dst, NULL, 0);
 }

