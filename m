From: Soren Brinkmann <soren.brinkmann@xilinx.com>
Subject: Re: [PATCH] git-clean: Display more accurate delete messages
Date: Thu, 6 Dec 2012 16:15:59 -0800
Message-ID: <7d290bdc-8654-4526-ba73-89408fa99a16@DB3EHSMHS002.ehs.local>
References: <1354788938-26804-1-git-send-email-zoltan.klinger@gmail.com>
 <7v8v9bjd44.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: Zoltan Klinger <zoltan.klinger@gmail.com>, <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 07 01:16:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tglc4-0008LG-US
	for gcvg-git-2@plane.gmane.org; Fri, 07 Dec 2012 01:16:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932363Ab2LGAQH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Dec 2012 19:16:07 -0500
Received: from db3ehsobe004.messaging.microsoft.com ([213.199.154.142]:3222
	"EHLO db3outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932208Ab2LGAQF (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 6 Dec 2012 19:16:05 -0500
Received: from mail112-db3-R.bigfish.com (10.3.81.254) by
 DB3EHSOBE008.bigfish.com (10.3.84.28) with Microsoft SMTP Server id
 14.1.225.23; Fri, 7 Dec 2012 00:16:04 +0000
Received: from mail112-db3 (localhost [127.0.0.1])	by
 mail112-db3-R.bigfish.com (Postfix) with ESMTP id 07C302025E;	Fri,  7 Dec
 2012 00:16:04 +0000 (UTC)
X-Forefront-Antispam-Report: CIP:149.199.60.83;KIP:(null);UIP:(null);IPV:NLI;H:xsj-gw1;RD:unknown-60-83.xilinx.com;EFVD:NLI
X-SpamScore: 0
X-BigFish: VPS0(zz98dI1432Izz1de0h1202h1e76h1d1ah1d2ahzz8275bhz32i95h668h839h93fhd24hf0ah119dh1288h12a5h12a9h12bdh137ah13b6h1441h14ddh1504h1537h153bh162dh1631h1758h906i1155h)
Received-SPF: permerror (mail112-db3: error in processing during lookup of domain of xilinx.com: Could not find a valid SPF record) client-ip=149.199.60.83; envelope-from=soren.brinkmann@xilinx.com; helo=xsj-gw1 ;helo=xsj-gw1 ;
Received: from mail112-db3 (localhost.localdomain [127.0.0.1]) by mail112-db3
 (MessageSwitch) id 1354839362325308_26807; Fri,  7 Dec 2012 00:16:02 +0000
 (UTC)
Received: from DB3EHSMHS002.bigfish.com (unknown [10.3.81.233])	by
 mail112-db3.bigfish.com (Postfix) with ESMTP id 4C909100060;	Fri,  7 Dec 2012
 00:16:02 +0000 (UTC)
Received: from xsj-gw1 (149.199.60.83) by DB3EHSMHS002.bigfish.com
 (10.3.87.102) with Microsoft SMTP Server id 14.1.225.23; Fri, 7 Dec 2012
 00:16:01 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]
 helo=xsj-smtp1.xilinx.com)	by xsj-gw1 with esmtp (Exim 4.63)	(envelope-from
 <soren.brinkmann@xilinx.com>)	id 1Tglbk-0004Rp-LG; Thu, 06 Dec 2012 16:16:00
 -0800
Content-Disposition: inline
In-Reply-To: <7v8v9bjd44.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-RCIS-Action: ALLOW
X-OriginatorOrg: xilinx.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211172>

Hi,

On Thu, Dec 06, 2012 at 09:37:31AM -0800, Junio C Hamano wrote:
> Zoltan Klinger <zoltan.klinger@gmail.com> writes:
> 
> > Only print out the names of the files and directories that got actually
> > deleted.
> >
> > Consider the following repo layout:
> >   |-- test.git/
> >         |-- foo/
> >              |-- bar/
> >                   |-- bar.txt
> >              |-- frotz.git/
> >                   |-- frotz.txt
> >         |-- tracked_file1
> >         |-- untracked_file1
> > ...
> > Consider the output of the improved version:
> >
> >   $ git clean -fd
> >   Removed foo/bar/bar.txt
> >   Removed foo/bar
> >   Removed untracked_file1
> 
> Hrm, following your discussion (ellided above), I would have
> expected that you would show
> 
>     Removing directory foo/bar
>     Removing untracked_file1

Also it would be nice to have warnings about undeleted directories since this git
clean behavior (or the work around to pass -f twice) is not documented.
Without a warning you would probably miss that something was _not_ deleted.

So something like:
	Removing foo
	Removing bar
	...

	Warning: Not all untracked objects have been deleted:
	<list objects here> (optional)
	Use git clean --force --force to delete all objects.


But clearly going into a good direction. Thanks.

	Soren
