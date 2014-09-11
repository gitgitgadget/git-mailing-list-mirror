From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 6/6] Make sure that index-pack --strict fails upon
 invalid tag objects
Date: Thu, 11 Sep 2014 19:04:25 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.1409111903280.990@s15462909.onlinehome-server.info>
References: <alpine.DEB.1.00.1408171840040.990@s15462909.onlinehome-server.info> <cover.1410356761.git.johannes.schindelin@gmx.de> <alpine.DEB.1.00.1409101553140.990@s15462909.onlinehome-server.info> <xmqqoaunf8fv.fsf@gitster.dls.corp.google.com>
 <alpine.DEB.1.00.1409111620420.990@s15462909.onlinehome-server.info> <xmqqa966f6eg.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 11 19:04:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XS7nN-0001DJ-S9
	for gcvg-git-2@plane.gmane.org; Thu, 11 Sep 2014 19:04:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753419AbaIKRE3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Sep 2014 13:04:29 -0400
Received: from mout.gmx.net ([212.227.15.18]:59983 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753185AbaIKRE2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Sep 2014 13:04:28 -0400
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx001) with ESMTPSA (Nemesis) id 0LdHeL-1Y9kHg2sef-00iTMZ;
 Thu, 11 Sep 2014 19:04:25 +0200
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <xmqqa966f6eg.fsf@gitster.dls.corp.google.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:df0O89R9CVS05YSo2MmUYgwfV+VG2Z4pp+nQD0SNUlAoIQNDh1C
 dsm48vu6xXwigx7u8gFol/ZarwDdMub4XyB4VerCb4DB8huJI3IzPKF34aiJjHZzPmYKsrw
 UEuT22VU/MhmT5L31P5XCpAw6a9unJHYDhgZ6Fuo+l0n/nejKBu5gcsrT7ehDGcGfGo5rQp
 vxvP7iIEmeHniEmOmOLKg==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256853>

Hi Junio,

On Thu, 11 Sep 2014, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > On Wed, 10 Sep 2014, Junio C Hamano wrote:
> >
> >> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> >> 
> >> > +    tag=$(git hash-object -t tag -w --stdin <wrong-tag) &&
> >> > +    pack1=$(echo $tag | git pack-objects tag-test) &&
> >> > +    echo remove tag object &&
> >> > +    thirtyeight=${tag#??} &&
> >> > +    rm -f .git/objects/${tag%$thirtyeight}/$thirtyeight &&
> >> > +    test_must_fail git index-pack --strict tag-test-${pack1}.pack 2> err &&
> >> 
> >> I had to drop "must fail" from this one (will amend the "SQUASH???"
> >> again).
> >
> > Funny. It failed here, but for the wrong reason: index-pack --strict
> > failed here because the object referenced by the tag object was not in the
> > pack.
> 
> That is strange.  It failed with the version you sent to the list
> for me for a different reason---it tried to verify the ident that
> did not exist in the tested object (which we fixed in the squash).

Hmm. It is very well possible that I ran the tests in the middle of a
rebase, i.e. without my changes to t5302. Will pay more attention next
time, sorry!

Ciao,
Dscho
