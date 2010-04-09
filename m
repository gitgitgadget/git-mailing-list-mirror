From: Aghiles <aghilesk@gmail.com>
Subject: Re: git pull suggestion
Date: Fri, 9 Apr 2010 16:54:41 -0400
Message-ID: <h2m3abd05a91004091354t1b1de4aag48816d7e47cc766@mail.gmail.com>
References: <r2x3abd05a91004071617z9ffd6e02v83d825405bb6ef1@mail.gmail.com> 
	<201004081754.24954.trast@student.ethz.ch> <p2x3abd05a91004081233j77b7177bm5928913a64de0e57@mail.gmail.com> 
	<20100408231154.GB13704@vidovic> <v2r3abd05a91004082006v74e243f2x33b500f2f6dadc9f@mail.gmail.com> 
	<20100409034911.GA4020@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>,
	Thomas Rast <trast@student.ethz.ch>,
	git list <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Apr 09 22:55:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O0LEN-0008LV-8m
	for gcvg-git-2@lo.gmane.org; Fri, 09 Apr 2010 22:55:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757217Ab0DIUzG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 9 Apr 2010 16:55:06 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:40697 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757199Ab0DIUzF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 Apr 2010 16:55:05 -0400
Received: by wyb39 with SMTP id 39so607754wyb.19
        for <git@vger.kernel.org>; Fri, 09 Apr 2010 13:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:received:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=LmW3uQFxA/eScQHYfwlmy1rEr657dTAwtsVQGHKIMRw=;
        b=ZMB6Tc4zA61AQHRk4hrkfEtIK8YSztnQX63vsG+HSwz22+dEsyPebEreWTLl2pCuvk
         Zpk5foZysQ1OzJwEx+BSPnaxTMx2EzLByharVxwji5Q+yJczpDzYagmMEE38f6YmQfQD
         D+WPj0WxTi7D1Rqb+SZnmVCe4k/tvxo82vbfQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=t8Wd7ZYIZ9rHfIvQ3/fpYRpIzpLcqBiSNu2BBxQUE08DzOElpuPN8iQ2verjdwTNOq
         KmKim7nIU4zWRFpsQ4koKmInSmphymr4yiMtGpKVZOkHHzOzff6lP7vo7qYwuYa9L00i
         +wLKgOYYc+43d4zZHVWWds7fArBDFnRU3rnMQ=
Received: by 10.216.170.8 with HTTP; Fri, 9 Apr 2010 13:54:41 -0700 (PDT)
In-Reply-To: <20100409034911.GA4020@coredump.intra.peff.net>
Received: by 10.216.163.67 with SMTP id z45mr352080wek.26.1270846501274; Fri, 
	09 Apr 2010 13:55:01 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144471>

Jeff King <peff@peff.net> wrote:
> It is possible to manually get the answer you want, or close to it. Y=
ou
> are looking for the intersection of files modified by you and files
> modified by the upstream. So:
>
> =A0# unique list of modified working tree files and index entries
> =A0$ (git diff-files --name-only;
> =A0 =A0 git diff-index --name-only HEAD
> =A0 =A0) | sort -u >us
> =A0# files that will be changing as part of merge
> =A0$ git diff-tree --name-only $HEAD_TO_MERGE_FROM | sort >them
> =A0$ comm -12 us them
>
> where $HEAD_TO_MERGE_FROM in my example would be "other", but in the
> case of a pull, would probably be FETCH_HEAD.

It works. You actually need the -r flag to 'git diff-tree' (recursive) =
in order
to list the actual files and not only their parent directories. So it b=
ecomes:

$ (git diff-files --name-only; git diff-index --name-only HEAD ) | sort=
 -u>us
$ git diff-tree -r --name-only $HEAD_TO_MERGE_FROM | sort > them
$ comm -12 us them

Thank you very much,

  -- aghiles
