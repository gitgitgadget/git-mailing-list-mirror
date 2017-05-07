Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.8 required=3.0 tests=BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0AA9420137
	for <e@80x24.org>; Sun,  7 May 2017 21:43:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754438AbdEGVnZ (ORCPT <rfc822;e@80x24.org>);
        Sun, 7 May 2017 17:43:25 -0400
Received: from mail.aegee.org ([144.76.142.78]:50795 "EHLO mail.aegee.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752541AbdEGVnY (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 May 2017 17:43:24 -0400
Authentication-Results: aegeeserv.aegee.org; auth=pass (PLAIN) smtp.auth=didopalauzov
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.aegee.org v47BqDNB009170
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aegee.org; s=k4096;
        t=1494157933; i=dkim+MSA-tls@aegee.org; r=y;
        bh=GbtjSdPrHcT6V7C66xzWZjkdAB5tmKa+mZM46H51XF4=;
        h=To:From:Subject:Date;
        b=pa5DJkdrbCHE4uGZO+lAm7YlPXjZ9bdh9eJeP5u2Ecm+b7T5Vzj7w+cRIrIFYEo/P
         55zTA3otAPaQwTC8JTmcvGVreuP0vg/hAoiXODcbX25r9HeY9I6TUaVsFw1nIfkUyP
         hY6mTOo3S6KhAwhhEW3yPcXd1NS2DPMVq/XmfITBo5Hf/IzvDeICtIkKtLTeqW12vM
         BtJQXWxDZrgSXxi1sZHvjnDwrTNGUUbBhIErBBqmXzIQwOiPlVR6kgljr9K6n053Rt
         dF1acOkf99vZa7v5hHq0MnMEW2cCRBj04Jea4m5WxFnrWYqGa92INP/oGbr+kIlDJI
         4VTz/xxWg0h+MsoUpZQlGs0NIyiQNCfO+JT8xcE/6l3AMPSbQ8UqiPmODDIJtNTXeH
         1TBcuvTN8+YE7J8BnlyEf+Ui3WqdpF6wXig8qcFlMvchBPThlk0ccznlyN5WmJWuvE
         9ENwLyRYTFiYz0p4Ty0uzl+BzbY6HZ9Nyr4z8NhM9+rPX/fWKavRQ5dYKpLC4pCmMe
         P32/rjWOgrGlx23oO3E3FzB6bqWKCDwd+A5rT77Mmy3mfBNkkz2e0HKOTMdFrCAYHN
         md5myeonNqXn5saKlgMJeuwmAzn48aMg4j3VR6bw9kKLqYs+UCyEHmhaG9S4p3PU1e
         RguMJfmeGcyGvIyz1uc3baFE=
Authentication-Results: mail.aegee.org; dkim=none
Received: from [192.168.178.46] (x5f74f7c7.dyn.telefonica.de [95.116.247.199])
        (authenticated bits=0)
        by mail.aegee.org (8.15.2/8.15.2) with ESMTPSA id v47BqDNB009170
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO)
        for <git@vger.kernel.org>; Sun, 7 May 2017 11:52:13 GMT
To:     git@vger.kernel.org
From:   =?UTF-8?B?0JTQuNC70Y/QvSDQn9Cw0LvQsNGD0LfQvtCy?= 
        <dilyan.palauzov@aegee.org>
Subject: git and the Clang Static Analyzer
Message-ID: <5696a8a3-0a17-18ac-8da4-4556586acee7@aegee.org>
Date:   Sun, 7 May 2017 13:50:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.99.2 at mail.aegee.org
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

I compiled git/master using the clang 4.0 static analyzer with

scan-build ./configure --with-libpcre --with-openssl
scan-build make

and here are the results:
   https://mail.aegee.org/dpa/scan-build-git-4fa66c85f11/

Please note, that the information is only about what gets actually 
compiled, code disabled by #if .. #endif is not considered (e.g. when 
determining whether a variable assignment is useless).  There are 
probably false-positives.  However in case of e.g. builtin/notes.c:1018, 
builtin/reset.c:294 or fast-import.c:2057 I consider the hints as justified.

This is for your information,  I wouldn't have a problem if you ignore 
the analysis.  When you are worried about javascript, use lynx.

Regards
   Дилян
