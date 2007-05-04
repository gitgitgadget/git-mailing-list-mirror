From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: repack: handling of .keep files
Date: Fri, 4 May 2007 12:42:10 +0200
Message-ID: <81b0412b0705040342p4fed3a4bnee92cce6b5fb6b9@mail.gmail.com>
References: <81b0412b0705040225p26679dbib6a1261a1a43ee67@mail.gmail.com>
	 <7vy7k4ud3d.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Junio C Hamano" <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri May 04 12:42:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HjvFV-0002iF-TN
	for gcvg-git@gmane.org; Fri, 04 May 2007 12:42:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031372AbXEDKmU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 4 May 2007 06:42:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030224AbXEDKmQ
	(ORCPT <rfc822;git-outgoing>); Fri, 4 May 2007 06:42:16 -0400
Received: from an-out-0708.google.com ([209.85.132.240]:22626 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1767810AbXEDKmL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 May 2007 06:42:11 -0400
Received: by an-out-0708.google.com with SMTP id b33so785013ana
        for <git@vger.kernel.org>; Fri, 04 May 2007 03:42:11 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=TmI+x+9R7Q1dgGtZVIazd14sl8t7CfEtCYtLGMKtmf4yAczQGHYuRgbfRGQkxe1vhTick1sttMBYiBjyFx8+HphVgGz6AOkgUJXiqrcGRumpWoCZHVypk774LnReTD/5M1Ib2PFUV3U9JnofHy4Nmh5IBpVSrbYBPIcOXJu62Xc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=uKgZ2WlzWPrmKyRXQCx/mFjRjn7lix2UW6I/d7qCaSW+/Z1GSLCagjK2v3ruhUx2Drlp7X4HjOU4kARKB57ikD024JlgBx5vmyoFWcOJR/ZPIKjU2oBnhGQmQfyRf30K+VW6ugO5qUqZ5Wdblxt+z0QzueAQXnZB2YqW48fOafs=
Received: by 10.100.9.19 with SMTP id 19mr1290565ani.1178275330169;
        Fri, 04 May 2007 03:42:10 -0700 (PDT)
Received: by 10.100.86.19 with HTTP; Fri, 4 May 2007 03:42:10 -0700 (PDT)
In-Reply-To: <7vy7k4ud3d.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46158>

On 5/4/07, Junio C Hamano <junkio@cox.net> wrote:
> "Alex Riesen" <raa.lkml@gmail.com> writes:
>
> > ... Experimenting with the .keep-files I had a crash in git-log,
> > when the pack was renamed into .keep.pack, but the
> > index was not. git-log complained about two objects it could not
> > read and than crashed. It's cygwin.
>
> This part makes me suspect you are not even using the .keep
> properly.  In addition to pack-[0-9a-f]{40}.(pack|idx), you
> would have a corresponding pack-[0-9a-f]{40}.keep file (whose
> contents does not matter) to mark that these should not get
> repacked.

This is it (described in git-index-pack.txt, maybe git-repack.txt should
reference it too), thanks.

Still, git-log shouldn't crash (nothing should, of course).
And, the temporary pack is created in working tree, instead of in GIT_DIR
(why not GIT_OBJECT_DIR, btw?)
