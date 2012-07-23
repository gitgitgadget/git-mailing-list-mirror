From: Kalle Launiala <kalle.launiala@gmail.com>
Subject: Re: git with large files...
Date: Mon, 23 Jul 2012 10:23:49 +0300
Message-ID: <CAHLTmjknX3g08Huv6iyV8uVc9mXjRY_rSBAKVPGwOqDk-O7GTA@mail.gmail.com>
References: <A18A933F-5627-4844-A4A6-B3AF244FD211@me.com>
	<86fw8mf3gp.fsf@red.stonehenge.com>
	<7vvchfple2.fsf@alter.siamese.dyndns.org>
	<CAMK1S_hO5g5p4NjoVcxYFTt_KZ-wBRJk=OCveeszwr8U2LeZbg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>,
	"Randal L. Schwartz" <merlyn@stonehenge.com>,
	Darek Bridges <darek.bridges@me.com>, git@vger.kernel.org
To: Sitaram Chamarty <sitaramc@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 23 09:24:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1StCzk-0003u6-7T
	for gcvg-git-2@plane.gmane.org; Mon, 23 Jul 2012 09:23:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753904Ab2GWHXv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jul 2012 03:23:51 -0400
Received: from mail-vb0-f46.google.com ([209.85.212.46]:37175 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753892Ab2GWHXu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jul 2012 03:23:50 -0400
Received: by vbbff1 with SMTP id ff1so4389249vbb.19
        for <git@vger.kernel.org>; Mon, 23 Jul 2012 00:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=p6tfTYWMBA/REEGnG0iVOHdtp8uQDfep6catLCB3OE8=;
        b=EMoA8QEeSNYkKHYauyiPkTDZo9kwL3PlGN7gxTzMBECOL/YsT7ESeD3eYalRkDFTVJ
         AtekaHe86OrieZXeUOLraIBDLfiNnxcH8erO9q6UuRK9Cyf61oL/wEQfPx9+CCfRF8PX
         syj+WixgYj+9QQQbVn0ZxuYTIafIrFnrWMIGgtyosiJtNyoaTr5jyy8OI6FjjvOw7Ijj
         ysIuiQtORrAMYesLT+FnETKnPH6mSLUpJDtdOjkQ00uY0bawBneuwrIvJuxAj5W9YJ9H
         6G0fKFMbKvaWkI3rLB1qKPj3+TSLmj2WZZAkaDqSWZ1GAPAZNK+Bz9TI0ZN3aPE4UT47
         xo4A==
Received: by 10.52.67.199 with SMTP id p7mr9925420vdt.126.1343028229818; Mon,
 23 Jul 2012 00:23:49 -0700 (PDT)
Received: by 10.52.162.97 with HTTP; Mon, 23 Jul 2012 00:23:49 -0700 (PDT)
In-Reply-To: <CAMK1S_hO5g5p4NjoVcxYFTt_KZ-wBRJk=OCveeszwr8U2LeZbg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201916>

2012/7/23 Sitaram Chamarty <sitaramc@gmail.com>:
> On Mon, Jul 23, 2012 at 2:24 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> merlyn@stonehenge.com (Randal L. Schwartz) writes:
>>
>>>>>>>> "Darek" == Darek Bridges <darek.bridges@me.com> writes:
>>>
>>> Darek> I use git for many things, but I am trying to work out the
>>> Darek> workflow to use git for deployment.
>>>
>>> Don't.
>>
>> Yeah, "don't think 'git checkout' is a way to 'deploy'".  Using Git
>> as a transport measure is probably fine.
>
> You can also try
> http://sitaramc.github.com/the-list-and-irc/deploy.html.  Whether it's
> saying you *can* use git for deploying something, or you *can* but
> *should not*, or you *cannot*, will depend on your own thoughts on the
> matter ;-)

Nice summary list of options!

If you combine that with several key concepts:
1. You plan and design to deploy - hence you have separate deploy
repositories dedicated for that
2. You design for modularity and complete audit trail, hence you have this:
http://abstractiondev.files.wordpress.com/2011/12/git-distribution-overview.png

You can combine the staging with any approach, that *tries* to
maintain the local version copy. But if any problem arises in
pull/fetch, simply trash that part and get it from fresh (or just use
the git archive approach).

Now this model would introduce complete and as detailed security
enforcement - as the deployment can validate with certificates (from
the additional catalogue-metadata binding, whether there is authorized
party confirmed signature available for the wished deployable
version).

I don't see much overhead in any of the steps here - and the
deployment is as detailed and as securely controlled as desired. With
just Git (and well, possibly GnuPG or alike common tool for digital
certificate work).

Everything is also transparent - which is very important in having
that complete control and audit trail.
