Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AB9BC433F5
	for <git@archiver.kernel.org>; Tue,  1 Feb 2022 21:22:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231828AbiBAVWY (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Feb 2022 16:22:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231383AbiBAVWR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Feb 2022 16:22:17 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AD03C061714
        for <git@vger.kernel.org>; Tue,  1 Feb 2022 13:22:17 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id i17so16986696pfq.13
        for <git@vger.kernel.org>; Tue, 01 Feb 2022 13:22:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=5ioet2itD91p/uVYEauSJqQ6nuEt05FQoJnImQATrEY=;
        b=nr8tbNZorbUL5AHyaZpYQqo0dvqpAZIBppY06Mq3zRvreS7V/vbPWwMRE8k3gwGnAS
         Xs8u45Jnh58uStOw+UHjT42VNgdl8AleNHTtyfL7sE64XKvTunLHU/XV5aCzVUOjFRmd
         FW6JGe9WOX/6hj2R8K0iLnloWPVje0+yGlsspkZPQoYTHOOoPPXEEgFLnhuKc0p2k1+y
         H/fe9IX0QxNCaoKFckEYxRmP53srJFNrO4LBAyKC9ZRo091ctSYGWuDJsJ0GmjA/ix8q
         cpILGeeTBULIQtJGT7WoTSoEcJmlsaXcTSzLy0lC7r5ydyTynGrq7hclYuKNqiwtXYGZ
         jsZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=5ioet2itD91p/uVYEauSJqQ6nuEt05FQoJnImQATrEY=;
        b=Cj0iww5h408oK4JV/dDx+IB428JVS+5XWMRlQkMzqiXH7grUPkhzsl4zWTumGBxm7G
         g1DN15hsRWdke+8d2I+tWZiqTbmZu8xG3mj3FSBjmP3/rY6VrfmdDSzTJO7+cFOim0Qn
         +1WJr40wvK6M+8RwqI15WMbNqiKnSG8eIDiB1OigRMRhLWMN43KST/9FMOO0dC9uuHRt
         9/pXlONK4PaQ+ydSbxL7oV8vcpGNXe+ezOPxRbLSSDP5g5c6A/R0KDGuu0c0HHyJiZ6i
         K08xcKh8CIPs5toMkaShnSL8xhFm5L9igkp+eLQCdDmvjgzGSt8Dk8L9iihkujoeOKFJ
         QxfA==
X-Gm-Message-State: AOAM5330WvrlkpPfC0LFQIXeLZ33b3PtjVNG6FWPSkzXXEdc7NoOfqiz
        /1b+Bpevjy25JlD56Lolj3Tlvg==
X-Google-Smtp-Source: ABdhPJxQUSSkmcEWJzGZYC04Z7HoWP0jr4R18xh3lvzCI445TbQ6VHt1zWgm0MkUTT+YEN3QhdgNHg==
X-Received: by 2002:a05:6a00:21c9:: with SMTP id t9mr22094640pfj.48.1643750536306;
        Tue, 01 Feb 2022 13:22:16 -0800 (PST)
Received: from google.com ([2620:15c:2ce:200:b721:7974:9ebe:afb2])
        by smtp.gmail.com with ESMTPSA id s30sm11639800pfw.63.2022.02.01.13.22.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Feb 2022 13:22:15 -0800 (PST)
Date:   Tue, 1 Feb 2022 13:22:09 -0800
From:   Josh Steadmon <steadmon@google.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, me@ttaylorr.com,
        jeffhost@microsoft.com
Subject: Re: [PATCH v2] test-lib: unset trace2 parent envvars
Message-ID: <YfmkgeoSGdic83j4@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, gitster@pobox.com, me@ttaylorr.com,
        jeffhost@microsoft.com
References: <82e51a52e20fbe13a5a898a0a2f6dbe1188e3fa3.1642116539.git.steadmon@google.com>
 <2b5e573c22f226cbdb07d931d470a37bca7ffe2b.1643234866.git.steadmon@google.com>
 <220127.86r18tdeve.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <220127.86r18tdeve.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2022.01.27 04:23, Ævar Arnfjörð Bjarmason wrote:
> 
> On Wed, Jan 26 2022, Josh Steadmon wrote:
> 
> > The trace2 subsystem can inherit certain information from parent
> > processes via environment variables; e.g., the parent command name and
> > session ID. This allows trace2 to note when a command is the child
> > process of another Git process, and to adjust various pieces of output
> > accordingly.
> >
> > This behavior breaks certain tests that examine trace2 output when the
> > tests run as a child of another git process, such as in `git rebase -x
> > "make test"`.
> >
> > While we could fix this by unsetting the relevant variables in the
> > affected tests (currently t0210, t0211, t0212, and t6421), this would
> > leave other tests vulnerable to similar breakage if new test cases are
> > added which inspect trace2 output.
> >
> > In t/test-lib.sh, we keep a pattern of permitted GIT_* environment
> > variables. Variables matching /^GIT_TRACE.*/ are currently allowed via
> > this pattern. We want to preserve this behavior, because it can be
> > useful to collect trace output over the entire test suite. Instead of
> > modifying the allow-pattern, we instead fix this issue by unsetting only
> > the GIT_TRACE2_PARENT_NAME and GIT_TRACE2_PARENT_SID in t/test-lib.sh.
> >
> > Reported-by: Emily Shaffer <emilyshaffer@google.com>
> > Signed-off-by: Josh Steadmon <steadmon@google.com>
> > ---
> > Updated commit message and added code comments to explain why we keep
> > "TRACE" in the allow pattern.
> >
> >  t/test-lib.sh | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/t/test-lib.sh b/t/test-lib.sh
> > index 0f7a137c7d..faf25ba1b2 100644
> > --- a/t/test-lib.sh
> > +++ b/t/test-lib.sh
> > @@ -432,7 +432,7 @@ EDITOR=:
> >  unset VISUAL EMAIL LANGUAGE $("$PERL_PATH" -e '
> >  	my @env = keys %ENV;
> >  	my $ok = join("|", qw(
> > -		TRACE
> > +		TRACE	# Allow tracing in general, but see unsets below.
> 
> I think it would be good to turn that -e into a -we, which would tell
> you why this doesn't work the way you think:
> 
>     Possible attempt to put comments in qw() list at -e line 14.
>     Possible attempt to separate words with commas at -e line 14.
> 
> I.e. you added one string "#" to the array, and a string "Allow" etc.

Whoops, yeah, thanks for the catch. I've forgotten most of the Perl I
ever knew but should have seen that.
