From: =?UTF-8?Q?J=C4=81nis_Ruk=C5=A1=C4=81ns?= <janis.ruksans@gmail.com>
Subject: Re: Submodule, subtree, or something else?
Date: Mon, 24 Aug 2015 20:53:15 +0300
Message-ID: <1440438795.32140.98.camel@gmail.com>
References: <1440197262.23145.191.camel@gmail.com>
	 <CAGZ79kbUXwEYnpDWgKqnUab2xP4m9m7FMskaK2u8WcqnLSSoog@mail.gmail.com>
	 <1440339066.32140.17.camel@gmail.com>
	 <CAGZ79kY+HLzd4esdy+i82Eh5Vhc1NEDDfinD2iiBMvV41GSCiw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Mon Aug 24 19:53:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZTvvx-00042A-6o
	for gcvg-git-2@plane.gmane.org; Mon, 24 Aug 2015 19:53:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753894AbbHXRxV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 24 Aug 2015 13:53:21 -0400
Received: from mail-lb0-f172.google.com ([209.85.217.172]:34785 "EHLO
	mail-lb0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751179AbbHXRxT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Aug 2015 13:53:19 -0400
Received: by lbbtg9 with SMTP id tg9so85217126lbb.1
        for <git@vger.kernel.org>; Mon, 24 Aug 2015 10:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :content-type:mime-version:content-transfer-encoding;
        bh=lgzRDpjgfyB/4GVc4SVFZ+/30JWiehfj+CjFsLDZcCA=;
        b=L/ck6pPH4LPo3ioioVr1TUwZlkzDTpVa3QX9iSt2BNWqC8XJMVjL41lLRg4ca+c29P
         ED39ec/IegRu5lV8Oa4Wsg9Z2k2MXrqdCmKoxcjAC0gFicleOFaWMAzPtc0u0U/OotsA
         khwxC7y4/TLp1yhJoYN5RKvtVAd0XjbaCUYVu34n/1RbhMZTk9bypX1Fbtui95w5RgbD
         l8/QkygFeYv01lEa7E2jJAhkkrPvca20oYEgNt6eKopL/oTWd/C6FOhje/3M3eRLVJzd
         7hwNngujxdtG1HKEXNKjDuOaqjfJ8wwDZ+S/8Hjn2vrk7Q0q9j46DdU6hVYXuU6RZC7z
         OhYg==
X-Received: by 10.112.52.2 with SMTP id p2mr21474118lbo.8.1440438798213;
        Mon, 24 Aug 2015 10:53:18 -0700 (PDT)
Received: from ganja (two.vendomar.lv. [195.244.143.5])
        by smtp.googlemail.com with ESMTPSA id cm12sm5243720lbd.2.2015.08.24.10.53.16
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Aug 2015 10:53:16 -0700 (PDT)
In-Reply-To: <CAGZ79kY+HLzd4esdy+i82Eh5Vhc1NEDDfinD2iiBMvV41GSCiw@mail.gmail.com>
X-Mailer: Evolution 3.12.11 (3.12.11-1.fc21) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276470>

On P , 2015-08-24 at 09:51 -0700, Stefan Beller wrote:
> IIUC, the second command will lookup the submodules in $(pwd), but if
> they are not there they are skipped, so all of the existing submodule=
s
> are cloned.
> Why do you need more submodules in the tmp clone than in
> $(pwd)/projectA would be my next question. But I see your point now.

The $(pwd) was just an example to illustrate my point.  The actual use
case is that I would be hacking on something at work, notice that it is
already late and I have to catch the last bus home, yet I don't want to
postpone whatever I was working on until the next day.  So I would do
git commit -a -m "[WIP] Stuff, finish at home" to save my work so far,
go home, and clone / fetch it over ssh.

Another important factor is that a lot of our code can be meaningfully
tested only on the actual hardware, and is built in a VM.  Quite often
getting things right involve many iterations of hack hack hack, git
commit --amend, fetch && reset --hard in the VM, build, test, repeat.
Being able to clone / fetch directly from the copy I am working on make=
s
it a lot easier.

As I wrote in the other e-mail, I managed to achieve the desired result
by using ./<submodule> (without .git suffix) as the submodule URL, and
creating a file named <submodule> in the bare repo with
'gitdir: ../<submodule.git>' as it's contents, but I'm not sure whether
it is a good idea or not.

J=C4=81nis
