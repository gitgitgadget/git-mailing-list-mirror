Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D04B4211B3
	for <e@80x24.org>; Thu,  6 Dec 2018 11:48:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729069AbeLFLso (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Dec 2018 06:48:44 -0500
Received: from smtp41.i.mail.ru ([94.100.177.101]:58246 "EHLO smtp41.i.mail.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727832AbeLFLso (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Dec 2018 06:48:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bswap.ru; s=mailru;
        h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=dEYIg1Qp7xCo9Et41COwtU3I0SE37nCovgLRv6/dZts=;
        b=Kls4GtrWCYSwv1Nfk6JmhxPhj81bdgUZXRQ9eCe1pc2IKBxrqjXPrpGB38u8HNPZBGhE8frwi4lksHWcI8r5ky66v/mU/0fTpjeOF8uTP/0kLelux1VAgvKY1D0aTX0rjo22iVJFN1hTXl3VWXaCM1BWvMuBO9pEO2HoxruR+nU=;
Received: by smtp41.i.mail.ru with esmtpa (envelope-from <kostix@bswap.ru>)
        id 1gUs92-0003GR-GM; Thu, 06 Dec 2018 14:48:40 +0300
Date:   Thu, 6 Dec 2018 14:48:36 +0300
From:   Konstantin Khomoutov <kostix@bswap.ru>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Konstantin Khomoutov <kostix@bswap.ru>,
        Konstantin Kharlamov <hi-angel@yandex.ru>, git@vger.kernel.org
Subject: Re: Any way to make git-log to enumerate commits?
Message-ID: <20181206114835.oro32chgf4qp2yqd@tigra>
References: <5e5c6d1c-6b3e-c94a-17be-a2af518c1607@yandex.ru>
 <20181205145419.vbbaghzzrnceez45@tigra>
 <xmqqa7ljbimv.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqa7ljbimv.fsf@gitster-ct.c.googlers.com>
User-Agent: NeoMutt/20170306 (1.8.0)
Authentication-Results: smtp41.i.mail.ru; auth=pass smtp.auth=kostix@bswap.ru smtp.mailfrom=kostix@bswap.ru
X-77F55803: 260C666A7D66B36A5A78504BD2AC294135F1F2F3833E2C938853F4A1608A35F8FBAB2296E871C62A5AFAF1840B19B558
X-7FA49CB5: 0D63561A33F958A51D9747CDE293397B5A9479FE45FCA0B5E844D5FBAB1AA0928941B15DA834481FA18204E546F3947CEDCF5861DED71B2F389733CBF5DBD5E9C8A9BA7A39EFB7666BA297DBC24807EA117882F44604297287769387670735209ECD01F8117BC8BEA471835C12D1D977C4224003CC8364767815B9869FA544D8D32BA5DBAC0009BE9E8FC8737B5C2249A5DF9383870C0FED3AA81AA40904B5D9CF19DD082D7633A0E7DDDDC251EA7DABD81D268191BDAD3D78DA827A17800CE767C209D01CC1E34BCD04E86FAF290E2D40A5AABA2AD3711975ECD9A6C639B01B78DA827A17800CE7F06569D524CC8C6E1AF90B32DC82ED8375ECD9A6C639B01B4E70A05D1297E1BBC6867C52282FAC85D9B7C4F32B44FF57D4B828FA1BC0F1ACBD9CCCA9EDD067B1EDA766A37F9254B7
X-Mailru-Sender: 3EA917A0E6524472E50B252446CEFEA4B0EC02683C73388D6A5F215C230C99FAA34552F20D351597FD27B1545737DED76F53C80213D1719CB3360D9C94DE366A1CC4A9B39F20364B73395D515EC5B64AAE208404248635DF
X-Mras: OK
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 06, 2018 at 09:31:36AM +0900, Junio C Hamano wrote:

> >> It would be great if git-log has a formatting option to insert an
> >> index of the current commit since HEAD.
> >> 
> >> It would allow after quitting the git-log to immediately fire up "git
> >> rebase -i HEAD~index" instead of "git rebase -i
> >> go-copy-paste-this-long-number-id".
> >
> > This may have little sense in a general case as the history maintained
> > by Git is a graph, not a single line. Hence your prospective approach
> > would only work for cases like `git log` called with the
> > "--first-parent" command-line option.
> 
> I do not see why the "name each rev relative to HEAD" formatting
> option cannot produce HEAD^2~2 etc.
> 
> It would be similar to "git log | git name-rev --stdin" but I do not
> offhand recall if we had a way to tell name-rev to use only HEAD as
> the anchoring point.

My reading was that the OP explicitly wanted to just glance at a single
integer number and use it right away in a subsequent rebase command.

I mean, use one's own short memory instead of copying and pasting.

The way I decided to format the reference in my sketch script — using
HEAD~<n> — is just a byproduct of the fact I was aware both of the
"gitrevisions" manual page and the fact `git name-rev` exists (though I
regretfully was not aware it's able to process a stream of `git log`).

Hence while getting fancy names for revisions would be technically
correct but less error-prone for retyping from memory ;-)

