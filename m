From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH v4 15/15] daemon: opt-out on features that require posix
Date: Thu, 21 Oct 2010 22:54:33 +0200
Message-ID: <AANLkTi=dAAsk8LMB=xnFtpyT7yuY2v76OOgJY5KdeD3D@mail.gmail.com>
References: <1286833829-5116-1-git-send-email-kusmabite@gmail.com>
 <1286833829-5116-16-git-send-email-kusmabite@gmail.com> <AANLkTikJXaqDH6vJzPna7txssMO67SxmVy_Nvu2SW46W@mail.gmail.com>
 <20101021203926.GB12685@burratino>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, msysgit@googlegroups.com, j6t@kdbg.org,
	avarab@gmail.com, sunshine@sunshineco.com,
	Junio C Hamano <gitster@pobox.com>, matled@gmx.net
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 21 22:55:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P92AA-0002m2-Bk
	for gcvg-git-2@lo.gmane.org; Thu, 21 Oct 2010 22:55:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757849Ab0JUUyz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Oct 2010 16:54:55 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:63962 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753420Ab0JUUyz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Oct 2010 16:54:55 -0400
Received: by gwj21 with SMTP id 21so472116gwj.19
        for <git@vger.kernel.org>; Thu, 21 Oct 2010 13:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:reply-to
         :in-reply-to:references:from:date:message-id:subject:to:cc
         :content-type;
        bh=5nJAsWqQXISpsxt3WWt0mMnap5wqlNtcvkVs2eENVuY=;
        b=rnAHzabWPjo+6/Nd+DD4lrDYDG7q1R/9uEZVbwsaCOHZBj4VdC3DxwYrRJoMEWg+Uz
         3XHe40EwWAvcbfVsUMwOjZdLco6ho88rvYGS9tdV9le7Czq0hdi99gd+pInIbJHHS3Sv
         +ZOBCtRbOBBgjvg5RA4Oqh9vrHiC+hKbY6KGs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        b=tODbr4HEIMmOUEB0T1Sib+7zPWQ658E56LOaGrRdSUQwCLs6I3J+kfEkWYBdhMBAjr
         jS8vhU4O9SMtie4Akx5mKg5DFCpq/jiAsXV6lvZpX+OXLYUfFm0Cu53+JCdj44yMIh1y
         H7QQu/MmNROvY9edAbuhFiYy8UWN/W1Oo+ZTo=
Received: by 10.103.2.10 with SMTP id e10mr386625mui.134.1287694493292; Thu,
 21 Oct 2010 13:54:53 -0700 (PDT)
Received: by 10.223.112.146 with HTTP; Thu, 21 Oct 2010 13:54:33 -0700 (PDT)
In-Reply-To: <20101021203926.GB12685@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159568>

On Thu, Oct 21, 2010 at 10:39 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Erik Faye-Lund wrote:
>
>> I understand that it might be beneficial in the --detach code-path,
>> but how can stdint, stdout or stderr be closed in this code-path?
>
> Maybe "git daemon >&- 2>&-"?
>
> In some situations involving setuid programs, this kind of thing
> can be a security problem (since fd 1 is not taken, the first open()
> uses that fd, so output intended for stdout goes to that file).
>

This is beyond my shell-fu, but if this is supposed to not open
stdin/out/err then I'm a bit puzzled. K&R explicitly states that
stdin, stdout and stderr should be opened at startup in Appendix B:
"When a program begins execution, the tree streams stdin, stdou and
stderr are already open". There's also section 7.5, which lists
redirection to files and pipes as exceptions, but not keeping them
closed.

Perhaps I'm interpreting K&R a little too literary?
