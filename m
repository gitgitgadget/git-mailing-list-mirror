From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 8/8] reflog_expire(): lock symbolic refs themselves, not
 their referent
Date: Fri, 13 Feb 2015 17:26:04 +0100
Message-ID: <54DE259C.4030001@alum.mit.edu>
References: <1423473164-6011-1-git-send-email-mhagger@alum.mit.edu>	<1423473164-6011-9-git-send-email-mhagger@alum.mit.edu>	<CAGZ79kaBGAOt-R1=mSG5H-5p=2UWjZEesktVwQcDAWFC-OW2Eg@mail.gmail.com>	<xmqq61b8t65x.fsf@gitster.dls.corp.google.com>	<CAGZ79kaaQWRXhph=0g3SRHKXMoW8eAp7QG21yuWXWd7OW4M+uA@mail.gmail.com>	<54DCDA42.2060800@alum.mit.edu> <CAGZ79kZgjRNS3zd4Tif6M66mjkP6-tDpy4FAtio8jiwqHxUtgw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu40=?= =?UTF-8?B?Yw==?= 
	<pclouds@gmail.com>, "git@vger.kernel.org" <git@vger.kernel.org>,
	=?UTF-8?B?Q2FybG9zIE1hcnTDrW4gTmlldG8=?= <cmn@elego.de>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri Feb 13 17:33:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YMJB6-0003xC-SH
	for gcvg-git-2@plane.gmane.org; Fri, 13 Feb 2015 17:33:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753544AbbBMQdM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 13 Feb 2015 11:33:12 -0500
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:59309 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752490AbbBMQdL (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 13 Feb 2015 11:33:11 -0500
X-Greylist: delayed 422 seconds by postgrey-1.27 at vger.kernel.org; Fri, 13 Feb 2015 11:33:11 EST
X-AuditID: 1207440f-f792a6d000001284-e3-54de259f9191
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id 3C.63.04740.F952ED45; Fri, 13 Feb 2015 11:26:07 -0500 (EST)
Received: from [192.168.69.130] (p5DDB38B4.dip0.t-ipconnect.de [93.219.56.180])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t1DGQ44T017567
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Fri, 13 Feb 2015 11:26:06 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.4.0
In-Reply-To: <CAGZ79kZgjRNS3zd4Tif6M66mjkP6-tDpy4FAtio8jiwqHxUtgw@mail.gmail.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrPKsWRmVeSWpSXmKPExsUixO6iqDtf9V6Iwa/dGhbTu1azWHRd6Way
	aOi9wmzx9uYSRovuKW8ZLXr7PrFabN7czuLA7nFp3Usmj52z7rJ7LNhU6nHxkrLH501yAaxR
	3DZJiSVlwZnpefp2CdwZM669ZS54Jlmx7p5tA+ME0S5GTg4JAROJ/hUTmCBsMYkL99azdTFy
	cQgJXGaUmN87hQnCOc8k0dg3lR2kildAW+Lm5pPMIDaLgKrE7ov/wWw2AV2JRT3NYJNEBYIk
	Dp1+zAJRLyhxcuYTMFtEQE1i5qrZYBuYBe4wSVz+PgtsqLBArMTPOw9ZIbbNZJa4u/IoI0iC
	UyBQ4v6sBjYQm1lAXeLPvEvMELa8RPPW2cwTGAVmIVkyC0nZLCRlCxiZVzHKJeaU5urmJmbm
	FKcm6xYnJ+blpRbpmujlZpbopaaUbmKEBD7/Dsau9TKHGAU4GJV4eF/43Q0RYk0sK67MPcQo
	ycGkJMprKH8vRIgvKT+lMiOxOCO+qDQntfgQowQHs5IIb8QNoHLelMTKqtSifJiUNAeLkjiv
	+hJ1PyGB9MSS1OzU1ILUIpisDAeHkgRvvQrQUMGi1PTUirTMnBKENBMHJ8hwLimR4tS8lNSi
	xNKSjHhQtMYXA+MVJMUDtLcPpJ23uCAxFygK0XqKUVFKnLcZJCEAksgozYMbC0tnrxjFgb4U
	5p0HUsUDTIVw3a+ABjMBDZ444zbI4JJEhJRUAyObUc7K2aVptVvvhWzb2bLvM3dB1o9nm397
	r95mcSwozfTZp6jvyWdXW86pshPvez3X26F2boKqubH/0e6XP2I01OritdVD7Ewv 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263811>

On 02/12/2015 07:04 PM, Stefan Beller wrote:
> On Thu, Feb 12, 2015 at 8:52 AM, Michael Haggerty <mhagger@alum.mit.e=
du> wrote:
>> However, another important question is whether other Git implementat=
ions
>> have copied this unusual locking policy. If so, that would be a reas=
on
>> not to change it. I just pinged the libgit2 maintainer to find out t=
heir
>> policy. Maybe you could find out about JGit?
>=20
> I could not really find reflog expiration for jgit for a while, but
> then I stumbled upon this:
>=20
>     // TODO: implement reflog_expire(pm, repo);
>=20
> so I think it's safe to change it in git.git for now.

Stefan: This locking policy doesn't only affect "reflog expire"; we als=
o
need to lock the reflog when we add a new entry to it, for example when
updating refs/heads/master through HEAD. Do you know what JGit locks in
that scenario?


I had a discussion in IRC [1] with Carlos Mart=C3=ADn Nieto about how l=
ibgit2
handles this:

* When libgit2 updates a reference through a symref, it locks the
pointed-to reference while updating the reflog for the symbolic ref. So=
,
for example, "git commit" would hold refs/heads/master.lock while
updating both logs/refs/heads/master and logs/HEAD. (This matches the
current Git behavior.)
* libgit2 doesn't support "reflog expire", though it does have an API
that allows users to overwrite the reflog with a specified list of
entries. That API locks the reference itself; i.e., HEAD.lock. This
disagrees with Git's current behavior.

I also realized that Git's current policy is probably not tenable if on=
e
process is re-seating a symref at the same time as another process is
expiring its reflog. The "git reflog expire HEAD" might grab
"refs/heads/master.lock" then start rewriting "logs/HEAD". Meanwhile,
"git checkout foo" would grab "HEAD.lock" (not being blocked by the
"expire" process), then rewrite it to "ref: refs/heads/foo", then grab
"refs/heads/foo.lock" before updating "logs/HEAD". So both processes
could be writing "logs/HEAD" at the same time.

In fact, it's even worse. "git checkout foo" and "git symbolic-ref HEAD
refs/heads/foo" release "HEAD.lock" *before* updating logs/HEAD--in
other words, they append to logs/HEAD without holding *any* lock.

What is the best way forward?

I think the current locking policy is untenable, even aside from the bu=
g
in "symbolic-ref".

Switching to holding only "HEAD.lock" while updating "logs/HEAD" is the
right solution, but it would introduce an incompatibility with old
versions of Git and libgit2 (and maybe JGit?) Probably nobody would
notice, but who knows?

Therefore, I propose that we hold *both* "HEAD.lock" *and*
"refs/heads/master.lock" when modifying "logs/HEAD" (even when running
"reflog expire" or "reflog delete"). I think this will be compatible
with old versions of Git and libgit2, and it will also fix some design
problems mentioned above. Plus, it will prevent updates to the two
reflogs from appearing out of order relative to each other.

Someday, when old clients have been retired, we can optionally switch t=
o
locking *only* "HEAD.lock" when modifying "logs/HEAD".

What do people think?
Michael

[1] https://github.com/libgit2/libgit2/issues/2902

--=20
Michael Haggerty
mhagger@alum.mit.edu
