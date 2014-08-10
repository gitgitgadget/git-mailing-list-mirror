From: =?UTF-8?B?w5h5dmluZCBBLiBIb2xt?= <sunny@sunbase.org>
Subject: Re: Tackling Git Limitations with Singular Large Line-seperated
 Plaintext files
Date: Sun, 10 Aug 2014 23:45:34 +0200
Message-ID: <CAA787rkoX=aEf3cs5LpPmKKOfKeAUQZ+3KqckofRjOfCaNP-+g@mail.gmail.com>
References: <CAJoVafc1LMxmvCiWci3N+AuAZBsABR3Wb3c6c3stw93OJZ7Scw@mail.gmail.com>
	<CAJo=hJtJCy96SRYmOxEpEMoEVcaegv0SCG0_AH2u0=bSrHZi_A@mail.gmail.com>
	<xmqqegya2qgu.fsf@gitster.dls.corp.google.com>
	<CA+55aFx6vFyZvpyQot_3Ym7wsCZ06abjNx_hEKkza-N856jMnw@mail.gmail.com>
	<53B15E64.9030005@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <gitster@pobox.com>,
	Shawn Pearce <spearce@spearce.org>,
	Jarrad Hope <me@jarradhope.com>, git <git@vger.kernel.org>
To: =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 10 23:45:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XGavs-0005tx-7Y
	for gcvg-git-2@plane.gmane.org; Sun, 10 Aug 2014 23:45:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751810AbaHJVpg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 10 Aug 2014 17:45:36 -0400
Received: from mail-la0-f50.google.com ([209.85.215.50]:33896 "EHLO
	mail-la0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751798AbaHJVpf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 10 Aug 2014 17:45:35 -0400
Received: by mail-la0-f50.google.com with SMTP id gf5so6046899lab.23
        for <git@vger.kernel.org>; Sun, 10 Aug 2014 14:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=mKhwS1O0KbG5RLvpNWrJ34NmbH9k0h+Iiq4QseHrbyY=;
        b=NtPm/oWJzjvUprsoZGF5Qjj4RmcnzUGkIEidTToUqMAiFbepPcFA1/pXIEXqwfU/dd
         GN+fANK27OsiIyz/tPARW7Vtjz7hz4uIZN7HCDpIG6CH0zqqeL3/38AnYZBNBpDT2RBZ
         aftc1SByeJ3McJevbESumSywP2ItO2rRhoWwBFDd+o4M3brWRptzevUiVARhyR3H0708
         +D1JDoJ1WYp1iXfcXRKp6/v5r2/hbBXspWZajGdUOS6DaG6LuQnUXsV00uBr7CQFOQui
         PA3u6Jrh73t2FE6nisILpXABUd1cDL6Y4xXC0MsZi0zWBKtpTdhN1g5vnUvnIkR07lWx
         Om7w==
X-Received: by 10.152.203.197 with SMTP id ks5mr21557203lac.11.1407707134107;
 Sun, 10 Aug 2014 14:45:34 -0700 (PDT)
Received: by 10.112.162.1 with HTTP; Sun, 10 Aug 2014 14:45:34 -0700 (PDT)
In-Reply-To: <53B15E64.9030005@gmail.com>
X-Google-Sender-Auth: xz2wwL-UyxpGrTIDflkkg_Cclcw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255111>

On 30 June 2014 14:56, Jakub Nar=C4=99bski <jnareb@gmail.com> wrote:
> Linus Torvalds wrote:
> > .. even there, there's another issue. With enough memory, the diff
> > itself should be fairly reasonable to do, but we do not have any
> > sane *format* for diffing those kinds of things.
> >
> > The regular textual diff is line-based, and is not amenable to
> > comparing two long lines. You'll just get a diff that says "the two
> > really long lines are different".
> >
> > The binary diff option should work, but it is a horrible output
> > format, and not very helpful. It contains all the relevant data
> > ("copy this chunk from here to here"), but it's then shown in a
> > binary encoding that isn't really all that useful if you want to sa=
y
> > "what are the differences between these two chromosomes".
>
> There is also --word-diff[=3D<mode>] word-based textual diff, and I
> think one can abuse --word-diff-regex=3D<regex> for character-based
> diff... or maybe not, as <regex> specifies word characters, not words
> or word separators.

Yes, I have this alias defined:

  dww =3D diff --word-diff --word-diff-regex=3D.

It creates nice diffs on a character level. Sometimes specifying
--patience to this helps.

-- =C3=98yvind
