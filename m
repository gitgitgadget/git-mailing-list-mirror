From: "Kyle J. McKay" <mackyle@gmail.com>
Subject: Re: [PATCH] protocol upload-pack-v2
Date: Tue, 10 Mar 2015 12:36:40 -0700
Message-ID: <96E9559D-9B15-464D-AC9E-8C17229A0A78@gmail.com>
References: <20150302092136.GA30278@lanh> <1425685087-21633-1-git-send-email-sbeller@google.com> <CACsJy8AuCAfHMbnV3N4ZyZCCqF6WAs_k2dS_Y1ZccWAzWm0yVA@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Stefan Beller <sbeller@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 10 20:36:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YVPxU-00084B-J6
	for gcvg-git-2@plane.gmane.org; Tue, 10 Mar 2015 20:36:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752742AbbCJTgr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Mar 2015 15:36:47 -0400
Received: from mail-pa0-f50.google.com ([209.85.220.50]:37717 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751737AbbCJTgq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Mar 2015 15:36:46 -0400
Received: by paceu11 with SMTP id eu11so4762508pac.4
        for <git@vger.kernel.org>; Tue, 10 Mar 2015 12:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:in-reply-to:subject:references:message-id:content-type
         :content-transfer-encoding:mime-version:date:cc;
        bh=2Nwc9xHv9RP1dSsRLn35HIu2qD3WvtpdGt/+qPuEbBU=;
        b=VdNvn/M/xLYOyYO8guQlqP5V80r56TM0r5KLBA5kL0uszSRDPx7pIRNwlv9z/Akr01
         cU/25HETMidQq1KpONEscAhDG0EFM26FKOK1D9Jy+731qbCHmydnIiNF92l64NHLEJFY
         LiaiDxA21CPNoqzu7fIBAwTkYS/rpwDss41kLHZUg8tI8j5Do8Goyb5I216ED7Awte8K
         +T/kOmpxn3EWaBpCmOVn/76MrxtMH2WQWIx86SiREHaohS0q4XLt5YxrODpRLujifARJ
         Cg9L3VPnds/X/yIhJepOzcpIHgYZlRtdYfiIZPPhQ8TVOVcDrr4xwnS3aFIxsA2Owzka
         CJ/g==
X-Received: by 10.66.141.42 with SMTP id rl10mr69630330pab.124.1426016204501;
        Tue, 10 Mar 2015 12:36:44 -0700 (PDT)
Received: from ?IPv6:2002:48c0:ad8d::223:12ff:fe05:eebd? ([2002:48c0:ad8d:0:223:12ff:fe05:eebd])
        by mx.google.com with ESMTPSA id um16sm2398941pab.7.2015.03.10.12.36.42
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 10 Mar 2015 12:36:43 -0700 (PDT)
In-Reply-To: <CACsJy8AuCAfHMbnV3N4ZyZCCqF6WAs_k2dS_Y1ZccWAzWm0yVA@mail.gmail.com>
X-Mauler: Craptastic (2.936)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265257>

On Mar 9, 2015, at 18:38, Duy Nguyen wrote:
> A minor point on capability negotiation. I remember why I passed
> capabilities via command line instead of this proposal. With this
> proposal, daemon.c does not recognize "i18n" capability and cannot
> switch to the correct language before it reports an error.
>
> But perhaps I approached it the wrong way. Instead of letting the
> daemon produce non-English language directly, if could sort of
> standardize the messages and send an error code back in "ERR" line,
> together with an English message (current pack-protocol.txt says "ERR"
> followed by explanation-text). The client can use this error code to
> print non-English messages if it wants to. Perhaps we can reuse http
> (or ftp) return codes or some other protocol then customize to fit
> Git's needs.

May I suggest that you take a look at RFC 2034 [1].  It describes  
almost exactly this same situation and how SMTP was enhanced to  
support error code numbers that could then be translated.

No reason this enhancement needs to be restricted to protocol v2 if  
it's just an "enhancedstatuscodes" capability the server sends back to  
indicate that its ERR text is in that format.

-Kyle

[1] http://tools.ietf.org/html/rfc2034
