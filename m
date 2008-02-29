From: "=?ISO-8859-1?Q?Johan_S=F8rensen?=" <johan@johansorensen.com>
Subject: Re: git-daemon hangs in futex()
Date: Fri, 29 Feb 2008 15:26:12 +0100
Message-ID: <9e0f31700802290626o22ffea7bj6a2410a860f75b1b@mail.gmail.com>
References: <9e0f31700802281441i33120d70s43ca9f4eced6b5c3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 29 15:26:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JV6CM-0001qg-HW
	for gcvg-git-2@gmane.org; Fri, 29 Feb 2008 15:26:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758607AbYB2O0R convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 29 Feb 2008 09:26:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758680AbYB2O0R
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Feb 2008 09:26:17 -0500
Received: from ag-out-0708.google.com ([72.14.246.242]:39697 "EHLO
	ag-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758287AbYB2O0Q convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 Feb 2008 09:26:16 -0500
Received: by ag-out-0708.google.com with SMTP id 33so10186454agc.1
        for <git@vger.kernel.org>; Fri, 29 Feb 2008 06:26:13 -0800 (PST)
Received: by 10.150.121.2 with SMTP id t2mr3273689ybc.69.1204295172000;
        Fri, 29 Feb 2008 06:26:12 -0800 (PST)
Received: by 10.150.97.16 with HTTP; Fri, 29 Feb 2008 06:26:12 -0800 (PST)
In-Reply-To: <9e0f31700802281441i33120d70s43ca9f4eced6b5c3@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75539>

On Thu, Feb 28, 2008 at 11:41 PM, Johan S=F8rensen
<johan@johansorensen.com> wrote:
> Hi,
>
>  I'm having an issue with my git-daemon (1.5.4.3 on ubuntu gutsy), it
>  works fine for a few minutes, then it hangs (eg, "git clone git://"
>  never comes past "initialized empty git repo" adnd just sits and
>  waits) and strace on the git-daemon says:
>  $ strace -Ff -p 27453
>  Process 27453 attached - interrupt to quit
>  futex(0x2b270fb50980, FUTEX_WAIT, 2, NULL) =3D -1 EINTR (Interrupted=
 system call)
>
>  .. and nothing more. But, if I attach to the git-daemon process with
>  strace before that happens, git-daemon keeps on working fine, so I c=
an
>  change the outcome by observing it which is always nice, but not too
>  helpful.

Upon further investigation, it seems that this could be related to me
updating glibc to 2.6.1. Google suggest that it can because libc
switched to NPTL. I'm not familiar with the internals of it, so I
can't decide if this is a git issue (by indirect usage of glibc
functions) or not?

Thanks
JS
