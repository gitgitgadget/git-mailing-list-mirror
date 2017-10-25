Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0F8C3202A0
	for <e@80x24.org>; Wed, 25 Oct 2017 10:49:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932437AbdJYKt6 (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Oct 2017 06:49:58 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:57470 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932419AbdJYKt4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Oct 2017 06:49:56 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20171025104954epoutp0136a1c8c8a4cc14ff888b8f2e6077925c~wyo-lfaXb1596415964epoutp016;
        Wed, 25 Oct 2017 10:49:54 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20171025104954epoutp0136a1c8c8a4cc14ff888b8f2e6077925c~wyo-lfaXb1596415964epoutp016
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1508928594;
        bh=YgbgKay+IGZqhGcxrlYUpg60FLQX1DcqOaeT+TSqYdA=;
        h=Subject:To:Cc:From:Date:In-reply-to:References:From;
        b=r3XOHPRQobvVhKsI0zv5Lh8oE0TOb/cABnTTHUdWRuc4qijkortobbPNJ5eiIvYKy
         CyUH45y6Ysbcxu8YvSDo1Z2FeNWebF/oLzsRHMdRpRbfaiK02d1/W7ZUFe7/4GxQBS
         ZFpnxr9PmI4BlYQNlsKkIuA+4qrypzSlKbo3eltE=
Received: from epsmges1p2.samsung.com (unknown [182.195.42.54]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20171025104954epcas1p3d6306de34195d42ec692acf7b877cd8e~wyo-Vcewf0309003090epcas1p34;
        Wed, 25 Oct 2017 10:49:54 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        DE.06.04153.25C60F95; Wed, 25 Oct 2017 19:49:54 +0900 (KST)
Received: from epsmgms2p1new.samsung.com (unknown [182.195.42.142]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20171025104953epcas1p23c2cc362d1dc7058b3c3f46162d04cbb~wyo_x8PE91582515825epcas1p2s;
        Wed, 25 Oct 2017 10:49:53 +0000 (GMT)
X-AuditID: b6c32a36-325ff70000001039-f1-59f06c52fe3d
Received: from epmmp1.local.host ( [203.254.227.16]) by
        epsmgms2p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        55.B8.04095.15C60F95; Wed, 25 Oct 2017 19:49:53 +0900 (KST)
Received: from [106.109.129.81] by mmp1.samsung.com (Oracle Communications
        Messaging Server 7.0.5.31.0 64bit (built May  5 2014)) with ESMTPA id
        <0OYD003FNKR3YP30@mmp1.samsung.com>; Wed, 25 Oct 2017 19:49:53 +0900 (KST)
Subject: Re: [PATCH] merge-recursive: check GIT_MERGE_VERBOSITY only once
To:     Eric Sunshine <sunshine@sunshineco.com>,
        Stefan Beller <sbeller@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        vmiklos@frugalware.org, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>
From:   Andrey Okoshkin <a.okoshkin@samsung.com>
Organization: Samsung RnD Institute Russia
Message-id: <41b8510f-d71b-9de6-9199-9e355f373af2@samsung.com>
Date:   Wed, 25 Oct 2017 13:49:50 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
        Thunderbird/52.4.0
MIME-version: 1.0
In-reply-to: <CAPig+cRTL2amjsgdp1=T3GMZLa=favugOfnQw9XjWzC+U=v5Sw@mail.gmail.com>
Content-type: text/plain; charset="utf-8"
Content-language: en-GB
Content-transfer-encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprDKsWRmVeSWpSXmKPExsWy7bCmgW5QzodIg57PXBZdV7qZLBp6rzBb
        /GjpYbbYvLmdxeLMm0ZGiyPtn5kc2DyeNPeweCzYVOrxrHcPo8fFS8oeix94eXzeJBfAFsVl
        k5Kak1mWWqRvl8CV8br3LFPBYaaKlqkLWRsYG5i6GDk5JARMJI6emcjWxcjFISSwg1Hiyv1v
        rBDOd0aJn3Pb4apa/v+EqtrNKPH+egeUc59RYs/F4ywgVcICnhJLf5xmBrFFBAIluqdNBhvF
        LNDBKDHp+ws2kASbgJ7E+V8T2EFsfgEtics/5oE18ArYSczrvQg2iEVAVaL1z15WEFtUIELi
        +OHljBA1ghI/Jt8DquHg4BQIlrizNgYkzCygKfHiyyQWCFtc4tj9m4wQtrzE5jVvmUFukBC4
        zSbROX0z1DsuEq//bmSBsIUlXh3fwg4yU0JAWuLSUVuIcL1Ea8cTNoheoPs/z1rKDpGwl9jS
        tZ0NYgGfxLuvPawQvbwSHW1CECUeEhOeHoRa5ShxZM15sHIhgQVMEu3n3SYwys9C8s0sJC/M
        QvLCLCQvLGBkWcUollpQnJueWmxYYKRXnJhbXJqXrpecn7uJEZxmtMx2MC4653OIUYCDUYmH
        V2D6+0gh1sSy4srcQ4wSHMxKIrzv0j5ECvGmJFZWpRblxxeV5qQWH2KU5mBREucVXX8tQkgg
        PbEkNTs1tSC1CCbLxMEp1cCY+CHBd3WK5Porl+rXX5vv1rnnWt7OnnOCjc0hlhtmHs76tLpr
        y1GzkzztJWyCYS+uua+Sjvu0LCF7a97EwJ3Nj127LNKbrjtEvj/vn8/LVZjJpfjhwt83udN1
        eFriv9bxvAwQj1L68ZrnzwWPZukdn/t7loXffef/QPpLV27byS9SpYuWWDkosRRnJBpqMRcV
        JwIAQ8GhOC8DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrKLMWRmVeSWpSXmKPExsVy+t9jAd3AnA+RBk0X1Sy6rnQzWTT0XmG2
        +NHSw2yxeXM7i8WZN42MFkfaPzM5sHk8ae5h8ViwqdTjWe8eRo+Ll5Q9Fj/w8vi8SS6ALYrL
        JiU1J7MstUjfLoEr43XvWaaCw0wVLVMXsjYwNjB1MXJySAiYSLT8/8nWxcjFISSwk1Hizddz
        zBDOQ0aJfwvPsIBUCQt4Siz9cZoZxBYR8Jd43L8CrINZoINR4vXRw4wQHYuYJO41LGcDqWIT
        0JM4/2sCO4jNL6AlcfnHPLBuXgE7iXm9F8GmsgioSrT+2csKYosKREg8b37PClEjKPFj8j2w
        Gk6BYIk1988CLeAA2qYuMWVKLkiYWUBc4tj9m4wQtrzE5jVvmScwCs5C0j0LoWMWko5ZSDoW
        MLKsYpRMLSjOTc8tNiowzEst1ytOzC0uzUvXS87P3cQIjIxth7X6djDeXxJ/iFGAg1GJhzdj
        5vtIIdbEsuLK3EOMEhzMSiK8i7M/RArxpiRWVqUW5ccXleakFh9ilOZgURLnvZ13LFJIID2x
        JDU7NbUgtQgmy8TBKdXAmHf25ambU+fpqSaWxSW6M3NXLWCMSfnJmuNd5ds385DWPzNvtqAj
        S7beSf7FPCPstO7HKadXe259yW6rLhf3adV0P3Hex87p2+5E1Iadu1eZweVw3JDNuDnjpfzX
        Bf4u5/LOZF7tdbbsYN+YH+F8em9YQ3uBuP3/AxWyoafU8ude9ki+u6BGiaU4I9FQi7moOBEA
        GABp4ogCAAA=
X-CMS-MailID: 20171025104953epcas1p23c2cc362d1dc7058b3c3f46162d04cbb
X-Msg-Generator: CA
CMS-TYPE: 101P
X-CMS-RootMailID: 20171024152727epcas2p4fb7dcf147e44aadf7733098151d469a5
X-RootMTR: 20171024152727epcas2p4fb7dcf147e44aadf7733098151d469a5
References: <CGME20171024152727epcas2p4fb7dcf147e44aadf7733098151d469a5@epcas2p4.samsung.com>
        <3aed764b-388c-d163-08fc-32b294c6b9d3@samsung.com>
        <CAGZ79kaSZG9WriqX0SLbTnEDRr-4YdFRuK17+9wnxyrftfnMmg@mail.gmail.com>
        <CAPig+cRTL2amjsgdp1=T3GMZLa=favugOfnQw9XjWzC+U=v5Sw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

24.10.2017 19:45, Eric Sunshine wrote:
> I feel uncomfortable about this change, not due to lack of thread
> safety, but due to the distance between the getenv() invocation and
> its point of use. See below for more detail.

Thanks, the usage must be just after the assignment.

-- 
Best regards,
Andrey Okoshkin
