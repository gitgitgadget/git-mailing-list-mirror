From: =?utf-8?b?w5h5c3RlaW4=?= Walle <oystwa@gmail.com>
Subject: Re: [PATCH v3] stash: handle specifying stashes with spaces
Date: Wed, 8 Jan 2014 00:03:54 +0000 (UTC)
Message-ID: <loom.20140108T003945-67@post.gmane.org>
References: <1389082935-16159-1-git-send-email-oystwa@gmail.com> <xmqq7gabeiqo.fsf@gitster.dls.corp.google.com> <87ob3nphc5.fsf@thomasrast.ch> <xmqqiotvbf4g.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 08 01:04:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W0gdL-0005aW-Gc
	for gcvg-git-2@plane.gmane.org; Wed, 08 Jan 2014 01:04:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754105AbaAHAE2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 7 Jan 2014 19:04:28 -0500
Received: from plane.gmane.org ([80.91.229.3]:58714 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752310AbaAHAE0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jan 2014 19:04:26 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1W0gdD-0005AG-Tm
	for git@vger.kernel.org; Wed, 08 Jan 2014 01:04:23 +0100
Received: from 80.156.189.109.customer.cdi.no ([109.189.156.80])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 08 Jan 2014 01:04:23 +0100
Received: from oystwa by 80.156.189.109.customer.cdi.no with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 08 Jan 2014 01:04:23 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 109.189.156.80 (Mozilla/5.0 (Windows NT 6.1; WOW64; rv:26.0) Gecko/20100101 Firefox/26.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240188>

Junio C Hamano <gitster <at> pobox.com> writes:

>=20
> Thomas Rast <tr <at> thomasrast.ch> writes:
>=20
> > Junio C Hamano <gitster <at> pobox.com> writes:
> >
> >>
> >> This is brittle.  If new tests are added before this, the test_tic=
k
> >> will give you different timestamp and this test will start failing=
=2E
> >>
> >> Perhaps grab the timestamp out of the stash that was created [...]
> >
> > Hmm, now that I stare at this, why not simply use something like
> >
> >   git stash apply "stash <at> { 0 }"
> >
> > It seems to refer to the same as stash <at> {0} as one would expect=
, while
> > still triggering the bug with unpatched git-stash.
>=20
> Yeah, that is fine as well.  For the record, here is what I
> tentatively queued.
>=20

I completely agree that it's brittle. I mentioned it when I submitted v=
1
but at the time it didn't occur to me that new tests might be added
before it. And of course I agree with your proposed changes to the test=
=2E
I must say I like Thomas' solution because of its simplicity and the
whole test could be made much shorter: just create stash and try to pop
it.

But it's seems the spaces trigger some other way of interpreting the
selector. In my git.git, git rev-parse HEAD{0} gives me the same result
as HEAD@{ 0 } but HEAD@{1} and HEAD@{ 1 } are different. Is this
intentional? If not, can this impact the reliability of the test if we
use HEAD@{ 0 } ?

Thanks for queuing!

Regards,
=C3=98sse
