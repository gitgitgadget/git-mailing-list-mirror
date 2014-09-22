From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH RFC] git-am: support any number of signatures
Date: Mon, 22 Sep 2014 17:01:44 +0300
Message-ID: <20140922140144.GA9769@redhat.com>
References: <1402589505-27632-1-git-send-email-mst@redhat.com>
 <xmqqioo654mg.fsf@gitster.dls.corp.google.com>
 <20140613080036.GA2117@redhat.com>
 <xmqqy4x03ecm.fsf@gitster.dls.corp.google.com>
 <20140615102736.GA11798@redhat.com>
 <xmqqy4wwraoz.fsf@gitster.dls.corp.google.com>
 <20140618030903.GA19593@redhat.com>
 <CAPc5daVTZynCKMubZmreAjBh3i51wPaAA+8vSRwB9dGrrJb6FA@mail.gmail.com>
 <xmqq38f2jed3.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 22 15:58:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XW48N-0002CJ-Db
	for gcvg-git-2@plane.gmane.org; Mon, 22 Sep 2014 15:58:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753572AbaIVN61 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Sep 2014 09:58:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54099 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751070AbaIVN60 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Sep 2014 09:58:26 -0400
Received: from int-mx13.intmail.prod.int.phx2.redhat.com (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s8MDwL7w010165
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 22 Sep 2014 09:58:22 -0400
Received: from redhat.com (ovpn-116-34.ams2.redhat.com [10.36.116.34])
	by int-mx13.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with SMTP id s8MDwJPG013361;
	Mon, 22 Sep 2014 09:58:20 -0400
Content-Disposition: inline
In-Reply-To: <xmqq38f2jed3.fsf@gitster.dls.corp.google.com>
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.26
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257363>

On Wed, Jun 18, 2014 at 10:51:04AM -0700, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
> > On Tue, Jun 17, 2014 at 8:09 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
> >>
> >> OK, after looking into this for a while, I realize
> >> this is a special property of the Signed-off-by footer.
> >> For now I think it's reasonable to just avoid de-duplicating
> >> other footers if any. Agree?
> >
> > Not really. I'd rather see "git am" hardcode as little such policy as possible.
> > We do need to support S-o-b footer and the policy we defined for it long time
> > ago, if only for backward compatiblity, but for any other footers,
> > policy decision
> > such as "dedup by default" isn't something "am" should know about.
> 
> By the way, "append without looking for dups" is a policy decision
> that is as bad to have as "append with dedup".
> 
> I'd rather not to see "am.signoff", or any name that implies what
> the "-s" option to the command is about for that matter, to be used
> in futzing with the trailers other than S-o-b in any way.  As I
> understand it, our longer term goal is to defer that task, including
> the user-programmable policy decisions, to something like the
> 'trailer' Christian started.
> 
> I suspect that it may add unnecessary work later if we overloaded
> "signoff" with a similar feature with the change under discussion.
> I would feel safer to see it outlined how we envision to transition
> to a more generic 'trailer' solution later if we were to enhance
> "am" with "am.signoff" now.
> 
> Thanks.

Hi Junio, Christian,
it's been a while.
I see that the work on trailers is going on.
I tried going over the documentation but I could not figure
out how would one implement multiple signatures using the
trailers mechanism.

As a reminder, this old patchset (that I replied to) enhanced git am -s
with an option to add different signatures depending on
the option passed to the -s flag.
E.g. I have
[am "a"]
        signoff = "Acked-by: Michael S. Tsirkin <mst@redhat.com>"

[am "r"]
        signoff = "Reviewed-by: Michael S. Tsirkin <mst@redhat.com>"

[am "t"]
        signoff = "Tested-by: Michael S. Tsirkin <mst@redhat.com>"

and now:
	git am -s art
adds all 3 signatures when applying the patch.


Any help will be appreciated.

-- 
MST
