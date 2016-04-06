From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: git interpret-trailers with multiple keys
Date: Wed, 6 Apr 2016 22:30:22 +0300
Message-ID: <20160406212940-mutt-send-email-mst@redhat.com>
References: <20160406191054-mutt-send-email-mst@redhat.com>
 <vpqlh4qbrnt.fsf@anie.imag.fr>
 <20160406201509-mutt-send-email-mst@redhat.com>
 <xmqq1t6iy6p9.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 06 21:30:47 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1antA6-0007FB-GK
	for gcvg-git-2@plane.gmane.org; Wed, 06 Apr 2016 21:30:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753183AbcDFTaa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Apr 2016 15:30:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39178 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752267AbcDFTa1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Apr 2016 15:30:27 -0400
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0E9F4C049D5A;
	Wed,  6 Apr 2016 19:30:26 +0000 (UTC)
Received: from redhat.com (vpn1-7-7.ams2.redhat.com [10.36.7.7])
	by int-mx11.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with SMTP id u36JUN3o016749;
	Wed, 6 Apr 2016 15:30:24 -0400
Content-Disposition: inline
In-Reply-To: <xmqq1t6iy6p9.fsf@gitster.mtv.corp.google.com>
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.24
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290864>

On Wed, Apr 06, 2016 at 10:42:42AM -0700, Junio C Hamano wrote:
> "Michael S. Tsirkin" <mst@redhat.com> writes:
> 
> > On Wed, Apr 06, 2016 at 06:58:30PM +0200, Matthieu Moy wrote:
> >> "Michael S. Tsirkin" <mst@redhat.com> writes:
> >> 
> >> > I have this in .git/config
> >> >
> >> > [trailer "r"]
> >> >         key = Reviewed-by
> >> >         command = "echo \"Michael S. Tsirkin <mst@redhat.com\""
> >> > [trailer "s"]
> >> >         key = Signed-off-by
> >> >         command = "echo \"Michael S. Tsirkin <mst@redhat.com\""
> >> >
> >> > whenever I run git interpret-trailers -t r I see these lines added:
> >> >
> >> > Reviewed-by: Michael S. Tsirkin <mst@redhat.com
> >> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com
> >> > Reviewed-by: Michael S. Tsirkin <mst@redhat.com
> >> >
> >> > Why is Reviewed-by repeated?  Bug or feature?
> >> 
> >> The first two lines are added unconditionally:
> >> 
> >> $ echo | git interpret-trailers 
> >> 
> >> Reviewed-by: Michael S. Tsirkin <mst@redhat.com
> >> Signed-off-by: Michael S. Tsirkin <mst@redhat.com
> >> 
> >> The last line is added because you've asked for it with --trailer r.
> >> 
> >> I don't think it's currently possible to get the behavior you seem to
> >> expect, ie. to define trailer tokens fully (key and value) in your
> >> config file but use them only on request.
> >> 
> >> (BTW, I think you wanted a closing > at the end)
> >
> > Is this worth fixing? It doesn't look like a behaviour anyone
> > would want...
> 
> CC'ing Christian who's done the "trailers" thing.
> 
> Personally, I do not think adding any configured trailers without
> being asked is a sensible behaviour, but it is likely that people
> already depend on it, as we seem to see "How do I configure to
> always add this and that trailer?" from time to time.  I do not
> think it is unreasonable to disable the "automatically add
> everything that is configured" when the command line arguments ask
> for some specific trailer, but I haven't thought deeply about it.
> 
> An additional (uninformed) observation is that the 'echo' looks like
> an ugly workaround for the lack of "always use this string as the
> value" configuration.

Or at least a default.

> Perhaps next to trailer.<token>.command, we
> would need trailer.<token>.value?


-- 
MST
