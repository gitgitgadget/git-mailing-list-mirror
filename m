Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A193AC433E0
	for <git@archiver.kernel.org>; Mon, 21 Dec 2020 21:03:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5928F20897
	for <git@archiver.kernel.org>; Mon, 21 Dec 2020 21:03:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725908AbgLUVDn convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Mon, 21 Dec 2020 16:03:43 -0500
Received: from elephants.elehost.com ([216.66.27.132]:60355 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725780AbgLUVDn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Dec 2020 16:03:43 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [173.33.197.34])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id 0BLL2x7k021413
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 21 Dec 2020 16:03:00 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Felipe Contreras'" <felipe.contreras@gmail.com>,
        "'Junio C Hamano'" <gitster@pobox.com>
Cc:     <git@vger.kernel.org>
References: <002001d6d7bd$d03d7e10$70b87a30$@nexbridge.com> <xmqqeejjm2ek.fsf@gitster.c.googlers.com> <003e01d6d7ce$ccc648f0$6652dad0$@nexbridge.com> <5fe108752910_f93820887@natae.notmuch>
In-Reply-To: <5fe108752910_f93820887@natae.notmuch>
Subject: RE: [BUG] git-2.30.0-rc1 - Transitive OpenLDAP requirement in libcurl
Date:   Mon, 21 Dec 2020 16:02:53 -0500
Message-ID: <004601d6d7dc$a99af4d0$fcd0de70$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQIwVeHqb+URxytNBq/tRiP96V2evAOu4pNCAzRoxM8C2wGU26kBGfJQ
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On December 21, 2020 3:41 PM, Felipe Contreras wrote:
> To: Randall S. Becker <rsbecker@nexbridge.com>; 'Junio C Hamano'
> <gitster@pobox.com>
> Cc: git@vger.kernel.org
> Subject: RE: [BUG] git-2.30.0-rc1 - Transitive OpenLDAP requirement in
> libcurl
> 
> Randall S. Becker wrote:
> > git is the only product my group builds that uses libcurl. There is a
> > less functional version of libcurl that comes with the operating
> > system that we ignore. We are not linking with that version. The
> > version of curl we have, we built but not since 2.29.2.
> > So  I'm confused.
> 
> Could be: b990f02fd8 (config.mak.uname: remove unused
> NEEDS_SSL_WITH_CURL flag, 2020-11-11)
> 
> It seems it was attempting to only remove NEEDS_SSL_WITH_CURL, which
> indeed wasn't used anymore, but it also removed:

I wondered about this one. I have rolled this back, with no positive effect. The 2.30.0-rc1 build works fine on the x86 platform (currently under test) but not on the Itanium (older) so I'm not suspecting this issue.

>   #NO_CURL = YesPlease

We have been building with Curl for years, so probably not this.

> I've no idea about these systems, but a quick search makes me wonder if
> perhaps this was not intended.

Is there some detection going on about OpenLDAP?

