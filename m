From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v6 06/10] fast-export: add new --refspec option
Date: Tue, 12 Nov 2013 15:02:51 -0600
Message-ID: <5282977b2ecd_3b98795e785e@nysa.notmuch>
References: <1384210507-26561-1-git-send-email-felipe.contreras@gmail.com>
 <1384210507-26561-6-git-send-email-felipe.contreras@gmail.com>
 <xmqqd2m6jyue.fsf@gitster.dls.corp.google.com>
 <CAMP44s2ubU_R0GkEUpEh24TxER3uONQJprh9Ot7+PL0QiDRmDg@mail.gmail.com>
 <5281DB46.2010004@bbn.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Sverre Rabbelier <srabbelier@gmail.com>
To: Richard Hansen <rhansen@bbn.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 12 22:21:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VgLP0-0004fm-Bg
	for gcvg-git-2@plane.gmane.org; Tue, 12 Nov 2013 22:21:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755881Ab3KLVVf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Nov 2013 16:21:35 -0500
Received: from mail-oa0-f49.google.com ([209.85.219.49]:46964 "EHLO
	mail-oa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752280Ab3KLVVd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Nov 2013 16:21:33 -0500
Received: by mail-oa0-f49.google.com with SMTP id h16so3719771oag.36
        for <git@vger.kernel.org>; Tue, 12 Nov 2013 13:21:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=cMLPiomp7KR/i6K1mD1gMVKIhd6J3dkzJ3CS4eyhP2c=;
        b=uOavpc8AtfKbSHmQruKj/7naIdEOvSlF//ZVyUhVPtQZ3k6K8jQXhMvEka0xfD6de0
         d2qrrmpacKvVLdDUgWkjsS0nJ9s5oQqAYQ/LtE6vDdZSUQDEaiOaJ0Yrtm5tfkLUcKBN
         uqlGwztIOgtCBO9p9A1WaEg9a9qZ/LO95MxM3o8bLsV28RgiJ/rKTGDzG5cwHGM0fcY4
         aIeBzqSbNxqOJGarmy54KJy6CP6Pedf/BfAJRvQw4WAQXd6Fwk2WdO5pEXe+xPwxc2r5
         RmSY9iqchQvQgQHRLEDp1LJFzwI055H7wOfqAYEHXPgwOH7m/E8HNRgWW1JZQMIPK1qu
         q/pQ==
X-Received: by 10.60.103.37 with SMTP id ft5mr13771682oeb.45.1384291291791;
        Tue, 12 Nov 2013 13:21:31 -0800 (PST)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id nw5sm8183950obc.9.2013.11.12.13.21.29
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Nov 2013 13:21:30 -0800 (PST)
In-Reply-To: <5281DB46.2010004@bbn.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237757>

Richard Hansen wrote:
> On 2013-11-11 18:50, Felipe Contreras wrote:
> > On Mon, Nov 11, 2013 at 5:25 PM, Junio C Hamano <gitster@pobox.com> wrote:
> >> Felipe Contreras <felipe.contreras@gmail.com> writes:
> >>
> >>> So that we can convert the exported ref names.
> >>>
> >>> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> >>> ---
> >>
> >> I thought that the discussion agreed this option should not be
> >> called --refspec but something like --refmap?
> > 
> > I don't know what you agreed to,
> 
> http://article.gmane.org/gmane.comp.version-control.git/237473
> 
> > but I didn't agree to anything.
> 
> Based on your silence I too thought that you had agreed.

Given that my opinion is regarded as inferior by those in the discussion, I
don't see why I should share it, specially since when I do, it's considered
toxic if I disagree.

> > What you pass to this option is a refspec, so it makes sense to name
> > the option --refspec.
> 
> As discussed in that thread, it's not really the same thing as a refspec
> used in push or fetch.  In those commands, the refspec specifies two
> separable things:  what to transfer, and how to translate refs names
> between the remote and local repositories.  IIUC, the fast-export
> --refspec argument only specifies how to translate ref names, not what
> gets transferred.

Does it?

 % git config remote.origin.fetch '+refs/heads/*:refs/remotes-test/origin/*'
 % git fetch origin master
 From /home/felipec/dev/git
  * branch            master     -> FETCH_HEAD
  * [new branch]      master     -> refs/remotes-test/origin/master

In this case remote.origin.fetch is determining how to translate ref names, not
what gets transferred, *exactly* the same as we are doing with --refspec. And
as far as I know, remote.origin.fetch is a refspec.

-- 
Felipe Contreras
