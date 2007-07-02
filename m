From: Andrew Morton <akpm@linux-foundation.org>
Subject: being nice to patch(1)
Date: Mon, 2 Jul 2007 12:54:50 -0700
Message-ID: <20070702125450.28228edd.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 02 21:55:05 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I5RzA-0003M0-IV
	for gcvg-git@gmane.org; Mon, 02 Jul 2007 21:55:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753449AbXGBTy6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 2 Jul 2007 15:54:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753512AbXGBTy6
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Jul 2007 15:54:58 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:48330 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752880AbXGBTy5 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 2 Jul 2007 15:54:57 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l62Jst4E005234
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Mon, 2 Jul 2007 12:54:56 -0700
Received: from akpm.corp.google.com (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with SMTP id l62JsoSV003669
	for <git@vger.kernel.org>; Mon, 2 Jul 2007 12:54:50 -0700
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
X-Spam-Status: No, hits=-2.709 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.181 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51398>


James's current git-scsi-misc has this commit in it:


commit a16efc1cbf0a9e5ea9f99ae98fb774b60d05c35b
Author: Kars de Jong <jongk@linux-m68k.org>
Date:   Sun Jun 17 14:47:08 2007 +0200

[SCSI] 53c700: Amiga 4000T NCR53c710 SCSI
    
    New driver for the Amiga 4000T built-in NCR53c710 SCSI controller, using the
    53c700 SCSI core.
    
    Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
    Signed-off-by: James Bottomley <James.Bottomley@SteelEye.com>


When one pulls that diff out of git with `git-show' or whatever, it doesn't
work - patch(1) has a heart attack over the "53c700":


|commit f98754960a9b25057ad5f249f877b3d6fab889ce
|Author: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
|Date:   Mon May 14 20:25:31 2007 +0900
|
|    [SCSI] hptiop: convert to use the data buffer accessors
|    
|    - remove the unnecessary map_single path.
|    
|    - convert to use the new accessors for the sg lists and the
|    parameters.
|    
|    Jens Axboe <jens.axboe@oracle.com> did the for_each_sg cleanup.
|    
|    Signed-off-by: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
|    Acked-by: HighPoint Linux Team <linux@highpoint-tech.com>
|    Signed-off-by: James Bottomley <James.Bottomley@SteelEye.com>
|
|commit a16efc1cbf0a9e5ea9f99ae98fb774b60d05c35b
|Author: Kars de Jong <jongk@linux-m68k.org>
|Date:   Sun Jun 17 14:47:08 2007 +0200
|
|    [SCSI] 53c700: Amiga 4000T NCR53c710 SCSI
|    
|    New driver for the Amiga 4000T built-in NCR53c710 SCSI controller, using the
--------------------------
File to patch: 




This I assume is because ^[ ]*<number>c<number> is a magic marker for
contextual diffs.

So...  if someone is feeling really, really, really bored one day, it would
be nice to teach git to somehow escape such patch-magic-patterns in the
changelog when emitting plain old patches.
