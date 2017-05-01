Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 869A7207D6
	for <e@80x24.org>; Mon,  1 May 2017 23:24:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751967AbdEAXY1 (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 May 2017 19:24:27 -0400
Received: from mail-pg0-f42.google.com ([74.125.83.42]:34329 "EHLO
        mail-pg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750757AbdEAXY0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 May 2017 19:24:26 -0400
Received: by mail-pg0-f42.google.com with SMTP id v1so51367272pgv.1
        for <git@vger.kernel.org>; Mon, 01 May 2017 16:24:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=eDBVWAXhdfoDRztLR/G5PMYMjZsZmI+Z1K9XVPBg4ng=;
        b=DhQ8Qdzi3GVw9pXQRmVi9tjFX4V8Akjf2ZIN73T6D5PtJgg8tldVfRckBE754Z1f6f
         fMcDESnmpjAHnFxKS7yzkOMLJ9F3bhjyZ3O39tOnggsIH2Q0X6qkbCbwUr5p/xMGoDLH
         nrvQMOkWAEpRDtTBzCSWoBajf9KmQ5idDO3nt1touXAB9+WjIZECMsBSpT6Tt8f46Etc
         2WF2ZzarjR24Z6svH1XXklxp+yGbFjxhapK80jT2Q8ERvS28zPKwsWsNxIpAms2p7Q1U
         BW98INzS9knM00baDo/EumXlJvulPLQc0MAwhGkTMljyKp51VLLZDRI3Mn/ZdpYJalpy
         dGvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=eDBVWAXhdfoDRztLR/G5PMYMjZsZmI+Z1K9XVPBg4ng=;
        b=B+ZAsne2qndzFb3VlC4/RKqczBuu+51m68uEGRNEV2Iepk7+6Q0OkRbom8+Eacj7PP
         /7KMZ0bh2KePP1L3OZ3JqbLhpUApC9r33C/tQLbeD6sCgfhgcs/v1DKwTnOrXaTIb0bU
         hIMAatpZ5pvCMkPw5hiqNYBLlBp9zK8ZGuEoK2V83LZqrn5e7Mk9Rbz5h/QkneCpbuxU
         yhOQh6fy7dqnnuQyzW+dIPYlf+2QvPdq2+r7XMJIXA8xkCxOacP/+vp5Xh4VHtR3ko8o
         PYBBDYk6G67m8BB8fRmInZA+BvlYNygL3wEmNfAIoGnME01ejOFxkHFUOtc6hJergoF+
         AaoA==
X-Gm-Message-State: AN3rC/5V6ZB5ZikbwGgwgdU+PXHNye2A6ah3fg01q0/oPLsnHgdr8QcZ
        tNsLe2hGnLefipUW
X-Received: by 10.98.57.71 with SMTP id g68mr28180776pfa.53.1493681065705;
        Mon, 01 May 2017 16:24:25 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([2620:0:100e:422:a910:d570:c34e:20d9])
        by smtp.gmail.com with ESMTPSA id b68sm16148187pfa.127.2017.05.01.16.24.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 May 2017 16:24:24 -0700 (PDT)
Subject: Re: [PATCH v2 39/53] refs/files-backend: convert many internals to
 struct object_id
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
References: <20170501022946.258735-1-sandals@crustytoothpaste.net>
 <20170501022946.258735-40-sandals@crustytoothpaste.net>
Cc:     Michael Haggerty <mhagger@alum.mit.edu>,
        Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
From:   Jonathan Tan <jonathantanmy@google.com>
Message-ID: <95a85924-6f5b-a625-e460-ecd14540a621@google.com>
Date:   Mon, 1 May 2017 16:24:23 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20170501022946.258735-40-sandals@crustytoothpaste.net>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 04/30/2017 07:29 PM, brian m. carlson wrote:
> @@ -195,27 +195,18 @@ static const char PACKED_REFS_HEADER[] =
>   * Return a pointer to the refname within the line (null-terminated),
>   * or NULL if there was a problem.
>   */
> -static const char *parse_ref_line(struct strbuf *line, unsigned char *sha1)
> +static const char *parse_ref_line(struct strbuf *line, struct object_id *oid)
>  {
>  	const char *ref;
>
> -	/*
> -	 * 42: the answer to everything.
> -	 *
> -	 * In this case, it happens to be the answer to
> -	 *  40 (length of sha1 hex representation)
> -	 *  +1 (space in between hex and name)
> -	 *  +1 (newline at the end of the line)
> -	 */
> -	if (line->len <= 42)
> +	if (!line->len)
>  		return NULL;

I would omit this check - parse_oid_hex already exits early if the first 
character is NUL. (The existing code makes a bit more sense, in that it 
avoids checking the first few characters if we already know a bit more 
about the string.)

>
> -	if (get_sha1_hex(line->buf, sha1) < 0)
> +	if (parse_oid_hex(line->buf, oid, &ref) < 0)
>  		return NULL;
> -	if (!isspace(line->buf[40]))
> +	if (!isspace(*ref++))
>  		return NULL;
>
> -	ref = line->buf + 41;
>  	if (isspace(*ref))
>  		return NULL;
>

Looks fine, up to here.

(Also, you requested extra-careful review for this patch, but this patch 
seems mostly mechanical to me.)
