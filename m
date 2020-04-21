Return-Path: <SRS0=ToNR=6F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8F36C54FCC
	for <git@archiver.kernel.org>; Tue, 21 Apr 2020 20:44:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AEED92072D
	for <git@archiver.kernel.org>; Tue, 21 Apr 2020 20:44:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726079AbgDUUoN (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Apr 2020 16:44:13 -0400
Received: from elephants.elehost.com ([216.66.27.132]:50894 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725850AbgDUUoN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Apr 2020 16:44:13 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id 03LKi1UG059391
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 21 Apr 2020 16:44:01 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Junio C Hamano'" <gitster@pobox.com>,
        "'Shourya Shukla'" <shouryashukla.oo@gmail.com>
Cc:     <git@vger.kernel.org>, <sandals@crustytoothpaste.net>,
        "'Derrick Stolee'" <dstolee@microsoft.com>,
        "'Elijah Newren'" <newren@gmail.com>,
        "'Christian Couder'" <christian.couder@gmail.com>
References: <20200421131223.29337-1-shouryashukla.oo@gmail.com>        <20200421131223.29337-4-shouryashukla.oo@gmail.com> <xmqqy2qomwwl.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqy2qomwwl.fsf@gitster.c.googlers.com>
Subject: RE: [PATCH v3 3/4] gitfaq: shallow cloning a repository
Date:   Tue, 21 Apr 2020 16:43:55 -0400
Message-ID: <011001d6181d$97301fc0$c5905f40$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHpLdAtq0iMdH6Skp6VrcJJkheEYQHcqM4+Amj3/YOoO7EZMA==
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On April 21, 2020 4:01 PM, Junio C Hamano
> Subject: Re: [PATCH v3 3/4] gitfaq: shallow cloning a repository
> 
> Shourya Shukla <shouryashukla.oo@gmail.com> writes:
> 
> > Add issue in 'Common issue' section which covers issues with cloning
> > large repositories. Use shallow cloning to clone the repository in a
> > smaller size.
> >
> > Signed-off-by: Shourya Shukla <shouryashukla.oo@gmail.com>
> > ---
> >  Documentation/gitfaq.txt | 14 ++++++++++++++
> >  1 file changed, 14 insertions(+)
> >
> > diff --git a/Documentation/gitfaq.txt b/Documentation/gitfaq.txt index
> > 13d37f96af..cea293cf07 100644
> > --- a/Documentation/gitfaq.txt
> > +++ b/Documentation/gitfaq.txt
> > @@ -275,6 +275,20 @@ I want to change the remote of my repository.
> How do I do that?::
> >  One can list the remotes of a repository using `git remote -v` command.
> >  The default name of a remote is 'origin'.
> >
> > +[[shallow-cloning]]
> > +The repository I am trying to clone is too big. Is there an
> > +alternative way of cloning it in lesser space?::
> > +	One can clone a repository having a truncated history, meaning the
> > +	history	will span upto a specified number of commits instead of
> > +	the whole history of the repository. This is called 'Shallow
Cloning'.
> > ...
> 
> The question is worth keeping but the answer is questionable.
> 
> I have a feeling that --depth/shallow is deprecated/frowned upon these
days
> and more people recommend partial/blob-less clones instead (a few random
> people added to Cc: to see if they want to say something here).

I rather hate to chime in as a dissenting opinion, but the --depth/shallow
clone is very useful when git is being used as an artifact repository for
production. The shallow clone allows only the production branch HEAD to be
cloned into production/staging areas and limits the visible history for
staff who do not want to go through a potentially long trail during
time-sensitive operations (a.k.a. production installs). There are also space
and policy constraints in some of these environments where they do not want
to have ongoing visibility to non-production commit paths. When the *stuff*
hits the fan, then it's good to be able to fetch everything (or a limited
set). I would be very disappointed to see --depth frowned upon.

Regards,
Randall

-- Brief whoami:
 NonStop developer since approximately 211288444200000000
 UNIX developer since approximately 421664400
-- In my real life, I talk too much.



