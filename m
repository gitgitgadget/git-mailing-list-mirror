From: David Lang <david.lang@digitalinsight.com>
Subject: Re: mingw, windows, crlf/lf, and git
Date: Mon, 12 Feb 2007 17:20:15 -0800 (PST)
Message-ID: <Pine.LNX.4.63.0702121715220.6630@qynat.qvtvafvgr.pbz>
References: <45CFA30C.6030202@verizon.net>  <20070212042425.GB18010@thunk.org>
  <Pine.LNX.4.64.0702120839490.8424@woody.linux-foundation.org> 
 <7vps8f6l81.fsf@assigned-by-dhcp.cox.net> 
 <Pine.LNX.4.63.0702130020450.22628@wbgn013.biozentrum.uni-wuerzburg.de> 
 <7vfy9b6iyt.fsf@assigned-by-dhcp.cox.net> 
 <Pine.LNX.4.63.0702130046450.22628@wbgn013.biozentrum.uni-wuerzburg.de> 
 <45D10D86.3030508@verizon.net>  <Pine.LNX.4.63.0702130204120.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <20070213011329.GB31377@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Mark Levedahl <mdl123@verizon.net>,
	Junio C Hamano <junkio@cox.net>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Theodore Tso <tytso@mit.edu>,
	Mark Levedahl <mlevedahl@verizon.net>,
	Git Mailing List <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Feb 13 02:35:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HGmaH-0001TG-9X
	for gcvg-git@gmane.org; Tue, 13 Feb 2007 02:35:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965464AbXBMBfo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Feb 2007 20:35:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965465AbXBMBfo
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Feb 2007 20:35:44 -0500
Received: from warden-p.diginsite.com ([208.29.163.248]:55908 "HELO
	warden.diginsite.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with SMTP id S965464AbXBMBfn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Feb 2007 20:35:43 -0500
Received: from wlvims02.diginsite.com by warden.diginsite.com
          via smtpd (for vger.kernel.org [209.132.176.167]) with SMTP; Mon, 12 Feb 2007 17:35:43 -0800
Received: from dlang.diginsite.com ([10.201.10.67]) by wlvims02.corp.ad.diginsite.com with InterScan Message Security Suite; Mon, 12 Feb 2007 17:34:59 -0800
X-X-Sender: dlang@dlang.diginsite.com
In-Reply-To: <20070213011329.GB31377@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39478>

On Mon, 12 Feb 2007, Shawn O. Pearce wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
>> On Mon, 12 Feb 2007, Mark Levedahl wrote:
>>
>>> Perhaps I'm too paranoid, but I've been burnt way too many times by
>>> text/binary mode stuff to let this part be trivialized. Maybe it only
>>> gets enabled by core.ImReallyParanoid, but I want that option.
>>
>> Be aware that what you proposed costs many CPU cycles. I am totally
>> opposed to enabling that option by default on all platforms. I am okay
>> with .gitattributes (but I would call it .gitfiletypes), but I am _not_
>> okay with git being _too much_ fscked up by Windows. Microsoft has done
>> enough harm already.
>
> Indeed; this type of checking should only occur if there is a filter
> applied to a file.  Most files in most projects would hopefully
> just be considered to be byte streams to Git, like they are today,
> and thus not incur any additional overhead, beyond matching their
> type to determine they are in fact just a byte stream.
>
> The type could be cached in the index; or at least a single bit
> which says "I'm just a byte stream, thanks" so that the matching
> only needs to occur during an initial read-tree.

for the limited case of line endings it may be reasonable to define the internal 
git format to be lf, and if you are running on a platform that uses this nativly 
no transition is needed

one possible way to make this be a general feture is to have the helper script 
have a --needed flag that tells git if it would do anything on the current 
platform or not. this way you don't need to run it (and sanity check it) if it's 
not needed.

David Lang
