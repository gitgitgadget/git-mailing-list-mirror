From: "Frawley, Sarah" <sarah.frawley@intel.com>
Subject: RE: FW: Query on git submodules
Date: Tue, 2 Jun 2015 14:22:55 +0000
Message-ID: <4C328B7D13677A4EAF715D0755A6D7EE25C60153@irsmsx110.ger.corp.intel.com>
References: <4C328B7D13677A4EAF715D0755A6D7EE25C56C89@irsmsx110.ger.corp.intel.com>
 <4C328B7D13677A4EAF715D0755A6D7EE25C589BF@irsmsx110.ger.corp.intel.com>
 <20150526170125.GC31115@book.hvoigt.net>
 <4C328B7D13677A4EAF715D0755A6D7EE25C5AD9E@irsmsx110.ger.corp.intel.com>
 <20150602111219.GA7442@book.hvoigt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Tue Jun 02 16:23:11 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yzn5r-0000NS-TO
	for gcvg-git-2@plane.gmane.org; Tue, 02 Jun 2015 16:23:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759032AbbFBOXA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 2 Jun 2015 10:23:00 -0400
Received: from mga01.intel.com ([192.55.52.88]:43272 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758948AbbFBOW6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 2 Jun 2015 10:22:58 -0400
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP; 02 Jun 2015 07:22:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.13,540,1427785200"; 
   d="scan'208";a="703961573"
Received: from irsmsx101.ger.corp.intel.com ([163.33.3.153])
  by orsmga001.jf.intel.com with ESMTP; 02 Jun 2015 07:22:56 -0700
Received: from irsmsx110.ger.corp.intel.com ([169.254.15.124]) by
 IRSMSX101.ger.corp.intel.com ([169.254.1.217]) with mapi id 14.03.0224.002;
 Tue, 2 Jun 2015 15:22:56 +0100
Thread-Topic: FW: Query on git submodules
Thread-Index: AdCSSWETsB/dvpOtTAu+b+O2ywQWlACTA2hAAM3yN4AAK8NYgAAA4TKwASc0fIAABcbmwA==
In-Reply-To: <20150602111219.GA7442@book.hvoigt.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [163.33.239.180]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270541>

Thanks for getting back to me Heiko

To comment on the below.  Adding some automated way of setting a relati=
ve path via git submodule add would be really useful.
Is this something that is possible in a new git release?

As regards using the command below.
git submodule update --init --recursive
We use this already however it just refreshes any submodule changes tha=
t have been pushed to git. =20
What I am looking for is a way to re-align submodule tags to new tags a=
cross a large hierarchy.

See example below.  It show a simple submodule hierarchy.  You can see =
that the 'c_block' occurs underneath both the 'e' and the 'd' blocks an=
d they are both set to the same tag (tag_1).  If I decide to create a n=
ew tag for 'c_block' called tag_2 in order for both d_block and e_block=
 to pick it up I will need to make a update to both blocks where I chec=
k out the tag_2 for 'd/e_blocks' and commit, push and tag and make anot=
her change to 'a_block' so that it checks out the new tags for 'c_block=
','d_block' and 'e_block'.  This all happens manually in my team curren=
tly.  Sometimes there is a need to roll out the same change to all repo=
s and for the hierarchy to be up rev'd to the latest tag for every subm=
odule so a script for this case would be useful.  It would be nice to b=
e able to have a script read in a list of tags for update across the hi=
erarchy.

a_block   ->  c_block (tag_1)    ->   d_block(tag_4)    =20

                     d_block (tag_4)     ->  c_block(tag_1)   =20

	       e_block (tag_8)      -> d_block(tag_4)    =20
                                                          c_block(tag_1=
)   =20

Commandline use to update e_block to pick up new tag for c_block:
cd e_block/submodules/c_block
git checkout tag_2
cd ../..
git commit
git push
git tag



git submodule update --init --recursive


Thanks,
Sarah Frawley
Quark DA

To raise a DA help ticket please file using the url below: https://hsde=
s.intel.com/home/default.html#article?&subject=3Dsupport&tenant=3Dquark

-----Original Message-----
=46rom: Heiko Voigt [mailto:hvoigt@hvoigt.net]=20
Sent: Tuesday, June 2, 2015 12:12 PM
To: Frawley, Sarah
Cc: git@vger.kernel.org
Subject: Re: FW: Query on git submodules

On Wed, May 27, 2015 at 01:20:11PM +0000, Frawley, Sarah wrote:
> Thanks Heiko for getting back to me.
>=20
> Correct when I referred to 10+ layers I meant nested repositories=20
> which make up a large hierarchy.=A0 Some repositories are repeated=20
> across the hierarchy.=A0 We check-out submodules to tag versions (as=20
> opposed to master branch).=A0 If we need to roll out a particular cha=
nge=20
> across a hierarchy (e.g. 60 repos) then every level in the hierarchy=20
> needs to pick up new submodule tags.
>=20
> The main 2 issues that we see are:
>=20
> 1. Enforcement of absolute paths in git submodules - I am currently=20
> trialing using a pre-commit hook to highlight this issue to users so=20
> that they can fix their submodule urls to relative paths.

So you mean, enforcement of relative paths. Right? It might be a good i=
dea to put some code in 'git submodule add' that would automatically us=
e a relative path instead of absolute path if it can calculate one from=
 the superproject. I think that would help your users even more as they=
 do not get an error from the pre-commit hook, but just having everythi=
ng right after doing the add.

If you want to go that route it should not be that much different from =
the hook, since the submodule subcommand code is all bash.

> 2. Slowness Integrating updates to submodule hierarchy -I have been=20
> looking at ways of automating such a roll out - this can be useful fo=
r=20
> new project setups or for rolling out an update to all repos and=20
> quickly integrating it into the submodule hierarchy.=A0 The link belo=
w=20
> shows something similar however it checks out a master branch of each=
=20
> submodule in its hierarchy.
> https://chrisjean.com/recursively-updating-git-submodules/

How about

	git submodule update --init --recursive

? That should do the same as the script written in that blog post. Or a=
m I missing something?

Cheers Heiko
-------------------------------------------------------------
Intel Ireland Limited (Branch)
Collinstown Industrial Park, Leixlip, County Kildare, Ireland
Registered Number: E902934

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.
