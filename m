Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 79AE7202C1
	for <e@80x24.org>; Wed, 15 Mar 2017 20:58:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751935AbdCOU6c (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Mar 2017 16:58:32 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:33284 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751822AbdCOU6c (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Mar 2017 16:58:32 -0400
Received: by mail-pf0-f194.google.com with SMTP id v190so3346531pfb.0
        for <git@vger.kernel.org>; Wed, 15 Mar 2017 13:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=q78nmQ3B6oubZaWmk6wKMIsxv0wUtfjvVbDASdePURY=;
        b=bmX7B0fTlTyGCV2f+7pvSYplzdHr4o1yPxf0Cx+/PN5NaOJoaZtdNyvvKfoBNd5fRo
         3qwCAu/MYciVDSteU+EkvmGh1/EKEzLjxdrfOpq17O5CXMAg6FEFjva6KGkA2c59CZKz
         D1ynOUlO1J+DCzQ/e6lh0mpqz/oBNaOgP+16kWDs7QSOVMf3ir6GjVrCasce/WBWscsX
         loR7dD9hIQ09ZOi7u2hP49CiMjKLIFGUcE61hmuuflXoUkgxBZcMZ9JIGlEPqubLEJxa
         vFLUgcKNpvx6IhaVYNOHMoUyD7WyYRnom4vtF4Te3uL5+WE/Ur+CpqAMengtQgQylakz
         G3ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=q78nmQ3B6oubZaWmk6wKMIsxv0wUtfjvVbDASdePURY=;
        b=HjX+uZjKetnZs8V1wtm2saZXP5kCw2Vpm/XNOrPEWYhy0Hw/FmVreQCDtKHCByBOKI
         IdeZWWLBHDSiOuTiPVeYALfJ+0QF30EsfjGgItP0TBARUvlzYInpCU0P4Z8+drfk48jV
         GH6E5etJnm/u++yfCuaLUV7krv8yq1ZNK3sjqLYWNdiLF92nsXe4R6DUJBeEuMOG03Lh
         T9Jx1a93TkYZBLSKhjZ+nUbifjKCxIRXSZXFsE8gi89waKkupaq74PXaIIUZpS3g+uRH
         1/Pz9XkwAn3hO2SLq2lhliMpLPUF5+Ar3B05obPkAANABI29h+FU21uGCyewBhXyybha
         BxEw==
X-Gm-Message-State: AFeK/H1J5Bmz6/O67riF/vzJA0B83EevYx/dgh/o1xcQhzOJgeIvgWhGpALlukZQqiY0Sw==
X-Received: by 10.84.151.9 with SMTP id i9mr7341530pli.122.1489611510908;
        Wed, 15 Mar 2017 13:58:30 -0700 (PDT)
Received: from gmail.com (wdas-1.disneyanimation.com. [198.187.190.1])
        by smtp.gmail.com with ESMTPSA id u75sm6016803pfk.3.2017.03.15.13.58.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 15 Mar 2017 13:58:29 -0700 (PDT)
Date:   Wed, 15 Mar 2017 13:58:15 -0700
From:   David Aguilar <davvid@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git ML <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Christophe Macabiau <christophemacabiau@gmail.com>
Subject: Re: [PATCH v2 3/3] difftool: handle modified symlinks in dir-diff
 mode
Message-ID: <20170315205735.5c6i4uivzj77bfsb@gmail.com>
References: <20170315093130.30110-1-davvid@gmail.com>
 <xmqq8to6fk15.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq8to6fk15.fsf@gitster.mtv.corp.google.com>
User-Agent: NeoMutt/20161126 (1.7.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 15, 2017 at 11:54:14AM -0700, Junio C Hamano wrote:
> David Aguilar <davvid@gmail.com> writes:
> 
> > @@ -397,7 +438,7 @@ static int run_dir_diff(const char *extcmd, int symlinks, const char *prefix,
> >  				return error("could not write '%s'", src_path);
> >  		}
> >  
> > -		if (rmode) {
> > +		if (rmode && !S_ISLNK(rmode)) {
> >  			struct working_tree_entry *entry;
> 
> It still makes me wonder why the new !S_ISLNK() is done only for the
> right hand side, though.  In fact, the processing done for the left
> hand side and the right hand side are vastly different even without
> this patch.
> 
> I suspect this is probably because the code is not prepared to drive
> the underlying "diff" when given the "-R" option (if I am reading
> the code correctly, argv[] that came from the end-user is appended
> to "diff --raw --no-abbrev -z", so the user could ask "difftool
> --dir-diff -R ..."), in which case you would see the working tree
> files as the left hand side of the diff.  In the dir-diff mode,
> because you want to make only the working-tree side writable (and
> reflect whatever edit the user made back to the working-tree side),
> the choices you have to fix it would either be forbid "-R" (which is
> less preferrable as it is a more brittle solution between the two)
> or read the "diff --raw" output and swap the sides when you notice
> that LHS has 0{40} with non 0 mode, which is a sign that that side
> represents the working tree.
> 
> Having said all that, let's focus on the "symlink" stuff in this
> series.
> 
> Thanks.

Agreed.  I can take a look at the reverse-diff
question later this week separately from this issue.

The symlink test case I just added can be used as a starting
ground for adding reverse-diff tests.

Thanks Junio and Dscho for the reviews,
-- 
David
