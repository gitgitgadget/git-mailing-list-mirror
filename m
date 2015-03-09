From: Matthew Rothenberg <mrothenberg@gmail.com>
Subject: Re: Efficient parsing of `status -z` output
Date: Mon, 9 Mar 2015 19:40:43 -0400
Message-ID: <CAMJduDvuBF6KwLjmnxmMgfeSYfO6uDVfnkF=VTLTr8t8qowb0w@mail.gmail.com>
References: <CAMJduDuxBDoJ9_ETY8FCRoANf+taAS7-1acf5CFRGXDFyL72Rg@mail.gmail.com>
 <xmqqlhj7sy7l.fsf@gitster.dls.corp.google.com> <CAMJduDvDO4GesL+eru3h1YHrbF5hFmyycX3f4ADQOo+VnD7GDg@mail.gmail.com>
 <20150309061920.GB27128@peff.net> <20150309064939.GA30819@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Mar 10 00:41:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YV7IN-0004oP-5J
	for gcvg-git-2@plane.gmane.org; Tue, 10 Mar 2015 00:41:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751111AbbCIXlF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Mar 2015 19:41:05 -0400
Received: from mail-ig0-f181.google.com ([209.85.213.181]:35710 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751571AbbCIXlE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Mar 2015 19:41:04 -0400
Received: by igqa13 with SMTP id a13so25838212igq.0
        for <git@vger.kernel.org>; Mon, 09 Mar 2015 16:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=gWAkZoO9tcUdz781q5trPdur9ELY+jfPqdwVFDnUGyg=;
        b=0aFp6YFXIdJnX7NkBytMpkU6JLC8VPqgbfzUx5a+T2oionwGW9xZ2U35DE0qaxGeLe
         Aa4bk/gbNVmatBCmNrUnSl4gy99It3L40KyQmd7TMt83vLwVgwRAEAJuwfhepJlEFsAx
         GoReccqs10e7iqA81VtYJV0dWhK1VfRqO0EmdWbzzrZSt61KNFn1bJ7JXVA6e2zY7VH8
         FdsBgw7P0xGSerw0ZXP3nL//hzL0Ht4sBHCXEmT1OUNKd8WJa7OLDjiBU7TFSLtFS5hf
         WvTbRMlwm13jzGTxoX9l9B17VFg64dhSx1nh/1119Ldxk+BlzLLNk+yT9tW3/bhh3vI7
         G6Bg==
X-Received: by 10.107.16.42 with SMTP id y42mr54021682ioi.41.1425944463873;
 Mon, 09 Mar 2015 16:41:03 -0700 (PDT)
Received: by 10.36.25.74 with HTTP; Mon, 9 Mar 2015 16:40:43 -0700 (PDT)
In-Reply-To: <20150309064939.GA30819@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265201>

On Mon, Mar 9, 2015 at 2:49 AM, Jeff King <peff@peff.net> wrote:
>   $ git init
>   $ seq 1 1000 >file && git add file && git commit -m base
>   $ mv file other
>   $ echo foo >file
>   $ git add .
>   $ git status --short
>   M  file
>   C  file -> other

Fantastic, I am able to replicate with these steps and will build
tests around this case.

For future proofing, from the documentation for git status is appears
the other two codes I would want to check for in addition to 'C '
(which this test cases generates) may be 'CM' and 'CD'? And all of
those should always have the additional PATH2 column present?

Thank you for your help!
