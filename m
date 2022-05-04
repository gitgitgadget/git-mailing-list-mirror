Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EA8DC433EF
	for <git@archiver.kernel.org>; Wed,  4 May 2022 15:47:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352727AbiEDPvU (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 May 2022 11:51:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352759AbiEDPvS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 May 2022 11:51:18 -0400
Received: from mout.web.de (mout.web.de [212.227.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BED245AD9
        for <git@vger.kernel.org>; Wed,  4 May 2022 08:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1651679259;
        bh=Uea28kwGxWzSbe8Pi+czl7FMMVhNr/K5X7Y16sXKzYs=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=MwCW7mC5FEAl+USvO79rlUyfOfK3PoGdOcI7pS56dUTFjka+0JouVLbSdGeFTBcLV
         ecGbU9xD2C/HqtqKLONFStJJ/8iVsVSrE9d/o505bpkIvMNDNMWe+pau4f1iM/STVJ
         PHx8HG4p72BF8TNrTXp8h/VvAsGlYUn0N9zgvQh8=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from localhost ([62.20.115.19]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MeDMb-1oM9f00pyp-00bDtW; Wed, 04
 May 2022 17:42:29 +0200
Date:   Wed, 4 May 2022 17:42:28 +0200
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     "Mirochnik, Oleg V" <oleg.v.mirochnik@intel.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: git reset --hard can leave modified files
Message-ID: <20220504154228.wxk6scaqtzri5w42@tb-raspi4>
References: <CY5PR11MB6089858FD6FCC971D6F216DDC6FC9@CY5PR11MB6089.namprd11.prod.outlook.com>
 <20220430044940.6botq23lxmpqxbel@tb-raspi4>
 <CY5PR11MB608914F7E815A8EF95441BB1C6C19@CY5PR11MB6089.namprd11.prod.outlook.com>
 <20220502192634.bzjfvoda2wjjxs3i@tb-raspi4>
 <CY5PR11MB608955D3020A85983471A260C6C19@CY5PR11MB6089.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY5PR11MB608955D3020A85983471A260C6C19@CY5PR11MB6089.namprd11.prod.outlook.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:iJu8w2B1+3gsq+r2U0zA2wr9jj4/ivaMOlV10Q3ongnvaNq5m+p
 kOEQJhy45FoTSpZq9qyC3v2Cr2YYenOFjn8gPHcZ0HeWLHeXjwD29BJn/nJ50pmswfqJNDP
 19dTliWad9kmPflyf9W9z7mDMfIeWttqsaiX/3vkJpLE6IVz6rkWDhwJYXqT56xCruAHyO7
 lY7W52C9WdrbzL6767VTA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Vd6mEIAPZyo=:de8lUE4yW+4ji+asDIdXzd
 7MfpE3kS6hZnY4DHoNQApxv79rwztQTEOmNb1RlZdDGejcqKqsv1DPzxVnDYeOsi5YioZWs9P
 SP4pUWsCDQ6fp7Dccu9pK6v6ekj9Otf10lddc4qEHvasEJy7v+KvLdEah2BLW3E31ww9Rgp4S
 Wh4Weg1jfR+Yrrqk8sanxBHIJDGqrCs0m31Qi98viDYtYoTg8THl3tHV7nJlQhPRw8UEuY3xT
 hHR6jF2+tdpEEDbzlI1W08Umku6kF36l9XiNhbwg5U42iagwcVoae630S/8+/Vnp9HZDxj2zz
 Jiok917CJ4vqXvGAQ4be7A1YPb5hmt1WFPMpHS7vGEpq2TJRUhGWAQOqo1dP8HIIqsn6myFAU
 cJhw96Rq6CYB6H3WmkeUWTMJ+wvXIZQ1wawX9/DvU5rH8FB83NeVXyLvZGAfy/SwKn0cOUViE
 y5ipkpzmOM9GNwrGYc7bIriKS4OJyQgSu6GfzoA7DbVB7PIrvEx82FRr5zt8fUrixXA6SMpDt
 Ya3GfhJ1mhz7ptzIsXlJf2DThXwSnygM4fQ2YN395PNxCLOBi0hJ877RWgAxGJ2KUR5jBN3d/
 cPR2XG+WvFqwzfo12igABtd+8w9MZcffLy7tBJckb7tgWZ02Ty7ClS8C4hIansRWkSoDXFHLw
 XexbIa0ofeP/QQDCIaR/wEPCZFhLVMZjzfyzf9tbx+KNKAtBnIBpZB66BiECdjzWTISAbnmFT
 5NNHslLoMrYvz3tXunY5XudmM88GmEh0vj9HEPB57GZMS7w8TaMJFJINgjWs0ONjbKHmjYA4A
 U/uhbYmh2dDi3ZOTRhHA34uaXaS31LxKK7Pa6JUP1LHB9CDx1pqh8Gh34OgL7RDrtoMbGtqA5
 MXgKmp212m0kF61WitvTdukjSJ1e/+Jk5o50XMzme1QJX74YkZkXloJD39yeulAT/3+5qUuW+
 +b577er4lqk2J5W6NdaQl4SCZVjIiMj1CJKYT/mOYybASgly7zVCQxQ1ONeuq65OFiGh6Jm/4
 sXxnrUlX1RJczMkZM8i5o23k0shm8WCUsrdweHhOXGp2ImNT17GDlgLh31b+7aCRAudlZ+rmu
 CKDSOw5wks7vuI=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 02, 2022 at 10:07:11PM +0000, Mirochnik, Oleg V wrote:
[]
> >
> > In other words
> > (I may be wrong due a lack of time to dig deeper into the llvm repo) t=
he problem
> > seems to come from upstream.
> >
> > And we could find out, what upstream really wants and needs, and may b=
e able
> > to help here.
> >
> > Is this maybe something you can do, contact upstream ?
> No, I could not as I'm not a llvm contributor.
You can become one ;-)

> Here is another related discussion, hopefully could be useful -- https:/=
/reviews.llvm.org/D48494
>
> Actually, I don't quite understand what your suggestions are.
>
> Are you telling it's not a git bug but an invalid setup in the llvm-proj=
ect repo?
Yes

> If so, then I'd suggest you (or git community) provide a clear descripti=
on
> (or link to a related document) what needs to be done to make it valid
> and I'd ask one of our contributors to propose a correspondent fix into =
the upstream.
> Or you agree it's a bug.
> Then I'd ask to propose your recommendations as a temporary (or permanen=
t) workaround.
>
> Could you please clarify?

Now, the documentation, which I think you ask for, is here:
https://git-scm.com/docs/gitattributes

If I look at the repo, commit 4ff40855fcc0c1320f31350bc9e93d4d6ce6891f
(HEAD -> git-bug-reproducer, origin/git-bug-reproducer)

and run the official eol-diagnostic tool:
$ git ls-files --eol >eol-prob.txt
and then
$ grep "^i/crlf.*attr/text" eol-prob.txt
I get 9 files listed, so I pick the first one for a discussion:

i/crlf  w/crlf  attr/text eol=3Dcrlf      clang-tools-extra/test/clang-app=
ly-replacements/Inputs/crlf/crlf.cpp

What we have in the repo is a "conflict".
The attributes says it is a text file, and the index file (what had been c=
ommited)
has CRLF.
Git can not resolve the conflict.
(setting text=3Dauto could work. Or normalize. Or both. Normalization is r=
ecomended anyway)

So, the solution would be to renormalize all files:

$ git add --renormalize .
(The . is important)

After that you will see those 9 files modified, and they need to be commit=
ed.

In general, for a cross-platform project, it could be useful to set up a
.gitattributes file in the top directory, with one line:
* text=3Dauto

That file can then be tweaked for BAT or sh files as needed.

That should all be in the documentation - if not, please ask and/or send u=
s
patches.







