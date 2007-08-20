From: Mike Hommey <mh@glandium.org>
Subject: Re: confused about preserved permissions
Date: Mon, 20 Aug 2007 20:13:57 +0200
Organization: glandium.org
Message-ID: <20070820181357.GA8264@glandium.org>
References: <20070820164411.GA15637@piper.oerlikon.madduck.net> <20070820174142.GA7943@glandium.org> <867inqhyuk.fsf@lola.quinscape.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Mon Aug 20 20:15:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1INBmS-0005sm-Tp
	for gcvg-git@gmane.org; Mon, 20 Aug 2007 20:15:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752587AbXHTSOy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 20 Aug 2007 14:14:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752300AbXHTSOx
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Aug 2007 14:14:53 -0400
Received: from vawad.err.no ([85.19.200.177]:56060 "EHLO vawad.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751934AbXHTSOw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Aug 2007 14:14:52 -0400
Received: from aputeaux-153-1-3-249.w82-124.abo.wanadoo.fr ([82.124.49.249] helo=namakemono.glandium.org)
	by vawad.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.62)
	(envelope-from <mh@glandium.org>)
	id 1INBm5-0005ke-FC; Mon, 20 Aug 2007 20:14:50 +0200
Received: from mh by namakemono.glandium.org with local (Exim 4.67)
	(envelope-from <mh@glandium.org>)
	id 1INBlF-0002AM-AV; Mon, 20 Aug 2007 20:13:57 +0200
Content-Disposition: inline
In-Reply-To: <867inqhyuk.fsf@lola.quinscape.zz>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.16 (2007-06-11)
X-Spam-Status: (score 0.0): Status=No hits=0.0 required=5.0 tests=none version=3.1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56233>

On Mon, Aug 20, 2007 at 07:58:43PM +0200, David Kastrup <dak@gnu.org> wrote:
> > I also never understood why there were no permissions set on
> > directories in trees...
> 
> Because directories are not actually tracked.  They are created and
> deleted as-needed.

I don't see why it would prevent to have a permission set to it... the
permission technically can be recorded in the parent tree, along its
sha1. Filesystems are also like this.

> In my proposal for allowing directories to get tracked, permissions of
> 000 would indicate a tree without a corresponding tracked directory.
> Other permissions would correspond to a tracked directory.  I am still
> stuck over the representation in the index.
> 
> One idea is to unconditionally have an entry "dirname" without
> permissions, and optionally "dirname/" with permissions iff the
> directory is supposed to be tracked, both to be sorted in
> alphabetically.  The idea of the first entry is being able to detect
> merge conflicts without extra passes.
> 
> But I have not worked on the stuff for a while.

I don't see why you would need an additional entry for the directory
permission.

> > nor why, while the sha1 for child objects are "packed", the modes
> > aren't...
> 
> Because a change of the mode of a file will then not cause different
> sha1 sums at the file level.

I think i wasn't clear enough... I just wondered why the format for tree
entries is something like (if you'd write it in perl):
sprintf "%06o %s\0%s", $mode, $file, pack("H[40]", $sha1)

Mike
