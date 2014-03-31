From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v3 2/3] patch-id: document new behaviour
Date: Mon, 31 Mar 2014 23:42:05 +0300
Message-ID: <20140331204205.GB12403@redhat.com>
References: <1396202583-2572-1-git-send-email-mst@redhat.com>
 <1396202583-2572-2-git-send-email-mst@redhat.com>
 <xmqqmwg65gp7.fsf@gitster.dls.corp.google.com>
 <20140331192604.GF12208@redhat.com>
 <xmqq7g7a5ek9.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, sunshine@sunshineco.com, jrnieder@gmail.com,
	peff@peff.net
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 31 22:41:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WUj1j-0007ZN-QX
	for gcvg-git-2@plane.gmane.org; Mon, 31 Mar 2014 22:41:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750974AbaCaUlr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Mar 2014 16:41:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49731 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750777AbaCaUlr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Mar 2014 16:41:47 -0400
Received: from int-mx01.intmail.prod.int.phx2.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s2VKfb3B018086
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Mon, 31 Mar 2014 16:41:37 -0400
Received: from redhat.com (vpn1-7-154.ams2.redhat.com [10.36.7.154])
	by int-mx01.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with SMTP id s2VKfZBL001446;
	Mon, 31 Mar 2014 16:41:36 -0400
Content-Disposition: inline
In-Reply-To: <xmqq7g7a5ek9.fsf@gitster.dls.corp.google.com>
X-Scanned-By: MIMEDefang 2.67 on 10.5.11.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245525>

On Mon, Mar 31, 2014 at 12:54:46PM -0700, Junio C Hamano wrote:
> "Michael S. Tsirkin" <mst@redhat.com> writes:
> 
> > The hash used is mostly an internal implementation detail, isn't it?
> 
> Yes, but that does not mean we can break people who keep an external
> database indexed with the patch-id by changing the default under
> them, and "they can give --unstable option to work it around" is a
> workaround, not a fix.  Without this change, they did not have to do
> anything.
> 
> I would imagine that most of these people will be using the plain
> vanilla "git show" output without any ordering or hunk splitting
> when coming up with such a key.  A possible way forward to allow the
> configuration that corresponds to "-O<orderfile>" while not breaking
> the existing users could be to make the "patch-id --stable" kick in
> automatically (of course, do this only when the user did not give
> the "--unstable" command line option to override) when we see the
> orderfile configuration in the repository, or when we see that the
> incoming patch looks like reordered (e.g. has multiple "diff --git"
> header lines that refer to the same path,

This would require us to track affected files in memory.
Issue?

> or the set of files
> mentioned by the "diff --git" lines are not in ascending order),
> perhaps?

I hope a patch-id configuration flag plus maybe checking the orderfile if not
specified together should be good enough.

-- 
MST
