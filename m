From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: Git server eats all memory
Date: Wed, 4 Aug 2010 16:12:17 -0400
Message-ID: <AANLkTimwy6GumHYSTo2je_hOUO80KEpx4_8z3iOoZyc0@mail.gmail.com>
References: <wesfwyupgrg.fsf@kanis.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Ivan Kanis <expire-by-2010-08-09@kanis.fr>
X-From: git-owner@vger.kernel.org Wed Aug 04 22:12:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OgkKY-0003th-Pi
	for gcvg-git-2@lo.gmane.org; Wed, 04 Aug 2010 22:12:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934429Ab0HDUMp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Aug 2010 16:12:45 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:32994 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934216Ab0HDUMl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Aug 2010 16:12:41 -0400
Received: by eya25 with SMTP id 25so2138829eya.19
        for <git@vger.kernel.org>; Wed, 04 Aug 2010 13:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=Nl+qeqQ5tfUCtSliLCLg4gu6xBzzL3u0Bkbl2AjmVNg=;
        b=S4tW4OglFzWI9K5byOF14a7jy9/BPYqSkBHJHbqBlYJVP6wBuKH07O3OuhyHvNw646
         j+hCHDIAZiwhTLLw9juUCy+rGp5qdkBarnxwOcPIOr16FmRbV0pGcIqrhLf+oDpNG7Ag
         ywtk10Z9Z/O5HB2SJ7hf/20uUpzgejTqIsVrg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=alTh3MsmWnsPbfvzA9yZ6E+Drs3ZV+x2W4O204J/C8OdNlkvSarQEw8xNSkwZFGvVC
         dyXty1dUm9xCELAoWSkaqS2Nacluqe+IetG38Abrrk6R77KWxPF018QFGeZTf9xt4pjX
         5h3sesYcPwj2Z84jn4SmNRc6z15wTyq7XmR6E=
Received: by 10.216.5.13 with SMTP id 13mr2493610wek.91.1280952758217; Wed, 04 
	Aug 2010 13:12:38 -0700 (PDT)
Received: by 10.216.235.202 with HTTP; Wed, 4 Aug 2010 13:12:17 -0700 (PDT)
In-Reply-To: <wesfwyupgrg.fsf@kanis.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152599>

On Wed, Aug 4, 2010 at 10:57 AM, Ivan Kanis
<expire-by-2010-08-09@kanis.fr> wrote:
> I am running git 1.7.0.4 on Debian stable. I have compiled git from
> source. I am cloning using ssh.The client and the server are running
> the same version. The bare repository is 4.5G with various binary files,
> I have 6G of memory on my server.
>
> I am having problem with memory ballooning when receiving object
> from the server. The amount of memory used on the server seems to be same
> size as the object received.

Git works fine with huge repositories; it does not work fine at all
with very large individual objects in a repository, and it does what
you're experiencing.  There are a few minor workarounds (like the
repack command someone mentioned) that slightly reduce the symptoms,
but the symptoms will crop up again eventually.

There's at least one project intended to solve this that people have linked to:
http://caca.zoy.org/wiki/git-bigfiles

...but it's incomplete and it doesn't look like their repo has changed
in some time.

I'm not aware of any workaround to this sort of thing other than
"don't store large objects in git."  You can split the big objects
into a bunch of small objects, as bup does, but then you have to
reassemble them all, which is inconvenient.

Sorry,

Avery
