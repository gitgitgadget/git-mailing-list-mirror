Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 11F4E1F453
	for <e@80x24.org>; Thu,  1 Nov 2018 14:56:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728611AbeKBAAC convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Thu, 1 Nov 2018 20:00:02 -0400
Received: from elephants.elehost.com ([216.66.27.132]:25197 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728264AbeKBAAC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Nov 2018 20:00:02 -0400
X-Greylist: delayed 1450 seconds by postgrey-1.27 at vger.kernel.org; Thu, 01 Nov 2018 20:00:01 EDT
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id wA1EW7lS004104
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 1 Nov 2018 10:32:07 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Christian Couder'" <christian.couder@gmail.com>,
        <nicolas.mailhot@laposte.net>
Cc:     "'git'" <git@vger.kernel.org>
References: <6d8ef01ad9eb08d90cb9848eeaeabe6784b7b3e3.camel@laposte.net> <87zhutjb3t.fsf@evledraar.gmail.com> <6f3d8c49e1d44ab20d4169e5254364cba707f1af.camel@laposte.net> <CAP8UFD1rTJNOZzFMryY9BNKHUZKE8FUEgw+4jFfnZ7G8KGNrkw@mail.gmail.com>
In-Reply-To: <CAP8UFD1rTJNOZzFMryY9BNKHUZKE8FUEgw+4jFfnZ7G8KGNrkw@mail.gmail.com>
Subject: RE: [RFE] Please add name and email to git credentials
Date:   Thu, 1 Nov 2018 10:32:00 -0400
Message-ID: <001601d471ef$a9ccf110$fd66d330$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQD3LANWA+v6knt34NSBD34IzH3tCQGMOeTrAf9b3T4Cl8zdk6bEatnA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On November 1, 2018 10:13 AM, Christian Couder wrote:
> Sent: > To: nicolas.mailhot@laposte.net
> Cc: git <git@vger.kernel.org>
> Subject: Re: [RFE] Please add name and email to git credentials
> 
> On Thu, Nov 1, 2018 at 2:31 PM Nicolas Mailhot
> <nicolas.mailhot@laposte.net> wrote:
> >
> > Le jeudi 01 novembre 2018 à 12:22 +0100, Ævar Arnfjörð Bjarmason a
> > écrit :
> > >
> > > Where would we get an E-Mail to lookup to pass to the helper? Are
> > > you just asking that the helper git the result of $(git config
> > > user.name && git config user.email)? If so why can't it just look
> > > this up itself?
> >
> > So, just in case it was not clear enough, allow things in .gitconfig
> > like
> >
> > [credential "https://pkgs.fedoraproject.org/"]
> > username = doe4ever
> > name = John Doe
> > email = doe4ever@fedoraproject.org
> > [credential "https://gitlab.corp.com/"] username = jdoe56874 name =
> > John Doe, Snr Engineer email = john.doe@corp.com
> >
> > Instead of just
> >
> > [user]
> > name = John Doe
> > email =  john.doe@corp.com
> > [credential "https://pkgs.fedoraproject.org/"]
> > username = doe4ever
> > [credential "https://gitlab.corp.com/"] username = jdoe56874
> >
> > and drat, I've commited to XXX with the wrong name/email again
> 
> How can Git know when you commit where you will want to push the
> commit afterwards?
> 
> What if you want to push the same commit to 2 different places that need
> different credentials?

Agree. You are asking git to change history depending on where pushes are done. Applying a legacy VCS paradigm here? Git has a global view of history. It must be the same everywhere, so if you push to two different places, the history must be the same, because those two places may in turn push to another shared repo. Then who is the authority?

What I have managed to do is to associated name and email with config --local so that it binds to the clone and overrides your --global setting. I can have different identities based on what clone I am working on, but once history is created, that's it. If I push from one clone to another, the identity of the clone where I did my first commit is what the second clone sees.

Hope this helps.
Randall

-- Brief whoami:
 NonStop developer since approximately 211288444200000000
 UNIX developer since approximately 421664400
-- In my real life, I talk too much.



