From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: CRLF problems with Git on Win32
Date: Tue, 8 Jan 2008 14:09:52 -0500
Message-ID: <20080108190952.GK22155@fieldses.org>
References: <Pine.LNX.4.64.0801071010340.1864@ds9.cixit.se> <200801071947.28586.robin.rosenberg.lists@dewire.com> <alpine.LSU.1.00.0801071915470.10101@racer.site> <200801072203.23938.robin.rosenberg.lists@dewire.com> <alpine.LSU.1.00.0801072115120.10101@racer.site> <3B08AC4C-A807-4155-8AD7-DC6A6D0FE134@zib.de> <20080108172957.GG22155@fieldses.org> <CE10C08D-AAF1-44B5-89B5-9A16A4AB70EA@zib.de> <7vmyrgry20.fsf@gitster.siamese.dyndns.org> <02DC77F5-7465-418D-972E-0F76E56C3F75@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	Jeff King <peff@peff.net>,
	Peter Karlsson <peter@softwolves.pp.se>,
	Git Mailing List <git@vger.kernel.org>,
	msysGit <msysgit@googlegroups.com>
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Tue Jan 08 20:10:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JCJqZ-0005fY-B4
	for gcvg-git-2@gmane.org; Tue, 08 Jan 2008 20:10:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751500AbYAHTKT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jan 2008 14:10:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750857AbYAHTKT
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Jan 2008 14:10:19 -0500
Received: from mail.fieldses.org ([66.93.2.214]:56756 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750792AbYAHTKS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jan 2008 14:10:18 -0500
Received: from bfields by fieldses.org with local (Exim 4.68)
	(envelope-from <bfields@fieldses.org>)
	id 1JCJpg-0004Sv-5h; Tue, 08 Jan 2008 14:09:52 -0500
Content-Disposition: inline
In-Reply-To: <02DC77F5-7465-418D-972E-0F76E56C3F75@zib.de>
User-Agent: Mutt/1.5.17 (2007-12-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69905>

On Tue, Jan 08, 2008 at 07:58:57PM +0100, Steffen Prohaska wrote:
>
> On Jan 8, 2008, at 7:07 PM, Junio C Hamano wrote:
>
>>
>>
>> Steffen Prohaska <prohaska-wjoc1KHpMeg@public.gmane.org> writes:
>>
>>> msysgit installs plain git.  core.autocrlf is unset.  Whatever plain
>>> git's default is, this is msysgit's default, too.
>>
>> That sounds like a mistake if you are installing a port to a
>> platform whose native line ending convention is different from
>> where plain git natively runs on (i.e. UNIX).
>
> We failed to agree on a better default and as the lengthy
> discussion documents, the best default isn't obvious.
>
> I don't think a solution will be found by declaring one platform
> native (UNIX) and all other platform non-native.  The question to
> answer is how to support cross-platform projects.  A valid
> solution should never corrupt data unless the user explicitly
> told git to do so.

My only suggestion is that we consider allowing the user that
"explicitly told git to do so" be the project maintainer.  So if you

	echo * autodetectcrlf >.gitattributes
	git add .gitattributes
	git commit

then users that clone your repo will get that default without having to
be told to do something magic on clone.

(And ideally I'd've hoped you could do that using the existing crlf
attribute rather than having to invent something new, but maybe that
doesn't work.)

--b.

> I don't believe it is a valid solution to set
> core.autocrlf=true on Windows and tell the users: "Well, in its
> default settings, git sometimes corrupts your data on Windows.
> Maybe you want to switch to Linux because this is the native
> platform where data corruption will never happen."
>
> I'd prefer the "warn/fail" proposal.
>
> 	Steffen
