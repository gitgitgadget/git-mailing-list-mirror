From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [1.8.0] Provide proper remote ref namespaces
Date: Mon, 7 Feb 2011 17:22:26 +0700
Message-ID: <AANLkTinmOiiizW6eDkAffpWXP+Xztyv1YJfHp2nfFUZ=@mail.gmail.com>
References: <AANLkTi=yFwOAQMHhvLsB1_xmYOE9HHP2YB4H4TQzwwc8@mail.gmail.com>
 <201102070958.11551.johan@herland.net> <AANLkTiksUqVnWeZOm-9XN3BbfVcjc6fWdwPcPJ-PLb88@mail.gmail.com>
 <201102071106.17269.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Sverre Rabbelier <srabbelier@gmail.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Dmitry Potapov <dpotapov@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Nicolas Pitre <nico@fluxnic.net>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Mon Feb 07 11:23:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PmOFP-00068D-Vo
	for gcvg-git-2@lo.gmane.org; Mon, 07 Feb 2011 11:23:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752708Ab1BGKW7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Feb 2011 05:22:59 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:32776 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752127Ab1BGKW6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Feb 2011 05:22:58 -0500
Received: by wwa36 with SMTP id 36so4611424wwa.1
        for <git@vger.kernel.org>; Mon, 07 Feb 2011 02:22:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=DK7oAQUmsy0z+0R2nlXbyqkgUy/ggBLvAMQvidPqvKs=;
        b=JBhtblAy16w/V3n2OlNqZ2Su2rBkrkFMCzjs7b7ov/9TjaWrKvAlyCVPRMvH974CfL
         DLzmxrDVS87cXlm4ew5uaOnHZaIdb6ZrMmLNboMNpcOxKXdUDFbSQzc5GtSQ97h/NgbU
         7WXuLfgHQ/pyWTOCFpxSlR/ZENA125FDUdFlU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=F98yk3hYXShmwt+hL/1gMeFCWiQLMrzeqGiu19eYRX5N3Omsd8WqNYq7eVMREuMqCS
         uI+HUr/WM6hnDN+wUi/kvZd7ygifU7v0+SCc9wD981sQP4/KhTVR+YT/FSh3IOeH+v7F
         Oq/iVaHUc4zcpohIbyA0gMRUZDMnlSwphDnbI=
Received: by 10.216.186.144 with SMTP id w16mr14011995wem.13.1297074176988;
 Mon, 07 Feb 2011 02:22:56 -0800 (PST)
Received: by 10.216.66.144 with HTTP; Mon, 7 Feb 2011 02:22:26 -0800 (PST)
In-Reply-To: <201102071106.17269.johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166249>

On Mon, Feb 7, 2011 at 5:06 PM, Johan Herland <johan@herland.net> wrote:
> On Monday 07 February 2011, Sverre Rabbelier wrote:
>> On Mon, Feb 7, 2011 at 09:58, Johan Herland <johan@herland.net> wrote:
>> > This is the same technique we use when talking about branch names:
>> > On this mailing list, nobody is confused when I refer to 'maint',
>> > 'master', 'next' and 'pu'. Still, in our own work repos (at least
>> > in mine), these branches are actually called
>> > "refs/remotes/origin/<name>" (commonly referred to by their
>> > shorthands "origin/<name>"). Here we are, juggling the same kind of
>> > namespaces that I propose for tags, and it seems to work well
>> > without causing much confusion.
>>
>> With the difference that you can't refer to "maint" as just "maint"
>> unless you've created "refs/heads/maint" iff it is unambiguous.
>
> Except that with 'git checkout', you can:
>
> $ git clone git://git.kernel.org/pub/scm/git/git.git
> $ cd git/
> $ git checkout maint

That's some checkout magic kicking in. I cloned and there was only
refs/heads/master. After checkout, refs/heads/maint appeared.

$ git clone git://git.kernel.org/pub/scm/git/git.git git2
$ cd git2
$ git rev-parse maint
maint
fatal: ambiguous argument 'maint': unknown revision or path not in the
working tree.
Use '--' to separate paths from revisions
$ git rev-parse origin/maint
597a63054241c122515c93cbce45bc44eb231f18
$ git co maint
Branch maint set up to track remote branch maint from origin.
Switched to a new branch 'maint'
$ git rev-parse maint
597a63054241c122515c93cbce45bc44eb231f18
-- 
Duy
