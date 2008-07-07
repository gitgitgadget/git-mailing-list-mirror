From: Don Zickus <dzickus@redhat.com>
Subject: Re: [PATCH] git-mailinfo may corrupt patch headers on attached
	files
Date: Mon, 7 Jul 2008 09:39:45 -0400
Message-ID: <20080707133945.GB23190@redhat.com>
References: <alpine.LFD.1.10.0807061036500.3016@woody.linux-foundation.org> <1215379261-10802-1-git-send-email-dzickus@redhat.com> <7v1w269sp9.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, torvalds@linux-foundation.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 07 15:41:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KFqxj-0004vx-G6
	for gcvg-git-2@gmane.org; Mon, 07 Jul 2008 15:41:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752666AbYGGNkF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jul 2008 09:40:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751714AbYGGNkF
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Jul 2008 09:40:05 -0400
Received: from mx1.redhat.com ([66.187.233.31]:58997 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751885AbYGGNkE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jul 2008 09:40:04 -0400
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id m67DdlDQ009177;
	Mon, 7 Jul 2008 09:39:47 -0400
Received: from mail.boston.redhat.com (mail.boston.redhat.com [10.16.255.12])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id m67DdkgO021015;
	Mon, 7 Jul 2008 09:39:46 -0400
Received: from drseuss.usersys.redhat.com (dhcp-100-19-202.bos.redhat.com [10.16.19.202])
	by mail.boston.redhat.com (8.13.1/8.13.1) with ESMTP id m67DdkLN024965;
	Mon, 7 Jul 2008 09:39:46 -0400
Received: from drseuss.usersys.redhat.com (localhost.localdomain [127.0.0.1])
	by drseuss.usersys.redhat.com (8.14.2/8.14.1) with ESMTP id m67DdkPd023375;
	Mon, 7 Jul 2008 09:39:46 -0400
Received: (from dzickus@localhost)
	by drseuss.usersys.redhat.com (8.14.2/8.14.2/Submit) id m67Ddjfh023374;
	Mon, 7 Jul 2008 09:39:45 -0400
X-Authentication-Warning: drseuss.usersys.redhat.com: dzickus set sender to dzickus@redhat.com using -f
Content-Disposition: inline
In-Reply-To: <7v1w269sp9.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Scanned-By: MIMEDefang 2.58 on 172.16.52.254
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87605>

On Sun, Jul 06, 2008 at 10:19:46PM -0700, Junio C Hamano wrote:
> The point you inserted strlen() above, however, is one of the places that
> line[] has patch text and can have NUL in it, so strlen() there would
> break the earlier fix.
> 
> Here is the minimum replacement patch, still not handling embedded NULs
> anywhere in the structural part of the message, that should work.  Sane
> MUAs should quote embedded NULs in the original contents with QP or BASE64
> to protect them from handle_boundary() and other functions, and after
> decoding, these embedded NULs will be kept by decode_transfer_encoding(),
> so I think this would work Ok in practice.
> 
> I tested this with both Linus's test message and it does not break t5100.

Good thing for test cases. :-)  Thanks for the explanation.

ACK

Cheers,
Don
