From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] remote-hg: fix path when cloning with tilde expansion
Date: Fri, 9 Aug 2013 17:28:13 -0500
Message-ID: <CAMP44s1Ky2AkEt-XS_nAo=_RrPXSVAL=8cGiMuJabw0=BRU0Dw@mail.gmail.com>
References: <CAMP44s1Jqao0YvBSh18t1C2LwAF4_u2GaTNx1RwdW+pmCFcxvQ@mail.gmail.com>
	<1376068387-28510-1-git-send-email-apelisse@gmail.com>
	<7veha266nq.fsf@alter.siamese.dyndns.org>
	<CALWbr2w2JjEr_hYX9ighu_-=iTV6etG=78g4AbKko64EsecxFA@mail.gmail.com>
	<7vy58a4mcy.fsf@alter.siamese.dyndns.org>
	<CALWbr2y5H_dfHAFW_qN+j8YtF4F9+VcG8G503hr4YN2Qv69CXA@mail.gmail.com>
	<CAMP44s13y39f-eCP1sBuMEedciU230C1O11+iMb1SHi45RnSNQ@mail.gmail.com>
	<7v7gfu4ikb.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Antoine Pelisse <apelisse@gmail.com>, git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 10 00:28:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V7vAR-0008KB-GD
	for gcvg-git-2@plane.gmane.org; Sat, 10 Aug 2013 00:28:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031353Ab3HIW2P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Aug 2013 18:28:15 -0400
Received: from mail-lb0-f180.google.com ([209.85.217.180]:55162 "EHLO
	mail-lb0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031336Ab3HIW2O (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Aug 2013 18:28:14 -0400
Received: by mail-lb0-f180.google.com with SMTP id a16so3555085lbj.39
        for <git@vger.kernel.org>; Fri, 09 Aug 2013 15:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=MbONdITDsbFBf+5HzCTW/QYIYjvIEGVkvBc7cVtmSBc=;
        b=N+9kgJqkb2Sd1ygLjewk9gaEVYen5HM1T+x1nkkHhwstCL/nldyrVWb5WKoggwW9C/
         7nCAuFhUqfFftCA1XUhQh7REKu6jPKDh732+HLeDno++I6/Dq9jEuM4ECeaUEkgd3NRA
         9BxbRfJbGI0Xm1fj7CNljnrperw9+EFjJgz3AP2vTMtj/7U0pFBWwoYC7fIwae+Oksjn
         Jiq3JVzA6wjkeVQddM2+Q5UaUWmHNInAnmYFt6+3dbRJT4D5fSZdAmWM1V2cfJrKoSz2
         By0dYe1l8P3W9BKjNOizE/1gCYmIX2Fc/VA4l9RAwTLJmO8U/io0zgg6ZqbyMKQK8uzm
         cwjQ==
X-Received: by 10.152.28.162 with SMTP id c2mr6735780lah.45.1376087293245;
 Fri, 09 Aug 2013 15:28:13 -0700 (PDT)
Received: by 10.114.91.169 with HTTP; Fri, 9 Aug 2013 15:28:13 -0700 (PDT)
In-Reply-To: <7v7gfu4ikb.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232045>

On Fri, Aug 9, 2013 at 5:15 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>>> OK, I think I see why you are puzzled.
>>>
>>> Cloning works fine because we "fix the path" *after* the clone is done
>>> successfully, for the following reason:
>>
>> So if we didn't store a different path, it would work. So instead of
>> expanding '~' ourselves, it would be better to don't expand anything,
>> and leave it as it is, but how to detect that in fix_path()?
>
> I think that the patch relies on that os.path.expanduser(), if
> url.path is such a path that begins with "~" (or "~whom"), returns
> an absolute path.  When given an absolute path, or "~whom/path",
> fix_path returns without running 'git config' on remote.<alias>.url
> configuration.

I think ~whom/path would run 'git config'.

-- 
Felipe Contreras
