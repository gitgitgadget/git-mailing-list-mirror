From: Bill Lear <rael@zopyra.com>
Subject: Re: Error "fatal: cannot pread pack file: Success"
Date: Wed, 28 Feb 2007 10:12:50 -0600
Message-ID: <17893.43522.511785.121778@lisa.zopyra.com>
References: <17892.64236.443170.43061@lisa.zopyra.com>
	<20070228035713.GC5597@spearce.org>
	<20070228044719.GA6068@spearce.org>
	<17893.40847.313519.283218@lisa.zopyra.com>
	<17893.42063.186763.291346@lisa.zopyra.com>
	<20070228155412.GC5479@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Feb 28 17:13:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMRQM-0000bZ-PH
	for gcvg-git@gmane.org; Wed, 28 Feb 2007 17:13:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751418AbXB1QM4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Feb 2007 11:12:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751453AbXB1QM4
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Feb 2007 11:12:56 -0500
Received: from mail.zopyra.com ([65.68.225.25]:60603 "EHLO zopyra.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751418AbXB1QM4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Feb 2007 11:12:56 -0500
Received: (from rael@localhost)
	by zopyra.com (8.11.6/8.11.6) id l1SGCqL23597;
	Wed, 28 Feb 2007 10:12:52 -0600
In-Reply-To: <20070228155412.GC5479@spearce.org>
X-Mailer: VM 7.18 under Emacs 21.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40954>

On Wednesday, February 28, 2007 at 10:54:12 (-0500) Shawn O. Pearce writes:
>Bill Lear <rael@zopyra.com> wrote:
>> fatal: cannot pread pack file: Success [n=0; rdy=0; len=207]
>> fatal: index-pack died with error code 128
>> fetch-pack from '/home/rael/devel/project/.git' failed.
>
>Bwhat?!?  Can you print out the offset and the size of the packfile?
>It looks like your pack has been truncated?  Or is this just your
>filesystem saying "nahh, I'm not going to give you that data right
>now, try again later and maybe I will"?

The code has this:

        unsigned long from = obj[0].offset + obj[0].hdr_size;
        unsigned long len = obj[1].offset - from;

by "offset", do you want obj[0].offset and obj[1].offset?

How do I get the size of the packfile?  Is it obj->size?

Well, I went ahead and did that.  Here are the results:

% git clone --bare ~/devel/project
[...]
Resolving 2210 deltas.
fatal: cannot pread pack file: Success [obj[0].offset=39393; obj[1].offset=39602; n=305; obj->size=0; rdy=0; len=207]
fatal: index-pack died with error code 128

Let me know if that is not what you intended.


Bill
