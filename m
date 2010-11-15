From: Drew Northup <drew.northup@maine.edu>
Subject: Re: Multiple clients accessing git over NFS
Date: Mon, 15 Nov 2010 15:44:18 -0500
Message-ID: <1289853858.9996.14.camel@drew-northup.unet.maine.edu>
References: <AANLkTimyFkVFAw4s2fiWKZFPvnx15K6U6GbxmRgznx7Z@mail.gmail.com>
	 <rmi39r3mrf6.fsf@fnord.ir.bbn.com>
	 <AANLkTim1bUbofDzC5HJnB--0WkT45ewbWCa25RebEgae@mail.gmail.com>
	 <20101115195641.GG30870@efreet.light.src>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jan Hudec <bulb@ucw.cz>
To: Khawaja Shams <kshams@usc.edu>
X-From: git-owner@vger.kernel.org Mon Nov 15 21:52:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PI628-0000mD-6x
	for gcvg-git-2@lo.gmane.org; Mon, 15 Nov 2010 21:52:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758339Ab0KOUwG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Nov 2010 15:52:06 -0500
Received: from basalt.its.maine.edu ([130.111.32.66]:46312 "EHLO
	basalt.its.maine.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758303Ab0KOUwF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Nov 2010 15:52:05 -0500
Received: from [IPv6:2610:48:100:827:211:43ff:fe9f:cb7e] (drew-northup.unet.maine.edu [IPv6:2610:48:100:827:211:43ff:fe9f:cb7e])
	by basalt.its.maine.edu (8.13.8/8.13.8) with ESMTP id oAFKiOTC013569
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 15 Nov 2010 15:44:29 -0500
In-Reply-To: <20101115195641.GG30870@efreet.light.src>
X-Mailer: Evolution 2.12.3 (2.12.3-8.el5_2.3) 
X-DCC-UniversityOfMaineSystem-Metrics: basalt.its.maine.edu 1003; Body=3
	Fuz1=3 Fuz2=3
X-MailScanner-Information: Please contact the ISP for more information
X-UmaineSystem-MailScanner-ID: oAFKiOTC013569
X-MailScanner: Found to be clean
X-MailScanner-From: drew.northup@maine.edu
X-UmaineSystem-MailScanner-Watermark: 1290458736.70285@OI6n80Mb/sy3QnpGRl0I2A
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161513>


On Mon, 2010-11-15 at 20:56 +0100, Jan Hudec wrote:
> On Sun, Nov 14, 2010 at 15:42:29 -0800, Khawaja Shams wrote:
> > Hi Greg,
> >    Thank you for the insightful response. We have multiple automated
> > clients pushing and pulling changes from git as events occur. We have
> > not hit any real performance issues just yet. Our main goal is to
> > improve the availability of the repository in case the box running the
> > apache server has an outage during a mission critical period.
> 
> If you are out for availability, NFS isn't an answer, because the NFS server
> remains a single point of failure. There are distributed filesystems
> (Gluster, Lustre etc.) that can provide redundancy of storage nodes too or
> you could have shared storage array with appropriate filesystem (GlobalFS,
> OCFS2, etc.), but that requires special hardware. These will probably give
> you better performance too -- git network protocol is optimized to send
> minimal data, but that often means a lot more needs to be read from the disk.
> 
> I don't have personal experience with them though, so I can't give you more
> specific recommendation.

Khawaja,
I haven't tried setting a server up with it yet, but perhaps DRDB
mirrored devices may be of use? At that point then you have a way of
making all of your HTTPd instances "see" the same filesystem (and will
have notification options for when they do not). It probably isn't
perfect, but may be worth looking into if your SAN cannot provide
downtime-less NFS. As an added benefit, there is no longer a requirement
that all of your front-ends be co-located (physically or logically).

-- 
-Drew Northup N1XIM
   AKA RvnPhnx on OPN
________________________________________________
"As opposed to vegetable or mineral error?"
-John Pescatore, SANS NewsBites Vol. 12 Num. 59
