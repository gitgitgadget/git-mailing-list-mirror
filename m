From: Paolo Bonzini <paolo.bonzini@gmail.com>
Subject: Re: [PATCH] git-format-patch, git-send-email: generate/handle escaped
   >From
Date: Sun, 28 Jun 2009 09:52:12 +0200
Message-ID: <4A47212C.5070000@gmail.com>
References: <1244714434-20794-1-git-send-email-bonzini@gnu.org> <20090611105538.GA4409@coredump.intra.peff.net> <4A30F16C.5040207@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 28 09:54:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MKpDA-0005FT-1R
	for gcvg-git-2@gmane.org; Sun, 28 Jun 2009 09:54:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751804AbZF1HwS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Jun 2009 03:52:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751785AbZF1HwR
	(ORCPT <rfc822;git-outgoing>); Sun, 28 Jun 2009 03:52:17 -0400
Received: from mail-bw0-f213.google.com ([209.85.218.213]:37899 "EHLO
	mail-bw0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751752AbZF1HwQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Jun 2009 03:52:16 -0400
Received: by bwz9 with SMTP id 9so2715545bwz.37
        for <git@vger.kernel.org>; Sun, 28 Jun 2009 00:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=PNy43dAragOSg6Y9JENiHfP2vytDMK42ZDtBAL1ngOY=;
        b=C8+YKjwa5tlGfSJPjuz33ZA9TWzwdhF0S2kGDZ/isIFt7/SsskJJQfLebGgcOMp+GQ
         x9WvmZ2QBUEGJXRiou3DyEz+H//qS68gbNmGWmcdK2H8tLL5enXoXeyoNG06Pc6/JYht
         tbnucT2WpA4WVjd3t5jAW0NnRv7030/qxkjqg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=C4zaP1UbRWzBceL7rCrgzpZt5GJUco3DkAmzRRVRIR+IR2E2jXAPYhqRoqAywJcbtK
         JiF8FA0+x63aU9S2nPG8i+Dkv2chsBQqruHFGKGU1b4KWfbuJbmgIMLgk0shCizLcUOo
         1/r63vrF9lUrrWbS80CmOdL6JX+KhZUP6+0UM=
Received: by 10.204.66.2 with SMTP id l2mr5657863bki.177.1246175538154;
        Sun, 28 Jun 2009 00:52:18 -0700 (PDT)
Received: from yakj.usersys.redhat.com ([85.93.118.17])
        by mx.google.com with ESMTPS id d13sm9034390fka.32.2009.06.28.00.52.17
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 28 Jun 2009 00:52:17 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.17 (X11/20081009)
In-Reply-To: <4A30F16C.5040207@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122396>

Paolo Bonzini wrote:
> 
>> But of course, which conversion you want depends entirely on what you
>> are going to feed it to, and which mbox they are expecting. Which is why
>> it really should be configurable.
>>
>> Your use case looks to be feeding it to send-email
> 
> Almost, :-) because git-send-email does not support sending multiple 
> messages out of one mbox file.  I have an upcoming patch to add this 
> support, and I was just "feeling the waters" before posting it.

I decided that it's easier to support sending a single mbox file with 
this alias instead:

send-mbox = "!bash -ec 'eval f=\\$$#; eval set -- `seq -f\"\\$%.0f\" 1 
$(($#-1))`; if last=`mkdir .mboxsplit && git mailsplit -d4 -o.mboxsplit 
-b -- \"$f\"`; then echo Found $last messages in \"$f\"; git send-email 
\"$@\" .mboxsplit && rm -rf .mboxsplit; else rm -rf .mboxsplit; fi' -"

So, patch withdrawn.  I don't think I'll post the patches in my 
mailsplit-with-sendemail branch.

Paolo
