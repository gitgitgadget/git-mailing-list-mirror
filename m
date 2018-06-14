Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 235B71F403
	for <e@80x24.org>; Thu, 14 Jun 2018 20:46:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755453AbeFNUqb convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Thu, 14 Jun 2018 16:46:31 -0400
Received: from elephants.elehost.com ([216.66.27.132]:27195 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755349AbeFNUqa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jun 2018 16:46:30 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from pangea (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id w5EKkGHQ031675
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 14 Jun 2018 16:46:16 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Jeff King'" <peff@peff.net>,
        "'brian m. carlson'" <sandals@crustytoothpaste.net>,
        "'Christian Halstrick'" <christian.halstrick@gmail.com>,
        "'Git'" <git@vger.kernel.org>
References: <CAENte7iUYcLX1ym1rdiYT2L8yLSWforf8kUvfHKLvhi_GhKQvg@mail.gmail.com> <20180614101342.GO38834@genre.crustytoothpaste.net> <20180614151507.GA6933@sigill.intra.peff.net>
In-Reply-To: <20180614151507.GA6933@sigill.intra.peff.net>
Subject: RE: OAuth2 support in git?
Date:   Thu, 14 Jun 2018 16:46:10 -0400
Message-ID: <003c01d40420$bd522990$37f67cb0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIkj/ykVSFwsNVy+Us5o5/ASRODFQGHqpEYAmkgJgejn5pSIA==
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On June 14, 2018 11:15 AM, Jeff King wrote:
> On Thu, Jun 14, 2018 at 10:13:42AM +0000, brian m. carlson wrote:
> 
> > > I know that other git server environments like github support that
> > > on client side by allowing tokens to be used as usernames in a BASIC
> > > authentication flow. We could do the same but I am asking whether
> > > there is also a way to transport tokens in a standard conform
> > > "Authorization: Bearer ..." Header field.
> >
> > There isn't any support for Bearer authentication in Git.  For HTTP,
> > we use libcurl, which doesn't provide this natively.  While it could
> > in theory be added, it would require some reworking of the auth code.
> >
> > You are, of course, welcome to send a patch.
> 
> If it's just a custom Authorization header, we should be able to support it
> with existing curl versions without _too_ much effort.
> 
> I think there are probably two possible directions:
> 
>  1. add a special "bearer" command line option, etc, as a string
> 
>  2. add a boolean option to send the existing "password" field as a
>     "bearer" header
> 
> I suspect (2) would fit in with the existing code better, as the special case
> would mostly be limited to the manner in which we feed the credential to
> curl. And you could probably just set a config option for "this url's auth will
> be oauth2", and use the existing mechanisms for providing the password.
> 
> We'd maybe also want to allow credential helpers to say "by the way, this
> password should be treated as a bearer token", for cases where you might
> sometimes use oauth2 and sometimes a real password.

Be aware that there are 4 (ish) flavours of OAuth2 the last time I checked. It is important to know which one (or all) to implement. The embedded form is probably the easiest to comprehend - and the least implemented from my research. More common OAuth2 instances use a third-man website to hold session keys and authorization. That may be problematic for a whole bunch of us who do not play in that world.

Cheers,
Randall

-- Brief whoami:
  NonStop developer since approximately NonStop(211288444200000000)
  UNIX developer since approximately 421664400
-- In my real life, I talk too much.



