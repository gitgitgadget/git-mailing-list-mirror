From: Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: Re: Git Newbie - GSoC mini Project
Date: Wed, 04 Mar 2015 08:49:46 +0100
Message-ID: <1425455386.1193.17.camel@kaarsemaker.net>
References: <CAMS+ib3LRT0xSzW-8Qkubbxc22RSifq=V8Za6TCrbDi2ko2ekA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Prudhvee Narasimha Sadha <prudhvi.sada@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 04 08:50:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YT448-0005Up-Ve
	for gcvg-git-2@plane.gmane.org; Wed, 04 Mar 2015 08:50:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935638AbbCDHtx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Mar 2015 02:49:53 -0500
Received: from mail-wi0-f172.google.com ([209.85.212.172]:38271 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933278AbbCDHtu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Mar 2015 02:49:50 -0500
Received: by wiwh11 with SMTP id h11so28524684wiw.3
        for <git@vger.kernel.org>; Tue, 03 Mar 2015 23:49:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:content-type:mime-version:content-transfer-encoding;
        bh=ucHm7D9m4IMdsx/HfhTEunP9eOaAbp4HuEqFNSW5QWY=;
        b=mHIyGQd/zgRqV3jVOyZZlG9oAAvpz+Yb7jV0FTyJcSffgLKCQObFOVg7BzLg9naj8w
         7kBH7foIbzz/bgCJiZ7cQ2Bz/wBD0+5IXC3KInRMc+UuxhWZ7hOYCSkBvoC+6/420Zif
         mFK4xD5QY5zgFZqp2CMT4Qa/jFSuTrTPenihqnHa2mAfSKgwXyn67PbDGoTe8ye3s6Gx
         426K54MiCwmmkpEidOHL1PQlGCAfhnhtqOTJ/WiQLbsvIF6MgY/h/uEC15tL8V2W1JQG
         LUTUX//5VQ5j31xteNUwUm/9nWhRhDaJGrI7+pb2O2B2QTMKoal6meUu2xw3mOUM9EAW
         cesA==
X-Gm-Message-State: ALoCoQmC9GjPFFhvvapjo0lnmKkeN4MM80tGgTgYd9Mv6Y9QptxPGkQGfBbRhfGi6/+Uz4ILMAPr
X-Received: by 10.194.8.99 with SMTP id q3mr5406506wja.88.1425455388535;
        Tue, 03 Mar 2015 23:49:48 -0800 (PST)
Received: from spirit.local (proxy-gw-l.booking.com. [5.57.20.8])
        by mx.google.com with ESMTPSA id uo6sm4680763wjc.49.2015.03.03.23.49.47
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Mar 2015 23:49:47 -0800 (PST)
In-Reply-To: <CAMS+ib3LRT0xSzW-8Qkubbxc22RSifq=V8Za6TCrbDi2ko2ekA@mail.gmail.com>
X-Mailer: Evolution 3.12.10-0ubuntu1~14.10.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264729>

On wo, 2015-03-04 at 11:50 +0530, Prudhvee Narasimha Sadha wrote:
>        I'm a newbie to git. I started  working on git. I cloned the
> git repository and started hacking it. I need a suggestion on how to
> start working on the micro project "
> 
> Make "git -C '' cmd" not to barf".

git -C '' cmd currently throws an error:

$ git -C '' status
fatal: Cannot change to '': No such file or directory

So the two things you should do are

- Determine what the desired behavior would be
- Implementing that behavior

For the first step, I'd send a mail to this list asking people for
input, paying special attention to the responses of the core maintainers
and possible GSOC mentors (I'm not one of them, but I think the error is
actually the right behavior, I'd prefer git -C "$repodir" to bomb out if
$repodir is unset. On the other hand cd '' is equivalent to not cd'ing
at all so there's precedent to change this).

For the second step, you'll need to find the bit of code where the -C
option is handled and add a special case for the empty string to do what
came out of the discussion about wanted behavior.

-- 
Dennis Kaarsemaker
www.kaarsemaker.net
