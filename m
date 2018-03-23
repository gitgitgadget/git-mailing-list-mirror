Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 81F961F404
	for <e@80x24.org>; Fri, 23 Mar 2018 02:23:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751853AbeCWCXa (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Mar 2018 22:23:30 -0400
Received: from mail-pl0-f51.google.com ([209.85.160.51]:46673 "EHLO
        mail-pl0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751843AbeCWCX3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Mar 2018 22:23:29 -0400
Received: by mail-pl0-f51.google.com with SMTP id f5-v6so6562071plj.13
        for <git@vger.kernel.org>; Thu, 22 Mar 2018 19:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:to:cc:in-reply-to:from:date:subject:references;
        bh=uNDliLIgL/bb+xI2l/0AGOV5EmfQafXEonHPDd9DPSw=;
        b=HnFH7Cwhazzbw4IBxEMnQgA7b2HO/EZp8+zA4o9Or2LboFYW13KS1yDsmVgHJqGIRp
         DL4DV7KTND5cDAFYp2SuANagvNSgEFEci9x6BTm6fwuFUIlG4ZKz7N79m+d8kzcyjIWL
         lBPJGXF9jS0A2Zrlg0T259Kry9geVSudHgGpZVf+32RaCPfGDDnGngyWGZX0HP4p8cHl
         X5gHX0Ru0olk/C8b+f5Z6QCOEWaXaKVQDDaPCnPcDOHAKIoVVQwRns0RV7TjD9NM+Lpk
         SDX89VSTiBBvDn/+3XyZK8keT1v1+PZK4rYSOlTVeDIKgzfUaT2bvLI/JFAev7bSG1/b
         3Smg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:to:cc:in-reply-to:from:date:subject
         :references;
        bh=uNDliLIgL/bb+xI2l/0AGOV5EmfQafXEonHPDd9DPSw=;
        b=EsktKFGcxNi3XpmsU88psk2QbhziW2F0DF24TvBzB9ENvIhE0GTFcvehAH6ZwBxJMZ
         v5vDrb5zAuq6KWmMJD4N9TNg9546vx0gQNtaIoYHGqwZC3P+VGOVLHko/tJ4dzMlQqj6
         4rSCQekMjCINAC1Ywp6MSeVu5FytJJZX8WiRl4yClD6x44uwxKeD8KMUw2CvzzZGx244
         BRMv5e7seeKQcdig/FtJqYs8IBut4lu+azv4DPA+nMtAmZXYDCNX6AeO8oljfkX+I5YJ
         0BQY71cUQj2V0HqBfEipXLXsYrvnghP9b9/DCkA03QAQc6YjOhRn7xoWHVLVGbqwo2Uf
         64CQ==
X-Gm-Message-State: AElRT7FDWxEgintXTJmZ1DAVfYZJjicC7dYvOHJAxK0FRuDDCxZ1ikwD
        Yyk5P7UdAxbMDJON79rQyfc=
X-Google-Smtp-Source: AG47ELu018O8fy7+RjmwsA24bNrbGh3uzUOL1+6yTgzWLP+eDdGjYaK5L+7Qy6phIkSrFZYFoyix3Q==
X-Received: by 2002:a17:902:b7cc:: with SMTP id v12-v6mr12019478plz.237.1521771809356;
        Thu, 22 Mar 2018 19:23:29 -0700 (PDT)
Received: from localhost (softbank126094241038.bbtec.net. [126.94.241.38])
        by smtp.gmail.com with ESMTPSA id o3sm11511412pgp.18.2018.03.22.19.23.27
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 22 Mar 2018 19:23:28 -0700 (PDT)
Message-ID: <5ab46520.0352650a.cc02b.a177@mx.google.com>
To:     Junio C Hamano <gitster@pobox.com>
CC:     git@vger.kernel.org
In-Reply-To: <xmqq370sm4cv.fsf@gitster-ct.c.googlers.com>
From:   Yuki Kokubun <orga.chem.job@gmail.com>
Date:   Fri, 23 Mar 2018 02:15:39 +0000
Subject: Re: [PATCH] filter-branch: consider refs can refer to an object other than commit or tag
References: <xmqq370sm4cv.fsf@gitster-ct.c.googlers.com>
        <xmqqpo3xnqq4.fsf@gitster-ct.c.googlers.com>
        <xmqqwoy5pcno.fsf@gitster-ct.c.googlers.com>
        <20180321103504.9483-1-orga.chem.job@gmail.com>
        <1521646299-16193-1-git-send-email-orga.chem.job@gmail.com>
        <5ab2b606.86f5620a.c0c10.41b3@mx.google.com>
        <5ab3bd79.d14d650a.be5c0.8544@mx.google.com>
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> However, if we pre-filter to limit the refs in "$tempdir/heads" to
> those that are committish (i.e. those that pass "$ref^0") like the
> patch and subsequent discussion suggests, wouldn't we lose the
> warning for these replace refs and non-committish tags.  We perhaps
> could do something like:
> 
> 	git rev-parse --no-flags ... >"$tempdir/raw-heads" || exit
> 
> 	while read ref
> 	do
> 		case "$ref" in ^?*) continue ;; esac
> 		if git rev-parse --verify "$ref^0" 2>/dev/null
>                 then
> 			echo "$ref"
> 		else
> 			warn "WARNING: not rewriting '$ref' (not a committish)"
> 		fi
> 	done >"$tempdir/heads" <"$tempdir/raw-heads"
> 
> (note: the else clause is new, relative to my earlier suggestion).

I agree these suggestions.
I'm gonna send a new patch that follow it.
