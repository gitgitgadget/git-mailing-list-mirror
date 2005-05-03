From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: git and symlinks as tracked content
Date: Tue, 03 May 2005 16:18:34 -0700
Message-ID: <427806CA.6030302@zytor.com>
References: <1115145234.21105.111.camel@localhost.localdomain>	<Pine.LNX.4.58.0505031151240.26698@ppc970.osdl.org>	<Pine.LNX.4.58.0505031255000.30768@sam.ics.uci.edu>	<Pine.LNX.4.58.0505031304140.26698@ppc970.osdl.org>	<7vr7got2tz.fsf@assigned-by-dhcp.cox.net> <42780185.7010204@zytor.com> <7v1x8nuchr.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@osdl.org>, Andreas Gal <gal@uci.edu>,
	Kay Sievers <kay.sievers@vrfy.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 04 01:13:27 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DT6Zc-0004w0-E4
	for gcvg-git@gmane.org; Wed, 04 May 2005 01:13:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261905AbVECXTR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 May 2005 19:19:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261906AbVECXTR
	(ORCPT <rfc822;git-outgoing>); Tue, 3 May 2005 19:19:17 -0400
Received: from terminus.zytor.com ([209.128.68.124]:5352 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S261905AbVECXTD
	(ORCPT <rfc822;git@vger.kernel.org>); Tue, 3 May 2005 19:19:03 -0400
Received: from [10.4.1.13] (yardgnome.orionmulti.com [209.128.68.65])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.1/8.13.1) with ESMTP id j43NIdSG009363
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 3 May 2005 16:18:39 -0700
User-Agent: Mozilla Thunderbird 1.0.2-1.3.2 (X11/20050324)
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v1x8nuchr.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: ClamAV version 0.84, clamav-milter version 0.84e on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-3.4 required=5.0 tests=ALL_TRUSTED,AWL 
	autolearn=ham version=3.0.3
X-Spam-Checker-Version: SpamAssassin 3.0.3 (2005-04-27) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
>>>>>>"HPA" == H Peter Anvin <hpa@zytor.com> writes:
> 
> 
> HPA> Owner and permissions are part of the tree object, and apply to all
> HPA> file types.
> 
> Huh?  I am confused...  Do you mean tree object should be
> changed to record these?  That would make the existing in-cache
> merging of files, which GIT was built for, quite interesting...
> 
> Well, doing device nodes _is_ a tangent, so let's drop this
> discussion.
> 

No, the tree object *ALREADY* records these.

BLOB: A "blob" object is nothing but a binary blob of data, and doesn't
refer to anything else.  There is no signature or any other verification
of the data, so while the object is consistent (it _is_ indexed by its
sha1 hash, so the data itself is certainly correct), it has absolutely
no other attributes.  No name associations, no permissions.  It is
purely a blob of data (ie normally "file contents").

TREE: The next hierarchical object type is the "tree" object.  A tree
object is a list of permission/name/blob data, sorted by name.  In other
words the tree object is uniquely determined by the set contents, and so
two separate but identical trees will always share the exact same
object.

	-hpa
