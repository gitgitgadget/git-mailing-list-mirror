From: Robert Dailey <rcdailey.lists@gmail.com>
Subject: Re: 'eol' documentation confusion
Date: Sun, 21 Jun 2015 09:16:03 -0500
Message-ID: <CAHd499Do_bpdOkL2TqdO+8L=pR53117pKR0GSwdgvFDwq_S4=w@mail.gmail.com>
References: <CAHd499CapqvC3pHszgmX2VexdmqiW4+N23YfkAP5jjXWDrbe0A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jun 21 16:16:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z6g2d-0003Rs-0A
	for gcvg-git-2@plane.gmane.org; Sun, 21 Jun 2015 16:16:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753400AbbFUOQH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Jun 2015 10:16:07 -0400
Received: from mail-ig0-f174.google.com ([209.85.213.174]:33851 "EHLO
	mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755729AbbFUOQE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Jun 2015 10:16:04 -0400
Received: by igboe5 with SMTP id oe5so46410379igb.1
        for <git@vger.kernel.org>; Sun, 21 Jun 2015 07:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:content-type;
        bh=fAkY1TVRxv7HGHbyJFmL16oE6Ohv5eggE/KSXyBicBU=;
        b=Wpf1VMFR8nUc2FNc6T/jbP8Qu/SbtgfNFD9loAE/aLZqFXefgFj5OkES4onw6jIKus
         iEnItB0jaqjdF4+fbJ9acX9m4pmpJQ0gEQykmhQAZBOg25/PC2IzzTLybsqSD+1isJ13
         B6fBBlHpU0WFPKye+wqwdW4gGh/VdnPr3XSDX22XB1gi2UltnPPyN9sS+gWFAvtNWToT
         SJKsweHZO7zWxLyUmesTgm3f/0emcSEWAnZNtXfIhZZ0d4RjBAfOWuWNtrFJOOLEqW5X
         +jeb+3kJ+lYE6AzItAJ16PENf9JWnZcjX5FALz6R+y+0QOEMIgAkemJXa3t4ro5F/4Yi
         0iJg==
X-Received: by 10.107.8.32 with SMTP id 32mr8114174ioi.15.1434896163626; Sun,
 21 Jun 2015 07:16:03 -0700 (PDT)
X-Google-Sender-Delegation: rcdailey@gmail.com
Received: by 10.36.86.148 with HTTP; Sun, 21 Jun 2015 07:16:03 -0700 (PDT)
In-Reply-To: <CAHd499CapqvC3pHszgmX2VexdmqiW4+N23YfkAP5jjXWDrbe0A@mail.gmail.com>
X-Google-Sender-Auth: JBAsSuOZTkYAVoBohU2L6DYAqbM
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272268>

On Sun, Jun 21, 2015 at 9:04 AM, Robert Dailey <rcdailey.lists@gmail.com> wrote:
> Upon inspection of the gitattributes documentation page here:
> https://git-scm.com/docs/gitattributes
>
> When comparing the documentation for 'text' with 'eol', I see the
> following missing explanations for 'eol':
>
> * eol
> * -eol
>
> Maybe the fact that these are missing means they are not valid to use.
> There is also the issue that `text` usually controls EOL anyway. Is
> there ever any reason to set eol in a way differently than explained
> in the documentation (that is, `eol=lf` or `eol=crlf`)?
>
> For example, what if you want a file to be treated as text BUT you do
> not want it to perform EOL normalization at all. Could you do this?
>
>     foo.txt text -eol
>
> Just at first glance, this to me would mean line endings on checkin
> and checkout are not touched (CRLF could be checked in). Is this
> possible?
>
> What about setting `eol` but not `text`?
>
> Honestly it seems like `eol` is just a supplementary setting for
> `text` and was never intended to be used in ways that are
> undocumented. Some explanation to help uncloud this would help, or
> maybe I missed something in the documentation that explains this.

I did a few tests out of curiosity:

    * eol

This allowed CRLF to be committed in a file named `foo.txt` (I saw ^M
in the diff, which I think means CR character, and treats this
character as an error)

    * text=auto eol

This did not differ in behavior from `* text=auto` from what I could
see. It removed CR characters in the repository on check in.

    * text=auto -eol

Same as before, the addition of `-eol` did not change the behavior at all.

So yeah, I'm still horribly confused. None of these scenarios make any
sense. The only time I ever set `eol` explicitly is to either do
`eol=lf` or `eol=crlf`.
