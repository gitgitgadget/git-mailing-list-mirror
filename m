From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] remote-hg: fix path when cloning with tilde expansion
Date: Fri, 9 Aug 2013 16:55:13 -0500
Message-ID: <CAMP44s13y39f-eCP1sBuMEedciU230C1O11+iMb1SHi45RnSNQ@mail.gmail.com>
References: <CAMP44s1Jqao0YvBSh18t1C2LwAF4_u2GaTNx1RwdW+pmCFcxvQ@mail.gmail.com>
	<1376068387-28510-1-git-send-email-apelisse@gmail.com>
	<7veha266nq.fsf@alter.siamese.dyndns.org>
	<CALWbr2w2JjEr_hYX9ighu_-=iTV6etG=78g4AbKko64EsecxFA@mail.gmail.com>
	<7vy58a4mcy.fsf@alter.siamese.dyndns.org>
	<CALWbr2y5H_dfHAFW_qN+j8YtF4F9+VcG8G503hr4YN2Qv69CXA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
To: Antoine Pelisse <apelisse@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 09 23:55:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V7ueY-0000bC-LX
	for gcvg-git-2@plane.gmane.org; Fri, 09 Aug 2013 23:55:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031272Ab3HIVzQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Aug 2013 17:55:16 -0400
Received: from mail-lb0-f179.google.com ([209.85.217.179]:54575 "EHLO
	mail-lb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031243Ab3HIVzP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Aug 2013 17:55:15 -0400
Received: by mail-lb0-f179.google.com with SMTP id v1so3546900lbd.10
        for <git@vger.kernel.org>; Fri, 09 Aug 2013 14:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=Xt0FkGNZU1aMk7HMRZNJ5WP4wIwYOMqoS1PDL/k0MkQ=;
        b=OrKQrgKtWFNCH4QakZF+0FmbnxzaON9Iitc89uasY3Rv7YQXK8s0KLeLm94Z6l0Trp
         ouvixPByZ7TpMCePMW6WgPBiDv84ln8R+qKcT3YcxJ8kW0DgsTYqKHWyqxqr7874aBUG
         jsm8XDanF/K75mE1CanZr72jClK+Pe/GNHEkYgFqxJQ1mCPakJj9wIBoVU5m/4uI9OdJ
         MEaE4cFgE5dZHFIcdVd4mifaQa+sZ7OwOWr3vnBPk9aezOis1AjebnErzFa3CXiMRe3Q
         Ek3DGCi7vhKhhnt9pEgdFTeGwOu22TPEjb77B2Qiq9LQ0xZ39UDjl0aJ0TwZidliQ82R
         2yUw==
X-Received: by 10.152.9.233 with SMTP id d9mr6741594lab.33.1376085313739; Fri,
 09 Aug 2013 14:55:13 -0700 (PDT)
Received: by 10.114.91.169 with HTTP; Fri, 9 Aug 2013 14:55:13 -0700 (PDT)
In-Reply-To: <CALWbr2y5H_dfHAFW_qN+j8YtF4F9+VcG8G503hr4YN2Qv69CXA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232041>

On Fri, Aug 9, 2013 at 4:19 PM, Antoine Pelisse <apelisse@gmail.com> wrote:
> Confusion everywhere :-)
>
> On Fri, Aug 9, 2013 at 10:53 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Antoine Pelisse <apelisse@gmail.com> writes:
>>
>>> So when we run:
>>>
>>> git clone hg::~/my/repo
>>>
>>> Git will remove the "hg::" part, and Mercurial will expand tilde and
>>> clone $HOME/my/repo.
>>
>> Now you confused me.  If the implementation were for us to remove
>> the hg:: prefix and let Mercurial do whatever it wants to do with
>> the rest, you are right that we will not have to do any expansion
>> like your patch.  But you sent a patch to do so, so apparently it
>> is not what happens.  So where does it go wrong?
>>
>> Puzzled...
>
> OK, I think I see why you are puzzled.
>
> Cloning works fine because we "fix the path" *after* the clone is done
> successfully, for the following reason:

So if we didn't store a different path, it would work. So instead of
expanding '~' ourselves, it would be better to don't expand anything,
and leave it as it is, but how to detect that in fix_path()?

-- 
Felipe Contreras
