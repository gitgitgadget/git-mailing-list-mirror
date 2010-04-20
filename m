From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: ghost refs
Date: Tue, 20 Apr 2010 17:03:18 +0200
Message-ID: <n2u81b0412b1004200803j578e834czfa8775110fb794eb@mail.gmail.com>
References: <89030B4A18ECCD45978A3A6B639D1F24032A074E1C@FL01EXMB01.trad.tradestation.com>
	 <r2h32541b131004070958pa66bb7a3g6a1ecfaea0419965@mail.gmail.com>
	 <20100407210010.GB27012@coredump.intra.peff.net>
	 <loom.20100420T085842-887@post.gmane.org>
	 <20100420115124.GB22907@coredump.intra.peff.net>
	 <s2m76718491004200633la1cb07a6n8bc0d8d8e71b4e92@mail.gmail.com>
	 <20100420142444.GA8851@coredump.intra.peff.net>
	 <g2u76718491004200752gcf73abf1se05e89bd605e77a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Yann Dirson <yann.dirson@bertin.fr>,
	git@vger.kernel.org
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 20 17:03:44 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O4EzI-0006my-E1
	for gcvg-git-2@lo.gmane.org; Tue, 20 Apr 2010 17:03:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751017Ab0DTPDf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 20 Apr 2010 11:03:35 -0400
Received: from mail-yx0-f171.google.com ([209.85.210.171]:52455 "EHLO
	mail-yx0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751179Ab0DTPDe convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 20 Apr 2010 11:03:34 -0400
Received: by yxe1 with SMTP id 1so3728858yxe.33
        for <git@vger.kernel.org>; Tue, 20 Apr 2010 08:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:received:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=TwXmjgaZLjqWwL7yu9b8AVKOmGgO657rXCXrmTqWA0g=;
        b=opMbbdLqlZPvaVk9e9SI+pY5xyfAGPDW2sFOA3iCfGVvWM4qoZ7Z2gGCQfUvNR/NKa
         8HLiHbOckoiz41AO8nEBsRSgUmwVZZvsju0MVkSELGCtPV6Nz/rX8KsoD8iKCXvPpaOj
         6OlX8oxU1tQu6yhr9SyQoM9L0eekjVxUrqB+c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=HrJ7H3c3wpZLXI6MCNGKrlYPDPFakqxHanSn/iVPSfVd5k/gRBFJyC1XNxHYD++xwL
         86r+iVpGu9cWH1oqi8RtHl4RtWzZZBTh7jiGT1yHXK/VjvkRhyX9FAftQ40D64t9fnG4
         XZqGRNlmqFyuXiZ+dgpufNODY2vg20RPzFQq4=
Received: by 10.100.212.9 with HTTP; Tue, 20 Apr 2010 08:03:18 -0700 (PDT)
In-Reply-To: <g2u76718491004200752gcf73abf1se05e89bd605e77a@mail.gmail.com>
Received: by 10.100.49.29 with SMTP id w29mr17107680anw.150.1271775798828; 
	Tue, 20 Apr 2010 08:03:18 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145382>

On Tue, Apr 20, 2010 at 16:52, Jay Soffian <jaysoffian@gmail.com> wrote=
:
> On Tue, Apr 20, 2010 at 10:24 AM, Jeff King <peff@peff.net> wrote:
>> On Tue, Apr 20, 2010 at 09:33:42AM -0400, Jay Soffian wrote:
>> I like how the user would interact with that, but what happens with:
>>
>> =C2=A0git checkout -b topic/subtopic
>>
>> The reflog of the deleted branch is in the way.
>
> Handle it just as gracefully as we do today. This is what happens whe=
n
> you try to create a branch with a similar collision:
>
> $ git branch foo/bar
> $ git branch foo
> error: there are still refs under 'refs/heads/foo'
> fatal: Failed to lock ref for update: Is a directory
>
> So the reflog analog would be:
>
> $ git branch topic/subtopic
> error: there are still logs under 'logs/refs/heads/topic'
> fatal: Failed to lock log for update: Is a directory
>
> I think it's an edge case; thus I think it's okay to fail as long as
> we give a reasonable error and a way to rename it.

No it is not. Creation of the reflog is not the purpose of
git branch operation (creation of the branch itself is).
It will be just annoyance, especially if the user will
have to do a rename which could be done automatically.
