From: Josh Triplett <josh@freedesktop.org>
Subject: Re: git cvsimport branches not consistent with CVS branches
Date: Sun, 08 Jul 2007 21:31:04 -0700
Message-ID: <4691BA08.2080107@freedesktop.org>
References: <46903396.1010507@heydon.com.au> <20070708054520.GD4087@lavos.net> <200707081253.06129.robin.rosenberg.lists@dewire.com> <3BA4D1AE-D5C9-42CB-81B4-38DC3946A966@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	Brian Downing <bdowning@lavos.net>,
	Gordon Heydon <gordon@heydon.com.au>,
	Git Mailing List <git@vger.kernel.org>
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Mon Jul 09 06:31:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I7kuF-0000Rz-3U
	for gcvg-git@gmane.org; Mon, 09 Jul 2007 06:31:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751344AbXGIEbY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 Jul 2007 00:31:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751291AbXGIEbY
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Jul 2007 00:31:24 -0400
Received: from mail4.sea5.speakeasy.net ([69.17.117.6]:48674 "EHLO
	mail4.sea5.speakeasy.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751221AbXGIEbX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jul 2007 00:31:23 -0400
Received: (qmail 13535 invoked from network); 9 Jul 2007 04:31:22 -0000
Received: from dsl093-040-092.pdx1.dsl.speakeasy.net (HELO [192.168.0.122]) (josh@[66.93.40.92])
          (envelope-sender <josh@freedesktop.org>)
          by mail4.sea5.speakeasy.net (qmail-ldap-1.03) with AES256-SHA encrypted SMTP
          for <prohaska@zib.de>; 9 Jul 2007 04:31:22 -0000
User-Agent: Mozilla-Thunderbird 2.0.0.4 (X11/20070622)
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <3BA4D1AE-D5C9-42CB-81B4-38DC3946A966@zib.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51948>

Steffen Prohaska wrote:
> On Jul 8, 2007, at 12:53 PM, Robin Rosenberg wrote:
>> Corecode's fromcvs is pretty fast and incremental and AFAIK  
>> accurate. I had
>> plenty problems with cvsimport, but fromcvs keeps in sync with the  
>> CVS repo.
>> Get  it at http://ww2.fs.ei.tum.de/~corecode/hg/fromcvs/ .
>>
>> It does not convert regular tags, only branches, however so there  
>> is something to
>> do for those that want a complete cvs import.
> 
> Did anyone compare
>     * git-cvsimport with cvsps patches from [1]
>     * parsecvs [2]
>     * fromcvs
> and can give a recommendation?
> 
> My experience with plain git-cvsimport (without cvsps patches from [1])
> is that it has a lot of problems. I'd recommend not to use it for
> incremental import and be very suspicious about the git repository
> created by git-cvsimport. You need to carefully validate the repository.
> It's likely that you need to fix imported branches. The trunk seems to
> be ok.

I've used both parsecvs and git-cvsimport, and I can definitely say from
experience that cvsimport badly munges history, and parsecvs seems to handle
it correctly.  parsecvs does have the limitations that it requires the ,v
files and doesn't work incrementally, making it great for project repository
conversions and painful for just wanting to use git on a CVS-(mis)managed
project.

I've never used fromcvs.

One idea to mitigate one of the limitations: how about modifying the CVS
server to add an extension that supports downloading full ,v files?  CVS has
had server extensions in the past, such as for ls/rls.  Once support for this
extension makes its way out to most CVS servers, this problem goes away.

- Josh Triplett
