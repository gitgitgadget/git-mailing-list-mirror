From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH] compat: add a getpass() compatibility function
Date: Thu, 19 May 2011 22:12:46 +0200
Message-ID: <BANLkTimG8E_Riz3rYC9PMw_2-D=Za0Ar6w@mail.gmail.com>
References: <563395AE-A3E5-45FF-9063-F807C2CE3AD0@gieschke.de>
 <BANLkTinPHeSfZXRb7pqt7-XWkR5fH=wAjg@mail.gmail.com> <EC81F772-7149-40A0-891A-973C886AB052@gieschke.de>
 <7v62p68ut0.fsf@alter.siamese.dyndns.org> <BANLkTimDW8W13Wm8i+n0ww9jCeHsXc__iA@mail.gmail.com>
 <8B762D96-54CF-4E42-BF90-7790E900AA30@gieschke.de> <BANLkTi=y5uk2Oi+yx+f-cjUeBrzKeFzzmg@mail.gmail.com>
 <74D1D7FC-A747-4F85-8B1E-7ABFC9DA70A3@gieschke.de>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Rafael Gieschke <rafael@gieschke.de>
X-From: git-owner@vger.kernel.org Thu May 19 22:13:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QN9au-0005yC-19
	for gcvg-git-2@lo.gmane.org; Thu, 19 May 2011 22:13:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934613Ab1ESUNK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 May 2011 16:13:10 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:39719 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934076Ab1ESUNI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 May 2011 16:13:08 -0400
Received: by pvg12 with SMTP id 12so1346603pvg.19
        for <git@vger.kernel.org>; Thu, 19 May 2011 13:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=4RxhHp2jwLGns/3d3UUWfRNm2zPAhjmriuCoUn9xC0w=;
        b=x4mtqcx4DRA3JJD6DPgTV6W8sXPfPLOH9WxOwdW+oBX/2lEIguQZetmpd9XLmvvehu
         uR+ToASrPzAiJ8PLcKT0V4X6q8tdIMmvbZpAc6INpRHyGljqZk59cHLHU+Hl+WZ6HtXl
         Ciaw6+cQUpVI/q36GR4qOyT5PUL0q2lrJR4M8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        b=wKHhNqiBBpLODrGxW1pyRi8qpQBA9ZvYmWqat899pXcuiC6aESSz2dUsBUg6TbiNVY
         zze75+917kFcpNM8sQHK2oQwE+9IFLcchltwM9oLlG2WnDlEPCsA6snnt/O2/OeVShT4
         l1FB7rLxyV3cONpo6/W+p5jXE5aA1CTLBWyTg=
Received: by 10.68.20.163 with SMTP id o3mr5669900pbe.366.1305835986355; Thu,
 19 May 2011 13:13:06 -0700 (PDT)
Received: by 10.68.64.229 with HTTP; Thu, 19 May 2011 13:12:46 -0700 (PDT)
In-Reply-To: <74D1D7FC-A747-4F85-8B1E-7ABFC9DA70A3@gieschke.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173999>

On Thu, May 19, 2011 at 9:42 PM, Rafael Gieschke <rafael@gieschke.de> wrote:
>
> Am 19.05.2011 um 21:19 schrieb Erik Faye-Lund:
>
>> On Thu, May 19, 2011 at 9:16 PM, Rafael Gieschke <rafael@gieschke.de> wrote:
>>>
>>> Am 19.05.2011 um 20:07 schrieb Erik Faye-Lund:
>>>> diff --git a/compat/mingw.h b/compat/mingw.h
>>>> index 62eccd3..e37d557 100644
>>>> --- a/compat/mingw.h
>>>> +++ b/compat/mingw.h
>>>> @@ -48,6 +48,8 @@ typedef int socklen_t;
>>>> #define EAFNOSUPPORT WSAEAFNOSUPPORT
>>>> #define ECONNABORTED WSAECONNABORTED
>>>>
>>>> +#define PASS_MAX 512
>>>> +
>>>
>>> It might be worth to have this in git-compat-util.h, so it can also be used by compat/getpass.c. I'm not sure about the name, however; it's a remote password and MAX_PASS is about local passwords AFAIK. Maybe PASS_MAX_REMOTE or something similiar. Like that, compat/getpass.c could also be used in case MAX_PASS has some insanely low value on a platform.
>>>
>>>
>>
>> PASS_MAX should be defined in limits.h (which is included by
>> git-compat-util.h) on POSIX platforms:
>> http://pubs.opengroup.org/onlinepubs/007908799/xsh/limits.h.html
>>
>> If it turns out it's not on some platforms, perhaps a define-guarded
>> version would make sense in git-compat-util.h instead.
>
> It is defined even on Android :-).
>

Good to hear.

> But I still wonder whether it's the right thing or if you should use it only for local passwords.
>
> If you imagine a platform with MAX_PASS=8, git couldn't connect to an IMAP server with a password of 10 chars on this platform without any proper reason.
>

Well, those platforms would currently fail, since that's the limit on
the string returned from getpass. Since that hasn't happened yet, I
suspect that this is a very theoretical problem.

If we created our own define we could fix such problems by setting
NO_GETPASS and having a reasonable lengthy GIT_MAX_PASS. But let's
leave that theoretical fix for when/if it turns out to be real, huh?
