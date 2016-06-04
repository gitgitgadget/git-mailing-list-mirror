From: Mike Hommey <mh@glandium.org>
Subject: Re: What's cooking in git.git (Jun 2016, #01; Thu, 2)
Date: Sun, 5 Jun 2016 06:46:18 +0900
Message-ID: <20160604214618.GA21629@glandium.org>
References: <xmqq4m9aqn4d.fsf@gitster.mtv.corp.google.com>
 <20160603232653.GA24538@glandium.org>
 <xmqqvb1pzvfu.fsf@gitster.mtv.corp.google.com>
 <20160604051458.GA3149@glandium.org>
 <1e3801ae-742f-61c4-2b72-350ada0b2220@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Torsten =?iso-8859-15?Q?B=F6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Sat Jun 04 23:46:38 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b9JOw-0001oi-Bq
	for gcvg-git-2@plane.gmane.org; Sat, 04 Jun 2016 23:46:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751175AbcFDVqd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 4 Jun 2016 17:46:33 -0400
Received: from ns332406.ip-37-187-123.eu ([37.187.123.207]:41264 "EHLO
	glandium.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751102AbcFDVqc (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Jun 2016 17:46:32 -0400
Received: from glandium by zenigata with local (Exim 4.87)
	(envelope-from <mh@glandium.org>)
	id 1b9JOc-0005lu-S3; Sun, 05 Jun 2016 06:46:18 +0900
Content-Disposition: inline
In-Reply-To: <1e3801ae-742f-61c4-2b72-350ada0b2220@web.de>
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
User-Agent: Mutt/1.6.0 (2016-04-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296449>

On Sat, Jun 04, 2016 at 04:51:28PM +0200, Torsten B=F6gershausen wrote:
> On 2016-06-04 07.14, Mike Hommey wrote:
> > On Fri, Jun 03, 2016 at 04:47:33PM -0700, Junio C Hamano wrote:
> >> Mike Hommey <mh@glandium.org> writes:
> >>
> >>> In fact, the parser doesn't even reject the one that is considere=
d
> >>> invalid (the first).
> >>
> >> My question was what the desired behaviour is, and if your "fix"
> >> gives us that desired outcome.
> >=20
> > From my POV, the desired outcome from this patch series is that the=
re is
> > no change of behavior, and Torsten's fix makes
> > git://[example.com:123]:/path/to/repo urls handled the same before =
and
> > after the patch series.
> >=20
> > Whether that's the desired behavior is another topic, that we can,
> > IMHO, leave for later.
> This is the old behavior:
>=20
>  GIT_TRACE=3D2  git clone -v git://[github.com:9418]:/tboegi/emacs.d.=
git $$
> 16:32:28.692918 git.c:350               trace: built-in: git 'clone' =
'-v'
> 'git://[github.com:9418]:/tboegi/emacs.d.git' '95214'
> Cloning into '95214'...
> Looking up github.com:9418 ... fatal: Unable to look up github.com:94=
18 (port
> 9418) (nodename nor servname provided, or not known)
> # Everything inside [] goes into the host part (good),
> # At the same time :9418 is printed as the port (weird)
>=20
> This is the new behavior:
> GIT_TRACE=3D2  git clone -v git://[github.com:9418]:/tboegi/emacs.d.g=
it $$
> Connecting to github.com (port 9418) ... 192.30.252.122 done.
> or
> GIT_TRACE=3D2  git clone -v git://[github.com:9418]/tboegi/emacs.d.gi=
t $$
> Connecting to github.com (port 9418) ... 192.30.252.122 done.

That is the new behavior without your patch. With your patch, it
becomes:
06:44:39.646833 git.c:350               trace: built-in: git 'clone'
'-v' 'git://[github.com:9418]:/tboegi/emacs.d.git' '13644'
Cloning into '13644'...
Looking up github.com:9418 ... fatal: Unable to look up github.com:9418
(port 9418) (Name or service not known)

IOW, no change from the current behavior.

Mike
