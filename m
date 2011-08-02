From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 17/18] revert: Introduce --continue to continue the operation
Date: Tue, 2 Aug 2011 04:51:35 +0200
Message-ID: <201108020451.36617.chriscool@tuxfamily.org>
References: <1312222025-28453-1-git-send-email-artagnon@gmail.com> <201108020436.42148.chriscool@tuxfamily.org> <201108020447.02545.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 02 04:51:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qo55C-0001bk-CI
	for gcvg-git-2@lo.gmane.org; Tue, 02 Aug 2011 04:51:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753913Ab1HBCvq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Aug 2011 22:51:46 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:46104 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753878Ab1HBCvp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Aug 2011 22:51:45 -0400
Received: from style.localnet (unknown [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 24B36A6133;
	Tue,  2 Aug 2011 04:51:37 +0200 (CEST)
User-Agent: KMail/1.13.6 (Linux/2.6.38-8-generic; KDE/4.6.2; x86_64; ; )
In-Reply-To: <201108020447.02545.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178435>

On Tuesday 02 August 2011 04:47:01 Christian Couder wrote:
> We can simplify this loop using strchrnul() like this:
> 
>  	for (i = 1; *p; i++) {
>  		struct commit *commit = parse_insn_line(p, opts);
>  		if (!commit)
>  			return error(_("Could not parse line %d."), i);
>  		next = commit_list_append(commit, next);
>  		p = strchrnul(p, '\n');
>  	}

Ooops, sorry I mean like this:

	for (i = 1; *p; i++) {
		struct commit *commit = parse_insn_line(p, opts);
		if (!commit)
			return error(_("Could not parse line %d."), i);
		next = commit_list_append(commit, next);
		p = strchrnul(p, '\n');
		if (*p)
			p++;
	}

Thanks,
Christian.
