From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: Files different for me
Date: Wed, 25 Feb 2009 14:16:25 -0500
Message-ID: <76718490902251116l12e7d3c5jb42657cb0432ae40@mail.gmail.com>
References: <450196A1AAAE4B42A00A8B27A59278E709E047DE@EXCHANGE.trad.tradestation.com>
	 <alpine.LFD.2.00.0902250957260.3111@localhost.localdomain>
	 <7v4oyi2vvf.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	John Dlugosz <JDlugosz@tradestation.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 25 20:17:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LcPGU-0005FC-JW
	for gcvg-git-2@gmane.org; Wed, 25 Feb 2009 20:17:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756303AbZBYTQ2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 25 Feb 2009 14:16:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756149AbZBYTQ1
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Feb 2009 14:16:27 -0500
Received: from rv-out-0506.google.com ([209.85.198.231]:3341 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755816AbZBYTQ0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 25 Feb 2009 14:16:26 -0500
Received: by rv-out-0506.google.com with SMTP id g37so150015rvb.1
        for <git@vger.kernel.org>; Wed, 25 Feb 2009 11:16:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=CURjDrqgw6gKQCJBu7tnhSdlSD4e/7lKYxcoB6tMN6Q=;
        b=T/wBVYA0+RxGFWexH/n1qHDTLTKQ5VOmFLiGBMpJ1M9JH5LudyeVikU8s6+frqunvz
         NNdN0HATnh5XdBd2C6Daw1qX5y1cWXfvMOI+71c8bzi6U0OSA6cHQIxbktoE/4VDS6bf
         nSiky8+xFZP+bO1gGNlXkYWwCM3YxnL1mO9KY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=vULqBdxpF+oaqJ/dbtheqVIkrkSOuGu300NNVFKPnl1mGgCWqLeG8I1rB9KB+40Hco
         i+lUzF6JHANO7bGUg0XcshPC4CbROsww9feHh6JYyZore3QVXILoz0Mn/hdutY48Wn3x
         1rqiRkudHczQY8txVf05tQk01RC6sGEfHZzRE=
Received: by 10.141.101.12 with SMTP id d12mr171080rvm.240.1235589385163; Wed, 
	25 Feb 2009 11:16:25 -0800 (PST)
In-Reply-To: <7v4oyi2vvf.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111481>

On Wed, Feb 25, 2009 at 1:51 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> The handling of a case where a pull decides to go ahead (because it d=
oes
> not have to touch the Makefile you have your codename updates in) but=
 does
> not complete with real conflicts, is not as graceful as the other two
> cases (merge refusing to run at all without touching anything, or mer=
ge
> completes cleanly and makes a commit).
>
> You will be left with:
>
> =C2=A0- Paths that have local changes (index matches HEAD but work tr=
ee does
> =C2=A0 not match the index --- like your Makefile);
>
> =C2=A0- Paths cleanly merged (index and HEAD are different but work t=
ree
> =C2=A0 already matches the index);
>
> =C2=A0- Unmerged paths (index has higher stage entries with <<</=3D=3D=
=3D/>>> files
> =C2=A0 in the work tree);
>
> You, I and experienced users know what to do. =C2=A0Deal *only* with =
the last
> kind, mark them with "git add" after you are done with each of them, =
and
> make sure you do not say "-a" when committing the result, to exclude =
the
> first kind from the merge result.
>
> I've been wondering if we can make this safer for others.

Have pull detect this case and stash if so, with a message to the user
to pop the stash after they have committed the merge results? Or would
it make more sense to do it in merge? Maybe a pre-merge hook?

j.
