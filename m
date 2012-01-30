From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] completion: add new zsh completion
Date: Mon, 30 Jan 2012 13:28:19 +0200
Message-ID: <CAMP44s2MmqEeyvztk8_3q9Ms_-su0D12GYD_LLWCKPAmb2ZKXg@mail.gmail.com>
References: <1327881699-25461-1-git-send-email-felipe.contreras@gmail.com>
	<vpqwr89d1p7.fsf@bauges.imag.fr>
	<CAMP44s3QeZuXrR=UE4qvDadu66Cmi-txmSps8Ow24om27URxOg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Jan 30 12:28:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RrpPO-0000dD-L0
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jan 2012 12:28:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752309Ab2A3L2V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jan 2012 06:28:21 -0500
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:58057 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752248Ab2A3L2V (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 Jan 2012 06:28:21 -0500
Received: by lagu2 with SMTP id u2so2122539lag.19
        for <git@vger.kernel.org>; Mon, 30 Jan 2012 03:28:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=4mEb9flNpkpR5O1p/mXl9jAeNUY14PJB2OLhiIP2qPQ=;
        b=UoGcjq6KkyJbA1vhtm27bHrNEhnH3TSd5vBexZSh5h8VrBEqvlfJUB7Xdvo9YWB8nz
         48BwxSJqJyNCKAg9oehuUVWfi2DKQ45lLPPF2pIihJwde0IoIdDdV9o+lWY9daUgVqa/
         sWPGFpy/FDjNO9Cr5LnFDx2uv0paftq2pLiZM=
Received: by 10.152.131.40 with SMTP id oj8mr8973362lab.24.1327922899711; Mon,
 30 Jan 2012 03:28:19 -0800 (PST)
Received: by 10.112.40.202 with HTTP; Mon, 30 Jan 2012 03:28:19 -0800 (PST)
In-Reply-To: <CAMP44s3QeZuXrR=UE4qvDadu66Cmi-txmSps8Ow24om27URxOg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189345>

On Mon, Jan 30, 2012 at 12:59 PM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> On Mon, Jan 30, 2012 at 10:39 AM, Matthieu Moy
> <Matthieu.Moy@grenoble-inp.fr> wrote:
>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>>
>>> +ZSH_VERSION='' . /usr/share/git/completion/git-completion.bash
>>
>> Probably stating the obvious, but this path shouldn't be hardcoded.
>>
>> Something along the lines of
>>
>> ZSH_VERSION='' . $(dirname ${funcsourcetrace[1]%:*})/git-completion.bash
>>
>> should do it (mostly untested, and written by a non-ZSH expert).
>
> Yes, it's hard-coded, because there's no way to know where is this
> file. In my case, it's on ~/.git-completion.sh, and this one that I am
> proposing sits in ~/.zsh/completion/_zsh, so your proposal breaks
> things completely for me.
>
> I will think about it, but I think for now, users of this script
> should set that manually--if for some reason they don't want to use
> the default.
>
> Maybe we should use zstyle so they can configure it on their .zshrc?

This seems to do the trick:

zstyle -s ":completion:$curcontext:" script script
test -z "$script" && script="$(dirname
${funcsourcetrace[1]%:*})"/git-completion.bash
ZSH_VERSION='' . "$script"

.zshrc:
zstyle ':completion:*:*:git:*' script ~/.git-completion.sh

-- 
Felipe Contreras
