From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC PATCH v2 3/4] unpack_trees(): add support for sparse
 checkout
Date: Mon, 10 Aug 2009 18:41:17 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0908101837510.8324@intel-tinevez-2-302>
References: <1249917562-5931-1-git-send-email-pclouds@gmail.com> <1249917562-5931-2-git-send-email-pclouds@gmail.com> <1249917562-5931-3-git-send-email-pclouds@gmail.com> <1249917562-5931-4-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-1098058971-1249922477=:8324"
Cc: git@vger.kernel.org
To: =?VISCII?Q?Nguy=ADn_Th=E1i_Ng=F7c_Duy?= <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 10 18:41:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MaXwC-0005Ru-Nk
	for gcvg-git-2@gmane.org; Mon, 10 Aug 2009 18:41:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755621AbZHJQlT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Aug 2009 12:41:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755538AbZHJQlT
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Aug 2009 12:41:19 -0400
Received: from mail.gmx.net ([213.165.64.20]:43329 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755350AbZHJQlS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Aug 2009 12:41:18 -0400
Received: (qmail invoked by alias); 10 Aug 2009 16:41:18 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp040) with SMTP; 10 Aug 2009 18:41:18 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+8SgUu5du8eux6Fy5qvpzLjo4kBbYA+BzUtYaIMK
	T01BvbdCVjIxVB
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <1249917562-5931-4-git-send-email-pclouds@gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6899999999999999
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125485>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1098058971-1249922477=:8324
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Hi,

On Mon, 10 Aug 2009, Nguyễn Thái Ngọc Duy wrote:

> This patch teaches unpack_trees() to checkout/remove entries on working 
> directories appropriately when sparse checkout area is changed. Hook 
> "sparse" is needed to help determine which entry will be checked out, 
> which will not be.
> 
> When the hook is run, it is prepared with a pseudo index. The hook then 
> can use "git update-index --[no-]assume-unchanged" to manipulate the 
> index. It should not do anything else on the index. Assume unchanged 
> information from the index will be used to shape working directory.

If I understand correctly, the purpose of the hook is to allow the user to 
mark something as unwanted preemptively, right?

If that is the sole reason for the hook, would it not be better to add 
support for a file .git/info/sparse which has the same syntax as 
.git/info/exclude, and which is used to determine if an 
added/modified/deleted file is supposed to be in the "sparse" area or not?

Something like

	*
	!/Documentation/

comes to mind.

Thanks,
Dscho
--8323329-1098058971-1249922477=:8324--
