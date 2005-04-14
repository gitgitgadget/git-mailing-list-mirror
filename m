From: Christopher Li <git@chrisli.org>
Subject: Re: Yet another base64 patch
Date: Wed, 13 Apr 2005 22:42:28 -0400
Message-ID: <20050414024228.GC18655@64m.dyndns.org>
References: <425DEF64.60108@zytor.com> <20050414022413.GB18655@64m.dyndns.org> <425E0174.4080404@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 14 07:49:41 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DLxE7-0002RY-TF
	for gcvg-git@gmane.org; Thu, 14 Apr 2005 07:49:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261287AbVDNFw0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Apr 2005 01:52:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261429AbVDNFw0
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Apr 2005 01:52:26 -0400
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:14819 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S261287AbVDNFwV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Apr 2005 01:52:21 -0400
Received: from localhost.localdomain (c-24-6-236-77.hsd1.ca.comcast.net[24.6.236.77])
          by comcast.net (rwcrmhc12) with ESMTP
          id <2005041405522001400hbd71e>; Thu, 14 Apr 2005 05:52:20 +0000
Received: by localhost.localdomain (Postfix, from userid 1027)
	id 55F1C3F1EF; Wed, 13 Apr 2005 22:42:28 -0400 (EDT)
To: "H. Peter Anvin" <hpa@zytor.com>
Content-Disposition: inline
In-Reply-To: <425E0174.4080404@zytor.com>
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 13, 2005 at 10:36:52PM -0700, H. Peter Anvin wrote:
> Christopher Li wrote:
> >On Wed, Apr 13, 2005 at 09:19:48PM -0700, H. Peter Anvin wrote:
> >
> >That is not surprising due to the directory index in ext3. Htree is pretty
> >good at random access and the hashed file name distribute evenly, that is
> >the best case for htree. 
> >
> 
> Right, so by not trying to do the filesystem's job for it we actually 
> come out ahead.
>

But if you write a large number of random files, when htree has three
levels index. htree will suffer on the effect that it dirty random block
very quickly, most block get dirty only contain one or two new entries.
Ext3 will choke on it due to the limited journal size.

While non-index directory, new entry are very compact on the blocks.
So it end up dirty a lot less blocks, of course, lookup will suffer.

Depend on you want check out fast or write a big tree fast, you can't
win it all.

Chris

 
