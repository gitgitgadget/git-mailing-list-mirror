From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH] Remove restriction on notes ref base
Date: Tue, 02 Nov 2010 23:58:11 +0100
Message-ID: <201011022358.11340.johan@herland.net>
References: <1288657003-17802-1-git-send-email-kroot@google.com>
 <AANLkTinN1UXSmkxOg59pT_xVd2eWS0Ms2sgAweLv7hbg@mail.gmail.com>
 <7vsjzj1v49.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>,
	Shawn Pearce <spearce@spearce.org>,
	Kenny Root <kroot@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Thomas Rast <trast@student.ethz.ch>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 02 23:58:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PDPo5-0001UM-RO
	for gcvg-git-2@lo.gmane.org; Tue, 02 Nov 2010 23:58:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751703Ab0KBW6P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Nov 2010 18:58:15 -0400
Received: from smtp.getmail.no ([84.208.15.66]:35433 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751059Ab0KBW6O (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Nov 2010 18:58:14 -0400
Received: from get-mta-scan01.get.basefarm.net ([10.5.16.4])
 by get-mta-out03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LBA005IR551EI30@get-mta-out03.get.basefarm.net> for
 git@vger.kernel.org; Tue, 02 Nov 2010 23:58:13 +0100 (MET)
Received: from get-mta-scan01.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id 27E9617991F7_CD09785B	for <git@vger.kernel.org>; Tue,
 02 Nov 2010 22:58:13 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan01.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id 7621A1797FA0_CD09784F	for <git@vger.kernel.org>; Tue,
 02 Nov 2010 22:58:12 +0000 (GMT)
Received: from alpha.localnet ([84.215.68.234])
 by get-mta-in02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LBA0031E550YH30@get-mta-in02.get.basefarm.net> for
 git@vger.kernel.org; Tue, 02 Nov 2010 23:58:12 +0100 (MET)
User-Agent: KMail/1.13.5 (Linux/2.6.35-ARCH; KDE/4.5.2; x86_64; ; )
In-reply-to: <7vsjzj1v49.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160561>

On Tuesday 02 November 2010, Junio C Hamano wrote:
> As to remote interface, refs/remotes/$remotes/ hierarchy corresponds to
> the local refs/heads/ interface, so I do not think we will change the
> default mapping we document (and have "clone" prepare) to place notes
> obtained from elsewhere in refs/remotes/ hierarchy (we do not do that for
> tags neither), so I think Johan's point is an independent issue.

I assume that means you'd rather have remote-tracking notes refs live under 
refs/notes. So, to avoid collisions with local notes refs (and remote-
tracking notes refs from _other_ remote), we probably want to store them 
under refs/notes/remotes/$remote/. I have no problem with that.

Although I'm starting to wonder whether our remote -> local refspec mappings 
are getting too varied (i.e. confusing). Currently we have:

  Remote repo    ->   Local repo
  ------------------------------------------------
  refs/heads/*        refs/remotes/$remote/*
  refs/tags/*         refs/tags/*

...and soon we may also have:
  refs/notes/*        refs/notes/remotes/$remote/*

Of these, the first is specified in the config, the second is 
implicit/magic, and the third would be specified in the config.


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
