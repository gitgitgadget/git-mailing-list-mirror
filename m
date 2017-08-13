Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CD1F3208B8
	for <e@80x24.org>; Sun, 13 Aug 2017 05:52:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750863AbdHMFwA (ORCPT <rfc822;e@80x24.org>);
        Sun, 13 Aug 2017 01:52:00 -0400
Received: from mout.web.de ([212.227.15.4]:52647 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750813AbdHMFv7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 Aug 2017 01:51:59 -0400
Received: from [192.168.178.36] ([79.237.60.227]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MGARb-1ds2DG1ehr-00FByY; Sun, 13
 Aug 2017 07:51:37 +0200
Subject: Re: [PATCH] strbuf: clear errno before calling getdelim(3)
To:     Jeff King <peff@peff.net>
Cc:     Simon Ruderich <simon@ruderich.org>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Yaroslav Halchenko <yoh@onerussian.com>
References: <20170809173928.h2ylvg5tp2p5inem@hopa.kiewit.dartmouth.edu>
 <8e307474-d180-6d98-2c6b-062f2181bd14@web.de>
 <xmqqzib72qvs.fsf@gitster.mtv.corp.google.com>
 <6d7b0d30-48ea-f79f-78cd-088557ea06ac@web.de>
 <20170810200502.rutab4z3ft7gcpjz@sigill.intra.peff.net>
 <cd49ce13-db87-89c1-77e7-998fdb9442c3@web.de>
 <20170811075059.nn6lru7uy6s6vpza@ruderich.org>
 <e8e7f028-6e23-368c-484f-9f069bae5dc8@web.de>
 <20170812100252.bhbgg5jjlom7dfl2@ruderich.org>
 <510f566b-3aee-98fd-9663-d97c3dcfeb96@web.de>
 <20170813043237.ndcm77i43ivepo7b@sigill.intra.peff.net>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <4bf18555-f8ea-a3f6-5204-b02bfd8f1ff9@web.de>
Date:   Sun, 13 Aug 2017 07:51:34 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20170813043237.ndcm77i43ivepo7b@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:JLBBxAsL6dv4us0VxSAQ+gFwTf+ReA2BCc7wRnXPjOUhAHaWN1F
 XKHI1gZwGUIuyTbVd4SzRJg03WK6rtMI4VVhaNq91azFDUKrFz3Cvjc7i045krIfQhPsNM8
 jE2SvMS7YOa+kuSnjLJBc3nEbyl9x87iiDe8+wAfBa1kTuRDiI+1qm5bf2/hpu4V5QZ4+nW
 kUwsQ5X9L9vz3GNrmGBSg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:79zimrurmM4=:iwic6KlWkAJ96MwteWj/Fg
 Dbbmd6BIvJ6awCpuGSd+pYaiOYe2b/jyDFsryIUwyI4qGfdZ2n9Vd3C6yhlMhXRZz3mRjdGm5
 AgFho/NTMaIKEBhkWHVXs7xiCWu6RLLMo+URnR3g4f0Xvdun7IehlQiUUyEQa+frV+O4OrVUS
 +jSCSXCDEFV5fzMhSY5/D4KGCYZY0fPd5LM0f03VgIdTLL8Vcy1U7qyB1syGopGf9wN7OhhxU
 Znmjdf/OJ5sSnCzJagp/caQXJWc9/ysCisCYPYgkMF4XIoX37/419Uw5graTgdgrzlRyVRn+a
 oxAETesM76pKbmalE+hNwLuZ9wCZkhD4wAN6zf1ECIVvMklo3q8WKtwwPWXKUjv5lGtnbktZu
 3UYQhvlwOiQNM2VZP2r4Pl5/3r36i0AL8VSQWVOMcFXNEpzVooAbSqlt7liIYQ11kwcF5LXpL
 pvJRWiz6lCT01UGsrNR+goIOnnNYS7qYTWluH1qPuj3uW1bsjTsHCtrmFCZSwtZu9+T6fepYr
 a6Mgsgksd15mTe8W4WOIMuIHIeuCTjcwu8mv0j5qsPB1MbrdqXqlju3fU+51Ok1uRhtq/kx8V
 S6nzTImokkjjJD5xuzys8BY3RX99IoP6bccY5WyYf7kwlLL2DYmagHNh04dmWTs9SHnW3tzru
 XigOFRfFse7dTKy+U5ZYqUbVT34f4KXyz/pP9k6WIopYOaCNNywEaxJQ35mddWxgLFaqyuDZD
 FlEb6rCvANtHHPNorb3okAXTRQMv7o7/eGYPbkV4ObLLsPGG2qEl/PcW8dMjqXfFcioM6okIi
 EHfsyS5tgbzYKjDL0zsrYizHRBLJQdjGN1XJd7iRG4mRlcH//E=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 13.08.2017 um 06:32 schrieb Jeff King:
> On Sat, Aug 12, 2017 at 01:57:06PM +0200, René Scharfe wrote:
> 
>> But we probably want to check for other errors.  They look unlikely
>> enough that we may get away with something like this:
>>
>> 	-	if (errno == ENOMEM)
>> 	-		die("Out of memory, getdelim failed");
>> 	+	if (errno || ferror(fp))
>> 	+		die_errno(_("getdelim failed"));
>>
>> NB: The other errors are EINVAL (input pointers are NULL or the
>> stream is invalid) and EOVERFLOW (read more than fits into ssize_t)
>> according to POSIX and the Linux manpage.
> 
> Can't we also get any of the errors that fgetc() would return. I.e., any
> normal read errors? We should return EOF on those, not die (and the
> caller can check ferror()).

Yes, we can get those as well, and leaving error checking to the caller
is a flexible way to handle them.  

Many of the existing callers don't seem to be bother, though.

René
