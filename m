From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [BUG] git_path() returns relative paths
Date: Sat, 27 Jul 2013 22:17:17 +0700
Message-ID: <CACsJy8CDg2ORKrpwiph=WdW5GPUYEwT1CSCttQ4fagQoMP4QGA@mail.gmail.com>
References: <CALkWK0m-4wtpTAcePPWFLT7iwXdcpp+nOy9oG2iFHLsp9XdKZQ@mail.gmail.com>
 <CALkWK0k-23rTohYvNWP_XbuUCSGUE+G_e_7cBbPP5C9OzsJ4XQ@mail.gmail.com>
 <CALkWK0kBesC2=kyygMCt61Fm5GGqX+yF6sbkCRcGYZ=ovgtTAQ@mail.gmail.com>
 <CACsJy8C5Du8zcqVeN7EGuyUxgSZaRq-X8y_hQvqQedYWfP8p+A@mail.gmail.com> <CALkWK0kWnge7fVtTXRgTiK1NbyN8X=bmqfPTc+Mp=BCssPc1og@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Xin Jiang <worldhello.net@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 27 17:17:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V36Fl-0000lm-BT
	for gcvg-git-2@plane.gmane.org; Sat, 27 Jul 2013 17:17:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752068Ab3G0PRt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Jul 2013 11:17:49 -0400
Received: from mail-ob0-f181.google.com ([209.85.214.181]:50605 "EHLO
	mail-ob0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752051Ab3G0PRt (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Jul 2013 11:17:49 -0400
Received: by mail-ob0-f181.google.com with SMTP id dn14so6035643obc.26
        for <git@vger.kernel.org>; Sat, 27 Jul 2013 08:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=fRQpRjQtKDPANVABx24pFa9qp9NDv3QR8P7n2C41m2w=;
        b=D45+464Mfg01exrn6HHWwQIChu5FXXpOOty0cAAtlkc0oQ/OtbpMOsMBSfcx/FdtBf
         xEdfcDb+UU8kRXSrAnn2ELvUpzagjee/n6xK6+zF1fWqD1Uuo4V2G2PTvHeYwP/U2Hut
         xRLoUaSH6F9woAhUnZHGQa0DaCIHqS6FeG7Vbao+IAF62Y9c6SlQUwoMXkFgfajZxDeh
         Z4ZBOV0mk1IVZmKNO+mnpagkKihLjphTs9bsxwOwo5jfEI8A/AbKb01s2TMYomX8yrAr
         OnJTTWJ3J5eUXaUqvueCbcSO7mircWFmKlCWLZjcNVHGklZyrgKK3cECbvHH6EC1grXX
         2DQQ==
X-Received: by 10.182.34.166 with SMTP id a6mr46690823obj.102.1374938268505;
 Sat, 27 Jul 2013 08:17:48 -0700 (PDT)
Received: by 10.182.240.168 with HTTP; Sat, 27 Jul 2013 08:17:17 -0700 (PDT)
In-Reply-To: <CALkWK0kWnge7fVtTXRgTiK1NbyN8X=bmqfPTc+Mp=BCssPc1og@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231247>

On Sat, Jul 27, 2013 at 9:33 PM, Ramkumar Ramachandra
<artagnon@gmail.com> wrote:
> Duy Nguyen wrote:
>> 044bbbc (Make git_dir a path relative to work_tree in
>> setup_work_tree() - 2008-06-19)
>
> Okay, so it does seem to be a significant optimization.  Frankly,
> e02ca72 only improves the relative_path() algorithm, and it's not
> really doing anything Wrong: it's has just uncovered a previously
> undiscovered bug.
>
> So far, we know that the line:
>
>   s->fp = fopen(git_path(commit_editmsg), "w");
>
> in commit.c:prepare_to_commit() isn't failing; so, the work_tree and
> git_dir do seem to be set correctly. The problem seems to be in
> launch_editor().  What's worse? Everything works just fine when I have
> a symbolic link to a directory in a normal repository; I still can't
> figure out what submodules have to do with any of this.
>
> What the hell is going on?!

I was involved with this code (the gitdir setup code, not submodule)
and am interested to know what's going on too. Could you produce a
small script to reproduce it?
-- 
Duy
