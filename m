From: Stefan Monnier <monnier@iro.umontreal.ca>
Subject: Re: fast-import fails in read-only tree
Date: Sat, 30 Jan 2016 08:56:48 -0500
Message-ID: <jwvtwlv18jw.fsf-monnier+gmane.comp.version-control.git@gnu.org>
References: <jwvfuxhz72e.fsf-monnier+gmane.comp.version-control.git@gnu.org>
	<20160129060802.GA23106@sigill.intra.peff.net>
	<jwv7fisxyhz.fsf-monnier+gmane.comp.version-control.git@gnu.org>
	<20160130051340.GA1677@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 30 14:57:09 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aPW1R-0006Jl-7b
	for gcvg-git-2@plane.gmane.org; Sat, 30 Jan 2016 14:57:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756927AbcA3N5B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Jan 2016 08:57:01 -0500
Received: from plane.gmane.org ([80.91.229.3]:43154 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756860AbcA3N46 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jan 2016 08:56:58 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1aPW1H-00066d-He
	for git@vger.kernel.org; Sat, 30 Jan 2016 14:56:55 +0100
Received: from 76-10-146-127.dsl.teksavvy.com ([76.10.146.127])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 30 Jan 2016 14:56:55 +0100
Received: from monnier by 76-10-146-127.dsl.teksavvy.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 30 Jan 2016 14:56:55 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 76-10-146-127.dsl.teksavvy.com
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
Cancel-Lock: sha1:pvvnISFCPGBvwKNuba/bqVJ3ois=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285112>

> You can use custom cat-file formatting to output your "name" strings as
> part of the same field. IOW, something like:
[...]
> If you're really going to do a lot of interactive back-and-forth access
> of objects, though, I think you want to set up pipes to cat-file.

OMG, I didn't realize that cat-file doesn't buffer its output so it can
be read&write to/from the same process.  And the "%(rest)" thingy takes
care of the rest of my needs, indeed.

Thanks!

> It's a little tedious to allocate fifos, but something like:

That's not a problem.

> One feature I do think would be useful (and almost implemented when I
> added --batch-check=<format>) is a formatter for the object content,
> with a pretty modifier. I.e., it would be nice to do:
>
>   echo $some_tree |
>   git cat-file --batch-check="%(objectsize:pretty) %(contents:pretty)"
>
> to work as the rough equivalent of "git cat-file -p" (but here you could
> feed multiple trees and get multiple answers).

Yes, that would be a good improvement,


        Stefan
