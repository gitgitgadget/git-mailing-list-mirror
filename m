From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [JGIT PATCH 1/2] Ensure that a PackFile instance stays invalid when overwritten
Date: Sun, 3 May 2009 10:05:57 +0200
Message-ID: <200905031005.57638.robin.rosenberg.lists@dewire.com>
References: <1241296230-19342-1-git-send-email-spearce@spearce.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sun May 03 10:06:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M0WiB-0002wZ-6K
	for gcvg-git-2@gmane.org; Sun, 03 May 2009 10:06:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754201AbZECIGE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 May 2009 04:06:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752705AbZECIGB
	(ORCPT <rfc822;git-outgoing>); Sun, 3 May 2009 04:06:01 -0400
Received: from mail.dewire.com ([83.140.172.130]:3820 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752565AbZECIGA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 May 2009 04:06:00 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 7896610233DD;
	Sun,  3 May 2009 10:05:59 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3gj0Yv06VAkh; Sun,  3 May 2009 10:05:59 +0200 (CEST)
Received: from sleipner.localnet (unknown [10.9.0.6])
	by dewire.com (Postfix) with ESMTP id 1E156800277;
	Sun,  3 May 2009 10:05:59 +0200 (CEST)
User-Agent: KMail/1.11.2 (Linux/2.6.28-11-generic; KDE/4.2.2; i686; ; )
In-Reply-To: <1241296230-19342-1-git-send-email-spearce@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118167>

> @@ -339,6 +351,8 @@ synchronized boolean endWindowCache() {
>  
>  	private void doOpen() throws IOException {
>  		try {
> +			if (invalid)
> +				throw new PackMismatchException("Pack checksum mismatch");
That /may/ be the case. We no longer know why the index failed to open. One way
is to save the reason, the other is not to be so d** sure and use a less specific
message.

-- robin
