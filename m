Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8586320756
	for <e@80x24.org>; Fri, 20 Jan 2017 20:07:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753040AbdATUHh (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Jan 2017 15:07:37 -0500
Received: from mail-io0-f179.google.com ([209.85.223.179]:35281 "EHLO
        mail-io0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753012AbdATUHf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Jan 2017 15:07:35 -0500
Received: by mail-io0-f179.google.com with SMTP id j18so69775543ioe.2
        for <git@vger.kernel.org>; Fri, 20 Jan 2017 12:07:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=wIW7rnMiJiqJoXSbqeu80gPAgB4pZkzETOEqIHjJtiQ=;
        b=UiDdoMo1bQ17rXvrBZ/rbwUdXhVnVSXtx0dOsQuKxBPNXDl6XMjXkFGRdckkyAyNZC
         n2BcV8J3HXKWCu92tvIx7sGMSKBKaa8g05Vlw4p4zpvnAo4qUu+9PPfMnjfhdp0VeAh1
         GjoVwDcx2JKXZ98FUg13KMs21oA34W2F9UjRzFj7gjjbjdjTnaigShnqAPyVMWZBCTSJ
         nqu4FHiWWGIjlcymiJMY6JKM9jo0dD3NTfnYmJ+NPwTo1rpmx058So6d7eKTOjwGHy0V
         21yYDFCitdaK3a510KjmUafSnimhSyZkKofxgGEIIyJJ7cRAub+qUtBInlAhxG5QvsuO
         kWgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=wIW7rnMiJiqJoXSbqeu80gPAgB4pZkzETOEqIHjJtiQ=;
        b=f0I0RqMb0iyVoo1Bx1BmpGs7bQwplsZZq1HXFIRN+kWGmzX85Lmx0nPw0xX8IjLrCX
         ZAlEmV+YxtSOLEoB7opbbneGgAaJpkUuSQf/Ajn84LJeqSDM+FLQ/4J80pR6kctyNX8I
         vmOzlXp6qwmVT+lfJcSlwxjc25L1CMD5IMS/FfZjl0zUZtLcqYbLLAXPYTqweMj5t5ZU
         iVcip4esofRHHZAyq8j3xvv3DYue8YMnybIwiqXIrpDMUQOXDpZvtnq7DvGnq3hVe+Cu
         ueooy+R3/vb3nzYSfux/Sg9xxCGqptrtDM/MHwAAhjqvMBlnJXr2Sicc9CvK4ptVe4RQ
         ss5w==
X-Gm-Message-State: AIkVDXJONPUQPdQ5qThjlcJNyB0bRFEfKZeMrvC/sNuWwy6hbMk2j3SmqQgQYSWc6EnbUakaryzBy4p/gorUGcTr
X-Received: by 10.107.37.148 with SMTP id l142mr14044821iol.159.1484942849060;
 Fri, 20 Jan 2017 12:07:29 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.39.19 with HTTP; Fri, 20 Jan 2017 12:07:28 -0800 (PST)
In-Reply-To: <20170120200041.hefg44stddqe344z@sigill.intra.peff.net>
References: <20170119193023.26837-1-sbeller@google.com> <20170120191728.l3ne5tt5pwbmafjh@sigill.intra.peff.net>
 <CAGZ79kaJQefSDkV-LKxRCTtSepsNsX7U+AZqy3Z_YCd1xsmTxQ@mail.gmail.com>
 <20170120194224.vikzovupwqx53x2c@sigill.intra.peff.net> <CAGZ79kYKY=hDVjUx7AkeWZ=3V8Fy2hqQMFPZcoxT4NvXTFgG=Q@mail.gmail.com>
 <20170120200041.hefg44stddqe344z@sigill.intra.peff.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 20 Jan 2017 12:07:28 -0800
Message-ID: <CAGZ79kYSW7i9kyT5Nd2QuiRF+=oWz+6U6VGpAQhfspUHMjWnpw@mail.gmail.com>
Subject: Re: [RFC/PATCH] Disallow commands from within unpopulated submodules.
To:     Jeff King <peff@peff.net>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 20, 2017 at 12:00 PM, Jeff King <peff@peff.net> wrote:
> On Fri, Jan 20, 2017 at 11:53:01AM -0800, Stefan Beller wrote:
>
>> > One alternative would be to make the check cheaper. Could we reliably
>> > tell from the submodule.foo.* block in the config that path "foo" is a
>> > submodule? I think that would work after "submodule init" but not right
>> > after "git clone". So the index really is the source of truth there.
>>
>> Well we can check if there is a .gitmodules file that has a
>> submodule.*.path equal to the last part of $CWD, no need to look
>> at the git config.
>>
>> And that would also work right after git clone (in an
>> unpopulated/uninitialized submodule as I call it).
>>
>> And in my current understanding of submodules the check in
>> .gitmodules ought to be enough, too.
>
> Yeah, that probably makes sense. You can have a gitlink without a
> .gitmodules file, but I don't quite know what that would mean in terms
> of submodules (I guess it's not a submodule but "something else").

yeah, I agree it could be git series[1] at work, or as you said
"something else", and we have no idea what to do.

I think this could actually be implemented top-down, because the
check is cheap as we're beginning with lstat(.gitmodules), and no further
pursue checking this corner case in case the .gitmodules is not found.

I'll see if I can make a patch that passes the test suite.

[1] https://github.com/git-series/git-series/blob/master/INTERNALS.md

>
> -Peff
