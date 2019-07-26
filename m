Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 05AEA1F462
	for <e@80x24.org>; Fri, 26 Jul 2019 23:26:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726767AbfGZX0k (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Jul 2019 19:26:40 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:36928 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726651AbfGZX0j (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Jul 2019 19:26:39 -0400
Received: by mail-ua1-f68.google.com with SMTP id z13so21885117uaa.4
        for <git@vger.kernel.org>; Fri, 26 Jul 2019 16:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PsgmYakvkhuyHtm4klER6V74PLUHtm4OpOXa0aK5iQA=;
        b=jjEc0PAuGG03O1tji/t0+4x6sLokkAJkvZfdxeXP7TyfmNcPHrrRdsm0MmlkhL057y
         3MMzezuUESrukqlAv93tpa9aqr+1g+iBdD8XxHXrRxp6rElCYBB1hQeKuXZ7YBgXdsk5
         TuB+2v4/ktbA2m1HLW4Qz3CIe1d71T31YMuUvNIxQgUeKfi3ubi3kUuyUIULzhm2Cl9R
         rCIS0FOxcNK/vF7k+eSP2Qw/xVxQfXlBZIN5ivSFy5MD3yX+s1h1MOZz2Rmx322fhJp/
         lE8hzU9NLRXaN1dLinuSkv6Ne6vhY30l4JETN4t3sggv8oIdR+VISniAbBPp20SG1LIu
         FIQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PsgmYakvkhuyHtm4klER6V74PLUHtm4OpOXa0aK5iQA=;
        b=tZZI+F78XCI+NzKe13HDTSd36RcqVP+zby1fO/y2i/wDdeI3t0Ad004OhTU/ZReF8Y
         fIoG2kGLp7GmAvGAcGre0VgLy3eu1YMo7dUA5siqs5JtovLWKzBSillaku8Z0lrm3huX
         QvZHM6T4cJ7vIHepbK2OrgCL9CvJpoy4WU31bP2QLEgPCXElt5d/DlKBoVTH0WXCcoxA
         7PdHN7lNd4fpJSOQqXmH+stDzRbudNNAUt+vAdimSiZ8DuIEqkvNNgAqCIcqS7ld2vnF
         hcUWD0bDH+kXTIxVfBu77eK6P74QRocpXRuGZByIYRlC7jfb+HpzOKgqgaVbs3L7PXoD
         pRsA==
X-Gm-Message-State: APjAAAX+qxx/q40gD0kMmuFdVTqZeUxyVeozCqKKzUljuJ0Cx390EAZW
        46zsjzy6O39eQNiHilhv0JI6l7JxugGX8veU19k=
X-Google-Smtp-Source: APXvYqxsJsih3/fsifdKlrWzLdVQITvqy00etc+uiTnV/GTzS8wY06o28hXL2HWgDme2mbSmTl2gpDRXspeihTpM4zU=
X-Received: by 2002:ab0:20d8:: with SMTP id z24mr30318283ual.1.1564183598852;
 Fri, 26 Jul 2019 16:26:38 -0700 (PDT)
MIME-Version: 1.0
References: <20190725174611.14802-1-newren@gmail.com> <20190726155258.28561-1-newren@gmail.com>
 <20190726155258.28561-5-newren@gmail.com> <xmqqblxgoamb.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqblxgoamb.fsf@gitster-ct.c.googlers.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 26 Jul 2019 16:26:27 -0700
Message-ID: <CABPp-BHKWV6pNk_72xVTr5-rJ6n71Q9=SFa2H75_FUhJ8DrUQQ@mail.gmail.com>
Subject: Re: [PATCH v2 04/20] merge-recursive: exit early if index != head
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 26, 2019 at 12:32 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Elijah Newren <newren@gmail.com> writes:
>
> > Make sure we do the index == head check at the beginning of the merge,
> > and error out immediately if it fails.  While we're at it, fix a small
> > leak in the show-the-error codepath.
>
> As the call to repo_index_has_changes() is moved to the very
> beginning of merge_recursive() and merge_trees(), the workhorse of
> the merge machinery, merge_trees_internal(), can lose it.

Is this just a re-summarization (a perfectly good one), or a
suggestion for alternate wording for the commit message?

> > +static int merge_start(struct merge_options *opt, struct tree *head)
> > +{
> > +     struct strbuf sb = STRBUF_INIT;
> > +
> > +     assert(opt->branch1 && opt->branch2);
>
> This is a new assertion that did not exist in the original, isn't
> it?  I do not object to new sensible assertions, and I think these
> two fields must be non-null in a freshly initialized merge_options
> structure, but shouldn't we be discussing if these two fields should
> be non-NULL, and if there are other fields in the same structure
> that we should be adding new assertions on, in a separate step on
> its own?

Good point.  The only other one I saw was opt->ancestor, and while it
does have conditions it should satisfy, somewhat surprisingly the
condition is the opposite in merge_trees() vs. merge_recursive().  So
I think this is the only check that makes sense to add to
merge_start(), but I can move that out into a separate patch and add
some words about why just these two.
