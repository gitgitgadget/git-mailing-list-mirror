Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 05EE21F97E
	for <e@80x24.org>; Sat, 24 Nov 2018 15:41:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726576AbeKYCaY (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Nov 2018 21:30:24 -0500
Received: from smtp33.i.mail.ru ([94.100.177.93]:51880 "EHLO smtp33.i.mail.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726012AbeKYCaY (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Nov 2018 21:30:24 -0500
X-Greylist: delayed 2659 seconds by postgrey-1.27 at vger.kernel.org; Sat, 24 Nov 2018 21:30:23 EST
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bswap.ru; s=mailru;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=Z+cOxUVZ3/I+mR5rbc8l6zYDd/dqeeL4ioj6qPJIKYI=;
        b=Sds1Ao3V8TIPTdy+HUN3MHG3ihuQ0sh4mLe70+ASxRiHrO32l1c0QSPa7ycxmiQBrDFOSimiGB84u+vEPXlcch/sYHJvnKfcuaXrqIWQKGiKI3o2Z7WSbgYwslTyZ9+iEjMt4GUaFsqrO3+Veo8N5rw7wXniiUDrUn3oIYZH9NA=;
Received: by smtp33.i.mail.ru with esmtpa (envelope-from <kostix@bswap.ru>)
        id 1gQa3w-0007D5-7L; Sat, 24 Nov 2018 18:41:40 +0300
Date:   Sat, 24 Nov 2018 18:41:32 +0300
From:   Konstantin Khomoutov <kostix@bswap.ru>
To:     David Mandelberg <david@mandelberg.org>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: git overwriting local ignored files?
Message-ID: <20181124154132.co3lo27wy25i4v47@tigra>
References: <a852c0e9-f278-8e2a-406c-bb6099b2440c@mandelberg.org>
 <xmqqftvr2jfo.fsf@gitster-ct.c.googlers.com>
 <7ac49733-2e62-7d29-36aa-99df4124b54c@mandelberg.org>
 <20181124145723.ow2h7x374xwwts6m@tigra>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181124145723.ow2h7x374xwwts6m@tigra>
User-Agent: NeoMutt/20170306 (1.8.0)
Authentication-Results: smtp33.i.mail.ru; auth=pass smtp.auth=kostix@bswap.ru smtp.mailfrom=kostix@bswap.ru
X-77F55803: BBE463BEF7A60BD05A78504BD2AC2941D12ABC1A1C441679C2DC38F13416281B6E544C18732E306C9E89CFA67B870A42
X-7FA49CB5: 0D63561A33F958A5FC3290FBC7B3CDB67B84118D6B58E1D9D990D3CA09F4F00B8941B15DA834481FA18204E546F3947CDB8A315C1FF4794D117882F4460429724CE54428C33FAD30A8DF7F3B2552694A4A5EC4583E1CDF108941B15DA834481F8AA50765F7900637D9CFB327BC390E24389733CBF5DBD5E9B5C8C57E37DE458B4DA2F55E57A558BE7B076A6E789B0E975F5C1EE8F4F765FC4AFB60FD1831C04CD81D268191BDAD3DBD4B6F7A4D31EC0B7815B9869FA544D8090A508E0FED6299176DF2183F8FC7C03DBBCB839D0549ACB3661434B16C20ACE7DDDDC251EA7DABAAAE862A0553A39223F8577A6DFFEA7C99C6C109AFC5FF6B7A09B21C7EA17E0AEFF80C71ABB335746BA297DBC24807EA27F269C8F02392CDC58410348177836EABEDDA51113D120200306258E7E6ABB4E4A6367B16DE6309
X-Mailru-Sender: 3EA917A0E6524472E50B252446CEFEA4F177821D5642B2189E600EE742C9FB713F17294BC1AFE60DFD27B1545737DED76F53C80213D1719CB3360D9C94DE366A1CC4A9B39F20364B73395D515EC5B64AAE208404248635DF
X-Mras: OK
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Nov 24, 2018 at 05:57:24PM +0300, Konstantin Khomoutov wrote:
> On Sat, Nov 24, 2018 at 09:37:06AM -0500, David Mandelberg wrote:
> 
> > > > It seems that git is overwriting my local files on merge if they're in
> > > > .gitignore.
> [...]
> > > The .gitignore file is to list "ignored and expendable" class of
> > > files; there is no "ignored but precious class" in Git.
> > Ok. Would a patch be welcome? I have three ideas for how to implement it,
> > and I'm not sure which is better.
> [...]
> 
> You might want to first investigate this recent thread [1] which AFAIK
> was dedicated to exactly this problem.

Well, actually the thread is old, but its continuation [2] is recent.
The crux is that it discusses certain approaches to solve the apparent
problem and patches to do that.

1. https://public-inbox.org/git/4C6A1C5B.4030304@workspacewhiz.com/
2. https://public-inbox.org/git/871s8qdzph.fsf@evledraar.gmail.com/

