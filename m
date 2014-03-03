From: David Aguilar <davvid@gmail.com>
Subject: Re: difftool sends malformed path to exernal tool on Windows
Date: Sun, 2 Mar 2014 16:35:23 -0800
Message-ID: <CAJDDKr751=c2AOBfjbg2_im6UCBvwWSVjJ7QX8=76vXMsLSw4g@mail.gmail.com>
References: <011301cf2c2d$90442810$b0cc7830$@lsst.org>
	<20140221103821.GA21414@gmail.com>
	<000801cf317f$ac1be2b0$0453a810$@lsst.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Paul Lotz <plotz@lsst.org>
X-From: git-owner@vger.kernel.org Mon Mar 03 01:35:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WKGrH-0000I8-B2
	for gcvg-git-2@plane.gmane.org; Mon, 03 Mar 2014 01:35:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753615AbaCCAfZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Mar 2014 19:35:25 -0500
Received: from mail-qc0-f175.google.com ([209.85.216.175]:51205 "EHLO
	mail-qc0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752274AbaCCAfY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Mar 2014 19:35:24 -0500
Received: by mail-qc0-f175.google.com with SMTP id e16so3113001qcx.34
        for <git@vger.kernel.org>; Sun, 02 Mar 2014 16:35:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=DW+fwl7L8X6s0g9d1FHyWQUjVNa5PH9zcanplcl7anQ=;
        b=zGnW0mAiB0++2W1BtlTzIw+Nq4X9t27PO5uc6vQq0T7QlIrz/hcenokSiygCBcXBWs
         QgnRApE2PA6tJHee09EpmZ4IRlC/92bvD0kh+HDrpVzxupKUaSgaj7hNRyao2HiFbz0G
         WmnxQPJr5ihVk1XId/N+Jymn6a53REIxZPY7Qg2GKTR+5Qw+PHL5SK7zLOEhaQ/eDp96
         BiBKqfBxg07pfuby5pBd1phZk6qHCr8La+C68CEcIKe8Udh1m3IhcBG9qEpPW6auL/MG
         KOTpxMPDESypcZU2KC4asaln8GUBOsT6CdQfQ/VCMx22p09b/ISvK677ec7rsG3bH8nk
         AwPg==
X-Received: by 10.224.114.78 with SMTP id d14mr19908014qaq.19.1393806923515;
 Sun, 02 Mar 2014 16:35:23 -0800 (PST)
Received: by 10.229.176.194 with HTTP; Sun, 2 Mar 2014 16:35:23 -0800 (PST)
In-Reply-To: <000801cf317f$ac1be2b0$0453a810$@lsst.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243169>

On Mon, Feb 24, 2014 at 8:44 AM, Paul Lotz <plotz@lsst.org> wrote:
> David,
>
> Thanks for the helpful reply.
>
> As you suggested, I modified the .gitconfig file to have:
> [difftool "test"]
>         cmd = echo \"$LOCAL\" \"$REMOTE\"
>
> and ran
> $ git difftool -t test
>
> An example of the the resulting console output is:
> C:/Users/Paul/AppData/Local/Temp/I8L2Bc_WriteTestParameters.vi Commands/StartAutomatedTest/WriteTestParameters.vi

Hmm. That's interesting.

The next test: replace "echo" with "cat".

Are the contents of both files printed?

If so, then the next thing to try is running:

LVCompare.exe [same paths printed by echo]

and then seeing if it does the right thing.

Could it be that LVCompare.exe is getting tripped up by the forward slashes?

I'm not familiar enough with how msysgit mangles paths before
launching programs. It may be that the C:/foo/bar/baz path is getting
manged (that's my current guess), but I really don't know.

Another tip I've read online is that launching git via "cmd.exe" may
avoid the path mangling. Sorry I'm not more helpful in this area.

Another workaround you can do is to place a shell script wrapper
around LVCompare.exe that replaces C:\/ with / and then launches the
real LVCompare.exe; that's a workaround, but it could work.

I hope that helps shed some light on what may be going on.
-- 
David
