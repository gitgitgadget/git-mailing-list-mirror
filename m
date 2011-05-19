From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH] compat: add a getpass() compatibility function
Date: Thu, 19 May 2011 23:16:48 +0200
Message-ID: <BANLkTingSqEM5=4=rLq7Yu1x9YXstiSsNw@mail.gmail.com>
References: <563395AE-A3E5-45FF-9063-F807C2CE3AD0@gieschke.de>
 <BANLkTinPHeSfZXRb7pqt7-XWkR5fH=wAjg@mail.gmail.com> <EC81F772-7149-40A0-891A-973C886AB052@gieschke.de>
 <7v62p68ut0.fsf@alter.siamese.dyndns.org> <BANLkTimDW8W13Wm8i+n0ww9jCeHsXc__iA@mail.gmail.com>
 <8B762D96-54CF-4E42-BF90-7790E900AA30@gieschke.de> <BANLkTi=y5uk2Oi+yx+f-cjUeBrzKeFzzmg@mail.gmail.com>
 <74D1D7FC-A747-4F85-8B1E-7ABFC9DA70A3@gieschke.de> <BANLkTimG8E_Riz3rYC9PMw_2-D=Za0Ar6w@mail.gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Rafael Gieschke <rafael@gieschke.de>
X-From: git-owner@vger.kernel.org Thu May 19 23:17:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QNAar-0004nG-4v
	for gcvg-git-2@lo.gmane.org; Thu, 19 May 2011 23:17:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933115Ab1ESVRK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 May 2011 17:17:10 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:47561 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932916Ab1ESVRI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 May 2011 17:17:08 -0400
Received: by pzk9 with SMTP id 9so1369100pzk.19
        for <git@vger.kernel.org>; Thu, 19 May 2011 14:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=SoRdp9Q9aq5wOJzI7wP3RVSnw2eaH5wqYY9MsuLUh6s=;
        b=ciRFvGqQM6eNic5GJyAbGniIlaWC8GlbjurpZcF3NytA+sgH+6z17hzHt5AZ2gFhLh
         8gM2sLYErGF2q3a83BKdK2GZ6ia7hdD+X4oQU6VaoZ3RrTv+S4GFNWWbhE9ZwMD1kpu5
         Ag4cF+LbM5YwwJ7UGqihSXdslFxxP2OKJdzGM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        b=iQZ6PolMzyaeNRWm0zStUfZGQtvX0BcmoHMY1df8O0u5T/tTknuMno48jjKrb3swy3
         C1WtbaEu5A01dOLL92y5mTWiwRcCyMunz+1/I2czcaEZowbmt50tITS47NWkfmPqe4Jh
         ryLkxnifLRuZC22AxpKrZr5trOcchPDz2Nx/w=
Received: by 10.68.12.72 with SMTP id w8mr4200969pbb.165.1305839828048; Thu,
 19 May 2011 14:17:08 -0700 (PDT)
Received: by 10.68.64.229 with HTTP; Thu, 19 May 2011 14:16:48 -0700 (PDT)
In-Reply-To: <BANLkTimG8E_Riz3rYC9PMw_2-D=Za0Ar6w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174004>

On Thu, May 19, 2011 at 10:12 PM, Erik Faye-Lund <kusmabite@gmail.com> wrote:
> On Thu, May 19, 2011 at 9:42 PM, Rafael Gieschke <rafael@gieschke.de> wrote:
>>
>> Am 19.05.2011 um 21:19 schrieb Erik Faye-Lund:
>>
>>> On Thu, May 19, 2011 at 9:16 PM, Rafael Gieschke <rafael@gieschke.de> wrote:
>>>>
>>>> Am 19.05.2011 um 20:07 schrieb Erik Faye-Lund:
>>>>> diff --git a/compat/mingw.h b/compat/mingw.h
>>>>> index 62eccd3..e37d557 100644
>>>>> --- a/compat/mingw.h
>>>>> +++ b/compat/mingw.h
>>>>> @@ -48,6 +48,8 @@ typedef int socklen_t;
>>>>> #define EAFNOSUPPORT WSAEAFNOSUPPORT
>>>>> #define ECONNABORTED WSAECONNABORTED
>>>>>
>>>>> +#define PASS_MAX 512
>>>>> +
>>>>
>>>> It might be worth to have this in git-compat-util.h, so it can also be used by compat/getpass.c. I'm not sure about the name, however; it's a remote password and MAX_PASS is about local passwords AFAIK. Maybe PASS_MAX_REMOTE or something similiar. Like that, compat/getpass.c could also be used in case MAX_PASS has some insanely low value on a platform.
>>>>
>>>>
>>>
>>> PASS_MAX should be defined in limits.h (which is included by
>>> git-compat-util.h) on POSIX platforms:
>>> http://pubs.opengroup.org/onlinepubs/007908799/xsh/limits.h.html
>>>
>>> If it turns out it's not on some platforms, perhaps a define-guarded
>>> version would make sense in git-compat-util.h instead.
>>
>> It is defined even on Android :-).
>>
>
> Good to hear.
>
>> But I still wonder whether it's the right thing or if you should use it only for local passwords.
>>
>> If you imagine a platform with MAX_PASS=8, git couldn't connect to an IMAP server with a password of 10 chars on this platform without any proper reason.
>>
>
> Well, those platforms would currently fail, since that's the limit on
> the string returned from getpass. Since that hasn't happened yet, I
> suspect that this is a very theoretical problem.
>
> If we created our own define we could fix such problems by setting
> NO_GETPASS and having a reasonable lengthy GIT_MAX_PASS. But let's
> leave that theoretical fix for when/if it turns out to be real, huh?
>

Whoa: http://www.opengroup.org/csq/view.mhtml?norationale=1&noreferences=1&RID=sun%2FSE2%2F10

It seems that Solaris has a MAX_PASS of 8... That should mean that
prompted passwords can't be above 8 characters there (without using
GIT_ASKPASS). Can this really be the case?
