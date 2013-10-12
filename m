From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v3 1/5] pull: rename pull.rename to pull.mode
Date: Fri, 11 Oct 2013 20:15:46 -0500
Message-ID: <CAMP44s2y0UZ9uS8xtG2WDD=k5pHSG+K+_WM2dj-DVaUDy4djdA@mail.gmail.com>
References: <1378689796-19305-1-git-send-email-felipe.contreras@gmail.com>
	<1378689796-19305-2-git-send-email-felipe.contreras@gmail.com>
	<522E3C6A.3070409@bbn.com>
	<CAMP44s1OyST3S1HEdS38WPsjq6w9SekuwT4DRUgVvduATox9tw@mail.gmail.com>
	<20130910022152.GA17154@sigill.intra.peff.net>
	<CAMP44s1FfQ-1pAK8T1cmiZk4i17HnpvzPwuZrzHiiXSmGzbrRw@mail.gmail.com>
	<vpqmwnljdmn.fsf@anie.imag.fr>
	<52589027a4851_5dc4c2be742754f@nysa.mail>
	<20131012005035.GA27939@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Richard Hansen <rhansen@bbn.com>, git@vger.kernel.org,
	Andreas Krey <a.krey@gmx.de>,
	John Keeping <john@keeping.me.uk>,
	Philip Oakley <philipoakley@iee.org>,
	"brian m. carlson" <sandals@crustytoothpaste.net>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Oct 12 03:15:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VUno8-0006Uz-Jh
	for gcvg-git-2@plane.gmane.org; Sat, 12 Oct 2013 03:15:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754186Ab3JLBPs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Oct 2013 21:15:48 -0400
Received: from mail-la0-f49.google.com ([209.85.215.49]:53674 "EHLO
	mail-la0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751742Ab3JLBPs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Oct 2013 21:15:48 -0400
Received: by mail-la0-f49.google.com with SMTP id ev20so3971940lab.22
        for <git@vger.kernel.org>; Fri, 11 Oct 2013 18:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=g3AJOgyiuaTx6M4LlaVxHAo9lyli+PRTJTIn6B8lbAc=;
        b=gDN+L/qxwZQjcZbXKf0nJn4Ow0c1P/adK5WDrvHZWGZYPeWTS00II85HEoDRTzsh/4
         7YBh1wkWNcPDkBAmNOjyDtHVxhqhY0rMtNtG1UKy2n9sqkn4JIojZXsUCEQ71Z5XUYys
         jJ1CH99B5XsN/m2QVf9IQfVA4kR0fuNFOj4/PmPYMjtVjKGrX13Jj4D44DxgcMsGRhJn
         niz/CErBHN2DlCno2mupzwO+ApXQ4zo3f1QA0HG3PZjUwMOPFM61DQ52KXqmvV43KABY
         DYaBIW1EDTvhsJFVnhzhCVw51X1zdKaPy6qOoOMVMuHSWNMoCJfQ9HJ9hVVL8PpTEfze
         uDag==
X-Received: by 10.112.0.242 with SMTP id 18mr18703612lbh.18.1381540546256;
 Fri, 11 Oct 2013 18:15:46 -0700 (PDT)
Received: by 10.114.91.230 with HTTP; Fri, 11 Oct 2013 18:15:46 -0700 (PDT)
In-Reply-To: <20131012005035.GA27939@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235935>

On Fri, Oct 11, 2013 at 7:50 PM, Jeff King <peff@peff.net> wrote:
> On Fri, Oct 11, 2013 at 06:56:23PM -0500, Felipe Contreras wrote:
>
>> > >>> > These deprecation warning messages should be written to stderr, and
>> > >>> > should probably be prefixed with "WARNING: ".
>> > >>>
>> > >>> Is there any deprecation warning that works this way?
>> > >>
>> > >> The ones in C code typically use warning(), which will prefix with
>> > >> "warning:" and write to stderr. They do not use all-caps, though.
>> > >>
>> > >> Try "git log --grep=deprecate -Swarning" for some examples.
>> > >
>> > > I'm asking about the ones in shell, because this is a shell script.
>> >
>> > No user cares whether "git pull" is written in shell. shell Vs C is an
>> > implementation detail, stdout Vs stderr is user-visible.
>>
>> You are free to go ahead and implement 'warning ()' in git-sh-setup.sh, in the
>> meantime no shell script does that, and that's no reason to reject this patch
>> series.
>
> You are completely missing Matthieu's point that we attempt to be
> consistent in the format of messages, as well as where they are output,
> and from a user's perspective it does not matter what language the tool
> is implemented in.

If we truly did that, there should be a warning () function, like in C.

> Also, you are wrong that there are no other shell scripts that behave as
> Richard said:
>
>   $ git grep '>&2' | grep -i deprecate
>   contrib/completion/git-completion.bash: echo "WARNING: this script is deprecated, please see git-completion.zsh" 1>&2
>   contrib/examples/git-resolve.sh:echo 'WARNING: This command is DEPRECATED and will be removed very soon.' >&2
>   git-lost-found.sh:echo "WARNING: '$0' is deprecated in favor of 'git fsck --lost-found'" >&2
>
> Please, can we just squash in the patch below and stop talking about
> this?
>
> diff --git a/git-pull.sh b/git-pull.sh
> index a9cf7ac..9c4091c 100755
> --- a/git-pull.sh
> +++ b/git-pull.sh
> @@ -58,8 +58,8 @@ then
>         if test "$rebase" = 'true'
>         then
>                 mode="rebase"
> -               echo "The configurations pull.rebase and branch.<name>.rebase are deprecated."
> -               echo "Please use pull.mode and branch.<name>.pullmode instead."
> +               echo >&2 "warning: The configurations pull.rebase and branch.<name>.rebase are deprecated."
> +               echo >&2 "Please use pull.mode and branch.<name>.pullmode instead."
>         fi
>  fi
>  test -z "$mode" && mode=merge

Are you sure you want me to squash that in? Because the warnings
wouldn't be consistent. Some would be "WARNING: " and others would be
"warning: ". Personally I don't care, but if your argument is
consistency, you should. If we had a warning () function, we could
truly be consistent.

-- 
Felipe Contreras
