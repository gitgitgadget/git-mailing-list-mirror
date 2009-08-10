From: Tony Finch <dot@dotat.at>
Subject: Re: [PATCH] fix potential infinite loop given large unsigned
 integer
Date: Mon, 10 Aug 2009 19:19:12 +0100
Message-ID: <alpine.LSU.2.00.0908101914470.14039@hermes-2.csi.cam.ac.uk>
References: <a3f15ee60908082141l7b2134cg5ddcef17c45fc888@mail.gmail.com> <7vy6pta4rd.fsf@alter.siamese.dyndns.org> <7v3a81a13z.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Ryan Flynn <parseerror@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 10 20:19:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MaZSu-0001rb-AS
	for gcvg-git-2@gmane.org; Mon, 10 Aug 2009 20:19:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751905AbZHJSTO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Aug 2009 14:19:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751549AbZHJSTO
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Aug 2009 14:19:14 -0400
Received: from ppsw-7.csi.cam.ac.uk ([131.111.8.137]:59121 "EHLO
	ppsw-7.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751499AbZHJSTO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Aug 2009 14:19:14 -0400
X-Cam-AntiVirus: no malware found
X-Cam-SpamDetails: not scanned
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Received: from hermes-2.csi.cam.ac.uk ([131.111.8.54]:42908)
	by ppsw-7.csi.cam.ac.uk (smtp.hermes.cam.ac.uk [131.111.8.157]:25)
	with esmtpa (EXTERNAL:fanf2) id 1MaZSi-0005qP-PL (Exim 4.70)
	(return-path <fanf2@hermes.cam.ac.uk>); Mon, 10 Aug 2009 19:19:12 +0100
Received: from fanf2 (helo=localhost) by hermes-2.csi.cam.ac.uk (hermes.cam.ac.uk)
	with local-esmtp id 1MaZSi-00047h-RG (Exim 4.67)
	(return-path <fanf2@hermes.cam.ac.uk>); Mon, 10 Aug 2009 19:19:12 +0100
X-X-Sender: fanf2@hermes-2.csi.cam.ac.uk
In-Reply-To: <7v3a81a13z.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.00 (LSU 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125495>

On Sun, 9 Aug 2009, Junio C Hamano wrote:

> +	if (numbered) {
> +		static char num_buf[64];
>  		rev.total = total + start_number - 1;
> +		sprintf(num_buf, "%d", rev.total);
> +		rev.num_width = strlen(num_buf);
> +	}

why not

	if (numbered) {
		rev.total = total + start_number - 1;
		rev.num_width = snprintf(NULL, 0, "%d", rev.total);
	}

?

Tony.
-- 
f.anthony.n.finch  <dot@dotat.at>  http://dotat.at/
GERMAN BIGHT HUMBER: SOUTHWEST 5 TO 7. MODERATE OR ROUGH. SQUALLY SHOWERS.
MODERATE OR GOOD.
