From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: RFC: display dirty submodule working directory in git gui and gitk
Date: Sat, 02 Jan 2010 16:33:22 +0100
Message-ID: <4B3F6742.6060402@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Paul Mackerras <paulus@samba.org>,
	Heiko Voigt <hvoigt@hvoigt.net>, Lars Hjemli <hjemli@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jan 02 16:33:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NR5yz-0003YL-BX
	for gcvg-git-2@lo.gmane.org; Sat, 02 Jan 2010 16:33:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752753Ab0ABPdc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Jan 2010 10:33:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752749Ab0ABPdb
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Jan 2010 10:33:31 -0500
Received: from fmmailgate01.web.de ([217.72.192.221]:54937 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752666Ab0ABPda (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Jan 2010 10:33:30 -0500
Received: from smtp06.web.de (fmsmtp06.dlan.cinetic.de [172.20.5.172])
	by fmmailgate01.web.de (Postfix) with ESMTP id A15D3143FB38D;
	Sat,  2 Jan 2010 16:33:29 +0100 (CET)
Received: from [80.128.99.24] (helo=[192.168.178.26])
	by smtp06.web.de with asmtp (WEB.DE 4.110 #314)
	id 1NR5yr-0002sO-00; Sat, 02 Jan 2010 16:33:29 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.1.5) Gecko/20091204 Thunderbird/3.0
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX19nVvG4fwDsIQ9GNBIFlVkQrHX5IDubtnvbFhAv
	asJeCYMrW9ZSwV3W419bwe4EXZlb+eHr7CMadyptE45T4BCpio
	G/BELLSjIi7+m7xVBf3g==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136029>

Now that we have much better output when displaying diffs of
submodules in git gui and gitk (many thanks to all involved!),
another usability issue shows up: A dirty working directory of
a submodule isn't visible in git gui or gitk.

So you might think a "submodule update" would be ok - as you
see no changes - just too see it fail because the submodules
working directory is dirty.

Or - even worse - you /think/ you committed your changes in
a submodule while you didn't. That can lead to 'interesting'
problems which can be pretty hard to diagnose (like breaking
builds on other peoples machines).


A possible solution could look like this:

AFAICS, git gui and gitk use "git diff-files" both to get the
file names of unstaged local changes and to later display the
actual differences.

If they could tell the diff core to also check the submodule
working directories and to output an extra line - maybe
something like "Submodule <name> contains uncommitted local
changes" - when a submodules working directory is dirty,
git gui and gitk could show the submodules state adequately.


What do you think about this approach?
