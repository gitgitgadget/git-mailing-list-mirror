From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: git cherry to find equivalent commit IDs?
Date: Thu, 13 Aug 2009 21:37:18 +0000
Message-ID: <32541b130908131437g7cb14a1eh6cd2e31a57f105d5@mail.gmail.com>
References: <2729632a0908131413w1a2efca8t31ac8cc43e1d6888@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: skillzero@gmail.com
X-From: git-owner@vger.kernel.org Thu Aug 13 23:37:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MbhzX-0004Kq-VQ
	for gcvg-git-2@gmane.org; Thu, 13 Aug 2009 23:37:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754561AbZHMVhj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 13 Aug 2009 17:37:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753365AbZHMVhi
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Aug 2009 17:37:38 -0400
Received: from mail-yw0-f193.google.com ([209.85.211.193]:49642 "EHLO
	mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752444AbZHMVhi convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 13 Aug 2009 17:37:38 -0400
Received: by ywh31 with SMTP id 31so1424936ywh.4
        for <git@vger.kernel.org>; Thu, 13 Aug 2009 14:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=8RiKHytpVjqbNgHAjRDtTsv0q59nyzIJQ7lPRd7irpU=;
        b=ZhljrbX6zzHhvriZ4isPTVEWbbBdZoUT84Eu/UK36CFPF9vkc6N87Rjl++TejJdJ0n
         tX5umlmK1RsyZ9Qhqj9MXH7NfelSghYMaYra+rZVlgKm8XUBDkeaN4U6hUtDJqjiFSAT
         JiGGLCWCdlKa4xck8D1PBMiGbiES1d3Qt6HIY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=BUtskx2V0SR+/hQrDyaXXMYb18wVnvmcOvqcw55JYUjYoWkZEdm0OL9gksW0cKYjYS
         mDt/xRslek/XSTCNlpuIPlOT4rjP+McJ3D/Agw387GvVRnOlHaRTvGAlbKTwUgCIWU22
         HDsFopj2xmNsbnybSDkEHR7PJKZbgz9x9fefI=
Received: by 10.150.113.18 with SMTP id l18mr1821882ybc.155.1250199458141; 
	Thu, 13 Aug 2009 14:37:38 -0700 (PDT)
In-Reply-To: <2729632a0908131413w1a2efca8t31ac8cc43e1d6888@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125879>

On Thu, Aug 13, 2009 at 9:13 PM, <skillzero@gmail.com> wrote:
> For example, commit 3642151 on branch A was a cherry pick of a commit
> 460050c on master:
>
> $ git branch -a --contains 3642151
> =A0A
>
> $ git branch -a --contains 460050c
> * master
>
> $ git cherry -v master 3642151
> - 3642151435ce5737debc1213de46dd556475bfad1 fixed bug
>
> I assume that means an equivalent change to 3642151 is already in
> master (which it is, as commit 460050c). But I want to find out the
> commit ID on master that's equivalent to 3642151 (i.e. something that
> tells me it's 460050c).

git show 3642151 | git patch-id

You should get a line with two hashes; the first is the patchid (call
it PATCHID_FROM_ABOVE)

git log -p | git patch-id | grep PATCHID_FROM_ABOVE

This should give you a list of all commits that correspond to that patc=
hid.

Note that if there were conflicts when applying the patch, the patchid
probably changed.

Have fun,

Avery
