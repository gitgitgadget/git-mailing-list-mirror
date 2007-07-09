From: Florian Weimer <fw@deneb.enyo.de>
Subject: Re: [PATCH v2] Make fetch-pack a builtin with an internal API
Date: Mon, 09 Jul 2007 17:10:36 +0200
Message-ID: <874pkdlij7.fsf@mid.deneb.enyo.de>
References: <Pine.LNX.4.64.0707090104120.6977@iabervon.org>
	<7vwsxaw2xu.fsf@assigned-by-dhcp.cox.net>
	<20070709115029.GD16032@thunk.org>
	<200707091416.39949.andyparkins@gmail.com>
	<20070709144030.GE16032@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 09 17:10:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I7uss-0007FK-DU
	for gcvg-git@gmane.org; Mon, 09 Jul 2007 17:10:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753327AbXGIPKk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 Jul 2007 11:10:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751805AbXGIPKk
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Jul 2007 11:10:40 -0400
Received: from mail.enyo.de ([212.9.189.167]:2346 "EHLO mail.enyo.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750750AbXGIPKj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jul 2007 11:10:39 -0400
Received: from deneb.vpn.enyo.de ([212.9.189.177] helo=deneb.enyo.de)
	by mail.enyo.de with esmtp id 1I7usn-0006UD-KE
	for git@vger.kernel.org; Mon, 09 Jul 2007 17:10:37 +0200
Received: from fw by deneb.enyo.de with local (Exim 4.67)
	(envelope-from <fw@deneb.enyo.de>)
	id 1I7usm-0004ez-Iz
	for git@vger.kernel.org; Mon, 09 Jul 2007 17:10:36 +0200
In-Reply-To: <20070709144030.GE16032@thunk.org> (Theodore Tso's message of
	"Mon, 9 Jul 2007 10:40:30 -0400")
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51999>

* Theodore Tso:

> On Mon, Jul 09, 2007 at 02:16:35PM +0100, Andy Parkins wrote:

>> Perhaps I'm reading it wrong but:
>> 
>> "All identifiers beginning with an underscore are reserved for ordinary 
>> identifiers (functions, variables, typedefs, enumeration constants) with file 
>                                                                       ^^^^^^^^^
>> scope."
>   ^^^^^^
>> 
>> Doesn't agree with what you've said.  I think that you _can_ use _[a-z]* for 
>> labels or structure members - however, not within file or function scope.
>
> I think the above does agree with what I said.  It says that you can
> use functions, variables, typdefs, enumeration constants (not just
> labels or structure members) WITH FILE SCOPE.

No, they are are reserved.

> I.e., so long as it doesn't leak across a .o linkage.  So one .o
> file can use a static _my_strdup, and another .o file can use a
> static _my_strdup, and they don't have to worry about multiply
> defined function conflicts, since they are static functions with
> file or smaller scoping.

This is not sufficient because the implementation might have a
*typedef* for _my_strdup in any header file, and neither translation
unit would compile.  Or they could have been declared with a different
prototype.
