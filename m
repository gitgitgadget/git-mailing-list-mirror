Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7B88C207D6
	for <e@80x24.org>; Tue, 25 Apr 2017 05:28:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S980409AbdDYF2J (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Apr 2017 01:28:09 -0400
Received: from mout.web.de ([212.227.15.14]:64250 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S978968AbdDYF2H (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Apr 2017 01:28:07 -0400
Received: from [192.168.178.36] ([79.213.114.92]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0M9ome-1crueY1l60-00B6mx; Tue, 25
 Apr 2017 07:28:02 +0200
Subject: Re: [PATCH v3 2/5] archive-zip: use strbuf for ZIP directory
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Peter Krefting <peter@softwolves.pp.se>,
        Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org,
        Keith Goldfarb <keith@blackthorn-media.com>
References: <37eb7c14-eb61-7a63-bdf0-ee1ccf40723f@kdbg.org>
 <alpine.DEB.2.11.1704222341300.22361@perkele.intern.softwolves.pp.se>
 <a1504d15-36d6-51f8-f2c9-a6563789bb6f@kdbg.org>
 <alpine.DEB.2.11.1704231526450.3944@perkele.intern.softwolves.pp.se>
 <e0d1c923-a9f5-9ffc-a7e7-67f558e50796@kdbg.org>
 <alpine.DEB.2.00.1704240901520.31537@ds9.cixit.se>
 <b3f2f12c-2736-46ed-62c9-16334c5e3483@web.de>
 <85f2b6d1-107b-0624-af82-92446f28269e@web.de>
 <949f19e6-0414-9abc-9754-064d7e58c169@web.de>
 <xmqq37cxw0mf.fsf@gitster.mtv.corp.google.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <80415bd2-1669-4dcc-4c08-87c096f9b063@web.de>
Date:   Tue, 25 Apr 2017 07:28:00 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.0.1
MIME-Version: 1.0
In-Reply-To: <xmqq37cxw0mf.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:BscwFYR0lLrv4PrawiY3kofvttcgRiMRYeY5UuZOCeQmhwJlOc8
 BhlsiNZQ0loZncbt6O3biNHOMpOmiDzL7KbuoOY6Qx4DSbPoxC2U3CU+7CVL9wgdO3xC7GF
 G3nH2DvSHrD653TbeU7plCSWUn8Cva6HVhUWMAXX2rqPr5FWdfa/9bXwblvrjPSv+B16mGn
 +xapaHC/HNR1lVWmD96wA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:yV0q1dfqnk4=:ZR2r4eMXj5WLvOTMPh52aT
 f3hIADehcKKUmLWI2dNfmVBLD2SCh15fYno/uife7Lljko1n3fr+yUxoEZx7hZ2EuEVpPYzpm
 DwIdsZCOxR4x9My1WBsmTv3FKoIXezkcankPIE+U5Fula76bbaRzSrDb02IVM/P/LSKr082fA
 3cts2HeZLSkKBH0iU7lbEU+8zWZfWJVA3e5Q7Hy9J130F4xl/R1zBIrO/M9HzD8kwjmxknn6z
 s0SPlLxWHdSRwqywgalv7Zk4I7q3P1dRzNIkfgUwlGaK0XPgY3SMNz5hZviMiMr89OVLsNISB
 L/7OMK364swOqSCj1Pv1BlVDiYCIBL+IbTqsCMCGpHsS7YCnYjcg8sjg9IEPO2vTDA2ZpTPFA
 aa5NqB/ImRFmFAA80rcT+9sFxhndUR9D0ZqRHpVLs1AVDVRCeTp5BF6wzAIGHwJE0WPeLoui+
 0VAzyzq6w0NsXY3kF0VZx67bJk/skPhnUeFpN0yeLfINWTBhsjdo/roFqYg0yg8fJbJzbkDaA
 LNjiwUcTahhDHwabSkgo6js9/u4TWo0472dx8gomCee9iVSC7fK+T/x116wTl7e4AcaxudtSQ
 7EIl6vIa46Ff1bzX0qlwUaiBhvVYtCZUURYi61xBwfUEVOCx9CkQH1J6Ir73mDH1VnMEVfmp+
 yQw+kokxyk2H92WSvyT2+YyPCIF9pIym5aoFsYRhkIbs+cZeE0G/humDGqS4NroltxFramTYN
 2IqatQPpAsz+ttR/j3N93ydmUD+WojvbeUUpW8RwwR3jqzDG+F1xcwE4kHdRnawPnkfJ5rZ9P
 pQePtC7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 25.04.2017 um 06:51 schrieb Junio C Hamano:
> René Scharfe <l.s.r@web.de> writes:
> 
>> Keep the ZIP central director, which is written after all archive
> 
> Is this typoed "directorY"?  I know there was discussion on the
> correct terminology I only skimmed and I am too lazy to go back
> there to understand it to answer this question myself, so...

Yep, a typo, this patch touches a "directory", as stated in the subject.

The "ZIP central director" would be PKWARE Inc., I guess? ;-)  The patch 
doesn't affect them..

René
