Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BF9F1207D6
	for <e@80x24.org>; Mon,  1 May 2017 23:44:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751241AbdEAXoV (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 May 2017 19:44:21 -0400
Received: from mail-pf0-f174.google.com ([209.85.192.174]:36111 "EHLO
        mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751189AbdEAXoT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 May 2017 19:44:19 -0400
Received: by mail-pf0-f174.google.com with SMTP id q66so36420241pfi.3
        for <git@vger.kernel.org>; Mon, 01 May 2017 16:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=Lg3Mf65+YNxxBv7dPg9+AohXk/6qFbFz0DCvRuanNgs=;
        b=m9J9F1cQyo026FUfmSfpYMjTMCMjYQTh1S4ayd4BhJesnIcNx6XqCxEHd+g9wu9/u6
         MGyAi04JHmWwMA6DTANhc5LuzeFK6TmgaFGGa4ya4QimGJJGcAzKpYuyQsAjZwQrwKp5
         lxZro5pDTnbfCMk67Y7vKHMXpSHRauVTv72xwU0daySFjD189G+LzztbXjok9WpC6TIE
         zTTbSW4dwYYDAeX86gR4eLJufOeiztu4QTq+sf80fB0ghOQRZbABdNM+mxDLwD7raDH6
         FRmPXSQcAuLQ3gku8k1hb3VScWo3pt2g/M4A/nOyVJzdklSUDhCiaCK3JTQTqB8rzlWn
         6lQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=Lg3Mf65+YNxxBv7dPg9+AohXk/6qFbFz0DCvRuanNgs=;
        b=gguw6CGKbKlfHamTOJx80y/pd8nfSK0GcCS66+y7T+J1iyM7u1A19lMjLrlOh08IC9
         bh4V/1YeZs1OwnU77rvAvIOC6JrV9Zb3E3L0oWqDF1eQHjJlNqykWedf3kvSFvswdk9E
         +n9yeaKf/N97/h/lhB+SC/acVVRI36LPTPvS3VA3+7txMAiQe0TdRt4AKDP7H4hCEPyR
         hC/mGGE9EIWcDnrk/iebpsbUoADm+NPvLCyL2ibM2k7kkMeY9omED6ZCecM2hSSEqOIC
         f1iO9YYXmRQ+9y+2GGr21zU4SEXeSxEgIZOITzAb3qyEmQYuviwr6/Chu3rMMLyGUoKA
         MFPw==
X-Gm-Message-State: AN3rC/5iq82jLwpxMBcqtBKOYZdUhBb0QZKa84HdpPVGwP4OhSIlJV5u
        jeeH+1HbQ0ewZiP3
X-Received: by 10.99.66.1 with SMTP id p1mr29417409pga.107.1493682259014;
        Mon, 01 May 2017 16:44:19 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([2620:0:100e:422:a910:d570:c34e:20d9])
        by smtp.gmail.com with ESMTPSA id g5sm31403473pgn.38.2017.05.01.16.44.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 May 2017 16:44:17 -0700 (PDT)
Subject: Re: [PATCH v2 53/53] object: convert parse_object* to take struct
 object_id
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
References: <20170501022946.258735-1-sandals@crustytoothpaste.net>
 <20170501022946.258735-54-sandals@crustytoothpaste.net>
Cc:     Michael Haggerty <mhagger@alum.mit.edu>,
        Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
From:   Jonathan Tan <jonathantanmy@google.com>
Message-ID: <167a7bf4-8d31-ef57-2b60-31a4b2d9ee9e@google.com>
Date:   Mon, 1 May 2017 16:44:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20170501022946.258735-54-sandals@crustytoothpaste.net>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 04/30/2017 07:29 PM, brian m. carlson wrote:
> Make parse_object, parse_object_or_die, and parse_object_buffer take a
> pointer to struct object_id.  Remove the temporary variables inserted
> earlier, since they are no longer necessary.  Transform all of the
> callers using the following semantic patch:

I've finished my review of the 53 patches and it all looks fine to me.
