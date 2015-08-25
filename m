From: Anish Athalye <anish.athalye@gmail.com>
Subject: Re: git-remote-helper behavior on Windows, not recognizing blank line as terminator
Date: Mon, 24 Aug 2015 18:52:15 -0700
Message-ID: <304662DC-3759-4482-A06C-3286FD45457F@gmail.com>
References: <CAFQ6zU1bdUwn+P3=1v2DoyVubMFz29ZuxHmnZ0pfezA-0MB+mQ@mail.gmail.com> <20150824092418.GF1412@serenity.lan>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Tue Aug 25 03:52:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZU3PS-00049S-HY
	for gcvg-git-2@plane.gmane.org; Tue, 25 Aug 2015 03:52:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754122AbbHYBwS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Aug 2015 21:52:18 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:34495 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751060AbbHYBwR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 24 Aug 2015 21:52:17 -0400
Received: by pabzx8 with SMTP id zx8so19652397pab.1
        for <git@vger.kernel.org>; Mon, 24 Aug 2015 18:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=references:mime-version:in-reply-to:content-type
         :content-transfer-encoding:message-id:cc:from:subject:date:to;
        bh=kP9cB3ykzxR71UvntwAhMYhWG2BzSzz59lX0hBXAMr4=;
        b=lNVwz43wyxjksEZd5ZBAijDtVBAIK6o3bXN/jcyrHwzLcnsQgT40zjVm1mv7v/nQyY
         URASG9nfVhXf3yB/pIDwG1g97HmBvlL3xlPT74bCJ/bvrX7Ebqf5TUqupACxPJ8AsSyx
         um+Vi83rxMa3hX5obS7JE2l/Ge68YqG121FfwewwLQcN6G4xYyV/t89IDtfPQsAaEGIl
         re9+xQAmHsnLBzPRWP9TF4UM0T44K+RSHD+suc5qTyzCmZMdm/8yPLL7eIL9IxogizwL
         iwc8Nxhn1reGqNoXaHukzksc+u87gbsKxaluM+LhluhGfS8jB4V1XHa70GJ69GCm78kW
         Q2kg==
X-Received: by 10.66.62.229 with SMTP id b5mr50661471pas.81.1440467536732;
        Mon, 24 Aug 2015 18:52:16 -0700 (PDT)
Received: from [192.168.77.225] ([205.189.0.149])
        by smtp.gmail.com with ESMTPSA id o7sm18884439pdr.25.2015.08.24.18.52.16
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 24 Aug 2015 18:52:16 -0700 (PDT)
In-Reply-To: <20150824092418.GF1412@serenity.lan>
X-Mailer: iPhone Mail (12F70)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276502>

Wow, yeah, that was it. Thanks for your help!



> On Aug 24, 2015, at 2:24 AM, John Keeping <john@keeping.me.uk> wrote:
> 
>> On Sun, Aug 23, 2015 at 11:40:17AM -0700, Anish Athalye wrote:
>> I'm having some issues with git remote helper behavior on Windows.
>> 
>> According to the protocol
>> (https://www.kernel.org/pub/software/scm/git/docs/gitremote-helpers.html),
>> when doing things like listing capabilities, git expects the remote
>> helper to send back a blank line when it's done.
>> 
>> I'm having trouble having git recognize the blank line (see
>> https://github.com/anishathalye/git-remote-dropbox/issues/13#issuecomment-133894730
>> for details).
>> 
>> Has anyone come across this behavior before? Am I doing something
>> wrong, or could there be a bug in git? What's the best way to proceed?
>> 
>> 
>> Any help or suggestions would be greatly appreciated!
> 
> The remote-helper parser tends to be very strict about its input.  I
> suspect that on Windows you are sending CRLF rather than LF, so Git sees
> a line containing CR.
> 
> By default the stdio streams are probably open in "text" mode, which
> will convert "\n" to "\r\n".  You probably need to reopen stdout in
> binary mode to make sure the output is correct.
