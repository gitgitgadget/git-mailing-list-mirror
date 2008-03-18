From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH 03/16] more tr portability test script fixes
Date: Tue, 18 Mar 2008 23:23:02 +0100
Message-ID: <20080318222302.GA3450@steel.home>
References: <cover.1205356737.git.peff@peff.net> <20080312213106.GD26286@coredump.intra.peff.net>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Whit Armstrong <armstrong.whit@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Mar 19 23:41:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jc6yb-0001qE-Up
	for gcvg-git-2@gmane.org; Wed, 19 Mar 2008 23:41:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161918AbYCSWkY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Mar 2008 18:40:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161916AbYCSWkW
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Mar 2008 18:40:22 -0400
Received: from mo-p07-fb.rzone.de ([81.169.146.191]:29381 "EHLO
	mo-p07-fb.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755291AbYCSWkT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Mar 2008 18:40:19 -0400
Received: from mo-p07-ob.rzone.de (fruni-mo-p07-ob.mail [192.168.63.183])
	by gibbsson-fb-05.store (RZmta 16.11) with ESMTP id Y00af7k2IHRMfi
	for <git@vger.kernel.org>; Tue, 18 Mar 2008 23:39:41 +0100 (MET)
	(envelope-from: <raa.lkml@gmail.com>)
X-RZG-CLASS-ID: mo07
X-RZG-AUTH: z4gQVF2k5XWuW3Ccul2ggTG+sg==
Received: from tigra.home (Fa830.f.strato-dslnet.de [195.4.168.48])
	by post.webmailer.de (fruni mo27) (RZmta 16.13)
	with ESMTP id k03af0k2IKwGKI ; Tue, 18 Mar 2008 23:23:03 +0100 (MET)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id D8E45277BD;
	Tue, 18 Mar 2008 23:23:02 +0100 (CET)
Received: by steel.home (Postfix, from userid 1000)
	id 89EAA56D28; Tue, 18 Mar 2008 23:23:02 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20080312213106.GD26286@coredump.intra.peff.net>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77578>

Jeff King, Wed, Mar 12, 2008 22:31:06 +0100:
> -    tr '\000' '\012' <"$1" | sed -e "$sanitize_diff_raw_z" >.tmp-1
> -    tr '\000' '\012' <"$2" | sed -e "$sanitize_diff_raw_z" >.tmp-2
> +    perl -pe 'y/\000/\012/' <"$1" | sed -e "$sanitize_diff_raw_z" >.tmp-1
> +    perl -pe 'y/\000/\012/' <"$2" | sed -e "$sanitize_diff_raw_z" >.tmp-2

These break in presence of ActiveState Perl on Windows.

I suggest replacing such simple construction with a simplified,
in-tree, version of tr.

Patches follow
