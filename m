From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: Question about 'branch -d' safety
Date: Tue, 20 Jul 2010 13:19:55 +0000
Message-ID: <AANLkTilOhFqhg1ulWEZUceNmrf0djZti9E1Y2QzTRgaN@mail.gmail.com>
References: <20091230065442.6117@nanako3.lavabit.com>
	<m3lj9jknlr.fsf@localhost.localdomain>
	<20100711065505.GA19606@localhost>
	<201007110916.29567.jnareb@gmail.com>
	<20100711133730.GA10338@localhost>
	<20100717093006.GA11452@localhost>
	<7v7hkrpcrk.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Clemens Buchacher <drizzd@aon.at>,
	Jakub Narebski <jnareb@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Nicolas Sebrecht <nicolas.s.dev@gmx.fr>,
	Nanako Shiraishi <nanako3@lavabit.com>,
	Joshua Jensen <jjensen@workspacewhiz.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 20 15:20:07 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ObCju-0003WM-64
	for gcvg-git-2@lo.gmane.org; Tue, 20 Jul 2010 15:20:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752271Ab0GTNT6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Jul 2010 09:19:58 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:52221 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752050Ab0GTNT5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Jul 2010 09:19:57 -0400
Received: by iwn7 with SMTP id 7so5744579iwn.19
        for <git@vger.kernel.org>; Tue, 20 Jul 2010 06:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=vGo4GXquSecJrLjRFADIpfbj4mKojZyS/l0E0kvFSag=;
        b=H/N5DF/DqVk1a3EoCrYlOZjOhKnqWImRZn6GcYCRXWstyfN1oDBiGoPQg4n+DcC2sC
         ephUKILo5G+3EU7DefFpWkd8ivzsniekbgSES7Gd4gRCd9Zxruh9UNbTNAx19Tk9NBSB
         qmcIjqrCQR6FLSBsyIm3ZH11ztz0NU1xDtx7k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=xcqS5qIoBngKbG1+Qk3eVmTfmlYZ+W0wbjYBnXXORwjJCcpIgDghs7+BSQLDXrFcza
         8xP7WEwJeOQU8kOHv/9xFkQ13/rBw11JVhN1nfnL7Vq8hFf44twDaPa4UPnAte83BMI3
         C6/1q6h/6rII/nS14MBZPRoT01isoUpbh//o0=
Received: by 10.231.159.203 with SMTP id k11mr5074835ibx.115.1279631995769; 
	Tue, 20 Jul 2010 06:19:55 -0700 (PDT)
Received: by 10.231.166.79 with HTTP; Tue, 20 Jul 2010 06:19:55 -0700 (PDT)
In-Reply-To: <7v7hkrpcrk.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151311>

On Mon, Jul 19, 2010 at 18:06, Junio C Hamano <gitster@pobox.com> wrote:
> Clemens Buchacher <drizzd@aon.at> writes:
>
>> Pros and cons for "undeleting branches":
>>
>> + safety net
>> It should not be easy to lose information with git.
>
> I am personally not very convinced by this argument when it comes to the
> cases where the user actively asks us to remove something.

I think it's mainly about user interface consistency. When you
"delete" stuff in with git reset (i.e. move the HEAD) it's recorded in
the reflog, but this isn't the case with branch deletions.

As Will Palmer pointed out, being able to tell newbies "Don't worry,
you aren't going to break it" is a very powerful thing to be able to
tell newbies and experienced users using Git.

It encourages experimentation, because you know that even if you botch
the rewrite and delete the wrong branch it's easy to recover your work
from the reflog in the morning.

I'd really like something like Joshua Jensen's suggestion for
recording a fake branch deletion commit in the reflog.
