X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-rev-list: --objects list inconsistency
Date: Tue, 14 Nov 2006 09:58:04 -0800
Message-ID: <7vlkmdzz9v.fsf@assigned-by-dhcp.cox.net>
References: <4559E6A9.9A30A236@eudaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Tue, 14 Nov 2006 17:58:24 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <4559E6A9.9A30A236@eudaptics.com> (Johannes Sixt's message of
	"Tue, 14 Nov 2006 16:54:17 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31358>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gk2Y0-0001uj-Ua for gcvg-git@gmane.org; Tue, 14 Nov
 2006 18:58:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S966225AbWKNR6J (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 14 Nov 2006
 12:58:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966048AbWKNR6I
 (ORCPT <rfc822;git-outgoing>); Tue, 14 Nov 2006 12:58:08 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:37264 "EHLO
 fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP id S966226AbWKNR6F
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 14 Nov 2006 12:58:05 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao01.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061114175804.WSP9173.fed1rmmtao01.cox.net@fed1rmimpo02.cox.net>; Tue, 14
 Nov 2006 12:58:04 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id mhyA1V00v1kojtg0000000; Tue, 14 Nov 2006
 12:58:11 -0500
To: Johannes Sixt <J.Sixt@eudaptics.com>
Sender: git-owner@vger.kernel.org

Johannes Sixt <J.Sixt@eudaptics.com> writes:

> I observed a puzzling behavior of git-rev-list:
>
> $ git-rev-list master^^..master 
> f3364ca9405e17772fecea1d06c40b9965b8e6e4
> bb3bfda219a85d2d49e62c261b9c8f6795ebdc22
> $ git-rev-list --max-count=2 master 
> f3364ca9405e17772fecea1d06c40b9965b8e6e4
> bb3bfda219a85d2d49e62c261b9c8f6795ebdc22
> $ git-rev-list --objects master^^..master |wc -l
>      10

You are asking to get objects reachable from master but exclude
objects reachable from master^^.

> $ git-rev-list --objects --max-count=2 master |wc -l
>    2376

You are asking to get objects reachable from master and master^.

You have 2300+ objects that are common in trees of master,
master^ and master^^.
