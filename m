From: "David Symonds" <dsymonds@gmail.com>
Subject: Re: HFS+ Unicode weirdness
Date: Tue, 4 Sep 2007 23:07:45 +1000
Message-ID: <ee77f5c20709040607u163d1336k46c83cfb9e37bfee@mail.gmail.com>
References: <052099D2-F79B-4063-82D3-BFB5D0102A55@wincent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Wincent Colaiuta" <win@wincent.com>
X-From: git-owner@vger.kernel.org Tue Sep 04 15:07:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ISY8F-0001hL-9s
	for gcvg-git@gmane.org; Tue, 04 Sep 2007 15:07:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753470AbXIDNHq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 4 Sep 2007 09:07:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753467AbXIDNHq
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Sep 2007 09:07:46 -0400
Received: from rv-out-0910.google.com ([209.85.198.190]:45683 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753311AbXIDNHp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 4 Sep 2007 09:07:45 -0400
Received: by rv-out-0910.google.com with SMTP id k20so1164906rvb
        for <git@vger.kernel.org>; Tue, 04 Sep 2007 06:07:45 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=QLSyLiVkSaP4zDxVm3g//biSnhf5NXh0WnK3c+P9O7DVKtxvl/wZ30fS7xnnIbqj8S0dkJwAJu39GRTkVZOGDQx/gdT9pNCUVvqeZiY+H4cySHDKbR41Af/6Rtt2ohL6ppd11fhGDDu5W9/CSKl0L5LicUB2Wn3AnQF0BapWcPw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=m6gIuZVEkPA4GiwA9/sBpqOPG1paZF060Ccb4Adwx3KSkeeM4lyWgowilvaUO0w+PPzI+1nNmHlP/2p4L0GYm5h4t+EqKMNrUMj+n/PhJEYm2OcppXfuNQ3StwMUv6RHX/Yl0YybVW95KBEIaDnu4H4oHwxINiGiRGmirZsfmCc=
Received: by 10.141.210.5 with SMTP id m5mr2285495rvq.1188911265177;
        Tue, 04 Sep 2007 06:07:45 -0700 (PDT)
Received: by 10.141.115.4 with HTTP; Tue, 4 Sep 2007 06:07:45 -0700 (PDT)
In-Reply-To: <052099D2-F79B-4063-82D3-BFB5D0102A55@wincent.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57563>

On 04/09/07, Wincent Colaiuta <win@wincent.com> wrote:
> On a brand new clone of git.git the file "gitweb/test/M=E4rchen" is
> provoking some weird behaviour running on Mac OS X and the toy HFS+
> filesystem. Note how the unmodified checkout of the file is shown as
> "untracked" by "git st", but on deleting the file it's shown as
> "deleted". If I build a copy of Git based on the clean working tree
> then the resulting build has a version number of "1.5.x-dirty".
>
> Any suggestions on where to start investigating the cause of this?
> About the only lead I have is that if I create a file with that name
> by typing it's name  it's encoded as "Ma\314\210rchen", but the file
> in the git.git repo is encoded as "M\303\244rchen".

It's because OS X is using composite Unicode encoding (storing "=E4" as
"a" + umlaut). Git doesn't canonicalise things, since OS X  does its
jiggery-pokery of that kind of stuff in CoreFramework, which I believe
Git doesn't use.


Dave.
