From: Erick Mattos <erick.mattos@gmail.com>
Subject: Re: [PATCH] t/: work around one-shot variable assignment with 
	test_must_fail
Date: Wed, 21 Jul 2010 21:28:16 -0300
Message-ID: <AANLkTikUs2kSqeNxzCW0fag4K_4yuQSX1JKwk4pFd0Ni@mail.gmail.com>
References: <8HvhdiflWJtex2eC6n_6Q38YcvRRYhnh0scnq4s56M4wdwT_YlAiOw@cipher.nrlssc.navy.mil> 
	<iU5XdZGtMeaspoCqSJIp6Y--60TPVkZUrm3SdW86dsTZkNYZWqbSppLBrMXyL1rVqqYtHm94ACo@cipher.nrlssc.navy.mil> 
	<AANLkTilY0fYxKlWLYGU4f4ZtJzsMSSnIIi0YnywKU5DU@mail.gmail.com> 
	<QGT_6Gjw_prM4Z_TThjuP3s9CSH7c4P6hnnNpVLNYxcJL6N_1HxuGQ@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, avarab@gmail.com, jrnieder@gmail.com,
	jaredhance@gmail.com, drafnel@gmail.com
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Thu Jul 22 02:28:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Objec-00022T-KC
	for gcvg-git-2@lo.gmane.org; Thu, 22 Jul 2010 02:28:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753482Ab0GVA2o convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 21 Jul 2010 20:28:44 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:63559 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752234Ab0GVA2n convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 Jul 2010 20:28:43 -0400
Received: by iwn7 with SMTP id 7so7285409iwn.19
        for <git@vger.kernel.org>; Wed, 21 Jul 2010 17:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=5lFA5rueQpJ3tYPyxkrAvjWZjrXzS9rMtO0Rg7TCfys=;
        b=OnaVWQ8uhUKMFEg+xGvryoiF8pmrsZ7hVf4S9frcgKiGCGX9pvf9W2S2vqG6GpzXQa
         +ULz2IzPpPQP+l3PpubC6OWdZRDdkgJOxT4s/zwabvnwtxUj+EkZpDQQhmii355feaUg
         KVZSpuJOiAF7Ai2T1Edv1f6Epsb4Ys0LwsAvc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=cPcGLlAidI3w9Aqe7A0sTfyOsRbNUjNDGF8vz3ZskMucfgA2vWyZueqUyOewBv3H1C
         F2mSSYWyYxB64nBfJO+WHRtRUk/AYEmlu0av/eL6QgPX+SCoubNKJ3Xt6g50lWPUCkqc
         dMMEkDXeJFDNFX6MsUAsrkrr6qoLqFCNt1s0c=
Received: by 10.231.32.70 with SMTP id b6mr873458ibd.99.1279758516436; Wed, 21 
	Jul 2010 17:28:36 -0700 (PDT)
Received: by 10.231.178.36 with HTTP; Wed, 21 Jul 2010 17:28:16 -0700 (PDT)
In-Reply-To: <QGT_6Gjw_prM4Z_TThjuP3s9CSH7c4P6hnnNpVLNYxcJL6N_1HxuGQ@cipher.nrlssc.navy.mil>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151436>

Hi,

2010/7/21 Brandon Casey <casey@nrlssc.navy.mil>:
> On 07/20/2010 06:19 PM, Erick Mattos wrote:
>> 2010/7/20 Brandon Casey <casey@nrlssc.navy.mil>
>>> No time to investigate, but here is an example patch and the
>>> results of running the affected tests.
>
>> You have made cosmetic changes which do not do the same as the origi=
nal.
>?
> Nope, look closer. =C2=A0The changes are not cosmetic.

Now I see it.  I was not completely aware of the problem, only of your
email.  Maybe I should subscribe to the list at last... ;-D

> Try this:
>
> =C2=A0 run_it () { "$@"; }; run_it foo=3D true && echo success || ech=
o failure
>
> You probably get something like this (if you're using bash):
>
> =C2=A0 bash: foo=3D: command not found

It would work if it was like:

run_it () { eval "$@"; }; run_it "foo=3D true" && echo success || echo =
failure

But I think your approach is better shaped for a fast solution.

> That's because the one-shot variable assignment doesn't work when
> used like this. =C2=A0It also means that the original tests which do:
>
> =C2=A0 test_must_fail PAGER=3D git ...
>
> are broken. =C2=A0We ran into this problem a while back and fixed it =
in
> the commit that I referenced (e2007832). =C2=A0I fixed the new instan=
ces
> in t2017, t3200, and t3301 in the patch that I sent.
>
> For the tests in t2017 and t3200 that now fail, the originals seem to
> expect 'git reflog show' to return non-zero when asked to show the re=
flog
> for a ref which doesn't have a log. =C2=A0reflog does not currently r=
eturn
> non-zero in this case. =C2=A0Either the tests should be updated to re=
flect
> the actual behavior of 'reflog show', or 'reflog show' should be upda=
ted
> to return non-zero when passed a ref without a log.

So fixing it is a need.

On t2017 and t3200 the problem that appeared was because no message
and error had been generated when there is no reflog.  Git reflog when
run on a ref with a nonexistent reflog file exits with 0 saying
nothing.

I don't see this as a correct behavior but as those tests were just to
enforce the previous "! test -f..." test which is already enough for
checking the intended behavior then I would think it was good enough
just to wipe out the "problematic git reflog" commands until deciding
how quiet git reflog command should be when there is no reflog file to
show.

Although I just realized Junio sent an email following this thread and
I bet he could give a better solution or his directions.  Going to
read it now.

Thanks for your clarifications.

Regards
