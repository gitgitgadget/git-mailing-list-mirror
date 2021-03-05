Return-Path: <SRS0=rdad=ID=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1299C433DB
	for <git@archiver.kernel.org>; Fri,  5 Mar 2021 23:46:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8AE34650A2
	for <git@archiver.kernel.org>; Fri,  5 Mar 2021 23:46:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230169AbhCEXpp convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Fri, 5 Mar 2021 18:45:45 -0500
Received: from elephants.elehost.com ([216.66.27.132]:58495 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229801AbhCEXpk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Mar 2021 18:45:40 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [173.33.197.34])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id 125NjWNf091450
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 5 Mar 2021 18:45:32 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'brian m. carlson'" <sandals@crustytoothpaste.net>,
        "'Soni L.'" <fakedme+git@gmail.com>
Cc:     <git@vger.kernel.org>
References: <355bb5d1-f661-4ac2-d536-d1c56ec5e408@gmail.com> <YEKmVWHJchUhxZmn@camp.crustytoothpaste.net> <537258e7-fcf4-814c-c7c1-95c8d525f34a@gmail.com> <YEKpoiy//SR5Nt3q@camp.crustytoothpaste.net>
In-Reply-To: <YEKpoiy//SR5Nt3q@camp.crustytoothpaste.net>
Subject: RE: Cross-signing commits
Date:   Fri, 5 Mar 2021 18:45:26 -0500
Message-ID: <022c01d71219$a18eed60$e4acc820$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQIdRUljHpZqVc8XYhalO0v2UtRMpgHh+YuLAXD+a1wCZy5KRqm71fqg
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On March 5, 2021 4:59 PM, brian m. carlson wrote:
> On 2021-03-05 at 21:53:14, Soni L. wrote:
> > On 2021-03-05 6:44 p.m., brian m. carlson wrote:
> > > Can you explain what you mean by "cross-signing"?  Are you proposing
> > > a situation where two parties sign the same commit?
> >
> > Yep. See, the repos enforce signing, but they can also be forks. If
> > someone wants to track upstream in one of their branches they just
> > can't. Would be cool if they could just say they trust the commits by
> > signing the relevant commits with their own key instead - on the
> > assumption that they actually reviewed said commits.
> 
> Git doesn't natively support having multiple signatures in a commit, although
> it is of course possible to do, since OpenPGP supports it.
> However, as you noted, changing the signature changes the object ID, so if
> you re-sign a commit for any reason, that changes the commit ID.
> There isn't any way around this at all; that's just how it works.
> 
> So you can either re-sign or have an unchanged commit ID, but not both at
> the same time.
> 
> You can use additional empty signed commits or signed tags, or you can use
> some sort of external system that keeps track of additional signatures or
> approvals if you want.

If your workflow requires multiple signatures on the same commit, you have options:

1. Use signed tags. So you can put multiple OpenPGP signed tags on a commit, representing each person's individual sign-off. Tags would be my preference as they show up explicitly in the git log --decorate output. Of course you will need a naming standard for this class of tags.
2. Create empty child commits with the desired commit as parent, and each person can sign their own commit - not really a great idea as history gets messy and potentially confusing.

Regards,
Randall

-- Brief whoami:
NonStop developer since approximately 211288444200000000
UNIX developer since approximately 421664400
-- In my real life, I talk too much.



