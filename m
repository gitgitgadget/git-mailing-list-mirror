Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F1D6C433DB
	for <git@archiver.kernel.org>; Mon, 21 Dec 2020 22:46:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 601A122573
	for <git@archiver.kernel.org>; Mon, 21 Dec 2020 22:46:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726048AbgLUWqV convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Mon, 21 Dec 2020 17:46:21 -0500
Received: from elephants.elehost.com ([216.66.27.132]:27253 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725844AbgLUWqV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Dec 2020 17:46:21 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [173.33.197.34])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id 0BLMjbHj027691
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 21 Dec 2020 17:45:37 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Felipe Contreras'" <felipe.contreras@gmail.com>,
        "'Junio C Hamano'" <gitster@pobox.com>
Cc:     <git@vger.kernel.org>
Subject: RE: [NOT BUG] git-2.30.0-rc1 - Transitive OpenLDAP requirement in libcurl
Date:   Mon, 21 Dec 2020 17:45:31 -0500
Message-ID: <004701d6d7ea$ffd61e70$ff825b50$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AdbX6nYgai7wEAOeRK25Cpbx6mjGVQ==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On December 21, 2020 4:03 PM, I wrote:
> To: 'Felipe Contreras' <felipe.contreras@gmail.com>; 'Junio C Hamano'
> <gitster@pobox.com>
> Cc: 'git@vger.kernel.org' <git@vger.kernel.org>
> Subject: RE: [BUG] git-2.30.0-rc1 - Transitive OpenLDAP requirement in
> libcurl
> 
> On December 21, 2020 3:41 PM, Felipe Contreras wrote:
> > To: Randall S. Becker <rsbecker@nexbridge.com>; 'Junio C Hamano'
> > <gitster@pobox.com>
> > Cc: git@vger.kernel.org
> > Subject: RE: [BUG] git-2.30.0-rc1 - Transitive OpenLDAP requirement in
> > libcurl
> >
> > Randall S. Becker wrote:
> > > git is the only product my group builds that uses libcurl. There is
> > > a less functional version of libcurl that comes with the operating
> > > system that we ignore. We are not linking with that version. The
> > > version of curl we have, we built but not since 2.29.2.
> > > So  I'm confused.
> >
> > Could be: b990f02fd8 (config.mak.uname: remove unused
> > NEEDS_SSL_WITH_CURL flag, 2020-11-11)
> >
> > It seems it was attempting to only remove NEEDS_SSL_WITH_CURL, which
> > indeed wasn't used anymore, but it also removed:
> 
> I wondered about this one. I have rolled this back, with no positive effect.
> The 2.30.0-rc1 build works fine on the x86 platform (currently under test) but
> not on the Itanium (older) so I'm not suspecting this issue.
> 
> >   #NO_CURL = YesPlease
> 
> We have been building with Curl for years, so probably not this.
> 
> > I've no idea about these systems, but a quick search makes me wonder
> > if perhaps this was not intended.
> 
> Is there some detection going on about OpenLDAP?

Well, looks like this probably an operator issue. I tried the build in a clean environment (our official Jenkins build environment) and 2.30.0-rc1 builds and is currently in testing on both NonStop platforms. Something is likely messed up in my clone. There's nothing in the environment that is weird. So it's obviously something I did, but I don't really know what (maybe git reset --hard master && git clean -dxf is not a sufficient reset).

Moving forward,
Randall

