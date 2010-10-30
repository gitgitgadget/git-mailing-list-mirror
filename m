From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: git merge-tree segfault
Date: Sat, 30 Oct 2010 17:25:06 +0000
Message-ID: <AANLkTi=mA5BUQN02r5ZUz_kHL+iC4J=4LFqe=tyCqg-q@mail.gmail.com>
References: <AANLkTinJQCqwRZpbO66VHrgxezedS1Ay3nr9kayiODi9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Klas Lindberg <klas.lindberg@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 30 19:27:07 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PCFCt-0003B6-Bg
	for gcvg-git-2@lo.gmane.org; Sat, 30 Oct 2010 19:27:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755353Ab0J3RZ1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Oct 2010 13:25:27 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:65360 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755144Ab0J3RZ0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Oct 2010 13:25:26 -0400
Received: by fxm16 with SMTP id 16so3970653fxm.19
        for <git@vger.kernel.org>; Sat, 30 Oct 2010 10:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=HyOkPlifh3TwsBKXPtu+jsUxywdDN2MCcS3P6+NSd60=;
        b=GhmdiYaePZV4EwbR6/P6b3nNsCL8mJceH/WOmEJrpMUr324pQFbrBzfEpodRBLvhZS
         Z+KwLzDTLSHQ1JcGbgjrT2dcfEbX2Axwzg33g0/AK2Nb9vJsu/SAxY9viENOph2t1WsL
         XZi4vL9Hcu9ygmbe+MC8iYpKeoVJri93FWAZ8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=bqFE9Mb/Pv21S3wS7nytRKNcXZnFJt1B73OXkaDieEW3o7iHEZYCGCLovlTIH9ELji
         XDS8m+eyM3oj2DrJbaozk2MY1PD5kQgjxRsJFeGJxyTa/+fnx+7gHFknegVAHe2jWWHy
         07/3xcTcqd3Pmyc/o5tOmNTqUZeTP93lsv5sI=
Received: by 10.223.125.136 with SMTP id y8mr5156595far.149.1288459506229;
 Sat, 30 Oct 2010 10:25:06 -0700 (PDT)
Received: by 10.223.123.203 with HTTP; Sat, 30 Oct 2010 10:25:06 -0700 (PDT)
In-Reply-To: <AANLkTinJQCqwRZpbO66VHrgxezedS1Ay3nr9kayiODi9@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160402>

On Thu, Oct 28, 2010 at 20:16, Klas Lindberg <klas.lindberg@gmail.com> wrote:
> I haven't tried this on newer versions of git, but the release notes
> for later releases don't mention merge-tree anywhere, so...

Doesn't segfault for me. Probably since my version has this commit:

commit 21baa6e0c56d229866c02c4b42b8b53af648d853
Author: Will Palmer <wmpalmer@gmail.com>
Date:   Wed Jul 14 18:04:07 2010 +0100

    merge-tree: fix where two branches share no changes

    15b4f7a (merge-tree: use ll_merge() not xdl_merge(), 2010-01-16)
    introduced a regression to merge-tree to cause it to segfault when merging
    files which existed in one branch, but not in the other or in the
    merge-base. This was caused by referencing entry->path at a time when
    entry was known to be possibly-NULL.

    To correct the problem, we save the path of the entry we came in with,
    as the path should be the same among all the stages no matter which
    sides are involved in the merge.

    Signed-off-by: Will Palmer <wmpalmer@gmail.com>
    Signed-off-by: Junio C Hamano <gitster@pobox.com>

$ git tag --contains 21baa6e0c56d229866c02c4b42b8b53af648d853|grep ^v
v1.7.2
v1.7.2.1
v1.7.2.2
v1.7.2.3
v1.7.2.3.msysgit.0
v1.7.3
v1.7.3-rc0
v1.7.3-rc1
v1.7.3-rc2
v1.7.3.1
v1.7.3.1.msysgit.0
v1.7.3.2
v1.7.3.2.msysgit.0
