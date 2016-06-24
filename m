Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_50,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 66A171FEAA
	for <e@80x24.org>; Fri, 24 Jun 2016 20:59:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751682AbcFXU7A (ORCPT <rfc822;e@80x24.org>);
	Fri, 24 Jun 2016 16:59:00 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:35634 "EHLO
	mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751652AbcFXU67 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jun 2016 16:58:59 -0400
Received: by mail-it0-f65.google.com with SMTP id g127so3776461ith.2
        for <git@vger.kernel.org>; Fri, 24 Jun 2016 13:58:59 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=B6Pp6KWI5cL317Wp5PWxQeAmy1AmwYCECzcp3iATGIM=;
        b=QrCzsreWjJTdvL1lgM8YNPNY7z50g5gxMBWJZcCfDalbYkEHxDa4G60fVjmIjAGSQi
         XwnTN24E7CQwP+KUEXK3PXA2ke9ckrLaN5Cau0ryoogpHwV1l0R7hkYZJ410Y+nAQQUe
         FAcUAxzGC3yTzosdoMM4vHAAeRP2shSplvkMin7HDytv929cWXXXb2b3KXPGCgoyhb7z
         nwM68e764L6j2JjJJ3XeyeS+Tp39Hp2TNLJQ1aqnh3QSOJ9JHz8+JosW2/4BjKpXHAl5
         BZNx73MS9tDTpqhbtQsCcWcRXS0FpvERgQ6mbzHkYMOhzmiiaSDAZ8PZDZWwSyber4AR
         P66Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=B6Pp6KWI5cL317Wp5PWxQeAmy1AmwYCECzcp3iATGIM=;
        b=HVLsJwUg+mW0gZ6p5WJMd06grpfbMmaIfLFMuXYgQpT/aJklxsL7S5oXRH5yox4P/F
         3vLF3iDPCnk3GL25PTP/YEIXG0Y7Fql7g5eylmjm0O3sx6yhWEaY8S4VRG9S2ag7mtp7
         VjMjtIYIpCnU5yQ1FbQrp6v2SBzn3rRoLiP9E4fUJi+xw5cwORtyT7AG/Xbo6IS7w8p0
         KZlNDldl+juE5WBxlx3GjEEcgstOlWxvu3to/hFQdQ8QhrZLcsAlLinKRsB7rrSS8LxO
         TA8XV6De6rWY+3N+jOGxuUzSCRcn9fK2fwtLVKmOyaMErsbH9SXwfFvSfSuqgenZurpo
         HYBw==
X-Gm-Message-State: ALyK8tL41RzVp1B5CMH7HRNEQWUHMjVkhnpmYlE5/Cib5LJNKdWUpSxf6UQiMxJwRP0gSW1rB8juKf/F0NlyuA==
X-Received: by 10.36.55.15 with SMTP id r15mr92097itr.73.1466801938824; Fri,
 24 Jun 2016 13:58:58 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.0.30 with HTTP; Fri, 24 Jun 2016 13:58:58 -0700 (PDT)
In-Reply-To: <20160624190744.GA32118@sigill.intra.peff.net>
References: <20160623231512.GA27683@sigill.intra.peff.net> <20160623232041.GA3668@sigill.intra.peff.net>
 <xmqq1t3mh0vg.fsf@gitster.mtv.corp.google.com> <20160624190744.GA32118@sigill.intra.peff.net>
From:	Eric Sunshine <sunshine@sunshineco.com>
Date:	Fri, 24 Jun 2016 16:58:58 -0400
X-Google-Sender-Auth: StqNje8fAwnsm0EurLOdYK8o7S8
Message-ID: <CAPig+cRD43DnaiZrT4ODnT7Nm5J8q=MhtSeyK3ZNjwaTW8mdbg@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] t5000: test tar files that overflow ustar headers
To:	Jeff King <peff@peff.net>
Cc:	Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	=?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
	"Robin H. Johnson" <robbat2@gentoo.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Fri, Jun 24, 2016 at 3:07 PM, Jeff King <peff@peff.net> wrote:
> On Fri, Jun 24, 2016 at 11:56:19AM -0700, Junio C Hamano wrote:
>> Jeff King <peff@peff.net> writes:
>> > +tar_info () {
>> > +   "$TAR" tvf "$1" | awk '{print $3 " " $4}' | cut -d- -f1
>> > +}
>
>> Seeing an awk piped into cut always makes me want to suggest a
>> single sed/awk/perl invocation.
>
> I want the auto-splitting of awk, but then to auto-split the result
> using a different delimiter. Is there a not-painful way to do that in
> awk?

The awk split() function is POSIX and accepts an optional separator argument.
