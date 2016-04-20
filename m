From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 2/2] xdiff: implement empty line chunk heuristic
Date: Wed, 20 Apr 2016 16:12:08 +0300
Message-ID: <20160420161028-mutt-send-email-mst@redhat.com>
References: <1461013950-12503-1-git-send-email-sbeller@google.com>
 <1461013950-12503-3-git-send-email-sbeller@google.com>
 <20160419050342.GA19439@sigill.intra.peff.net>
 <CAGZ79kbzg7SmJHFpxeJNKmLaEEw+irCxUedo45jGx8G8fmPtKg@mail.gmail.com>
 <20160419170624.GA3999@sigill.intra.peff.net>
 <CA+P7+xp60r6Tsv0_=Qy6Wo39MmXMbCba7g5goPQD-e8FNaaEjw@mail.gmail.com>
 <xmqqoa95xknc.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jacob Keller <jacob.keller@gmail.com>, Jeff King <peff@peff.net>,
	Stefan Beller <sbeller@google.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Jacob Keller <jacob.e.keller@intel.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 20 15:12:17 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1asrvU-0004U2-Ef
	for gcvg-git-2@plane.gmane.org; Wed, 20 Apr 2016 15:12:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753959AbcDTNMM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Apr 2016 09:12:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36577 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753358AbcDTNML (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Apr 2016 09:12:11 -0400
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id F406D811A7;
	Wed, 20 Apr 2016 13:12:10 +0000 (UTC)
Received: from redhat.com (vpn1-7-239.ams2.redhat.com [10.36.7.239])
	by int-mx11.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with SMTP id u3KDC8SP027623;
	Wed, 20 Apr 2016 09:12:09 -0400
Content-Disposition: inline
In-Reply-To: <xmqqoa95xknc.fsf@gitster.mtv.corp.google.com>
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.24
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292009>

On Tue, Apr 19, 2016 at 04:07:35PM -0700, Junio C Hamano wrote:
> Jacob Keller <jacob.keller@gmail.com> writes:
> 
> > On Tue, Apr 19, 2016 at 10:06 AM, Jeff King <peff@peff.net> wrote:
> >> On Tue, Apr 19, 2016 at 08:17:38AM -0700, Stefan Beller wrote:
> >>
> >>> On Mon, Apr 18, 2016 at 10:03 PM, Jeff King <peff@peff.net> wrote:
> >>>
> >>> > I guess this will invalidate old patch-ids, but there's not much to be
> >>> > done about that.
> >>>
> >>> What do you mean by that? (What consequences do you imagine?)
> >>> I think diffs with any kind of heuristic can still be applied, no?
> >>
> >> I mean that if you save any old patch-ids from "git patch-id", they
> >> won't match up when compared with new versions of git. We can probably
> >> ignore it, though. This isn't the first time that patch-ids might have
> >> changed, and I think the advice is already that one should not count on
> >> them to be stable in the long term.
> >>
> >> -Peff
> >
> > Plus they'll be stable within a version of Git, it's only recorded
> > patch ids that change, which hopefully isn't done very much if at all.
> >
> > Thanks,
> > Jake
> 
> Some people, like those who did things like 30e12b92 (patch-id: make
> it stable against hunk reordering, 2014-04-27), _may_ care.
> 

FWIW IIRC what that commit is about is ability to reorder the chunks in
a patch without changing patch-id. Not about keeping id stable across
git revisions.

-- 
MST
