Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2CBED20281
	for <e@80x24.org>; Tue, 19 Sep 2017 02:42:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750884AbdISCm4 (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Sep 2017 22:42:56 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:36439 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750783AbdISCm4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Sep 2017 22:42:56 -0400
Received: by mail-pf0-f196.google.com with SMTP id f84so925383pfj.3
        for <git@vger.kernel.org>; Mon, 18 Sep 2017 19:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=UKaXuOxmN9XDkoiSBM4ZWTiCvlZorW92m93TWwL6AnY=;
        b=gImQXHQkA/eIx9LXNM/MWaImhZPT3VNqi0Vivlev7glcZ4Bw0OAjHHigvY5aH+POLX
         M9JDWGp+czLrocT01ls5/BRC9YuOrsP8NJpSCSAGKG1nGSGXFlX49p6kjbNLmNZnV4IG
         UDtPb9x3sQ+PQC1xvycHjsMLRoJiOLElInOFen/MKyhFoNhh+iEWPG25HUWQqGFOiBLe
         FBwTEu5446UAk58xTnKUCpslyhQDsTtQktlWvlTJ5D1SKIsgwCWvWCyRUjwsrcGfm13A
         vkg5iVw/EeyS99Iq32qlueuoq+fyZ6gfESf2+xrNjEqt0u4EWucvskUH3jDpN5O7m60Y
         8PPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UKaXuOxmN9XDkoiSBM4ZWTiCvlZorW92m93TWwL6AnY=;
        b=nHvk13fw6v8tmetERk36JC/WUPPjjW7q0c5ILqu5ctlwB99VeU4bFoUWUuAtjVG4qS
         PbCF62JT8HUTkhlqbkzj+HKDcR1WwP3684kNqOoeijSk9rMKOCq3Of8BmumTEss1H6Q3
         bof/KSvTl4HyaY9zRirAugrI1W/ehWIy6eengod25GxZOidnJxqv3IaHYEzyHU8SNunF
         RBNs/asJa6LQNMy78wM6baBEeCvPXjAWVD3JNgJ7ezb3M4kHioyZAyNuwOjvtNlb2VxT
         GPze41iLrLSzUu/lnU9yy+rMMgKQkObfxsHgmjdTcdeidRnQkZeaHIP5LrVHqQc9ewny
         MXKA==
X-Gm-Message-State: AHPjjUghHOBZE7yoSDXLlWtnTWhXPOqZF2qi/6ZAiMVB4QfKWYluWIn2
        nxjkVFmJQsyq+Q==
X-Google-Smtp-Source: AOwi7QBZz3QLikAIPI50Q8Wbqu7McO1PiH7jmklvdimZYtTKHmmVQQ00Y6DxZxu7rCEhLZo+pQqHfw==
X-Received: by 10.84.130.35 with SMTP id 32mr579586plc.368.1505788975480;
        Mon, 18 Sep 2017 19:42:55 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:288c:7217:eb8c:bacc])
        by smtp.gmail.com with ESMTPSA id p71sm1045004pfl.56.2017.09.18.19.42.54
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 18 Sep 2017 19:42:55 -0700 (PDT)
Date:   Mon, 18 Sep 2017 19:42:53 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 1/2] read_info_alternates: read contents into strbuf
Message-ID: <20170919024253.GC175206@aiede.mtv.corp.google.com>
References: <20170918155059.54f7z6cnrl47f5el@sigill.intra.peff.net>
 <20170918155429.hgql4ngayun5nbyd@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170918155429.hgql4ngayun5nbyd@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King wrote:

> Reported-by: Michael Haggerty <mhagger@alum.mit.edu>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  sha1_file.c | 29 +++++++++--------------------
>  1 file changed, 9 insertions(+), 20 deletions(-)

Thanks for tracking it down.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

[...]
> +++ b/sha1_file.c
[...]
> @@ -427,28 +427,17 @@ static void link_alt_odb_entries(const char *alt, int len, int sep,
>  
>  static void read_info_alternates(const char * relative_base, int depth)
>  {
> -	char *map;
> -	size_t mapsz;
> -	struct stat st;
>  	char *path;
> -	int fd;
> +	struct strbuf buf = STRBUF_INIT;
>  
>  	path = xstrfmt("%s/info/alternates", relative_base);
> -	fd = git_open(path);
> -	free(path);
> -	if (fd < 0)
> -		return;
> -	if (fstat(fd, &st) || (st.st_size == 0)) {
> -		close(fd);
> +	if (strbuf_read_file(&buf, path, 1024) < 0) {
> +		free(path);
>  		return;

strbuf_read_file is careful to release buf on failure, so this doesn't
leak (but it's a bit subtle).

What happened to the !st.st_size case?  Is it eliminated for
simplicity?

The rest looks good.

Thanks,
Jonathan
