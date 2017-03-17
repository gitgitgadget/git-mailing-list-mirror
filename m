Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9568020951
	for <e@80x24.org>; Fri, 17 Mar 2017 19:21:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751170AbdCQTVb (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Mar 2017 15:21:31 -0400
Received: from mail-pg0-f46.google.com ([74.125.83.46]:35872 "EHLO
        mail-pg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751094AbdCQTVa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Mar 2017 15:21:30 -0400
Received: by mail-pg0-f46.google.com with SMTP id g2so47588904pge.3
        for <git@vger.kernel.org>; Fri, 17 Mar 2017 12:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mEd0eN/KtF8fhAtL9lUyBSmSKDZKtY80lNfTaXzGJ/o=;
        b=kT6m5uW0jvTH+CABqVIO6ApZDjcOeschE/5QhJLHlbveUifOBWhN6fBgKVYmISLlmL
         sUCC0ZFb1RGNurolq8L5fOuXRr8vTwwg2khL0LODaGSe6Gbb1fBNv4fKsiZK7aBBlotK
         axl7bl/BJsn2NTA06ljorsKrHUO67/iyKAFNhiq2dF3PTu9D0rAYbZu94rCwcxemoabj
         /Ex8c9wA9amToeCtn0ZK6phRxaH7Pnk3PtazLmhNjbDqBZQy6xP5tRaL554CbzLwfmHK
         LKMkZJvVSiRYOlFJKsoN/Uu9VSrSJ11sv54b19C8fV6syEfjd+4ezesUCuQfYx+ZtBlI
         Nfug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mEd0eN/KtF8fhAtL9lUyBSmSKDZKtY80lNfTaXzGJ/o=;
        b=behpb8QfXsvN52z9GZ12kHNxJ9QhuaEozhZWL5tckbJUEkZ/z0wp9ENST/IsRFBXEK
         7pB+vTlJYcIxip2r74Y1DWxFRuRF2G3ul1kxOHX5Hlj18HLcnN92/Jjps5JPXLeTNyB5
         zIB7pKMN15dRmQwyccP/wBOuI1DPhycI6E+gf7KeCAbEMAcfPcZ8fYqdZxCv4b5hXJbM
         /ZOBzi+wzErSg/EcH3dyc3dAUmgAreVMjfLhZrCyfVhUKDIle0x1Ehd3TPGKID6w318n
         uNJK7R1buUUHNNSqqCMnw9jQsoYSQBjfeBihm8iACrG2/DPcs7O4P1xFRC7fcPSE+8T6
         Uzlg==
X-Gm-Message-State: AFeK/H16PucoWkymU+6HX0G3pZy7nsuKKkJsYw5bfDgJx9v/eUREdn/5+9foR2x6FUiyR16d
X-Received: by 10.84.229.73 with SMTP id d9mr14770819pln.177.1489778465215;
        Fri, 17 Mar 2017 12:21:05 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b10:c001:d329:ba91:25ca])
        by smtp.gmail.com with ESMTPSA id x21sm18434515pgf.15.2017.03.17.12.21.03
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 17 Mar 2017 12:21:04 -0700 (PDT)
Date:   Fri, 17 Mar 2017 12:21:03 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Stefan Beller <sbeller@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v3 2/5] setup: allow for prefix to be passed to git
 commands
Message-ID: <20170317192103.GE110341@google.com>
References: <20170314221100.24856-1-bmwill@google.com>
 <20170317172257.4690-1-bmwill@google.com>
 <20170317172257.4690-3-bmwill@google.com>
 <CAGZ79kZAZeb5rsL80dty_tRM5SDCAXVq_yATpDQREq_vV4Yj+Q@mail.gmail.com>
 <xmqq60j77lx3.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq60j77lx3.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/17, Junio C Hamano wrote:
> Stefan Beller <sbeller@google.com> writes:
> 
> >>         prefix = setup_git_directory_gently_1(nongit_ok);
> >> +       env_prefix = getenv(GIT_TOPLEVEL_PREFIX_ENVIRONMENT);
> >> +
> >> +       if (env_prefix)
> >> +               prefix = env_prefix;
> >> +
> >>         if (prefix)
> >>                 setenv(GIT_PREFIX_ENVIRONMENT, prefix, 1);
> >
> > so we load that GIT_TOPLEVEL_PREFIX_ENVIRONMENT prefix
> > first, such that we essentially copy it into GIT_PREFIX_ENVIRONMENT,
> > such that e.g. aliased commands will know about the superprefix, too.
> 
> If the aliased commands or anything else spawned from this process
> is happy with GIT_PREFIX set to the outside of the current
> repository, doing this setenv() is OK.  If you are in ~/dir1, and
> your repository is in ~/repos/repo1, and if you somehow had a way
> to run your "git" inside ~/repos/repo1 without doing any chdir(2),
> then you are essentially setting ../../dir1/ as GIT_PREFIX for that
> "git" invocation (this has nothing to do with submodules).
> 
> But if your "git" is fine with GIT_PREFIX pointing outside the root
> level of the working tree of the current repository like that, do we
> even need a separate toplevel prefix environment, I have to wonder?
> 
> That is, if this "if TOPLEVEL_PREFIX environment is there, set it to
> local variable prefix and export it as GIT_PREFIX" is expected to
> work correctly for anything that would inherit that GIT_PREFIX, then
> we should be able to invoke the "git" that got TOPLEVEL_PREFIX
> without setting that environment, but instead setting the same value
> to GIT_PREFIX and we should get the same behaviour, no?
> 

Very true, potentially we could just use GIT_PREFIX instead of
introducing a brand new env var (which is essentially just the same
thing).  I was being cautious with this patch since git didn't currently
read GIT_PREFIX.  I was hoping other with more knowledge in this area
would voice their opinions and lead me in the right direction ;)

-- 
Brandon Williams
