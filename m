From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] Makefile: Fix compilation of windows resource file
Date: Wed, 22 Jan 2014 08:12:38 -0800
Message-ID: <xmqq38kgyozt.fsf@gitster.dls.corp.google.com>
References: <52DD857C.6060005@ramsay1.demon.co.uk>
	<xmqqy529t5bb.fsf@gitster.dls.corp.google.com>
	<xmqqppnlt3u3.fsf@gitster.dls.corp.google.com>
	<52DEF9F2.1000905@ramsay1.demon.co.uk>
	<xmqqk3dssxpb.fsf@gitster.dls.corp.google.com>
	<52DF6B6C.4020708@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	GIT Mailing-list <git@vger.kernel.org>,
	Pat Thoyts <patthoyts@users.sourceforge.net>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Jan 22 17:12:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W60Q6-0001rD-2S
	for gcvg-git-2@plane.gmane.org; Wed, 22 Jan 2014 17:12:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753042AbaAVQMp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Jan 2014 11:12:45 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47367 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752175AbaAVQMo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jan 2014 11:12:44 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0DFB2642C7;
	Wed, 22 Jan 2014 11:12:44 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=fBGCZD30E+9wb5eCfvxqDigdMPw=; b=FgUuPE
	E5WxG2yvP3rcPhNLzVEyn8FjCzg/Anqzm065gTN7TgM7+w9FFoqLlt70D8lMddXT
	KeX6yWQP7tgJnpoa1OEjB4Y64j5N+Knq1R4ZHIZ8Ms5uYMTmAFj/gRJ9CMQrT3GN
	6ju3An3G5ndltvOEYE8vmh0HerFuS7teVliwo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BYUgQJOOhy1A8ir9TXJxf6K7CijPkMkn
	sEDkbETaxorsLABIE/1jIyoB1BYl1EisTh7JD97vI4NCp/VmGGrW4xhNATQhNJkE
	2ce2MHHUvJyc6SfkChLI0R/FKHdYsfnySFvuWkBKRUQfhGlWXNYCQYIJ94fE71G7
	GGfu+7qrgQc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E7A16642C1;
	Wed, 22 Jan 2014 11:12:43 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0B5CC642BB;
	Wed, 22 Jan 2014 11:12:41 -0500 (EST)
In-Reply-To: <52DF6B6C.4020708@viscovery.net> (Johannes Sixt's message of
	"Wed, 22 Jan 2014 07:55:40 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 056135D0-8380-11E3-AB3D-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240837>

Johannes Sixt <j.sixt@viscovery.net> writes:

> [Cc Pat, who added git.rc]
>
> Am 1/22/2014 0:48, schrieb Junio C Hamano:
>> Ramsay Jones <ramsay@ramsay1.demon.co.uk> writes:
>> 
>>>> Note that I am merely guessing that "short-digit" version numbers
>>>> are acceptable by now after seeing
>>>>
>>>>     https://sourceware.org/ml/binutils/2012-07/msg00199.html
>>>
>>> Ah, nice find!
>>>
>>> I will test your patch (below) and let you know soon, but it looks
>>> good to me. (I can't test it tonight, unfortunately.)
>> 
>> One thing to note is that I don't know why the existing code dropped
>> the fourth digit from the maintenance series.
>
> I don't know either. But it does not really matter. When there are 4
> digits in the FILEVERSION and PRODUCTVERSION statements, then the user
> does not see them as-are, but, for example, 1.8.1283 for
> FILEVERSION 1,8,5,3 (1283 = 5*256+3). Therefore, I think that there is
> no point in providing 4 numbers, and the patch below should be
> sufficient.

Would that work well when we do 1.9.1, the first maintenance/bugfix
release for 1.9?

> diff --git a/Makefile b/Makefile
> index b4af1e2..99b2b89 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1773,7 +1773,7 @@ $(SCRIPT_LIB) : % : %.sh GIT-SCRIPT-DEFINES
>  
>  git.res: git.rc GIT-VERSION-FILE
>  	$(QUIET_RC)$(RC) \
> -	  $(join -DMAJOR= -DMINOR= -DPATCH=, $(wordlist 1,3,$(subst -, ,$(subst ., ,$(GIT_VERSION))))) \
> +	  $(join -DMAJOR= -DMINOR=, $(wordlist 1,2,$(subst -, ,$(subst ., ,$(GIT_VERSION))))) \
>  	  -DGIT_VERSION="\\\"$(GIT_VERSION)\\\"" $< -o $@
>  
>  ifndef NO_PERL
> diff --git a/git.rc b/git.rc
> index bce6db9..33aafb7 100644
> --- a/git.rc
> +++ b/git.rc
> @@ -1,6 +1,6 @@
>  1 VERSIONINFO
> -FILEVERSION     MAJOR,MINOR,PATCH,0
> -PRODUCTVERSION  MAJOR,MINOR,PATCH,0
> +FILEVERSION     MAJOR,MINOR,0,0
> +PRODUCTVERSION  MAJOR,MINOR,0,0
>  BEGIN
>    BLOCK "StringFileInfo"
>    BEGIN
