From: Bill Lear <rael@zopyra.com>
Subject: Re: Error "fatal: cannot pread pack file: Success"
Date: Wed, 28 Feb 2007 10:55:31 -0600
Message-ID: <17893.46083.869042.467318@lisa.zopyra.com>
References: <17892.64236.443170.43061@lisa.zopyra.com>
	<20070228035713.GC5597@spearce.org>
	<20070228044719.GA6068@spearce.org>
	<17893.40847.313519.283218@lisa.zopyra.com>
	<17893.42063.186763.291346@lisa.zopyra.com>
	<20070228155412.GC5479@spearce.org>
	<17893.43522.511785.121778@lisa.zopyra.com>
	<17893.44181.129918.669187@lisa.zopyra.com>
	<20070228163256.GD5479@spearce.org>
	<118833cc0702280842g3e121fg601d7e102956ba93@mail.gmail.com>
	<20070228164922.GB5924@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Morten Welinder <mwelinder@gmail.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Feb 28 17:55:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMS5c-0000y1-UM
	for gcvg-git@gmane.org; Wed, 28 Feb 2007 17:55:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933054AbXB1Qzk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Feb 2007 11:55:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933076AbXB1Qzk
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Feb 2007 11:55:40 -0500
Received: from mail.zopyra.com ([65.68.225.25]:60674 "EHLO zopyra.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933054AbXB1Qzj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Feb 2007 11:55:39 -0500
Received: (from rael@localhost)
	by zopyra.com (8.11.6/8.11.6) id l1SGtZZ28618;
	Wed, 28 Feb 2007 10:55:35 -0600
In-Reply-To: <20070228164922.GB5924@spearce.org>
X-Mailer: VM 7.18 under Emacs 21.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40966>

On Wednesday, February 28, 2007 at 11:49:22 (-0500) Shawn O. Pearce writes:
>Morten Welinder <mwelinder@gmail.com> wrote:
>> >+                       die("cannot pread pack file: %s from=%lu, packfile 
>> >size=%lu", strerror(errno), from, lseek(pack_fd, SEEK_END, 0));
>> 
>> That might give you the errno from the lseek call.
>
>Yes, and I don't care here.  We're dead either way, that pread is
>returning bunk and we don't know why.
>
>But it is also giving me SEEK_END, not the end of the file.  I got
>the arguments backwards to lseek.  Whoops.  ;-)

Ok, fixed that:

% strace -f -o tracefile git clone --bare ~/devel/project
[...]
fatal: cannot pread pack file: Success from=39395, packfile size=0
[...]
% grep pread tracefile
28635 pread(3,  <unfinished ...>
28635 <... pread resumed> "", 207, 39395) = 0
28635 write(2, "cannot pread pack file: Success "..., 59) = 59


Bill
