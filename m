Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5022D1FBB0
	for <e@80x24.org>; Thu,  8 Dec 2016 19:02:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752737AbcLHTCq (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Dec 2016 14:02:46 -0500
Received: from mail-pg0-f42.google.com ([74.125.83.42]:35236 "EHLO
        mail-pg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752658AbcLHTCp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Dec 2016 14:02:45 -0500
Received: by mail-pg0-f42.google.com with SMTP id p66so176793461pga.2
        for <git@vger.kernel.org>; Thu, 08 Dec 2016 11:02:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=5i57vqDtRXzOzDBB8+S6eV+Pu7+zt0KLptntgaAVjjw=;
        b=IRrRqrUvSub7joNvIazEgt6gGICbQyiUkaccil++lqBpVU2UtPdtUabFJK6UcqyRcp
         TQdHmK71MC8dITzkzNVvUYOL8+cPeKlwuWk5sn8j6nTtNTx68wsMdJOQwuAUt/A4XWbs
         bmvki3WP9AIeFxDLrmjK9rb/PikG7MoCZRpYW6Qy271TgIngmQn/u8PWwpdNWrivz0TV
         WYn3TSDB4d1m3HmE29MGYBDupAadw4da8fpf+cw7T9dCKJKAdeHFqVDI32E1Rhmi2JWH
         r9IaZAkjiM7pJWMTaIopz2mvxRq2Spx2T3BQwa/1ZQAW6EfIuO4KQvPw2xNnjJIdS7+C
         +F4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=5i57vqDtRXzOzDBB8+S6eV+Pu7+zt0KLptntgaAVjjw=;
        b=AaavhM39t84PebcV2nKKtUUbaPmmgepGVF1tCoS5+j3t7SnhkFb2nGhhKq3AOgr9UR
         vIj6a+ryepA4aTQWgc3MX+QvVtc+5qFGQ64dj/ETHGD6LgOBudjGHqVxaUJ1i/KLLH+N
         FNaKDyBX3CIX/f8gYlBMu1HU1KQhTvmP3YI4Z0g8QDPc1PTP96349GW4qm37D71b1/xw
         caRi8+m15shGHQZGyyF3CI0KZXROY/MNgm32PSSn5lNFt5Ig3cfbGQkC5xvsbn+fsut9
         FXos9FTWtQc4GN3DMUJq7ljJ+u8DT+7Y1gh4uUnLv/i4h/nGTBbIBIeVLS0QbzwHOtjj
         +kIw==
X-Gm-Message-State: AKaTC01caTDp7J/iZ9hgehoGFXmDS6/KmskydESBJ2Eh2pKCqu5i+JZKg30VCtp/9I5qC5pz
X-Received: by 10.99.5.21 with SMTP id 21mr133633745pgf.32.1481223764527;
        Thu, 08 Dec 2016 11:02:44 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:5c3f:7794:7672:2048])
        by smtp.gmail.com with ESMTPSA id i194sm52036722pgc.46.2016.12.08.11.02.43
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 08 Dec 2016 11:02:43 -0800 (PST)
Date:   Thu, 8 Dec 2016 11:02:42 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>,
        Junio C Hamano <gitster@pobox.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        git@vger.kernel.org, sbeller@google.com, peff@peff.net,
        jacob.keller@gmail.com
Subject: Re: [PATCH] real_path: make real_path thread-safe
Message-ID: <20161208190242.GA63154@google.com>
References: <1480964316-99305-1-git-send-email-bmwill@google.com>
 <1480964316-99305-2-git-send-email-bmwill@google.com>
 <xmqqtwagy65q.fsf@gitster.mtv.corp.google.com>
 <20161207001018.GD103573@google.com>
 <b73e61f8-0cff-b33e-118a-e530d367c94c@ramsayjones.plus.com>
 <20161207201409.GA19743@tb-raspi>
 <xmqqtwafwkdt.fsf@gitster.mtv.corp.google.com>
 <20161207221335.GA116201@google.com>
 <20161208075555.GA23595@tb-raspi>
 <6cae7549-72f2-e591-ad48-28d449a62caf@kdbg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6cae7549-72f2-e591-ad48-28d449a62caf@kdbg.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/08, Johannes Sixt wrote:
> Am 08.12.2016 um 08:55 schrieb Torsten Bögershausen:
> >Some conversion may be done in mingw.c:
> >https://github.com/github/git-msysgit/blob/master/compat/mingw.c
> >So what I understand, '/' in Git are already converted into '\' if needed ?
> 
> Only if needed, and there are not many places where this is the
> case. (Actually, I can't find one place where we do.) In particular,
> typical file accesses does not require the conversion.

That's convenient, that way I don't have to worry about using '\' as a
directory separator instead of '/'.

> 
> >It seams that we may wnat a function get_start_of_path(uncpath),
> >which returns:
> >
> >get_start_of_path_win("//?/D:/very-long-path")         "/very-long-path"
> 
> We have offset_1st_component().

Thanks for letting me know this function exists, that makes my job a bit
easier.

-- 
Brandon Williams
