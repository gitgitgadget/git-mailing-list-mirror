From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: push not resolving commit-ish?
Date: Fri, 24 May 2013 00:26:50 +0300
Message-ID: <20130523212650.GF31421@redhat.com>
References: <20130523105310.GA17361@redhat.com>
 <7v8v35fu7n.fsf@alter.siamese.dyndns.org>
 <20130523210920.GB31421@redhat.com>
 <7v38tde6mr.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 23 23:26:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ufd1v-0005j5-CY
	for gcvg-git-2@plane.gmane.org; Thu, 23 May 2013 23:26:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759195Ab3EWV0b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 May 2013 17:26:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:1090 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758136Ab3EWV0a (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 May 2013 17:26:30 -0400
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r4NLQSD7003172
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Thu, 23 May 2013 17:26:28 -0400
Received: from redhat.com (vpn-202-161.tlv.redhat.com [10.35.202.161])
	by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with SMTP id r4NLQQXL025024;
	Thu, 23 May 2013 17:26:27 -0400
Content-Disposition: inline
In-Reply-To: <7v38tde6mr.fsf@alter.siamese.dyndns.org>
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.23
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225300>

On Thu, May 23, 2013 at 02:19:40PM -0700, Junio C Hamano wrote:
> "Michael S. Tsirkin" <mst@redhat.com> writes:
> 
> > On Thu, May 23, 2013 at 11:05:00AM -0700, Junio C Hamano wrote:
> >> "Michael S. Tsirkin" <mst@redhat.com> writes:
> >> 
> >> > Looks like push can't resolve tags to commits.
> >> > Why is that?
> >> 
> >> How else would you push a tag out?
> >
> > Well my reaction is, it seems to figure out it needs a commit and then
> > instead of just getting it, it errors out.  Why not just DWIM?
> 
> Ahh, that one.
> 
> The local branch name hierarchy refs/heads/ is special in that you
> cannot have a tag sitting at the tip, so when "push" decides to
> update something under refs/heads/ on the receiving end, it may not
> be a bad idea to peel it to a commit (and fail if it does not)
> before creating a pack and telling the other end what the value of
> the updated tip should be, and I do not think it will hurt anybody.

Yes, that would help my case.

> 
> Restriction in the other direction (i.e. "if push does not go to
> refs/tags/, unconditionally unwrap") is a no-no, though.
