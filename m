From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: Git Gui does not want to work on chunk level
Date: Mon, 15 Sep 2008 09:08:31 +0200
Message-ID: <48CE09EF.7090609@viscovery.net>
References: <c6c947f60808270216k2feb8f9ar765cdee1fc3910ee@mail.gmail.com> <c6c947f60809031223i575ca3fdya357588610bb72e8@mail.gmail.com> <20080903230814.GJ28315@spearce.org> <c6c947f60809040220t589e65bfkbd693fd335792069@mail.gmail.com> <20080904143723.GB23708@spearce.org> <c6c947f60809040754g34e60633lcd5f872ac5e80158@mail.gmail.com> <20080905045327.GA31166@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Alexander Gladysh <agladysh@gmail.com>, git-users@googlegroups.com,
	git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Sep 15 09:11:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kf8Ez-0007UV-6W
	for gcvg-git-2@gmane.org; Mon, 15 Sep 2008 09:11:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752112AbYIOHIp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Sep 2008 03:08:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752104AbYIOHIp
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Sep 2008 03:08:45 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:12857 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752018AbYIOHIp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Sep 2008 03:08:45 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Kf8CM-0003Zf-Sh; Mon, 15 Sep 2008 09:08:39 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 5E57F69F; Mon, 15 Sep 2008 09:08:31 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <20080905045327.GA31166@spearce.org>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95884>

Shawn O. Pearce schrieb:
> git-gui: Fix diff parsing for lines starting with "--" or "++"
> 
> Languages like Lua and SQL use "--" to mark a line as commented out.
> If this appears at column 0 and is part of the pre-image we may see
> "--- foo" in the diff, indicating that the line whose content is
>  "-- foo" has been removed from the new version.
> 
> git-gui was incorrectly parsing "--- foo" as the old file name
> in the file header, causing it to generate a bad patch file when
> the user tried to stage or unstage a hunk or the selected line.
> We need to keep track of where we are in the parsing so that we do
> not misread a deletion or addition record as part of the header.

This (slightly) breaks parsing of new files and removed files that are
staged by showing the file names in the diff header:

 new file mode 100644
 --- /dev/null
 +++ b/foo
 @@ -0,0 +1 @@
 +foo

-- Hannes
