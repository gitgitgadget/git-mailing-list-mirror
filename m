Return-Path: <SRS0=QAHC=4O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B5DDC4BA2B
	for <git@archiver.kernel.org>; Wed, 26 Feb 2020 21:32:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E5302072D
	for <git@archiver.kernel.org>; Wed, 26 Feb 2020 21:32:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cBS3BF+Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727591AbgBZVcS (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Feb 2020 16:32:18 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:59718 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727503AbgBZVcR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Feb 2020 16:32:17 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01QLMiSY077105;
        Wed, 26 Feb 2020 21:32:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=QWiDAhEncHdEkQstd/xCqUSEt9lGMHQApIwCaRQ2t2o=;
 b=cBS3BF+YJa+lkerxyw1Ag++Bu3rt34dZpi9sSG1X+1gkXzi7UcByW2H2JcudYwcC015G
 bD6HfyrkWTb6YiYZKXLS/Qh76fI2BzHAiUIF+yZBV63/Gf6uq+lFGg7yKNIgGUMwH1DW
 KgfKaHUcMVAGuslW0hHKcPOOPLQ5E04PgRfkj/CqlC6Pmh1CXYL1kUphnVak4aCqGCJV
 jywONVN6HDHV9Bw9iE4VcDwu9NVClB4r5P05EpFbwhQM8MlpJ8OCPMmq9t6ObYQ+P/H6
 r0NveXQKyjTs5T+CQ3bdGlyoIDaaYJCkFwKo66IAcmTLfYfNwLiomVbLsTwLgqWPSeJX uA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2ydct36gqc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Feb 2020 21:32:13 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01QLMHMe007137;
        Wed, 26 Feb 2020 21:32:13 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 2ydcs6b3fp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Feb 2020 21:32:12 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 01QLWCgK003761;
        Wed, 26 Feb 2020 21:32:12 GMT
Received: from [10.175.32.145] (/10.175.32.145)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 26 Feb 2020 13:32:12 -0800
Subject: Re: Making GitGitGadget conversion lossless
To:     Junio C Hamano <gitster@pobox.com>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     git@vger.kernel.org
References: <20200226200929.z4aej74ohbkgcdza@chatter.i7.local>
 <xmqq5zfthxlw.fsf@gitster-ct.c.googlers.com>
From:   Vegard Nossum <vegard.nossum@oracle.com>
Message-ID: <51155ef5-e301-2f5d-263e-184b9ab0979d@oracle.com>
Date:   Wed, 26 Feb 2020 22:32:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <xmqq5zfthxlw.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9543 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 phishscore=0
 mlxlogscore=999 spamscore=0 suspectscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002260126
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9543 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 bulkscore=0
 impostorscore=0 spamscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 phishscore=0 mlxlogscore=999 mlxscore=0 suspectscore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002260126
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/26/20 10:01 PM, Junio C Hamano wrote:
> As I said already, I do not think that the desire to get the
> bit-for-bit identical commit is compatible with the idea to discuss
> e-mailed patches---the pieces of patch e-mail will become "you may
> look at them, you may apply them, but it is no use to comment on
> them to get them improved".  So, I dunno.

For me, at least, the goal was to be able to store previous patch
submissions in git (even if it is not merged into the main tree) so
that you can use git and all its tools (diff, log, blame, grep, notes,
etc.) to browse previous versions and browse discussions _and_ use the
SHA1 as a stable identifier for a specific submission.

The point of having the stable identifier is so that the submitter can
take comments into account and resubmit their patchset while still
keeping a (stable, universal, unambiguous) reference to their previous
submission.

I don't see the incompatibility at all. The whole point was that the
current email workflow used by Linux and git (that includes discussion,
feedback, and revision) _does not need to change_.


Vegard
