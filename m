From: Shawn Pearce <spearce@spearce.org>
Subject: Re: is hosting a read-mostly git repo on a distributed file system practical?
Date: Tue, 12 Apr 2011 22:06:50 -0400
Message-ID: <BANLkTimPYchTXiMpnmE47kxiXvJ_c6QZ9Q@mail.gmail.com>
References: <BANLkTiniGcRAHbt5LP2NVhE+c8grOr5sLA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git Mailing List <git@vger.kernel.org>
To: Jon Seymour <jon.seymour@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 13 04:07:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q9pUF-00027x-Lb
	for gcvg-git-2@lo.gmane.org; Wed, 13 Apr 2011 04:07:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932814Ab1DMCHM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Apr 2011 22:07:12 -0400
Received: from mail-vx0-f174.google.com ([209.85.220.174]:59173 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932797Ab1DMCHL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Apr 2011 22:07:11 -0400
Received: by vxi39 with SMTP id 39so120432vxi.19
        for <git@vger.kernel.org>; Tue, 12 Apr 2011 19:07:10 -0700 (PDT)
Received: by 10.52.174.176 with SMTP id bt16mr2161089vdc.282.1302660430114;
 Tue, 12 Apr 2011 19:07:10 -0700 (PDT)
Received: by 10.52.167.36 with HTTP; Tue, 12 Apr 2011 19:06:50 -0700 (PDT)
In-Reply-To: <BANLkTiniGcRAHbt5LP2NVhE+c8grOr5sLA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171429>

On Tue, Apr 12, 2011 at 21:40, Jon Seymour <jon.seymour@gmail.com> wrote:
> Is it practical to host a read-mostly git repo on a WAN-based
> distributed file system?

Usually not. But test it and find out?

> The idea is that most developers would use the DFS-based repo to track
> the tip of the development stream, but only the integrator would
> publish updates to the DFS-based repo.
>
> As such, the need to repack the DFS-based repo will be somewhat, but
> not completely, reduced.

Serving git clone is basically a repack operation when run over
git://, http:// or SSH. If the DFS was mounted as a local filesystem,
git clone would turn into a cpio to copy the directory contents. I'm
not sure if that is what you are suggesting to do here or not.

> Is this going to be practical, or are whole of repo operations
> eventually going to kill me because of latency and bandwidth issues
> associated with use of the DFS?

Latency is a problem. The Git pack file has decent locality, but there
are some things that could still stand to be improved. It really
doesn't work well unless the pack is held completely in the machine's
memory.

-- 
Shawn.
