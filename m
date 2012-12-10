From: Soren Brinkmann <soren.brinkmann@xilinx.com>
Subject: Re: [PATCH] git-clean: Display more accurate delete messages
Date: Mon, 10 Dec 2012 09:33:56 -0800
Message-ID: <5b69a9f1-0860-41da-914c-d55a17e54092@TX2EHSMHS026.ehs.local>
References: <1354788938-26804-1-git-send-email-zoltan.klinger@gmail.com>
 <7v8v9bjd44.fsf@alter.siamese.dyndns.org>
 <7d290bdc-8654-4526-ba73-89408fa99a16@DB3EHSMHS002.ehs.local>
 <CAKJhZwROXsTa4wu-C9rhfGysetL+cZRDECyFUn5VTb833pWzMQ@mail.gmail.com>
 <7v38zecrqc.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: Zoltan Klinger <zoltan.klinger@gmail.com>,
	Soren Brinkmann <soren.brinkmann@xilinx.com>,
	<git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 10 18:34:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ti7Fn-0004wc-Hq
	for gcvg-git-2@plane.gmane.org; Mon, 10 Dec 2012 18:34:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752322Ab2LJReL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Dec 2012 12:34:11 -0500
Received: from tx2ehsobe003.messaging.microsoft.com ([65.55.88.13]:4945 "EHLO
	tx2outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751549Ab2LJReH (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Dec 2012 12:34:07 -0500
Received: from mail130-tx2-R.bigfish.com (10.9.14.237) by
 TX2EHSOBE007.bigfish.com (10.9.40.27) with Microsoft SMTP Server id
 14.1.225.23; Mon, 10 Dec 2012 17:34:06 +0000
Received: from mail130-tx2 (localhost [127.0.0.1])	by
 mail130-tx2-R.bigfish.com (Postfix) with ESMTP id 6D6AE4E0124;	Mon, 10 Dec
 2012 17:34:06 +0000 (UTC)
X-Forefront-Antispam-Report: CIP:149.199.60.83;KIP:(null);UIP:(null);IPV:NLI;H:xsj-gw1;RD:unknown-60-83.xilinx.com;EFVD:NLI
X-SpamScore: -1
X-BigFish: VPS-1(zz98dI1432Izz1de0h1202h1e76h1d1ah1d2ahzz8275bhz2fh95h668h839h93fhd24hf0ah119dh1288h12a5h12a9h12bdh137ah13b6h1441h14ddh1504h1537h153bh162dh1631h1758h906i1155h)
Received-SPF: pass (mail130-tx2: domain of xilinx.com designates 149.199.60.83 as permitted sender) client-ip=149.199.60.83; envelope-from=soren.brinkmann@xilinx.com; helo=xsj-gw1 ;helo=xsj-gw1 ;
Received: from mail130-tx2 (localhost.localdomain [127.0.0.1]) by mail130-tx2
 (MessageSwitch) id 1355160844716798_2412; Mon, 10 Dec 2012 17:34:04 +0000
 (UTC)
Received: from TX2EHSMHS026.bigfish.com (unknown [10.9.14.237])	by
 mail130-tx2.bigfish.com (Postfix) with ESMTP id A171B14004C;	Mon, 10 Dec 2012
 17:34:04 +0000 (UTC)
Received: from xsj-gw1 (149.199.60.83) by TX2EHSMHS026.bigfish.com
 (10.9.99.126) with Microsoft SMTP Server id 14.1.225.23; Mon, 10 Dec 2012
 17:34:02 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]
 helo=xsj-smtp1.xilinx.com)	by xsj-gw1 with esmtp (Exim 4.63)	(envelope-from
 <soren.brinkmann@xilinx.com>)	id 1Ti7Ew-0002Qw-IC; Mon, 10 Dec 2012 09:34:02
 -0800
Content-Disposition: inline
In-Reply-To: <7v38zecrqc.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-RCIS-Action: ALLOW
X-OriginatorOrg: xilinx.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211264>

Hi, 

On Sun, Dec 09, 2012 at 11:04:59PM -0800, Junio C Hamano wrote:
> Zoltan Klinger <zoltan.klinger@gmail.com> writes:
> 
> > Would like to get some more feedback on the proposed output in case of
> >  (1) an untracked subdirectory with multiple files where at least one of them
> >      cannot be removed.
> >  (2) reporting ignored untracked git subdirectories
> >
> > Suppose we have a repo like the one below:
> >   test.git/
> >     |-- tracked_file
> >     |-- untracked_file
> >     |-- untracked_foo/
> >     |     |-- bar/
> >     |     |     |-- bar.txt
> >     |     |-- emptydir/
> >     |     |-- frotz.git/
> >     |     |     |-- frotx.txt
> >     |     |-- quux/
> >     |           |-- failedquux.txt
> >     |           |-- quux.txt
> >     |-- untracked_unreadable_dir/
> >     |     |-- afile
> >     |-- untracked_some.git/
> >           |-- some.txt
> >
> > $ git clean -fd
> > Removing untracked_file
> > Removing untracked_foo/bar
> > Removing untracked_foo/emptydir
> > Removing untracked_foo/quux/quux.txt
> > warning: failed to remove untracked_foo/quux/failedquux.txt
> > warning: failed to remove remove untracked_unreadable_dir/
> 
> "remove remove" is a typo, I presume.
> 
> > warning: ignoring untracked git repository untracked_foo/frotz.git/
> > warning: ignoring untracked git repository untracked_some.git/
> 
> If you mean "we report the topmost directory and nothing about
> (recursive) contents in it if everything is removed successfully"
> (in other words, if we had subdirectories and files inside
> untracked_foo/bar/ and we successfully removed all of them, the
> above output does not change), it seems quite reasonable.
> 
> > Use git clean --force --force to delete all untracked git repositories
> 
> But I am not sure if this is ever sane.  Especially the one that
> removes an embedded repository is suspicious.  "git clean" should
> not ever touch it with or without --superforce or any other command.
As I mentioned in my email where I reported this incorrect git clean output, I
have a use case where I want git clean to remove embedded repositories.
Whether it is a sane one is probably a different discussion.

	Soren
