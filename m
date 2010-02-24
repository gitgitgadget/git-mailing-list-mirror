From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCH] is_submodule_modified(): clear environment properly
Date: Wed, 24 Feb 2010 07:43:28 +0100
Message-ID: <cb7bb73a1002232243w2f5f63bcw45662bb80cb9e52@mail.gmail.com>
References: <4B844D07.8070406@web.de> <cb7bb73a1002231413n3a38e344hce8188671763c17b@mail.gmail.com> 
	<7veikbjokw.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 24 07:43:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NkAyR-0007Hd-2V
	for gcvg-git-2@lo.gmane.org; Wed, 24 Feb 2010 07:43:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755253Ab0BXGnu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Feb 2010 01:43:50 -0500
Received: from mail-ew0-f212.google.com ([209.85.219.212]:34971 "EHLO
	mail-ew0-f212.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755097Ab0BXGnt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Feb 2010 01:43:49 -0500
Received: by ewy4 with SMTP id 4so679706ewy.28
        for <git@vger.kernel.org>; Tue, 23 Feb 2010 22:43:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=Oy7Kg/CYuvLrRimPaLoygypG1mlaP73hmaXxhhEnMWU=;
        b=ia9UR2m979ISLWZZfiktx9vLxy5xuL2+Tqulv9ayE/yqBGRfjnEnuuX5z6zGXU7eBr
         TxxWpfclQe8egPCe2Vexxk1Bd/pOLaoXQUTjKlJ1hMXkjMzyDYvPnLHL7BnMhFpUJKS0
         Psvq6zuCPw2oFHRw9tQNVrWXXNqsSc4y37dGk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=U7HwfP8ZkB8zsu8/DplRtCQZIJeXYdMF45MENMHj9FGLi3SFcKzS7F/lDGH4mfKtDK
         XWViaRlNNfApn72lXqg+Eg1DlVwIuYMVjPWlursfkAtQrS7EUoeBZkwfcg4KWMPVPTKw
         4Mon/4wia/LCikeVeRz+krYIjpoimjdDoPQiQ=
Received: by 10.213.100.160 with SMTP id y32mr110843ebn.49.1266993828128; Tue, 
	23 Feb 2010 22:43:48 -0800 (PST)
In-Reply-To: <7veikbjokw.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140905>

On Wed, Feb 24, 2010 at 4:32 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Giuseppe Bilotta <giuseppe.bilotta@gmail.com> writes:
>
>> On Tue, Feb 23, 2010 at 10:47 PM, Jens Lehmann <Jens.Lehmann@web.de> wrote:
>>> Only GIT_INDEX_FILE was cleared until now, but other environment variables
>>> have to be cleared too before running git status in a submodule.
>>>
>> Of course this third use-case has a difference in that GIT_DIR is
>> actually set to something else and not just cleared, but this
>> particular case could just deep-copy the array modifying the
>> appropriate entry.
>
> Something like this, I guess.
>
> It is a bit frustrating that local_repo_env[] is a NULL terminated array
> and we cannot use ARRAY_SIZE(local_repo_env) as a compile-time constant.

I have a very simple solution for this, coming in the next revision of
my patchset, together with the environment.c move

-- 
Giuseppe "Oblomov" Bilotta
