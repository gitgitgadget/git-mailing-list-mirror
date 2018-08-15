Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 054591F404
	for <e@80x24.org>; Wed, 15 Aug 2018 16:14:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729487AbeHOTHY (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Aug 2018 15:07:24 -0400
Received: from mail-wm0-f46.google.com ([74.125.82.46]:39175 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729348AbeHOTHY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Aug 2018 15:07:24 -0400
Received: by mail-wm0-f46.google.com with SMTP id q8-v6so1812034wmq.4
        for <git@vger.kernel.org>; Wed, 15 Aug 2018 09:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=3cbuTt1bLSFmp7lrgzNkZ5YeLEHzXF1wfVqhaRTwq9k=;
        b=fTnF1WHXmhddlU33M+pyoqWo0vYwaBqXTA2EKK1QdYq9Q2pZhXccs3BAtef5EgGdDh
         qdUs3UOzOf2O9cC+Xun9+0s3UaoiIkiudxOK703RZtO/w8XtwHxzGmSE6NYqPccm+IJI
         lkKZzMKRdAt/pfLrfw0+bMUD3seJGITUUVFY45vfJobNW/l+EFFHROf+j/ovF4R1jY2F
         QVKYvXG6fk4gc85s1zmYeg2yNL98PvPcSVwayHGuWPuOF75ZlJGfUXT/Ri7Jk70dwkp9
         XuNY59zBQxBNNioUI4S3rCj6EIpwi67Zc8ZMIjW3OS8nSPx22jamMnEWK3LXayPJg3g2
         oI3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=3cbuTt1bLSFmp7lrgzNkZ5YeLEHzXF1wfVqhaRTwq9k=;
        b=qXEvndMqOZmaTFzvs+qZz/47gzXCUCVRvsI4vC7zIySwmQbxKwyF5Ym8orPFHmdRGA
         B4AdvGNYybhORj31DrEcGV7OsUsAlLnNd/0V8jWisnGOKWHreHz9rpdO3aYZN0G2igM2
         FkEieJg5Ajos3tRAUmoeI003c5oMqDLSJXM1tyy2o2hnZbzI4qqGrWgBtzhcobkQ2fvg
         q246B/PNcngQb1y3+E3OtEqqT+lVfMmurBPS3gj4AzRQ7jkVftzgMT8Nyn1y5J2q8SuA
         hcIYlPsBKMmGG7BLFmZZBDd4w2XXgn8qW7CA3xnRV9L327Ag0uZacRpiASGV8stJp+/y
         0uZw==
X-Gm-Message-State: AOUpUlG0MYob6IOHxKpF+y81jvAyy8+Bse23fC+t8+bmtNFgHaqtOk2C
        40F/OugYA1HWtlAPIbocCORKie5C
X-Google-Smtp-Source: AA+uWPxkPCajSxeqgTVlTuNu56ug/6bM4zqmHXxPh8xHQ/jRkzVGhjqNI5At7dSJTGReCLi9BavXgw==
X-Received: by 2002:a1c:c147:: with SMTP id r68-v6mr14129477wmf.161.1534349676615;
        Wed, 15 Aug 2018 09:14:36 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id x23-v6sm1394382wmh.26.2018.08.15.09.14.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 15 Aug 2018 09:14:35 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Matthew DeVore <matvore@google.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        git@jeffhostetler.com, jeffhost@microsoft.com,
        Jeff King <peff@peff.net>,
        Stefan Beller <stefanbeller@gmail.com>
Subject: Re: [PATCH v4 6/6] list-objects-filter: implement filter tree:0
References: <CAMfpvhKr4jmjZ3NUmxMyTM7KJxQX30UYXKf_rJ30A4C=P3tB=g@mail.gmail.com>
        <20180814201920.56534-1-jonathantanmy@google.com>
        <xmqqa7pozmzv.fsf@gitster-ct.c.googlers.com>
        <CAMfpvh+H5UeHmCqeVNZNoOe_-vgH3_3aTuO+c=imgzaVkC6N2g@mail.gmail.com>
Date:   Wed, 15 Aug 2018 09:14:35 -0700
In-Reply-To: <CAMfpvh+H5UeHmCqeVNZNoOe_-vgH3_3aTuO+c=imgzaVkC6N2g@mail.gmail.com>
        (Matthew DeVore's message of "Tue, 14 Aug 2018 16:30:37 -0700")
Message-ID: <xmqqva8bk3o4.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matthew DeVore <matvore@google.com> writes:

> Thank you. I changed it to this:
>   awk -e "/tree|blob/{print \$1}" objs >trees_and_blobs

The "-e" option does not appear in

http://pubs.opengroup.org/onlinepubs/9699919799/utilities/awk.html

and I think you can safely drop it from your command line.

    If no -f option is specified, the first operand to awk shall be the
    text of the awk program. The application shall supply the program
    operand as a single argument to awk. If the text does not end in a
    <newline>, awk shall interpret the text as if it did.

