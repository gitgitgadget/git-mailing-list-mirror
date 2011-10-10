From: Alexey Shumkin <Alex.Crezoff@gmail.com>
Subject: Git bug. gitattributes' pattern does not respect spaces in the
 filenames
Date: Mon, 10 Oct 2011 11:02:21 +0400
Message-ID: <20111010110221.38e9985a@ashu.dyn.rarus.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 10 09:02:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RD9sm-00027c-Qa
	for gcvg-git-2@lo.gmane.org; Mon, 10 Oct 2011 09:02:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752389Ab1JJHC3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Oct 2011 03:02:29 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:56013 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752381Ab1JJHC1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Oct 2011 03:02:27 -0400
Received: by wyg34 with SMTP id 34so5560654wyg.19
        for <git@vger.kernel.org>; Mon, 10 Oct 2011 00:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rarus.ru; s=google;
        h=sender:date:from:to:subject:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=+iOaZAF/6Z23nVFyTgVtLH68Ap6s3pW2HQYDDCXqmLY=;
        b=lS27MteHXfDvepaWu0nENj6smXVTJESzcliazN5nw5WcRc0ihOMe16Ooo4iwAcRpIz
         Dhk4IiSCg5bi5nNHaB8BjhsOMCcpOmwnIlpiHkcZLsaaqn1Qv+h8nhE60knkJkz8A4VM
         X5NYD2E5FQ/MndeGpbiMNH6fgvkPNxr99/KdM=
Received: by 10.227.57.208 with SMTP id d16mr1564953wbh.55.1318230145024;
        Mon, 10 Oct 2011 00:02:25 -0700 (PDT)
Received: from ashu.dyn.rarus.ru (mail.rarus.ru. [213.247.194.83])
        by mx.google.com with ESMTPS id ep5sm799557wbb.12.2011.10.10.00.02.23
        (version=SSLv3 cipher=OTHER);
        Mon, 10 Oct 2011 00:02:24 -0700 (PDT)
X-Mailer: Claws Mail 3.7.9 (GTK+ 2.22.0; i386-redhat-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183228>

Hello everyone!

There's a description for the understanding of a
situation.
I have a project on Windows. I use Git under Cygwin.
There are some *.xml in the project. But some of them are in cp1251
encoding, another ones are in UTF-8. For the first ones there is no
need of any conversion to see the git-diff, but for the *.xml's in UTF-8
I set

*.xml diff=utf8-to-cp1251

And according to this I have
$ git config diff.utf8-to-cp1251.textconv 'iconv -f utf-8 -t cp1251'

Unfortunately, *.xml's in cp1251 DOES match this pattern, too.
As far as cp1251 and UTF-8 files are in different folders,
it is logically enough to set pattern like

<folder with a UTF-8-xmls>/*.xml diff=utf8-to-cp1251

for the UTF-8 files.
BUT!
Unfortunately, <folder with a UTF-8-xmls> have spaces in its name,
so textconv filter does not work because of error of
parsing .gitattributes

I have no enough skills to patch Git to fix this error.
Is anybody interested in to do?

Thanks
