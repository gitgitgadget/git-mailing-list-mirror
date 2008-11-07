From: Mike Hommey <mh@glandium.org>
Subject: Re: absurdly slow git-diff
Date: Fri, 7 Nov 2008 22:28:36 +0100
Organization: glandium.org
Message-ID: <20081107212836.GA22717@glandium.org>
References: <20081107200126.GA20284@toroid.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Abhijit Menon-Sen <ams@toroid.org>
X-From: git-owner@vger.kernel.org Fri Nov 07 22:30:01 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KyYu0-0003Sd-Jv
	for gcvg-git-2@gmane.org; Fri, 07 Nov 2008 22:30:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751388AbYKGV2q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Nov 2008 16:28:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751345AbYKGV2q
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Nov 2008 16:28:46 -0500
Received: from vuizook.err.no ([194.24.252.247]:38813 "EHLO vuizook.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750816AbYKGV2p (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Nov 2008 16:28:45 -0500
Received: from cha92-13-88-165-248-19.fbx.proxad.net ([88.165.248.19] helo=jigen)
	by vuizook.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <mh@glandium.org>)
	id 1KyYsg-0002KD-GE; Fri, 07 Nov 2008 22:28:41 +0100
Received: from mh by jigen with local (Exim 4.69)
	(envelope-from <mh@jigen>)
	id 1KyYse-0006MA-QE; Fri, 07 Nov 2008 22:28:36 +0100
Content-Disposition: inline
In-Reply-To: <20081107200126.GA20284@toroid.org>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Spam-Status: (score 0.1): No, score=0.1 required=5.0 tests=RDNS_DYNAMIC autolearn=disabled version=3.2.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100334>

On Sat, Nov 08, 2008 at 01:31:27AM +0530, Abhijit Menon-Sen wrote:
> I have a 240k-line file, and I change one character on every sixth line.
> The resulting diff gives git serious indigestion:
> 
> $ git --version
> git version 1.6.0.3.640.g6331a
> $ mkdir a; cd a; git init
> Initialized empty Git repository in /home/ams/a/.git/
> $ cp ../1 .; git add 1; git commit -q -m 1
> $ cp ../2 1; git add 1; git commit -q -m 2 

You don't need to go that far. You can stop at cp ../2 1 and run git
diff from there.

All the time is spent in the two loops in
xdiff/xprepare.c:xdl_cleanup_records, on line 400 and 412.

I'll leave the rest of the investigation to people actually knowing this
code ;)

Mike
