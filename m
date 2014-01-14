From: "krzf83@gmail.com " <krzf83@gmail.com>
Subject: hooks scripts and noexec partition
Date: Tue, 14 Jan 2014 16:41:03 +0100
Message-ID: <CAJ1PRS=96aSp3GE+wj=zHX=JGfZbjUeiUuiDDvfJNuRhrbK_Yg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 14 16:41:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W3674-0005Xk-Mg
	for gcvg-git-2@plane.gmane.org; Tue, 14 Jan 2014 16:41:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751472AbaANPlG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Jan 2014 10:41:06 -0500
Received: from mail-qc0-f179.google.com ([209.85.216.179]:36754 "EHLO
	mail-qc0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751342AbaANPlF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Jan 2014 10:41:05 -0500
Received: by mail-qc0-f179.google.com with SMTP id e16so5544865qcx.24
        for <git@vger.kernel.org>; Tue, 14 Jan 2014 07:41:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=NaSXavJhdJecQkICdmXviNumQwxwo+D53pNIC/ltxQQ=;
        b=vuSXaB2RwYAI2dELgfadKSF+sJ/O8CX0f+yY2OyO2QvGWj9V27j7APt29Qj6YkrgFb
         v7HM9Ow7P76WpDWyHKx5KYVG446rujcOCVwoYEHdUKL8t0DzA5MwQB3uHC0ssUd9ulFc
         dTMd1/cEbKYgpg89YCFTSh1uZoQo9OAmmlTIMA+Hr4Uc7+FiM2TRfvWKuebSDLAOqCzh
         L8pV1u6DoOQ9DNJTj0zIFYphwSOGKEg7202MJxCFSznYrMG/ouJTZUXPlGo8ZlwQ4OPn
         H9xeAatB/vEvQ6S1y8GdEKrJcS+KZlimBPcBLaCYauiKLZHQx2R/hBOQwW32A5w1LOA1
         /+ow==
X-Received: by 10.49.127.205 with SMTP id ni13mr4216699qeb.40.1389714063945;
 Tue, 14 Jan 2014 07:41:03 -0800 (PST)
Received: by 10.229.185.10 with HTTP; Tue, 14 Jan 2014 07:41:03 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240400>

git can't execute hooks no partitions mounted with noexec - even if
those are just scripts with shebang line and they actualy work by
hooks/./post-comit (because I use small patch on kernel that allows
running scripts that way on noexec partition)

fs/exec.c

//        error = -EACCES;
//        if (file->f_path.mnt->mnt_flags & MNT_NOEXEC)
//                goto exit;
...
//        if (file->f_path.mnt->mnt_flags & MNT_NOEXEC)
//                goto exit;
