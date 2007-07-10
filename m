From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: I used git pull instead of stg pull !
Date: Tue, 10 Jul 2007 15:29:57 +0200
Message-ID: <20070710132957.GA9297@diana.vm.bytemark.co.uk>
References: <469356EF.201@eclis.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jean-Christian de Rivaz <jc@eclis.ch>
X-From: git-owner@vger.kernel.org Tue Jul 10 15:30:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I8Fnm-000771-Kj
	for gcvg-git@gmane.org; Tue, 10 Jul 2007 15:30:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752956AbXGJNas convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 10 Jul 2007 09:30:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752803AbXGJNas
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jul 2007 09:30:48 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:4694 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752743AbXGJNar (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jul 2007 09:30:47 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1I8Fmv-0002na-00; Tue, 10 Jul 2007 14:29:57 +0100
Content-Disposition: inline
In-Reply-To: <469356EF.201@eclis.ch>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52066>

On 2007-07-10 11:52:47 +0200, Jean-Christian de Rivaz wrote:

> I have made the error to use the "git pull" command instead of the
> "stg pull" command. The "git pull" have been executed successfuly,
> but now stg seem to be confused:
>
> stg pull -n
> stg pull: local changes in the tree. Use "refresh" to commit them
>
> stg new dummy -m "dummy"
> stg new: HEAD and top are not the same. You probably committed
>   changes to the tree outside of StGIT. If you know what you
>   are doing, use the "refresh -f" command
>
> How can I restore the archive to a normal state for stg ?

The problem is that you have committed a merge on top of the StGIT
stack, and StGIT can't deal with that. You can undo the merge
(provided that you haven't committed anything else on top of it) with
"git reset --hard HEAD^".

  NOTE: "reset --hard" will erase uncommitted modifications to working
  tree files, so first make sure that "git status" doesn't report any
  modifications you want to keep.

If you want to get a better view of what it is you're doing, you could
fire up gitk and find the sha1 of the commit that is supposed to be at
the top of the StGIT stack, and "git reset <sha1>" to that commit.

Once the merge is undone, just "stg pull" like you wanted to do in the
first place.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
