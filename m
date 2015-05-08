From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] contrib/subtree: portability fix for string printing
Date: Fri, 8 May 2015 13:56:34 -0400
Message-ID: <CAPig+cQQSrQiSzp7Jat8LYH+RqYdpJ2XCXweAtrYE_QoLzSznQ@mail.gmail.com>
References: <xmqqmw1gp7aa.fsf@gitster.dls.corp.google.com>
	<1431046619-2340-1-git-send-email-danny0838@gmail.com>
	<xmqqy4kzklhp.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Danny Lin <danny0838@gmail.com>, git develop <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 08 19:56:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YqmVr-0002iF-KV
	for gcvg-git-2@plane.gmane.org; Fri, 08 May 2015 19:56:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753537AbbEHR4f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 May 2015 13:56:35 -0400
Received: from mail-ig0-f171.google.com ([209.85.213.171]:35415 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753029AbbEHR4e (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 May 2015 13:56:34 -0400
Received: by igbyr2 with SMTP id yr2so27486362igb.0
        for <git@vger.kernel.org>; Fri, 08 May 2015 10:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=jjti9uHdW7DcMFZmPT1ng8BL7/Ach2utMwdeaMVBmBs=;
        b=RNWRZUIN0+5UnduTzxbXGI/hL0IaNYDq43nbKeffrJn6X27kupNl2vlHrbAIHUtVIW
         Be1p7YTTfjO6MzPKo2pEzUzD13foyr5EnqX48PdWPWHG1LQY6pBTlFp+CyohGfB7nRfL
         3q46dcKMd1XHlGgmG3uRIc60zKpdkF9HJJDXeoWUWJa33+LZdi2BHEcupRfdNujotRWj
         AZR/b3qPEMW7SydV28N/y3mhaT4oZtubj+v2KmYQFI3BHbzbs5/AlDatlC/wv1U3ea/a
         54qqMOmZ2g70xBNCLsonV7XddkwNVl8VXOW3G/+E7t+VBj0M8e2WDkY1Yte1orKkpNXo
         UdtQ==
X-Received: by 10.107.31.134 with SMTP id f128mr6652097iof.19.1431107794163;
 Fri, 08 May 2015 10:56:34 -0700 (PDT)
Received: by 10.107.28.132 with HTTP; Fri, 8 May 2015 10:56:34 -0700 (PDT)
In-Reply-To: <xmqqy4kzklhp.fsf@gitster.dls.corp.google.com>
X-Google-Sender-Auth: 1eHJYLMyt-oBxTiA_K89uPOd7RI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268634>

On Fri, May 8, 2015 at 1:49 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Danny Lin <danny0838@gmail.com> writes:
>
>> Replace echo using printf in debug() and say() for
>> better portability.
>>
>> Also re-wrap previous 'say -n "$str<CR>"' using a new
>> function progress() to prevent CR chars included in the
>> source code, which could be mal-processed in some shells.
>> For example, MsysGit trims CR before executing a shell
>> script file in order to make it work right on Windows
>> even if it uses CRLF as linefeeds.
>>
>> Signed-off-by: Danny Lin <danny0838@gmail.com>
>> ---
>
> Thanks, this looks good.  Will apply with a little bit of tweak in
> the log message.

Hmm, I would say that the changes to debug() and say() should either
be dropped or moved to a separate patch (along with the first
paragraph of the commit message). With the introduction of the
progress() abstraction, there is no longer any need for changes to
say(), and the "better portability" rationale for changing say() and
debug() is never properly explained, and is thus nebulous at best.
