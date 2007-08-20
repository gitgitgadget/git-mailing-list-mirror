From: Junio C Hamano <gitster@pobox.com>
Subject: Re: How to do a reverse rebase?
Date: Sun, 19 Aug 2007 23:33:29 -0700
Message-ID: <7vr6ly90li.fsf@gitster.siamese.dyndns.org>
References: <20070820053237.9349.qmail@science.horizon.com>
	<20070820055809.GZ27913@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux@horizon.com, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Aug 20 08:33:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IN0pY-0002op-A4
	for gcvg-git@gmane.org; Mon, 20 Aug 2007 08:33:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751316AbXHTGdh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 20 Aug 2007 02:33:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751314AbXHTGdh
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Aug 2007 02:33:37 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:54174 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751286AbXHTGdg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Aug 2007 02:33:36 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 844AD12488B;
	Mon, 20 Aug 2007 02:33:53 -0400 (EDT)
In-Reply-To: <20070820055809.GZ27913@spearce.org> (Shawn O. Pearce's message
	of "Mon, 20 Aug 2007 01:58:09 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56178>

"Shawn O. Pearce" <spearce@spearce.org> writes:

>> Is there an easier way?
>
> I don't think so.  To do the merge of those files we need a working
> directory to operate in; that working directory is the one you have.

Actually, if the rebase is really tine compared to the
differences between the branches, we _could_ do that without
using the real work tree.

Prepare a "for rebase" index, with an empty temporary directory
as the work tree, and use the merge machinery to do the
necessary per-path and contents merge all inside that temporary
directory.  As the merge machiery is designed to be usable
inside an empty directory and treat "missing" work tree files as
if they are unchanged since index, the checkout in this
temporary directory would be kept to the minimum.
