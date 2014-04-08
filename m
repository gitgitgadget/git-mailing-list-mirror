From: Ronald Weiss <weiss.ronald@gmail.com>
Subject: Re: [PATCH v3 2/2] commit: add --ignore-submodules[=<when>] parameter
Date: Tue, 08 Apr 2014 22:19:12 +0200
Message-ID: <534459C0.4090705@gmail.com>
References: <CABxC_L92v=cV=+e_DNa0L6f21LB0BRP5duai2h_heGJN_PRoUQ@mail.gmail.com>	<5335A78C.60401@web.de>	<CABxC_L-4=qcZiix05dL8GrDJXv=19fw4yB0qFzRRfw=G=_Gxbg@mail.gmail.com>	<53374E49.9000702@gmail.com>	<533874F9.3090802@web.de>	<5338AC36.6000109@gmail.com>	<5338B1B0.3050703@gmail.com>	<5339BAE4.8020306@web.de> <CABxC_L8_tQrANXji_Z0LfigxsAuzSDj3K9ndTGOTHh2ctHvc6A@mail.gmail.com> <5339F122.60801@gmail.com> <5339FBB4.1010101@gmail.com> <533B2036.3050506@web.de> <533B36AA.3090600@gmail.com> <533C5CBD.4050601@web.de> <533C6B57.3080901@gmail.com> <534180BC.308@web.de> <53431CB8.2050600@gmail.com> <53432EA5.5060102@gmail.com> <53444368.9050607@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Heiko Voigt <hvoigt@hvoigt.net>, Junio C Hamano <gitster@pobox.com>
To: Jens Lehmann <Jens.Lehmann@web.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 08 22:19:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WXcUP-0006xL-NZ
	for gcvg-git-2@plane.gmane.org; Tue, 08 Apr 2014 22:19:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932170AbaDHUTT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Apr 2014 16:19:19 -0400
Received: from mail-ee0-f47.google.com ([74.125.83.47]:57996 "EHLO
	mail-ee0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932118AbaDHUTQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Apr 2014 16:19:16 -0400
Received: by mail-ee0-f47.google.com with SMTP id b15so1098742eek.20
        for <git@vger.kernel.org>; Tue, 08 Apr 2014 13:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=+p6ARgZx/1RcZgDIX3ZaWdcS6p557EOiU2IfRIGc1/g=;
        b=lfAchzm2qhRfw9kcMiiTv8Gt4lxSVCJ3SYXQu9ZqJ9z4RyXb5jTMob8TOUkB0EC0W8
         krT5kxDTBsFwj9MtFWiERJGqwhSkOlNpBmiWY5FyougrIL1h88Lm4CHRAoTDRuXwDnSk
         nCFPXgOjj7dZjmC7SN/w0H7CRqwdxjVhltHjiYQKOnzXuQkdMFtPiecMJx8iA3srbRH4
         SPQyIBJdPn505uBFwzmh7wuUZ+4+qRZlO2vj2F/XGtNSYp3XNnnMOCvZGdW3qwugF7P0
         ENzYGKBZ6xo+zqa+1SeEVJocU0paIA4KMlEaxf6bgXWXyT+T1h/9rxiHD441LnKSp9qT
         UmLg==
X-Received: by 10.15.53.69 with SMTP id q45mr6674407eew.22.1396988355128;
        Tue, 08 Apr 2014 13:19:15 -0700 (PDT)
Received: from [10.0.1.226] (chello089173067059.chello.sk. [89.173.67.59])
        by mx.google.com with ESMTPSA id 44sm6729117eek.30.2014.04.08.13.19.13
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 08 Apr 2014 13:19:14 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.4.0
In-Reply-To: <53444368.9050607@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245956>

On 8. 4. 2014 20:43, Jens Lehmann wrote:
> Am 08.04.2014 01:03, schrieb Ronald Weiss:
>> Git commit honors the 'ignore' setting from .gitmodules or .git/config,
>> but didn't allow to override it from command line, like other commands do.
>>
>> Useful <when> values for commit are 'all' (default) or 'none'. The others
>> ('dirty' and 'untracked') have same effect as 'none', as commit is only
>> interested in whether the submodule's HEAD differs from what is commited
>> in the superproject.
> 
> Unless it outputs a status message, then 'dirty' and 'untracked' do
> influence what is shown there. Apart from that (and maybe tests for
> these two cases ;-) this is looking good to me.

Hm, You mean the status message, which is pre-inserted as comment into
the commit message, when opening an editor to write the commit message?

OK, that really makes a difference, although really small and actually
affecting nothing. I'll take it into account. But are You sure the tests
for this would be actually useful? If only effect of them would be
increasing time needed to run the full test suite, then it's better to
not have them :-). But I can do that, if You still think it's useful.
