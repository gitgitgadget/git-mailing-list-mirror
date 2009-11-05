From: "Andrzej K. Haczewski" <ahaczewski@gmail.com>
Subject: Re: [PATCH] MSVC: Windows-native implementation for subset of 
	Pthreads API
Date: Thu, 5 Nov 2009 21:09:47 +0100
Message-ID: <16cee31f0911051209jcc490e2pabeab9a1b6e3b11d@mail.gmail.com>
References: <1257283802-29726-1-git-send-email-ahaczewski@gmail.com>
	 <1257439548-9258-1-git-send-email-ahaczewski@gmail.com>
	 <alpine.LFD.2.00.0911051434090.10340@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, kusmabite@gmail.com,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Paolo Bonzini <bonzini@gnu.org>
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Thu Nov 05 21:09:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N68eZ-0001Xk-31
	for gcvg-git-2@lo.gmane.org; Thu, 05 Nov 2009 21:09:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756806AbZKEUJo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Nov 2009 15:09:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756179AbZKEUJo
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Nov 2009 15:09:44 -0500
Received: from gv-out-0910.google.com ([216.239.58.187]:42457 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755960AbZKEUJn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 Nov 2009 15:09:43 -0500
Received: by gv-out-0910.google.com with SMTP id r4so121814gve.37
        for <git@vger.kernel.org>; Thu, 05 Nov 2009 12:09:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=x1txqYRb50fFUqOP112pPyIUIdN8fvvL9ZubOuHIwuA=;
        b=Vw1AKSsPCywXZWVIKNxtVSsVVm+EKQ9wv19QYsjT5peodX2btkYJR4j4QYY1FPoGzv
         FQnnCeVxSw4NCNtF4l9z1JbD9bCbGU/s1bfu+7U4G6u71xoA1IS1J3qjFlNnz0B65b2b
         BGcJxyeKSMMvFn6wJ8Kj7wRHLExdi7hTYqdzo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=sAEgIF/GEr12rySlJqNnWYl/IpUDcZpwsWbApbhWKsjblV5dc7Zq63jxHaQdLqMabn
         7ujQM7IhOMFrgJvAO00j08Havt4z3V+kndB07iwe0wBkXk99u5g5MlkQVK+3o55xCzSW
         Hm2DBVRhZvTNjnmMcWXbl9N+He+Uqg5u9lcUw=
Received: by 10.239.139.4 with SMTP id r4mr361627hbr.199.1257451787734; Thu, 
	05 Nov 2009 12:09:47 -0800 (PST)
In-Reply-To: <alpine.LFD.2.00.0911051434090.10340@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132241>

2009/11/5 Nicolas Pitre <nico@fluxnic.net>:
> On Thu, 5 Nov 2009, Andrzej K. Haczewski wrote:
>
>> +static unsigned __stdcall win32_start_routine(void *arg)
>> +{
>> + =A0 =A0 pthread_t *thread =3D arg;
>> + =A0 =A0 thread->value =3D thread->start_routine(thread->arg);
>> + =A0 =A0 return 0;
>> +}
>
> I suppose you could reuse thread->arg for both the argument and the
> returned value to save a word.

You're right! J6t committed already, what can I do now?

> Why are you casting thread->handle here? =A0Why not simply declaring =
it as
> a HANDLE?

Just to silence MSVC warnings. WaitForSingleObject requires HANDLE,
_beginthreadex() returns uintptr_t. It's just a matter of where would
I put cast ;).

--
Andrzej
