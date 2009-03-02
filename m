From: Alexander Gavrilov <angavrilov@gmail.com>
Subject: Re: VSS to git
Date: Mon, 2 Mar 2009 21:55:31 +0300
Organization: HOME
Message-ID: <200903022155.31771.angavrilov@gmail.com>
References: <b0a3bf780903020915g60d97b76pfdbbd60017625f0a@mail.gmail.com> <e2b179460903020951h7f1538daya4d3cdb96fc7c65d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Chris Velevitch <chris.velevitch@gmail.com>, git@vger.kernel.org
To: Mike Ralphson <mike.ralphson@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 02 19:54:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LeDI0-00040l-JH
	for gcvg-git-2@gmane.org; Mon, 02 Mar 2009 19:54:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752681AbZCBSx2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Mar 2009 13:53:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752578AbZCBSx2
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Mar 2009 13:53:28 -0500
Received: from ey-out-2122.google.com ([74.125.78.26]:18736 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752417AbZCBSx1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Mar 2009 13:53:27 -0500
Received: by ey-out-2122.google.com with SMTP id 25so533248eya.37
        for <git@vger.kernel.org>; Mon, 02 Mar 2009 10:53:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:organization:to:subject
         :date:user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=p9HwDNSP1Q9BfsQnKXx0XHv7e5xX61LfmUCGUJkN3ts=;
        b=somKWv5kG4lAMHihICgHwkHQdWsyy5ushcX2J0EuBuUQqo363GHZpG48j9pgrHHyzt
         TJZE1g5iliebtNFT7lQrzRFmrEthTmfg6a2/NFUVyva7n/8DMY1KsXtaSsrJscS9yNZH
         3+qoXQe7SWvR+JBVCDM6koMQYTfxfgWq6oAMc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:organization:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=EiMvSBQ59yIFJ23gkSuzwf1u8VQ4kvQtIFzYaKSQl+yzX8GVIBZzNvCbiJ0s0CI7CJ
         GMEvnZRDj6UaFWiSBmg5y4dmaY4AnjlDuO2GBcsosb01cFa3ZuRbyOvRTKTL5RxuLpa0
         9/BIEa4DituP0Hdeq+SytwaAbqz4hIeU8cy1Y=
Received: by 10.210.112.1 with SMTP id k1mr3457546ebc.47.1236020004619;
        Mon, 02 Mar 2009 10:53:24 -0800 (PST)
Received: from keydesk.localnet ([92.255.85.78])
        by mx.google.com with ESMTPS id 7sm221018eyb.38.2009.03.02.10.53.18
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 02 Mar 2009 10:53:19 -0800 (PST)
User-Agent: KMail/1.11.0 (Linux/2.6.27.12-170.2.5.fc10.i686; KDE/4.2.0; i686; ; )
In-Reply-To: <e2b179460903020951h7f1538daya4d3cdb96fc7c65d@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111958>

On Monday 02 March 2009 20:51:12 Mike Ralphson wrote:
> 2009/3/2 Chris Velevitch <chris.velevitch@gmail.com>:
> > I can't seem to find any utilities to convert a vss repository to git.
> > In the absence of such a tool, what is the best approach to converting
> > an vss repository to git?
> 
> You might be able to two-stage through vss2svn[1], and from there to git.
> Or take the guts of vss2* [2] and rewrite the backend to create git
> fast-import format?

Last year I experimented with conversion using vss2svn plus a heavily
patched version of git-svnimport, and it worked quite well. The largest
problem is that VSS cannot record directory copies, so the resulting
SVN repository does not have them either. This makes conversion tools
unable to detect any branching, so I had to implement support for
completely arbitrary mapping specs.

I also made an incremental synchronization script for simple actions
(requires logging to be enabled in VSS).

Alexander

P.S: I made some fixes to vss2svn too, they are in a separate branch:
  http://www.pumacode.org/projects/vss2svn/browser/branches/Alexander
