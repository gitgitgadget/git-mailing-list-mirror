From: Thomas Berg <merlin66b@gmail.com>
Subject: Re: [BUG?] Fresh clone of jquery.git shows modifications?
Date: Wed, 18 Aug 2010 17:50:17 +0200
Message-ID: <AANLkTik8RGR4OTeZYsttyBtiywGU7Wtz3gQsTjoqAQPD@mail.gmail.com>
References: <1282135226.24584.92.camel@wpalmer.simply-domain>
	<2F030CF4-995A-4BA2-9D79-DA2A71F9FF79@gmail.com>
	<1282140854.24584.112.camel@wpalmer.simply-domain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>,
	git@vger.kernel.org
To: Will Palmer <wmpalmer@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 18 17:50:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OlkuW-0005QQ-C7
	for gcvg-git-2@lo.gmane.org; Wed, 18 Aug 2010 17:50:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753742Ab0HRPuX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Aug 2010 11:50:23 -0400
Received: from mail-qy0-f174.google.com ([209.85.216.174]:49071 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753710Ab0HRPuT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Aug 2010 11:50:19 -0400
Received: by qyk9 with SMTP id 9so1159273qyk.19
        for <git@vger.kernel.org>; Wed, 18 Aug 2010 08:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=GPJwKLTVWDIyEvzw5e8KkWlyqBt4mIFCeJTygKMxne0=;
        b=VZV2Ar83nhVhpUZ1mESwqnUTWFmi1kaitgSwbmSxw7DxycniCZzyAX5Fys387BhLKY
         ygvYBN5wdzyXdymMW6IRbj/ODR3dG2sxadioo+LK65gvsoUj1EGZWTgfRFEYvEh++6Rm
         vI78ipCFwe9Es0t6cJvt2s9/DT08xEdAkmHBw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=eMRR5yTxyixW7KIdbN7LFWSkXt9/MJ+dE1jmeSHZuWBaNZg5qy/3HBLrRiQI0EVuHk
         X3rXAXWRE0CKjcT+v9cDyLMtuSO8oIHNVEJ9iW2ix1eUY7njeOqqcXs+RoSBDWzxMEc7
         4EjTcPZzB7Mpsk8xUErd2s3zaCCZtRlq8/bmU=
Received: by 10.229.233.195 with SMTP id jz3mr6214190qcb.207.1282146617470;
 Wed, 18 Aug 2010 08:50:17 -0700 (PDT)
Received: by 10.229.16.209 with HTTP; Wed, 18 Aug 2010 08:50:17 -0700 (PDT)
In-Reply-To: <1282140854.24584.112.camel@wpalmer.simply-domain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153862>

Hi,

On Wed, 2010-08-18 at 15:18 +0200, Eyvind Bernhardsen wrote:
> Git _is_ giving you a real pristine copy, it's just informing you that your repository is not consistent with the attributes you have set.

Marking the files as modified is sometimes a very user-unfriendly way
of informing the user, at least if just want to work with something
unrelated, and not actually fix those issues. Maybe there is a better
way?

On Wed, Aug 18, 2010 at 4:14 PM, Will Palmer <wmpalmer@gmail.com> wrote:
> "pristine" to me means "no changes". If there is an inconsistency which
> git doesn't like, git should complain about that, refuse to checkout,
> declare "broken repository! Oh no!" and refuse all operations, etc. It
> git can determine that it is unable to act in a sane manner, I don't
> want git to just go ahead making wild guesses.
>
[snip]
> Just to re-state: This is not "my repository". That is, I don't consider
> it to be. So I would prefer only solutions which involve editing
> something unversioned, such as .git/config, rather than making random
> patches which feel very much like work-arounds to a git problem.

Such a solution exists, you can create a file .git/info/attributes,
which will override the faulty .gitattributes file in the repository
[1]. Then you could make git treat all files as binary files, making
no conversions. Using this unversioned file also enables you to jump
back in history, rebase etc. without problems.

Hope this helps,
Thomas

[1] http://www.kernel.org/pub/software/scm/git/docs/gitattributes.html
