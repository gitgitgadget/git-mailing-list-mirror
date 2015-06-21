From: Richard Weinberger <richard@nod.at>
Subject: Re: broken repo after power cut
Date: Sun, 21 Jun 2015 16:08:15 +0200
Message-ID: <5586C54F.1090705@nod.at>
References: <5585C1B6.50407@nod.at> <330ab8f498e1b435d5b210384200b649@www.dscho.org> <5586B71D.2070407@nod.at> <20150621135903.GA18719@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	git@vger.kernel.org, David Gstir <david@sigma-star.at>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	Theodore Ts'o <tytso@mit.edu>
To: Christoph Hellwig <hch@infradead.org>
X-From: linux-fsdevel-owner@vger.kernel.org Sun Jun 21 16:08:25 2015
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Envelope-to: lnx-linux-fsdevel@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-fsdevel-owner@vger.kernel.org>)
	id 1Z6fv5-0007VK-CP
	for lnx-linux-fsdevel@plane.gmane.org; Sun, 21 Jun 2015 16:08:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754284AbbFUOIT (ORCPT <rfc822;lnx-linux-fsdevel@m.gmane.org>);
	Sun, 21 Jun 2015 10:08:19 -0400
Received: from a.ns.miles-group.at ([95.130.255.143]:65276 "EHLO radon.swed.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751655AbbFUOIT (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
	Sun, 21 Jun 2015 10:08:19 -0400
Received: (qmail 4404 invoked by uid 89); 21 Jun 2015 14:08:17 -0000
Received: by simscan 1.3.1 ppid: 4399, pid: 4402, t: 0.0487s
         scanners: attach: 1.3.1
Received: from unknown (HELO ?192.168.0.11?) (richard@nod.at@213.47.235.169)
  by radon.swed.at with ESMTPA; 21 Jun 2015 14:08:17 -0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
In-Reply-To: <20150621135903.GA18719@infradead.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272267>

Am 21.06.2015 um 15:59 schrieb Christoph Hellwig:
> On Sun, Jun 21, 2015 at 03:07:41PM +0200, Richard Weinberger wrote:
>>>> To me it seems like git was creating a new object and got interrupted
>>>> before fsync/fdatasync'ing it.
>>>> As the object was referenced before syncing the data to disk the repo broke.
> 
> Git doesn't fsync by default, and because of that I've seen similar
> data losses on ext4/xfs/btrfs.
> 
> You can set the core.fsyncobjectfiles to mitigate it, but even with
> that I've seen corrupted index files.

Yeah, after inspecting git's source I've found that config option too.
Now it's also crystal clear that git is not power cut safe at all by default. ;-\

So, anyone that cares about his repos has to enable core.fsyncobjectfiles,
which is IMHO kind of sad.

Thanks,
//richard
--
To unsubscribe from this list: send the line "unsubscribe linux-fsdevel" in
