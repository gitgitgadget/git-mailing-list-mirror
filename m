Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3F700209B8
	for <e@80x24.org>; Wed, 13 Sep 2017 08:04:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751454AbdIMIEH (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Sep 2017 04:04:07 -0400
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:58587 "EHLO
        alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751317AbdIMIEC (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 13 Sep 2017 04:04:02 -0400
X-AuditID: 1207440e-be1ff70000007085-a0-59b8e67178da
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id 94.7A.28805.176E8B95; Wed, 13 Sep 2017 04:04:01 -0400 (EDT)
Received: from [192.168.69.190] (p57BCC855.dip0.t-ipconnect.de [87.188.200.85])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v8D83wKd005337
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Wed, 13 Sep 2017 04:04:00 -0400
Subject: Re: [PATCH 3/4] replace-objects: evaluate replacement refs without
 using the object store
To:     Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Christian Couder <chriscool@tuxfamily.org>
References: <20170912172330.GA144745@aiede.mtv.corp.google.com>
 <20170912173140.GD144745@aiede.mtv.corp.google.com>
From:   Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <fe956802-41ab-783f-62b3-f7c4b8292e8c@alum.mit.edu>
Date:   Wed, 13 Sep 2017 10:03:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20170912173140.GD144745@aiede.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupileLIzCtJLcpLzFFi42IRYndR1C18tiPS4FqXocWm5xOZLbqudDNZ
        vL25hNFi8+Z2FgcWj52z7rJ7LNhU6rH8wSt2j8+b5AJYorhsUlJzMstSi/TtErgyVm+fwFJw
        nKOiZfME9gbGJvYuRk4OCQETiclPXjF3MXJxCAnsYJJo2nKYEcI5zyRx6c8BFpAqYYEUiR1T
        mphAbBEBW4nlV5axdjFycDALREscfygCEhYSKJX4em0BI4jNJqArsainGaycV8Be4uHqeWwg
        NouAqsT3/81gI0UFIiT63l5mh6gRlDg58wlYnFPAQaL7xXxmEJtZQF3iz7xLULa4xK0n85kg
        bHmJ7W/nME9gFJiFpH0WkpZZSFpmIWlZwMiyilEuMac0Vzc3MTOnODVZtzg5MS8vtUjXWC83
        s0QvNaV0EyMkyPl2MLavlznEKMDBqMTDu+LO9kgh1sSy4srcQ4ySHExKorz79+yIFOJLyk+p
        zEgszogvKs1JLT7EKMHBrCTC++s+UI43JbGyKrUoHyYlzcGiJM6rtkTdT0ggPbEkNTs1tSC1
        CCYrw8GhJMH79ClQo2BRanpqRVpmTglCmomDE2Q4D9DwapAa3uKCxNzizHSI/ClGRSlx3jVP
        gBICIImM0jy4XlgSesUoDvSKMK8jSDsPMIHBdb8CGswENPjMabDBJYkIKakGRt//LRbHmL6+
        Z7t593X7g/0HT+t+S1x2KlF14k3X3fX+Er+nNr4WZrrxaNPaHWJzfz++aqA3/TnjI4FpUp9T
        1EzLXkQFHpJdWPk9ufrq1qtzu6eXR7Y/+zftiK2l2Y47sgkllpk3vS8c+Fuzzd/oy5tp6t+f
        HhNk/DrfTIDXzYLx8DZGe8Hptz8osRRnJBpqMRcVJwIATUKScR0DAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 09/12/2017 07:31 PM, Jonathan Nieder wrote:
> From: Stefan Beller <sbeller@google.com>
> 
> Pass DO_FOR_EACH_INCLUDE_BROKEN when iterating over replacement refs
> so that the iteration does not require opening the named objects from
> the object store. This avoids a dependency cycle between object access
> and replace ref iteration.
> 
> Moreover the ref subsystem has not been migrated yet to access the
> object store via passed in repository objects.  As a result, without
> this patch, iterating over replace refs in a repository other than
> the_repository it produces errors:
> 
>    error: refs/replace/3afabef75c627b894cccc3bcae86837abc7c32fe does not point to a valid object!
> 
> Noticed while adapting the object store (and in particular its
> evaluation of replace refs) to handle arbitrary repositories.

Have you checked that consumers of this API can handle broken
references? Aside from missing values, broken references can have
illegal names (though hopefully not unsafe in the sense of causing
filesystem traversal outside of `$GITDIR`).

Michael
