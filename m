From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: [BUG] git diff-tree --stdin doesn't accept two trees
Date: Tue, 5 Aug 2008 18:48:39 +0200
Message-ID: <20080805164839.GA3934@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 05 18:28:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KQPOB-0005wV-GT
	for gcvg-git-2@gmane.org; Tue, 05 Aug 2008 18:27:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761471AbYHEQ0f convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 5 Aug 2008 12:26:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761433AbYHEQ0f
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Aug 2008 12:26:35 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:3865 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756692AbYHEQ0d (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Aug 2008 12:26:33 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1KQPiB-0001FT-00; Tue, 05 Aug 2008 17:48:39 +0100
Content-Disposition: inline
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91446>

I'm trying to use diff-tree --stdin to diff several trees in one go.
But I just get error messages when I feed it two space-separated trees
(one commit works fine):

  $ echo $(git rev-parse HEAD^{tree}) $(git rev-parse HEAD^^{tree}) | g=
it diff-tree -p --stdin
  error: Object 7bfd9971f77438858e412be0219ec78afb3ca46f not a commit

This is at odds with the documentation:

  --stdin::
        When '--stdin' is specified, the command does not take
        <tree-ish> arguments from the command line.  Instead, it
        reads either one <commit> or a pair of <tree-ish>
        separated with a single space from its standard input.

I tried reading the code to figure out what's wrong, and as far as I
can tell the code to do this is there, but seems to be protected by
logic that aborts everything unless the whole input line is a valid
commit. Or maybe I'm just confused ...

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
