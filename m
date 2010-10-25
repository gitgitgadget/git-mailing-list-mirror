From: Mike Herrick <mike.herrick@gmail.com>
Subject: Re: fsck errors on newly cloned, newly imported git repository
Date: Mon, 25 Oct 2010 08:25:10 -0400
Message-ID: <AANLkTi=7mg-1Q1hHPA52MiHa3BXF95SGTTTTLFR9+VZ3@mail.gmail.com>
References: <AANLkTimxXXNxUOMQyDDoW9+vT9aKL5C5m+VD51jk0zL9@mail.gmail.com>
	<1288004282.819.26.camel@drew-northup.unet.maine.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Drew Northup <drew.northup@maine.edu>
X-From: git-owner@vger.kernel.org Mon Oct 25 14:25:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PAM76-0000bE-5Z
	for gcvg-git-2@lo.gmane.org; Mon, 25 Oct 2010 14:25:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754117Ab0JYMZN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 25 Oct 2010 08:25:13 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:59803 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753432Ab0JYMZM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Oct 2010 08:25:12 -0400
Received: by wwe15 with SMTP id 15so3424330wwe.1
        for <git@vger.kernel.org>; Mon, 25 Oct 2010 05:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=zxuU9yud/7AaPhkOYr20WdVX20MI4TaMjGffr7D5Gzw=;
        b=BK6c+sQLCpmnyXv7zuT3dvukcMc7Ds2UY358L++s6SSaRE57G8VdCD3akrEEVde8e+
         T5z0X/hiC3CR/Re2QgFsqD9EMuLcC/E2a8rsNjhhZ0pddy1LvjgBw5RYHphsaFvh8fSs
         THDYqWE8xY/sAa/0ryA7wBiLxvYmtTlOSrHQc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=QlyejPHr/5FIUMFbgONPxMcTjkCfk2PCwr9tsBhxSLKkWr307ww5EWLGGZM5SZZoL4
         ThKhi2lAYFF2KOpn6E3GpUtZDXhG9bvKrKl+pEw5RNdfD11sHjKPCgUtr4wokjokR7yD
         nj22orgIDYQFC1Hi4Rkdxn80WKuH6dCZibXbU=
Received: by 10.216.28.204 with SMTP id g54mr268859wea.73.1288009510670; Mon,
 25 Oct 2010 05:25:10 -0700 (PDT)
Received: by 10.216.255.143 with HTTP; Mon, 25 Oct 2010 05:25:10 -0700 (PDT)
In-Reply-To: <1288004282.819.26.camel@drew-northup.unet.maine.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159945>

On Mon, Oct 25, 2010 at 6:58 AM, Drew Northup <drew.northup@maine.edu> =
wrote:
>
> On Sun, 2010-10-24 at 11:54 -0400, Mike Herrick wrote:
>> This weekend we're cutting over to use git for our source code contr=
ol
>> system. =A0I've imported about 20 years worth of previous history us=
ing
>> "git cvsimport" (takes about four hours). =A0I then cloned the resul=
ting
>> repository onto five different machines (four Linux, one Solaris).
>> I've set up a cron job to do a nightly "git fsck" on each of the fiv=
e
>> machines, and last night, two of the machines reported fsck errors o=
n
>> their initial run.
> <snip>
>
>> The errors reported on these two machines were different, but what's
>> interesting is that all of the missing blobs refer to various
>> revisions of the same file, namely our "Changes" file (which is
>> updated with each change). =A0It's also the largest file in our
>> repository (3.3M). =A0I immediately started looking at logs to see i=
f
>> there was any indication of disk corruption and found none (no SMART
>> errors either). =A0Both of these machines have been stable over a
>> multi-year period of time (no unexplained crashes). =A0They're also
>> older Linux machines (running =A02.6.5-1.358 and =A02.6.1-1.65, with
>> relatively little memory: 1GB and .5GB), but with newly installed
>> version of git (1.7.3.1). =A0I initially used git-daemon for the clo=
ne
>> process, but even using ssh, I still see fsck errors on the resultin=
g
>> clones on these two machines.
>
> Did you "git fsck" BEFORE you attempted to clone? Is it ONLY clones
> showing errors? Alas, no blatant evidence of disk corruption is not
> evidence of no disk corruption as well.

Thanks for your reply.

Only two of the five clones exhibit fsck errors and the server
repository has no fsck errors.

The two machines report different sets of missing blobs, but always in
the "Changes" file (which has the somewhat unique characteristics that
it is the "most changed" file in the repository, the largest, and one
which is almost always only added to).

I've since created two more clones on one of the machines (one using
git-daemon and the other ssh) and both of these clones have the exact
same set of missing blobs!  For me this rules out disk corruption.

The good(?) news is that the process is repeatable on one machine:
cloning from a known good repository results in different (but
repeatable) errors.  Performing a second clone on the other "bad"
machine also results in missing blobs, but different ones than the
first (although all in the Changes file).

My current thought is that somehow it's related to very old kernels?
Apparently these machines are FC2 vintage.

Mike.
