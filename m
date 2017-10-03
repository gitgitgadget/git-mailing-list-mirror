Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D2C522036B
	for <e@80x24.org>; Tue,  3 Oct 2017 22:45:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751190AbdJCWpF (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Oct 2017 18:45:05 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:37425 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750865AbdJCWpE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Oct 2017 18:45:04 -0400
Received: by mail-pf0-f194.google.com with SMTP id e69so10501667pfg.4
        for <git@vger.kernel.org>; Tue, 03 Oct 2017 15:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=S4fTqs5uItpNpsH9e8G37tV0gSK1DUFTv6pMjzDx4B0=;
        b=fX0Gft7l7V8VwJuCjNHYPmnVbdaSYe6VnxIcOLDBk2C71a5/WELiSo/qREgAuKRs2J
         IPpGSAtyZnNZ/bpHfbs/m9UJ3YCC2ocWj6OvGM1b263pqLpNP9aJFQuLTKTr+RzmJMX/
         BWrQYzl7NNlxDtBDx01HeI44nzmsCkklaB4LEuTNJ5To9Pw8n1GOUt2fuJchRKs/pp50
         6LoknTzas1VpAVyHcg2M3wW4+g8P+pZIfFiyyCHlvY0C5lV5BRiiMrf3L92j4BUTpSlw
         42MNmO+7cNUtEPM+zQdVu76EVl2IGSuXlxL/aiYhO5tw4hma/m4mWDdtwaNl5wkgY3Sa
         Gq/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=S4fTqs5uItpNpsH9e8G37tV0gSK1DUFTv6pMjzDx4B0=;
        b=W/ukn5ATQGFRHqt5Fu7Yaky41LIJDQpASRxxF0S26HTkdepW7BwF0mwLKCinmlnjYR
         kseekjANxpyFHUpvbPXB821Gp2hqkQdMnwuLV6G4BdkLTXodbqTD5Uvy5U+21RR/Wy0q
         EzLGMusp/nfquygSPPnPQD7JCyK+yDoQ+fIcd9WjKBrAocnQydxoVRyOtu+UOu7eEl/v
         GuUwbPwkGh/9itAeck61Ovjkk/vvqpa8klpXXvkknk8fK+KplgT/VvIF9ygCuKyWL9jE
         HWSTAa31ItqTFXKHCknVEiPv8lJlwc4TKyi/f3ELNAa4yEfcUobNaF0jXh0GOGIeTw8D
         aC7g==
X-Gm-Message-State: AMCzsaUG7kAeXOGNNR1ftCKNJ1jOJl8nrTGLAnBJbvBil9GTjYAimTYk
        +ebw7TBGU1u0SFte/w60swI=
X-Google-Smtp-Source: AOwi7QDPNm7W0cuobhmNaZfCetGdn90cu2o3nBoeLheREjWJSy/T8GLx0rN0WNEi6QYAKwPvSRXY1Q==
X-Received: by 10.84.245.137 with SMTP id j9mr11314766pll.423.1507070704216;
        Tue, 03 Oct 2017 15:45:04 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:3463:ab6b:5863:927c])
        by smtp.gmail.com with ESMTPSA id k67sm19690474pga.46.2017.10.03.15.45.03
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 03 Oct 2017 15:45:03 -0700 (PDT)
Date:   Tue, 3 Oct 2017 15:45:01 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] path.c: fix uninitialized memory access
Message-ID: <20171003224501.GD19555@aiede.mtv.corp.google.com>
References: <20171003195713.13395-1-t.gummerer@gmail.com>
 <20171003195713.13395-2-t.gummerer@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171003195713.13395-2-t.gummerer@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Thomas Gummerer wrote:

> In cleanup_path we're passing in a char array, run a memcmp on it, and
> run through it without ever checking if something is in the array in the
> first place.  This can lead us to access uninitialized memory, for
> example in t5541-http-push-smart.sh test 7, when run under valgrind:
[...]
> Avoid this by checking passing in the length of the string in the char
> array, and checking that we never run over it.
>
> Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
> ---
>  path.c | 19 ++++++++++---------
>  1 file changed, 10 insertions(+), 9 deletions(-)

When I first read the above, I thought it was going to be about a
NUL-terminated string that was missing a NUL.  But in fact, the issue
is that strlen(path) can be < 2.

In other words, an alternative fix would be

	if (*path == '.' && path[1] == '/') {
		...
	}

which would not require passing in 'len' or switching to index-based
arithmetic.  I think I prefer it.  What do you think?

Thanks and hope that helps,
Jonathan

diff --git i/path.c w/path.c
index b533ec938d..3a1fbee1e0 100644
--- i/path.c
+++ w/path.c
@@ -37,7 +37,7 @@ static struct strbuf *get_pathname(void)
 static char *cleanup_path(char *path)
 {
 	/* Clean it up */
-	if (!memcmp(path, "./", 2)) {
+	if (*path == '.' && path[1] == '/') {
 		path += 2;
 		while (*path == '/')
 			path++;
