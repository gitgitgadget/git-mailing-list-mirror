From: David Kastrup <dak@gnu.org>
Subject: Re: Arbitrary long file lists?
Date: Mon, 30 Jul 2007 15:18:10 +0200
Message-ID: <86zm1erpwt.fsf@lola.quinscape.zz>
References: <866442t6j5.fsf@lola.quinscape.zz> <81b0412b0707300543p48964b73o5f972405645e70e9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 30 15:18:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IFV8w-0002a4-12
	for gcvg-git@gmane.org; Mon, 30 Jul 2007 15:18:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760063AbXG3NS0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 30 Jul 2007 09:18:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759062AbXG3NS0
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jul 2007 09:18:26 -0400
Received: from main.gmane.org ([80.91.229.2]:45701 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758862AbXG3NSZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jul 2007 09:18:25 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IFV8d-0006Bv-73
	for git@vger.kernel.org; Mon, 30 Jul 2007 15:18:19 +0200
Received: from pd95b0fdb.dip0.t-ipconnect.de ([217.91.15.219])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 30 Jul 2007 15:18:19 +0200
Received: from dak by pd95b0fdb.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 30 Jul 2007 15:18:19 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: pd95b0fdb.dip0.t-ipconnect.de
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.51 (gnu/linux)
Cancel-Lock: sha1:l10q+oFS5RX1mxSHUBLEhMlA+Bw=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54230>

"Alex Riesen" <raa.lkml@gmail.com> writes:

> On 7/30/07, David Kastrup <dak@gnu.org> wrote:
>> commands like git-archive take a file list on the command line.  If
>> the number of files does no longer fit the argv limitations, this
>> causes a problem.
>>
>> So it might be nice to be able to treat some "filenames" in a file
>> list special:
>>
>> -@=filename (read LF-lines with filenames from filename)
>> -@=- (read lines with filenames from stdin)
>> -@z=filename (read NUL-terminated list with filenames from filename)
>> -@z=- (same from stdin)
>
> git-update-index and the like use --stdin and -z.
> What do you need the one with filename for?

Uh, git-archive?

I was thinking that -z could conflict with other uses for in/output,
but indeed git-archive does not seem to have any other area that would
be affected by -z.

So this request at the current point of time can be reduced to let
git-archive have --stdin and -z options.  That is actually important
as one can't concatenate zip-files, and so xargs does not help.

But file lists are also important for things like git-diff (for which
the NUL-endedness of input is a separate issue from its output).  So
instead of adding stdin piecemeal, it was some sort of idea to have
this generally available in file lists.

If somebody can come up with a nice syntax.

-- 
David Kastrup
