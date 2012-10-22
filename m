From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] transport-helper: check when helpers fail
Date: Mon, 22 Oct 2012 13:50:00 +0200
Message-ID: <CAMP44s2XDkLhKkqvxnGH+U5X=42dXU1550xVQvyQk=WD2p0c6Q@mail.gmail.com>
References: <1350847158-14154-1-git-send-email-felipe.contreras@gmail.com>
	<5084E931.3010809@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon Oct 22 13:50:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TQGWO-0008Sd-H5
	for gcvg-git-2@plane.gmane.org; Mon, 22 Oct 2012 13:50:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752927Ab2JVLuD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Oct 2012 07:50:03 -0400
Received: from mail-oa0-f46.google.com ([209.85.219.46]:42390 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752849Ab2JVLuB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Oct 2012 07:50:01 -0400
Received: by mail-oa0-f46.google.com with SMTP id h16so2297553oag.19
        for <git@vger.kernel.org>; Mon, 22 Oct 2012 04:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=cnUTyaYAlXefg8Pwy7XXCD7m4Qt3ymcU1UIrf+4WMv4=;
        b=D/meenPZ5ITy1NDPK2Po6Gv+hdftsgmlLjde1OuvWMbQjl1Onqm8e9eXAow3sNHJ+A
         PHWhkmdXXzFXvvY9ILYD5JzEoCymjYiHMYbp6xqFyaDzz/5GQba1/4Wpkzo+JXn+sm1t
         mg6Fl7k3CXkuHpptqoTiMDhRd3mz04BR6yQFxjQ0wb3eb8BuNXBrFQPFrSu96NHa9uEE
         y6j1y+WJmHHzwz3Lc8A+K3E7F2v+NXGB6VVUzYo9NiutqKFjNfl32iJjIMiyqEdYVRqw
         bxK0csSbGUIYPTGkpXxadErGBf4Z7oI/C8ZLqaI54nX9syOiAULVaQTNHydUkB10H1Fy
         ozZw==
Received: by 10.60.27.71 with SMTP id r7mr7899819oeg.96.1350906600996; Mon, 22
 Oct 2012 04:50:00 -0700 (PDT)
Received: by 10.60.4.74 with HTTP; Mon, 22 Oct 2012 04:50:00 -0700 (PDT)
In-Reply-To: <5084E931.3010809@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208178>

On Mon, Oct 22, 2012 at 8:35 AM, Johannes Sixt <j.sixt@viscovery.net> wrote:
> Am 10/21/2012 21:19, schrieb Felipe Contreras:

> I would expect the function to be usable in this way:
>
>         start_command(&proc);
>
>         loop {
>                 if (check_command(&proc))
>                         break;
>         }
>
>         finish_command(&proc);
>
> but it would require a bit more work because it would have to cache the
> exit status in struct child_process.

Yes, I would expect that as well. I just noticed transport-helper also
fails with that, but some reason that's not enough to actually fail
the tests, so something weird is going on.

> BTW, you should check for return value 0 from waitpid() explicitly.

Right.

> Another thought: In your use-case, isn't it so that it would be an error
> that the process exited for whatever reason? I.e., even if it exited with
> code 0 ("success"), it would be an error because it violated the protocol?

How is that violating the protocol?

-- 
Felipe Contreras
