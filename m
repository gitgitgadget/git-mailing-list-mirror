From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] diff: add a config option to control orderfile
Date: Tue, 17 Sep 2013 19:42:26 +0300
Message-ID: <20130917164226.GB20672@redhat.com>
References: <20130831194425.GA14706@redhat.com>
 <xmqqioyhu8wd.fsf@gitster.dls.corp.google.com>
 <20130903210815.GB24480@redhat.com>
 <20130915074900.GA30438@redhat.com>
 <20130915080830.GA30465@redhat.com>
 <xmqq8uyv1kka.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 17 18:41:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VLyL9-0000Lp-Q7
	for gcvg-git-2@plane.gmane.org; Tue, 17 Sep 2013 18:41:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753456Ab3IQQlX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Sep 2013 12:41:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:15175 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753404Ab3IQQlS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Sep 2013 12:41:18 -0400
Received: from int-mx01.intmail.prod.int.phx2.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r8HGeEdk022246
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Tue, 17 Sep 2013 12:40:17 -0400
Received: from redhat.com ([10.35.213.190])
	by int-mx01.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with SMTP id r8HGeC3R030540;
	Tue, 17 Sep 2013 12:40:13 -0400
Content-Disposition: inline
In-Reply-To: <xmqq8uyv1kka.fsf@gitster.dls.corp.google.com>
X-Scanned-By: MIMEDefang 2.67 on 10.5.11.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234886>

On Tue, Sep 17, 2013 at 09:26:13AM -0700, Junio C Hamano wrote:
> "Michael S. Tsirkin" <mst@redhat.com> writes:
> 
> > Actually, after I've looked at the code,
> > diffcore_order is already already called for patch-id.
> 
> That was a band-aid for an ill-thought-out orderfile misfeature to
> hide the breakage.  You somehow make sure that you pass the same
> orderfile to diff generating machinery used internal to patch-id
> generation.  The standalone "git patch-id" would be reading the
> patch in the order you give it when you are feeding a patch somebody
> sent you via the mailing list using an order unknown to you, no?

Yes but that's already the case, right?
People don't have to use git to generate patches.

So might it not be useful to tweak patch id to
sort the diff, making it a bit more stable?
This means it needs to pass twice over the file, but is this
a huge issue?
pass 1 - get offsets of chunks and sort them
pass 2 - seek each chunk and hash

what do you think?

> Before making it _easier_ to use the orderfile to generate diffs, we
> would need to prepare the parts that will be broken by wider use of
> the feature.

I'll be glad to help do this if you tell me what these parts are.
anything else besides fixing besides the stand-alone patch id?

-- 
MST
