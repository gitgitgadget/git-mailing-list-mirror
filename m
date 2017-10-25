Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4A441202A0
	for <e@80x24.org>; Wed, 25 Oct 2017 10:49:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932412AbdJYKts (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Oct 2017 06:49:48 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:49298 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750862AbdJYKtq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Oct 2017 06:49:46 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20171025104944epoutp03f51bb53d66e3a22fd8703110daab3518~wyo2eCS8r1696116961epoutp03N;
        Wed, 25 Oct 2017 10:49:44 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20171025104944epoutp03f51bb53d66e3a22fd8703110daab3518~wyo2eCS8r1696116961epoutp03N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1508928584;
        bh=71sNg6wdDaIgCBK3zg2OS1uxR18zemQmYekHf2sHMo4=;
        h=Subject:To:Cc:From:Date:In-reply-to:References:From;
        b=SFN7uHppewGVOJUFQLwOn3EpdmrclspY2S83Us6QR7cR7T6NEa3QasDkgYfAPxO4n
         /lAMRx2hEvafp3yvQNCWMWnuixybRUWi7NblJ3/TqpNJ/SAXRO+Iau0z/p2l2T4Lok
         EHXrR7+C1wPCKT4BbvsyW3NpVYNJK9PIyKsKEYWk=
Received: from epsmges1p5.samsung.com (unknown [182.195.42.57]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20171025104944epcas1p44ea6c8974ac06930fc65f7f7de4663e7~wyo2PWsIb0599905999epcas1p4l;
        Wed, 25 Oct 2017 10:49:44 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        63.07.04139.84C60F95; Wed, 25 Oct 2017 19:49:44 +0900 (KST)
Received: from epsmgms2p1new.samsung.com (unknown [182.195.42.142]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20171025104944epcas1p2c671544bd1d4f5caa0fbf2319fcc2d0d~wyo11rwbq0654206542epcas1p26;
        Wed, 25 Oct 2017 10:49:44 +0000 (GMT)
X-AuditID: b6c32a39-969ff7000000102b-24-59f06c4895b3
Received: from epmmp1.local.host ( [203.254.227.16]) by
        epsmgms2p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        44.B8.04095.74C60F95; Wed, 25 Oct 2017 19:49:43 +0900 (KST)
Received: from [106.109.129.81] by mmp1.samsung.com (Oracle Communications
        Messaging Server 7.0.5.31.0 64bit (built May  5 2014)) with ESMTPA id
        <0OYD003FBKQLYP30@mmp1.samsung.com>; Wed, 25 Oct 2017 19:49:43 +0900 (KST)
Subject: Re: [PATCH] merge-recursive: check GIT_MERGE_VERBOSITY only once
To:     Stefan Beller <sbeller@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        vmiklos@frugalware.org, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>
From:   Andrey Okoshkin <a.okoshkin@samsung.com>
Organization: Samsung RnD Institute Russia
Message-id: <b92619c8-8ae1-1270-ba7e-bfd0afd3055f@samsung.com>
Date:   Wed, 25 Oct 2017 13:49:33 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
        Thunderbird/52.4.0
MIME-version: 1.0
In-reply-to: <CAGZ79kaSZG9WriqX0SLbTnEDRr-4YdFRuK17+9wnxyrftfnMmg@mail.gmail.com>
Content-type: text/plain; charset="utf-8"
Content-language: en-GB
Content-transfer-encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprKKsWRmVeSWpSXmKPExsWy7bCmnq5HzodIg9krZS26rnQzWTT0XmG2
        +NHSw2yxeXM7i8WR9s9MDqweT5p7WDwWbCr1eNa7h9Hj4iVlj8+b5AJYo7hsUlJzMstSi/Tt
        Ergy7k1fxVrQwl4xoX8TWwPjedYuRk4OCQETid8PVjN2MXJxCAnsYJRYf/oAE4TznVHi4a3l
        TDBVl27/ZodI7GaUePy/gQ3Cuc8ocfzVG2aQKmEBT4mlP06D2SICahIzV80GK2IW6GCUmPT9
        BRtIgk1AT+L8rwnsIDa/gJbE5R/zwBp4BewkppzZCHYUi4CqxNIrH8HqRQUiJI4fXs4IUSMo
        8WPyPRYQm1MgWOLq7ytgvcwCmhIvvkxigbDFJY7dv8kIYctLbF7zlhnkCAmBM2wS0682MEP8
        4yLx+tghFghbWOLV8S1AB3EA2dISl47aQoTrJVo7nrBB9AI98HnWUnaIhL3Elq7tbBAL+CTe
        fe1hhejllehoE4Io8ZCY8PQgNOgcJY6sOQ8NrZuMEn9nrmGewCg/C8k/s5D8MAvJD7OQ/LCA
        kWUVo1hqQXFuemqxYYGpXnFibnFpXrpecn7uJkZwYtGy3MF47JzPIUYBDkYlHl6B6e8jhVgT
        y4orcw8xSnAwK4nwLs7+ECnEm5JYWZValB9fVJqTWnyIUZqDRUmcV3T9tQghgfTEktTs1NSC
        1CKYLBMHp1QDI5dAToTirompP9gSEnSEDJb+tu7d+Mvt7+IzjOf+75pll//XcDIjz/kaR5PE
        pu8qSvtY//nJXs+Pmmg7cd7pzKLcCdZCF9u3v27YKqmku+ffNdUXzyND779S/6i09398oMFm
        9dYDi307FRfPZvf6fqdRK//Sq4wF1nx2Z1433rcsVomKNH1sr8RSnJFoqMVcVJwIADJqR/Eo
        AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrNLMWRmVeSWpSXmKPExsVy+t9jAV2PnA+RBr3cFl1XupksGnqvMFv8
        aOlhtti8uZ3F4kj7ZyYHVo8nzT0sHgs2lXo8693D6HHxkrLH501yAaxRXDYpqTmZZalF+nYJ
        XBn3pq9iLWhhr5jQv4mtgfE8axcjJ4eEgInEpdu/2bsYuTiEBHYySnTPvcQI4TxklHg76TFY
        lbCAp8TSH6eZQWwRATWJmatms4EUMQt0MEq8PnoYquM2o8TCtn9MIFVsAnoS539NYAex+QW0
        JC7/mAfWzStgJzHlzEawqSwCqhJLr3xkA7FFBSIknje/Z4WoEZT4MfkeC4jNKRAssapjOVAN
        B9A2dYkpU3JBwswC4hLH7t9khLDlJTavecs8gVFwFpLuWQgds5B0zELSsYCRZRWjZGpBcW56
        brFRgWFearlecWJucWleul5yfu4mRmAUbDus1beD8f6S+EOMAhyMSjy8GTPfRwqxJpYVV+Ye
        YpTgYFYS4V2c/SFSiDclsbIqtSg/vqg0J7X4EKM0B4uSOO/tvGORQgLpiSWp2ampBalFMFkm
        Dk6pBsYg8Ym3V0mzOn9acbbGuucGg5PtousWXUnvQ8MCD8fUHuSS1783xXXLjCjR798EH/97
        1vD9t7pB11KVIk+NqgsTeUv1pvxO9k98pc3t+Pp7Vs2jG8tyhLZtVbxoO/Njd5FPgmnFDlF9
        Ec70o8syMwXft21bvW7hjyVl5TcursnT2xBl1Dx7+mUlluKMREMt5qLiRAA83n53fgIAAA==
X-CMS-MailID: 20171025104944epcas1p2c671544bd1d4f5caa0fbf2319fcc2d0d
X-Msg-Generator: CA
CMS-TYPE: 101P
X-CMS-RootMailID: 20171024152727epcas2p4fb7dcf147e44aadf7733098151d469a5
X-RootMTR: 20171024152727epcas2p4fb7dcf147e44aadf7733098151d469a5
References: <CGME20171024152727epcas2p4fb7dcf147e44aadf7733098151d469a5@epcas2p4.samsung.com>
        <3aed764b-388c-d163-08fc-32b294c6b9d3@samsung.com>
        <CAGZ79kaSZG9WriqX0SLbTnEDRr-4YdFRuK17+9wnxyrftfnMmg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for your review.

24.10.2017 19:28, Stefan Beller wrote:
> So I think this function is never called from within a threaded environment
> in git.
You are right, it's just a hypothetic case.
 
> Despite not being in a threaded environment, I wonder if we want to
> minimize the time between  calling getenv and the use of the result,
> i.e. declare merge_verbosity here, but assign it later, just before the
> condition?
> 
> (The compiler may shuffle stuff around anyway, so this is a
> moot suggestion; It gears mostly towards making the code more
> readable/maintainable when presenting this part of the code
> to the user.)
> 
> With or without this change:
> Reviewed-by: Stefan Beller <sbeller@google.com>
Yes, in current situation it's more for readability. And I'll make the usage
of merge_verbosity just after the assignment.

-- 
Best regards,
Andrey Okoshkin
