From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [PATCH v2] send-email: add --confirm option
Date: Sun, 1 Mar 2009 12:49:47 -0500
Message-ID: <76718490903010949h7b64eb97ob567101fbc7e4cd1@mail.gmail.com>
References: <7vhc2d8vjk.fsf@gitster.siamese.dyndns.org>
	 <1235924234-16923-1-git-send-email-jaysoffian@gmail.com>
	 <7d1d9c250903010909h7d92f165oc703a05e819671a4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Nanako Shiraishi <nanako3@lavabit.com>,
	Junio C Hamano <gitster@pobox.com>
To: Paul Gortmaker <paul.gortmaker@windriver.com>
X-From: git-owner@vger.kernel.org Sun Mar 01 18:51:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ldpov-0002Vc-Gp
	for gcvg-git-2@gmane.org; Sun, 01 Mar 2009 18:51:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756538AbZCARtu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 1 Mar 2009 12:49:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756400AbZCARtu
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Mar 2009 12:49:50 -0500
Received: from rv-out-0506.google.com ([209.85.198.229]:34289 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756442AbZCARtt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 1 Mar 2009 12:49:49 -0500
Received: by rv-out-0506.google.com with SMTP id g37so1919704rvb.1
        for <git@vger.kernel.org>; Sun, 01 Mar 2009 09:49:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=JLrSUmqY630mqnMaznEOeqLOTenqxR96CSDlMG/cHzs=;
        b=NZKkgawBoK8qMchzVXMQyUzVzHxq72DsEQSSoj9r+JCYhZcs4k/GafuRh3M2OL+eXA
         4tDiZ3gmjOEJmtINj12iGCXgVIbozNLOQ5z9HFI7rWLi3CQSzbKZHPcEIa7qekUl9sQE
         8MtVo9V0LmoShcwJnXsoDGAfs2WBhCLSkm0jM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=WvWh2MAB+wChaY9tBRVtApqOoEEp1R4D/QbOOVRgkYdduivvbTx/maDhHE5UfLKjJu
         cltLOn17CqCTcWcVyN6XhsfEwyBNeDZWCEP/x+Id2ZtI/D/pV3x49uKp98ffb95GhYvP
         UKfQxaNQj1UIgHkQpWJVKBEiOZXgXVV6bt4HI=
Received: by 10.141.122.1 with SMTP id z1mr2448958rvm.275.1235929787766; Sun, 
	01 Mar 2009 09:49:47 -0800 (PST)
In-Reply-To: <7d1d9c250903010909h7d92f165oc703a05e819671a4@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111863>

On Sun, Mar 1, 2009 at 12:09 PM, Paul Gortmaker
<paul.gortmaker@windriver.com> wrote:
>
> On Sun, Mar 1, 2009 at 11:17 AM, Jay Soffian <jaysoffian@gmail.com> w=
rote:
>> =C2=A0* Allowing the user to "git config sendemail.config never"
>
> I think it should be sendemail.confirm in the above.

Yep, thanks. Junio, please amend my commit message if v2 is acceptable =
as is.

> Thanks for
> taking this seriously -- I think lots of new git users (who probably
> will never make it to this list) will benefit from it without ever
> even knowing.

Well it's all for naught unless Junio can be convinced that it's an
acceptable trade-off. On this point I want to elaborate a little more,
so pardon me while I step up on the soap box.

Once upon a time, all git commands were git-something and they were
installed in PATH. A smattering of users complained about this.
Eventually git learned "git something" in addition to "git-something".
Then some folks decided why not just get rid of "git-something"
entirely. And so it was done. And many other users who were happy with
the way it was complained.

And rightly so. The change was made w/no escape hatch for those users.
And to plumbing no less. The users who wanted "git-something" out of
PATH (which wasn't really hurting anything) got what they wanted, but
nothing was done to accommodate the existing users. Eventually a
compromise was reached. The git-something commands moved out of PATH,
but were still installed, and existing users could relatively easily ge=
t
to them by adding "git --exec-path" to their PATH.

(Please correct me if my summary is wrong, but that's how I recall it.)

If the compromise is how it was done in the first place, perhaps Junio
would not be as hyper-sensitive to any change which affects existing
users expectations.

But this patch is not like the git-something situation. This patch
benefits new (all?) users, while bending over backwards to accommodate
existing users. And it is a porcelain change.

I sympathize with Junio's aversion to accepting patches which affect
existing users expectations. But I also think there are times when the
greater good is served by such patches, and it would be nice to have
some guidelines for how and when such patches can be made. For example:

- No non-backwards compatible changes to plumbing.
- Non-backwards compatible changes to porcelain IFF:
  - The change provides a notable (non-trivial) benefit to new users.
    Some litmus tests for such a change might be:
    - "in hindsight, this is how it clearly should've been done."
    - "this is really confusing for new users; existing users users hav=
e
      forgotten how confusing it was when they first encountered it."
    - "the default behavior is potentially dangerous/embarrassing."
  - Existing users can easily get the prior behavior. i.e. via a config
    setting
  - The change, where possible, maintains previous expectations if it
    appears the command is being used by an experienced user.

(In fairness, there appears to be a framework for non-backwards
compatible changes; you introduce a warning about the change in the nex=
t
minor release that the behavior of X will change and inform the user ho=
w
they can keep the existing behavior of X; wait one patch release, then
make the actual change. But my reading of Junio's message is that he
doesn't think _this_ patch is even worthy of that step until I can
demonstrate that there is not a silent-majority who really likes the
existing behavior of send-email. But as I said, this is not my itch, an=
d
while I'm happy to offer up this patch, that's as far as I go.)

Stepping off soapbox.

j.
