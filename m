From: Igor Lautar <igor.lautar@gmail.com>
Subject: Re: commit gone after merge - how to debug?
Date: Mon, 26 Nov 2012 14:58:38 +0100
Message-ID: <CAO1Khk8=nrKknfqY-k6XaGPDbLrHyrK-8fxfB7XXUWeB7L4EUA@mail.gmail.com>
References: <CAO1Khk_eugH--wp3s-gr4HTvuRyL=SaWHWtEXCRZ_Ak7+s5U=w@mail.gmail.com>
	<1353935441-ner-9639@calvin>
	<vpqr4ngsdjl.fsf@grenoble-inp.fr>
	<CAO1Khk9mzJjnysnc1iDFeMgqnRq0z35t0kgC-8nrsjJ-oOvdOg@mail.gmail.com>
	<vpqehjgscv3.fsf@grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Tomas Carnecky <tomas.carnecky@gmail.com>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Nov 26 14:58:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TczD6-0007Y9-0I
	for gcvg-git-2@plane.gmane.org; Mon, 26 Nov 2012 14:58:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754707Ab2KZN6j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Nov 2012 08:58:39 -0500
Received: from mail-vb0-f46.google.com ([209.85.212.46]:59694 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754100Ab2KZN6i (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Nov 2012 08:58:38 -0500
Received: by mail-vb0-f46.google.com with SMTP id ff1so5617142vbb.19
        for <git@vger.kernel.org>; Mon, 26 Nov 2012 05:58:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=hkx1NiCP1xS+bCnJdfKueC1kmXhfwNBLVnM1XIzp0J4=;
        b=e7j/3Jno++y7vHnSDAeeUpiSGamVg/wQmp6p89JzCPbc0XRlL4wL9CoA6iZeFyMsu7
         y3H6sG+AILMRkXbWffLut+/ZOiXYwzMbvxUwYk3KFlfPMjsKFI6oTKloORXVWIvZYzxB
         FaPBywcIT29dsZybbAwA+cmyG+uU3v79sMtfOZShjUD1fVe4XF1UYljaUDNhu9zmftDt
         dtjHa6GuAWALhZ4OBEsCqYbZWnVqbEK5QumOB0Yu15WPalJHcy0kdfKUYm3Pon/joX3S
         G4D1B7NJ5sqspUuoPknK1LdjF8gThWTkwh3rnmqPbU2CoAWRs2p9h9pnCnviDyDb3vNI
         nbdQ==
Received: by 10.52.175.225 with SMTP id cd1mr16598288vdc.130.1353938318198;
 Mon, 26 Nov 2012 05:58:38 -0800 (PST)
Received: by 10.58.69.112 with HTTP; Mon, 26 Nov 2012 05:58:38 -0800 (PST)
In-Reply-To: <vpqehjgscv3.fsf@grenoble-inp.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210447>

On Mon, Nov 26, 2012 at 2:38 PM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Igor Lautar <igor.lautar@gmail.com> writes:
>> Somewhat, but it does not explain why the file no longer has that
>> change.
>
> It still has, but it's not shown by "git log <file>", probably because
> one of the parent of the merge commit introduces no change for this
> file, so one side of the merge is not needed to explain you how you went
> from the origin of time to the last commit.

No, the change is not there. See below.

> Try this:
>
> commit=<sha1 of your merge commit>
> # Show diff with first parent:
> git diff "$commit" "$commit"^1
> # Show diff with second parent:
> git diff "$commit" "$commit"^2

Yes, change is shown in commit^2, but actual file after merge does not have it.

I've double and triple checked, it is just not there. In the end, I've
cherry-picked the same commit after the merge and change is applied.
If change would be there after the merge, cherry-pick would not have
anything to do (whole commit is a one line change in single file).

So its not that the history is hidden, the change *is* missing after the merge.

Is there anything else I can try to figure out why its missing (other
than actually debugging git code/scripts)? Like debug output for each
change being considered/merged in?

Regards,
Igor
