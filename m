From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: git-cvsimport fuzzy commit log matching?
Date: Tue, 23 Dec 2008 10:53:42 -0200
Message-ID: <46a038f90812230453m4122e018l2cc22be3f40ab630@mail.gmail.com>
References: <20081223110302.GA9376@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Matthias Urlichs" <smurf@smurf.noris.de>, git@vger.kernel.org
To: "Christoph Hellwig" <hch@lst.de>
X-From: git-owner@vger.kernel.org Tue Dec 23 13:55:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LF6n5-0005U1-Nm
	for gcvg-git-2@gmane.org; Tue, 23 Dec 2008 13:55:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751059AbYLWMxp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Dec 2008 07:53:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751050AbYLWMxo
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Dec 2008 07:53:44 -0500
Received: from yw-out-2324.google.com ([74.125.46.29]:12994 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750984AbYLWMxn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Dec 2008 07:53:43 -0500
Received: by yw-out-2324.google.com with SMTP id 9so849739ywe.1
        for <git@vger.kernel.org>; Tue, 23 Dec 2008 04:53:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=hvtIOPm7SMu2hac3Cc8cgLQ9AW1YXwcu35NMhiS5D3k=;
        b=FRm5uF6KoyRrIFnxSGGrFlU9v8bU/IFCjmmAKTQpCXgQ3eLIRRaJtNtdJtJ4ulksSU
         cUhnTR2DyBtDvEIAVc70cn+OKWnxYpsLNycHsGU50+SOg9kX82iIENRCDCSC+i3KSrUb
         da3UFSp8rMNAKOGzK+XT+pfYMY5JC8sfnEkRQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=he2dKpQ35v2k6wBR1PnRO+KLNKl1mTXI3Pe6k+XBfmYgV2YSxpxBMOy0SUDnuztV1e
         GIvcXxgO9hOGCXOvoUbMpxC9kClbOLPouz4Et36S1zhUV4yxZ0QhNgENP2aCP852lwjq
         lydPBwHZgAzYkUgeIrtgyF6hrNZpfz8LbbTK4=
Received: by 10.100.178.2 with SMTP id a2mr4507997anf.114.1230036822592;
        Tue, 23 Dec 2008 04:53:42 -0800 (PST)
Received: by 10.100.3.14 with HTTP; Tue, 23 Dec 2008 04:53:42 -0800 (PST)
In-Reply-To: <20081223110302.GA9376@lst.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103816>

On Tue, Dec 23, 2008 at 9:03 AM, Christoph Hellwig <hch@lst.de> wrote:
> Any idea how to tell git-cvsimport that if we have exactly the same
> timestamp, and maybe the same author it really is the same changeset and
> we want to merge the commit message?

Right now, cvsimport relies on cvsps for this. cvsps compares author,
timestamp (with a fuzz factor 'cause cvs commits over slow networks or
hosts can span minutes - you could dial down to 0, it's the -z flag)
*and* commit msg.

What you could do is

 1 - run cvsps with export to a file (I've posted in this list how to
run it exactly as cvsimport does)
 2 - post-process cvsps ouput with perl (there's a parser already in
cvsimport ;-) )
 3 - run cvsimport with the post-processed file

Or postprocess the imported git tree as others have suggested.

hth,



martin
-- 
 martin.langhoff@gmail.com
 martin@laptop.org -- School Server Architect
 - ask interesting questions
 - don't get distracted with shiny stuff  - working code first
 - http://wiki.laptop.org/go/User:Martinlanghoff
