From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: rebuild repo from data, packfiles?
Date: Sat, 20 Nov 2010 21:27:07 -0600
Message-ID: <20101121032707.GA11571@burratino>
References: <auto-000024044659@sci.utah.edu>
 <20101121001643.GB27666@burratino>
 <auto-000024045093@sci.utah.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: tom fogal <tfogal@sci.utah.edu>
X-From: git-owner@vger.kernel.org Sun Nov 21 04:28:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PK0bZ-0002bX-OR
	for gcvg-git-2@lo.gmane.org; Sun, 21 Nov 2010 04:28:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751553Ab0KUD1V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Nov 2010 22:27:21 -0500
Received: from mail-gx0-f174.google.com ([209.85.161.174]:32916 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751329Ab0KUD1U (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Nov 2010 22:27:20 -0500
Received: by gxk23 with SMTP id 23so3474140gxk.19
        for <git@vger.kernel.org>; Sat, 20 Nov 2010 19:27:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=037LZW0ZqrJnb8xuQ7zJ0s43jcnYFL9jJsivshMp2LE=;
        b=eiusb7c+mqmNyHcXjK5t89t1wphcRqQgZPD0TAqElNZjbE3qcXlj80fCw0AIWIRJpX
         SYNUN8iO4nH1mbnoWqyNeUNWsqEFrwALzawJ2ZMGl7ZGu26CNc0ZvuCrwE5G93y+Vwf9
         T8c58XRu0sE7b1UVt68T0cm5EmZjaeERCXXxY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=WeuDeT1VDNBIWdzxsU5rigdFxRZoPn6+Yq74cAaWb+NeZd08dP5Dx2zG8n6CJD6wAV
         zg+uLAoXx2W9dqVdmOLxrA0Y4AvIZ3HwAAR5wU9uyG+NzBVMud3z3ksI4fZXgRylDdsv
         s/oMaU3sGAp9zGzgg2/IhcSPDUHd/2RKsVlq0=
Received: by 10.90.10.34 with SMTP id 34mr5065947agj.157.1290310039666;
        Sat, 20 Nov 2010 19:27:19 -0800 (PST)
Received: from burratino ([68.255.106.176])
        by mx.google.com with ESMTPS id 28sm3916032anv.26.2010.11.20.19.27.17
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 20 Nov 2010 19:27:18 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <auto-000024045093@sci.utah.edu>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161854>

tom fogal wrote:

> My thought is to cat-file all my commits, filter out the ones which are
> upstream, order them by date, and git-am them back into a repo.
> 
> Some of my data only exist in blobs, though... maybe git-diff-tree
> can get me the patch I need?  Not quite sure what to diff it with,
> though... maybe the most-recent sha1 I have, based on date?
> 
> Other ideas would certainly be welcome!

What did "git fsck" say?

If it is possible to unambiguously recover your data without using any
external knowledge, then that would imply a bug imho --- why doesn't
git do it automatically?  Chances are some objects are missing ---
blobs, trees, commits, or tags --- and you will have to fill in some
information for a full recovery.

Perhaps you have another copy of those objects somewhere.  Have you
ever cloned this repo or pushed to another machine?

Sometimes it is possible to recover some specific object with
detective work; see howto/recover-corrupted-blob-object.txt in the
Documentation directory for an example of that.

git does not use text diffs for its object storage.  The information
the repository can give you directly consists of binary deltas and
full objects.

Are the old refs (branches and tags) intact?  More generally, what
files does

 ls -lR .git

list in the old repository?

Regards,
Jonathan
