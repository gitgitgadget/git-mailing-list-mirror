Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1352F1FE4E
	for <e@80x24.org>; Tue, 12 Jul 2016 15:12:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933413AbcGLPM4 (ORCPT <rfc822;e@80x24.org>);
	Tue, 12 Jul 2016 11:12:56 -0400
Received: from mail-it0-f44.google.com ([209.85.214.44]:35917 "EHLO
	mail-it0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932428AbcGLPMz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jul 2016 11:12:55 -0400
Received: by mail-it0-f44.google.com with SMTP id f6so82637035ith.1
        for <git@vger.kernel.org>; Tue, 12 Jul 2016 08:12:54 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=FI1GVK0+vLH3VBpxUM3QotUM3uIkzgND124rF1Au6jE=;
        b=ARs3jQO+wb57LpzRfQCRx/6L1C7ZtdiDygA7ySOmjlaRdWrgiFYkIyEwlfA2Je+yzf
         ST8zSWXX93LRv+HleXDdR02zgNuK8+walQWYAs57swr2ChDsgOP73iGEMPnGkeTws5MI
         rtVIQwRgyBrkIxNG7J8iED5/l7N32nnTzTeRakH9fy6aXDYd8iR+3kPHU0aaMoKu+blJ
         kAUgOyERIj25NCF5b6KQ0tltfDXlrSE+/WdNHyOCRGFL4HJaWkaJ4w2NM2Pk2oazcQDO
         5S4o98SgNnvUJeQocLrieKa8bvCpT/MrTn9/LvfsF5PkgGmMNHDgkcpsdrIRmd8pqGL1
         xj6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=FI1GVK0+vLH3VBpxUM3QotUM3uIkzgND124rF1Au6jE=;
        b=HGKTxS1Lx2a89aas6/sf8U30ahNamn76Fh5kWh5pCUWJy1K6ecmsWC8a/m0TVKrpE2
         a1CYz6mdvnJqqDV7Bk+L+1cumdAOYiSnE0UxSLckWLzM+YYQwn/88FZatTheY5fTMFtz
         g6WZacHWWvrzCtOsEdgw8JC0vNlMUJJOvEUVGwW5I12qWcUc2xBzgJL1u3cwR5datzZr
         ndhw1id8UgNRoFHpx5h6n8n/OAUL9JH++aj227K9DcPH99eEb5fOuFPAV1Jr5z0BF6r4
         oHZRT9MEJrPH/qcI82uIe3yGgvNEjoZsJV8wo1JAfaZ3o6A/rVMofQiOPrGhNMOMjhBB
         ONew==
X-Gm-Message-State: ALyK8tJ8lOwCQp2IJ4HsQ4p0zBP0TPWMLc8ZaHr3iddohMeC1hzp49vBDvNTifYC6QUp+ZiPmxjeOzClI98Jwg==
X-Received: by 10.36.33.22 with SMTP id e22mr17129490ita.42.1468336374176;
 Tue, 12 Jul 2016 08:12:54 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.225.235 with HTTP; Tue, 12 Jul 2016 08:12:24 -0700 (PDT)
In-Reply-To: <CAP8UFD01MiMnz6qNGYa9WEjZ_EOy-hBqO4gGKGyxUc71aOyp4w@mail.gmail.com>
References: <20160711172254.13439-1-chriscool@tuxfamily.org>
 <20160711172254.13439-9-chriscool@tuxfamily.org> <CACsJy8BqMFASHf5kJgUh+bd7XG98CafNydE964VJyPXz-emEvA@mail.gmail.com>
 <CAP8UFD01MiMnz6qNGYa9WEjZ_EOy-hBqO4gGKGyxUc71aOyp4w@mail.gmail.com>
From:	Duy Nguyen <pclouds@gmail.com>
Date:	Tue, 12 Jul 2016 17:12:24 +0200
Message-ID: <CACsJy8CEimmc=W=bNcLw+TP0tGRPCL5rr3uNeFMJ=Ms9HkyABw@mail.gmail.com>
Subject: Re: [RFC/PATCH 8/8] read-cache: unlink old sharedindex files
To:	Christian Couder <christian.couder@gmail.com>
Cc:	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Tue, Jul 12, 2016 at 9:04 AM, Christian Couder
<christian.couder@gmail.com> wrote:
> On Mon, Jul 11, 2016 at 8:27 PM, Duy Nguyen <pclouds@gmail.com> wrote:
>> On Mon, Jul 11, 2016 at 7:22 PM, Christian Couder
>> <christian.couder@gmail.com> wrote:
>>> Everytime split index is turned on, it creates a "sharedindex.XXXX"
>>> file in the git directory. This makes sure that old sharedindex
>>> files are removed after a new one has been created.
>>
>> Hmm it's one-way link, we don't know how many index files use this
>> shared index file, how can you be sure nobody else will need it? I'm
>> thinking about temporary indexes. If a temp index is created, saved on
>> disk, and use delete the shared index file, the real, main index may
>> become useless. Temp index will most likely replace the main index
>> (git commit) but if a failure happens, we can't fall back.
>
> Isn't there a way to scan all the current indexes (temp or not) to see
> which shared indexes they need?

No. People could create an index file anywhere in theory. So you don't
know how many index files there are.

>> A safer approach is "touch" the shared index every time a linked index
>> is used, then we can delete shared indexes with old mtime, older than
>> a grace period, in git-prune (or here).
>
> Maybe old linked indexes could be converted after some time to use a
> newer shared index, so that we can get rid of the old shared indexes.
> That seems safer than just deleting old linked indexes.

It really depends. If the shared part is too small for old indexes, we
might as well unsplit them. In practice though, the only long-term
index file is $GIT_DIR/index. If we don't delete old shared index
files too close to their creation time, temp index files will go away.
-- 
Duy
