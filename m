From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 0/2] fast-import: tighten up parsing ident line
Date: Sat, 24 Apr 2010 15:38:27 -0500
Message-ID: <20100424203827.GA24948@progeny.tock>
References: <1272069944-20626-1-git-send-email-lodatom@gmail.com>
 <20100424160608.GA14690@progeny.tock>
 <20100424190419.GA7502@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mark Lodato <lodatom@gmail.com>, git@vger.kernel.org,
	Nicolas Pitre <nico@fluxnic.net>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Apr 24 22:38:04 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O5m71-0005Po-Uc
	for gcvg-git-2@lo.gmane.org; Sat, 24 Apr 2010 22:38:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753992Ab0DXUhx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Apr 2010 16:37:53 -0400
Received: from mail-yw0-f194.google.com ([209.85.211.194]:35787 "EHLO
	mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753118Ab0DXUhw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Apr 2010 16:37:52 -0400
Received: by ywh32 with SMTP id 32so6390958ywh.33
        for <git@vger.kernel.org>; Sat, 24 Apr 2010 13:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=EW3OESDmkxNiUDhYdwDhDXghGxAv58EgmTehFj3j1rI=;
        b=GL/wXa9xB+NQjQ8dqEiHEMjA0OKo4aZmIEOPGyj5DU4D9Dso9Q/FVJOluU4H4l7CGf
         kGg+8+lPS/bbvqYIQeR32CEQ2akseSqH5bWgs+L4QUOFrf7d2DenK1UbbFcX2ymzZz05
         VkfXFEwkL2HHS9rv2CFQ6SWWg3gWegl4a8BF4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=CgJzn41P7oY7Ez0czMSWP9C6OqXmD7ZsQOfJvi4b74jj1+vRwNFzWN+JUwRzXilbEG
         rWbGMSIPH5q7F0WP4CQp1TShwAUcoAtEQW+LNAUojha7KIahAzuaOQcLt64afy+NAHa7
         ByZhYiPTBZSp2uI5U0lE5dDcvt/GRoiq/VEFM=
Received: by 10.101.150.5 with SMTP id c5mr2285537ano.158.1272141471655;
        Sat, 24 Apr 2010 13:37:51 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 20sm1753047iwn.5.2010.04.24.13.37.50
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 24 Apr 2010 13:37:51 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100424190419.GA7502@spearce.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145702>

Shawn O. Pearce wrote:
> Jonathan Nieder <jrnieder@gmail.com> wrote:

>> git fast-import is capable of producing commits with some of these
>> problems: for example, it is fine with
>> 
>> 	committer C O Mitter <foo@b>ar.net> 005 -    +5
>
> Yuck.  We probably should tighten up the parser in fast-import a
> bit more.

How about this?

Jonathan Nieder (2):
  fast-import: be strict about formatting of dates
  fast-import: validate entire ident string

 Documentation/git-fast-import.txt |    9 ++--
 fast-import.c                     |   63 ++++++++++++++--------
 t/t9300-fast-import.sh            |  105 +++++++++++++++++++++++++++++++++++++
 3 files changed, 150 insertions(+), 27 deletions(-)
