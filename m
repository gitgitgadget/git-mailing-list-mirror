From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [FYI] pack idx format
Date: Wed, 15 Feb 2006 12:16:08 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0602151208181.9837@wbgn013.biozentrum.uni-wuerzburg.de>
References: <7vd5hpm2x0.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 15 12:16:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F9Kdr-0001HB-DY
	for gcvg-git@gmane.org; Wed, 15 Feb 2006 12:16:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422750AbWBOLQL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 15 Feb 2006 06:16:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422753AbWBOLQK
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Feb 2006 06:16:10 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:64983 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1422750AbWBOLQJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Feb 2006 06:16:09 -0500
Received: from virusscan.mail (amavis2.rz.uni-wuerzburg.de [132.187.3.47])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 1CCC014737B; Wed, 15 Feb 2006 12:16:09 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id 0BF20223C;
	Wed, 15 Feb 2006 12:16:09 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id DB04514737B; Wed, 15 Feb 2006 12:16:08 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vd5hpm2x0.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16234>

Hi,

On Wed, 15 Feb 2006, Junio C Hamano wrote:

> [...]
> 
> Before this main table, at the beginning of the idx file, there
> is a table of 256 4-byte network byte order integers.  This is
> called "first-level fan-out".  N-th entry of this table records
> the offset into the main index for the first object whose object
> name SHA1 starts with N+1.  fanout[255] points at the end of
> main index.  The offset is expressed in 24-bytes unit.

The description of the n-th entry is not completely correct. How about 
something like this:

The fan-out table is sort of an index to the main table: It contains 
offsets into the main table, and all SHA1s starting with byte b are 
between fanout[b-1] .. fanout[b]-1 (or if b==0 between 0 .. fanout[0]-1).

Comments?

Ciao,
Dscho
