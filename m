Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0ED591FC96
	for <e@80x24.org>; Tue,  6 Dec 2016 22:38:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751563AbcLFWiJ (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Dec 2016 17:38:09 -0500
Received: from mail-pg0-f43.google.com ([74.125.83.43]:33504 "EHLO
        mail-pg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752288AbcLFWiH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Dec 2016 17:38:07 -0500
Received: by mail-pg0-f43.google.com with SMTP id 3so153958181pgd.0
        for <git@vger.kernel.org>; Tue, 06 Dec 2016 14:37:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=S8kcXsioYCz42bnNFXQjRqH1/FBP1CSB4XQpKzhwPe4=;
        b=CY1qo8wphajPTVmQqLWsfCkJDF3IDN9HTiHQTj1BVAIh5SA3cnJ+rI3DUkRCXXsneb
         pcq/RmTpnjgnLbZKKEzO38n1MCTbcGHOlmdXHChUwW6izs/ci8pZwgs+72RFUIrkAJqt
         d1Ge3wAcSLVhTL5Uo/PKGsdZ0jAkVPdv2JwG7EkLuHMZ8tamCQ6SmqliBY+1BBOGM7TP
         pumfatdbvac2+hBn+0OIMVWPVGbCliBdvKG3JXg5yqOb9Zbp8Dca7tAH43a6/gW2z2kI
         zK1rOvIDr6crl/7O/5ZxL4O35rQ1lryCs+m1oZ3n5auvbLP3eHwSpsxFknTuwFfHfdkR
         rgkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=S8kcXsioYCz42bnNFXQjRqH1/FBP1CSB4XQpKzhwPe4=;
        b=ZwBSG8bPCJhHDULLg86hnBbv8ueSxHeqZUzk5rBTvKrPHcz1K5/+uHe/fYS9TK8zmc
         Di59Jdoyoms+0KpeVmNSqWz0AWb4spNXkrrFo4CN7Rny8+WZBwJQwuoAl7Ybds4dYw92
         sJgw+L0vkkgbEFp6hr3zyjK+DK3R7x7J5H7MgC+FO5fWGLHgE8juJD5nkav0D2C9vA7t
         jeXclDNvbdTpRjdxX+4uSsBMUpHP6Ys9fZx3a2xHeYsBz7EkBySLzbwjoNzmUl0AujR0
         ZPT8aFiWaDHe+6PxFFGyZkhMh14QbEpDK2G2n2jWSm5+D8lcFk8wcBXG6EQPP64h+6qk
         0vww==
X-Gm-Message-State: AKaTC02TpaK1+tpz7dgH3Pl69x7c4Fy9UypL116xCLgPSISDh1m0l2/fZM86iG/c0npK2mg1
X-Received: by 10.99.122.14 with SMTP id v14mr117109790pgc.31.1481063879234;
        Tue, 06 Dec 2016 14:37:59 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:e0c5:1a05:7bf2:5496])
        by smtp.gmail.com with ESMTPSA id 72sm37130347pfw.37.2016.12.06.14.37.58
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 06 Dec 2016 14:37:58 -0800 (PST)
Date:   Tue, 6 Dec 2016 14:37:57 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Duy Nguyen <pclouds@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 10/17] pathspec: simpler logic to prefix original
 pathspec elements
Message-ID: <20161206223757.GC103573@google.com>
References: <1481061106-117775-1-git-send-email-bmwill@google.com>
 <1481061106-117775-11-git-send-email-bmwill@google.com>
 <CAGZ79kausxZMinZymG8mE4jQ1pi4yJ80WRBUGFhUK7mmfOBCvg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGZ79kausxZMinZymG8mE4jQ1pi4yJ80WRBUGFhUK7mmfOBCvg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/06, Stefan Beller wrote:
> On Tue, Dec 6, 2016 at 1:51 PM, Brandon Williams <bmwill@google.com> wrote:
> 
> >                 struct strbuf sb = STRBUF_INIT;
> > -               if (prefixlen && !literal_global) {
> > -                       /* Preserve the actual prefix length of each pattern */
> > -                       if (short_magic)
> > -                               prefix_short_magic(&sb, prefixlen, short_magic);
> > -                       else if (long_magic_end) {
> > -                               strbuf_add(&sb, elt, long_magic_end - elt);
> > -                               strbuf_addf(&sb, ",prefix:%d)", prefixlen);
> > -                       } else
> > -                               strbuf_addf(&sb, ":(prefix:%d)", prefixlen);
> 
> This fixes the issue with add -p . mentioned somewhere else on the mailing list.
>
> > -               }
> > +
> > +               /* Preserve the actual prefix length of each pattern */
> > +               prefix_magic(&sb, prefixlen, element_magic);
> > +
> 
> Did you find a reason why we passed magic literally, i.e. short magic
> was passed as short magic and long magic as long magic before?
> 
> I cannot think of any reason why that would have been the case,
> but I assume there had to be a reason for that.

nope, perhaps it was because we technically already have the long magic
string and the short magic needs to be converted to long magic (as you
can't mix short and long magic).

> Another note: This collides with the attr system refactoring, which I
> postpone redoing until the submodule checkout is done, so maybe
> you want to pickup this patch:
> https://public-inbox.org/git/20161110203428.30512-31-sbeller@google.com/
> which only relies on one patch prior
> https://public-inbox.org/git/20161110203428.30512-30-sbeller@google.com/

After looking at those patches I think I do something extremely similar
in a future patch in this series, the parse_long_magic patch.

-- 
Brandon Williams
