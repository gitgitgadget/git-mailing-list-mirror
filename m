From: Dylan Grafmyre <dylang@conversica.com>
Subject: git grep argument parser bug
Date: Thu, 4 Feb 2016 14:02:52 -0800
Message-ID: <CANzEV58SgS6P_qBequGSfA0vFy9s0-KM3xOFaU2DDz_S3OyN3g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 04 23:03:10 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRRzN-0006ie-Fz
	for gcvg-git-2@plane.gmane.org; Thu, 04 Feb 2016 23:02:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755975AbcBDWCy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Feb 2016 17:02:54 -0500
Received: from mail-pa0-f43.google.com ([209.85.220.43]:34803 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755392AbcBDWCx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Feb 2016 17:02:53 -0500
Received: by mail-pa0-f43.google.com with SMTP id uo6so22579043pac.1
        for <git@vger.kernel.org>; Thu, 04 Feb 2016 14:02:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=conversica.com; s=google;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=D6wHifwPrJ5I9iIwH/xhGL2XpQyxvOF4yB9/7HWy6j8=;
        b=YosJ7ajbrgWSsY5XzMYMHEDXzYXAX0X9g0hYDTepUZii6lXkK3gwJMieJp1eWofm6O
         xg35vCpoZ1CCC0vYawsWuP7LMR4WbuNubF43ysLgkX0iwrTWQ/AmBKFaMLwnC5MmaZP3
         k1C7BJmEwCEae966yJ//3ezAQ5fP0y2dld9c8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to
         :content-type;
        bh=D6wHifwPrJ5I9iIwH/xhGL2XpQyxvOF4yB9/7HWy6j8=;
        b=RB8wGZpBd2oe7X/ssb2Fp+D71lb1s9AYO1W/ETxdheFT7KH1PMh+S5WQ5o8zPolBaD
         /rjypT07U16LRGcA4G5kffPqfQgJ5vfXJ61TR+2INJk7KMbPrFdapYN1FOZhSXXhCbh4
         vU4+p65IrpAcXma/Vhn8W5F02M8FwFlA2n8bItRGab+BIoKDhIYkTnXYYpjlUMnkLQ61
         XLre60cI0m56m5VAQrkWMNG6VdnVP/qjBok0vaMziK1wYBTlL1S/xngBoHcyAuG67nDv
         36+lW3qphc9fy5vw1D4NDrACGSMy6LFbr8rcvptugPdX9ipZEBvMMFI/QQSxWjD/sHb4
         eD+Q==
X-Gm-Message-State: AG10YOQyqs9qy+3cxak3l9FrIHgkgeV9CBgokMIWLpHgVLpDWVO//IdbEgSUL9vNZ72cfg6ggpyE04JAy1ujwA==
X-Received: by 10.66.232.202 with SMTP id tq10mr14716602pac.14.1454623372547;
 Thu, 04 Feb 2016 14:02:52 -0800 (PST)
Received: by 10.67.14.41 with HTTP; Thu, 4 Feb 2016 14:02:52 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285499>

In both ubuntu versions of git 1.9.1 and 2.7.0

    git grep '-test'
    git grep '--help'

Or any other expressions literal leading with a single dash or double
dash get interpreted as argument flags and not as search expressions.

What I expect is grep results for the literal strings "-test" and "--help"
What i get is git help output informing of wrong argument usage, or
accidentally turning on flags I didn't expect.

Work around; for afflicted users terminating argument parsing with `
-- ` works as it should.

    git grep -- '-test'

Confirmed on two Ubuntu [based] systems, Ubuntu Server 14.03 and
LinuxMint 17.3 [Cinnamon]

-- 
Dylan Grafmyre
Associate System Administrator

Email: DylanG@conversica.com
Office: +1 (888) 778 1004
Web:   www.conversica.com
