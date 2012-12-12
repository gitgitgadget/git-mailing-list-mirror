From: Tomas Carnecky <tomas.carnecky@gmail.com>
Subject: Re: Python extension commands in git - request for policy change
Date: Wed, 12 Dec 2012 02:22:59 +0000
Message-ID: <1355278979-ner-1662@calvin>
References: <20121125024451.1ADD14065F@snark.thyrsus.com>
	<CAMP44s18MzmWRNRiRjL6hvpK1cm=S-97fB2ep-_0RAhnfs5cvA@mail.gmail.com>
	<50B1F684.5020805@alum.mit.edu>
	<CACsJy8BgOpWdxgCfwBwZ=abAEDr+sbj3hnmKY2EYCFeBPRUT7w@mail.gmail.com>
	<CACh33FrGPhaeNzZ2Tj5OxScecOPN13idw8TwU8Mf6o0KsAOB9A@mail.gmail.com>
	<CAMK1S_hy8U0rVY=-u-QCqXjhn-6jwz5ofj_q_mbokVn8CGCMtw@mail.gmail.com>
	<1355273635-ner-4863@calvin>
	<CACsJy8A9h4QJ_iWvQqTtYa4NPH6Q1Gy0NTozbgukC3=ep58mLA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Sitaram Chamarty <sitaramc@gmail.com>,
	Patrick Donnelly <batrick@batbytes.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	"Eric S. Raymond" <esr@thyrsus.com>, git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 12 04:31:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tid2q-0008JW-7N
	for gcvg-git-2@plane.gmane.org; Wed, 12 Dec 2012 04:31:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754261Ab2LLDbX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Dec 2012 22:31:23 -0500
Received: from mail-wg0-f44.google.com ([74.125.82.44]:59724 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754143Ab2LLDbX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Dec 2012 22:31:23 -0500
Received: by mail-wg0-f44.google.com with SMTP id dr12so72254wgb.23
        for <git@vger.kernel.org>; Tue, 11 Dec 2012 19:31:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:subject:to:cc:references:in-reply-to:mime-version:date
         :message-id:content-type;
        bh=dEe6NAUvqJFEfjGz/Tz7iLIHsYVaNBlmORJ2ZfdjFW8=;
        b=HMfy1jfhR6SwhmDNhRKRo+blLVX8xB8z9op1mYCVf/lQ0Df3p0Bq5kVl/4gRE4g/uO
         dPuOdJCIouDZnCgRB2JTuSqjRPIvYh+hbZXa4TVsWImHMkRgBk0eLamjOEMC+qtfQQm3
         ndQLk42SIlGurzlN4GwGWZW4VVF0rEn4H/Ocv9o70in7qEc4duAXsMBAcgRDsNDoV0z5
         USgW/m0oR+BQc7+oLR/u+/8AMQ7t6gNMtnvm9J/e2UJ+v+euD+ZxTC1lEsbB2O/bfd2S
         NsRF4oRdzimcchC/y3I59IcAVDrLAuFQpnMW9QEXqalhWUcTulD+MWNArMBRKHcY6Pm1
         RkVg==
Received: by 10.194.21.70 with SMTP id t6mr223226wje.42.1355278999596;
        Tue, 11 Dec 2012 18:23:19 -0800 (PST)
Received: from calvin.caurea.org (pub082136067238.dh-hfc.datazug.ch. [82.136.67.238])
        by mx.google.com with ESMTPS id g2sm19060030wiy.0.2012.12.11.18.23.10
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 11 Dec 2012 18:23:18 -0800 (PST)
Received: by calvin.caurea.org (Postfix, from userid 3301)
	id 8AE75113518; Wed, 12 Dec 2012 02:22:59 +0000 (UTC)
In-Reply-To: <CACsJy8A9h4QJ_iWvQqTtYa4NPH6Q1Gy0NTozbgukC3=ep58mLA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211325>

On Wed, 12 Dec 2012 08:50:27 +0700, Nguyen Thai Ngoc Duy <pclouds@gmail.com> wrote:
> On Wed, Dec 12, 2012 at 7:53 AM, Tomas Carnecky
> <tomas.carnecky@gmail.com> wrote:
> > If it doesn't, it would be trivial to add. It's a one-liner. It's been a while
> > since I used Lua, but it would be something like this:
> >
> >     void L_putenv(lua_State *L) {
> >         putenv(lua_tostring(L, 1));
> >     }
> >
> > and then somewhere during setup:
> >
> >     lua_register(L, "putenv", L_putenv);
> 
> I should have done my homework before asking, but well.. is there any
> way to automate this? If we use lua for writing "builtin" commands,
> we'll need to export a lot of C functions and writing wrappers like
> this is boring and time consuming. Also, assume I export fn(char*,int)
> to Lua, then I change the prototype to fn(char*, char*), can Lua spot
> all the call sites at compile time (or something) so I can update
> them?

A Patrick mentioned in an earlier email, there is luaposix which includes lots
of these functions [1]. There may be tools which generate these bindings
automatically, but I'm not aware of any. Likewise, I'm not aware of any static
analyzer which would be required to spot changes in the prototypes (though you
could cover some(most?) of it through tests). The last time I seriously used
Lua and its C bindings was many years ago, so I am not the best person to
answer these questions.

[1]: http://luaposix.github.com/luaposix/docs/index.html
