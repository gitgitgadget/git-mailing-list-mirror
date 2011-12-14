From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 1/7] revert: give --continue handling its own function
Date: Wed, 14 Dec 2011 18:46:43 +0530
Message-ID: <CALkWK0nQm9fCNgP5koo9YUp_jXTzrqZNnGpf81MAbT-K=qRhYQ@mail.gmail.com>
References: <CALkWK0=45OwcBoH2TorsgwTbaXjnffVuh0mGxh2+ShN9cuF-=A@mail.gmail.com>
 <20111120094650.GB2278@elie.hsd1.il.comcast.net> <20111122111207.GA7399@elie.hsd1.il.comcast.net>
 <20111122112001.GF7399@elie.hsd1.il.comcast.net> <7vr50zd5x0.fsf@alter.siamese.dyndns.org>
 <20111123012721.GA14217@elie.hsd1.il.comcast.net> <4ECCB3A2.5030102@viscovery.net>
 <20111123100452.GA30629@elie.hsd1.il.comcast.net> <4ECCC935.7010407@viscovery.net>
 <20111210124644.GA22035@elie.hsd1.il.comcast.net> <20111210124736.GB22035@elie.hsd1.il.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Christian Couder <chriscool@tuxfamily.org>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	Jay Soffian <jaysoffian@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 14 14:17:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Raohx-0001Qw-Jo
	for gcvg-git-2@lo.gmane.org; Wed, 14 Dec 2011 14:17:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757188Ab1LNNRI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 14 Dec 2011 08:17:08 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:45242 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757186Ab1LNNRF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 Dec 2011 08:17:05 -0500
Received: by faar15 with SMTP id r15so1130871faa.19
        for <git@vger.kernel.org>; Wed, 14 Dec 2011 05:17:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=jpgTS6A8LqqYGwwM6i7tUQwWU5qLyaeJUnOd2lCuyP4=;
        b=YYOmIRFTsbg2V9aPW8IzZ7519THNhA0Y4drinwAyDam1eAQe6oJP0BnY3H47Httnwq
         VIzO+Bv+t270+NvJDCBQntz/xYPtFIWXlO/gXv0POwV8K4ApX4CluFN/exhMCghYiDN3
         pj2EbLQmc5XG027KBr9ELGdeFxqxAMVv3oCDU=
Received: by 10.180.90.6 with SMTP id bs6mr4475389wib.63.1323868624423; Wed,
 14 Dec 2011 05:17:04 -0800 (PST)
Received: by 10.216.51.141 with HTTP; Wed, 14 Dec 2011 05:16:43 -0800 (PST)
In-Reply-To: <20111210124736.GB22035@elie.hsd1.il.comcast.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187110>

Hi Jonathan,

Jonathan Nieder wrote:
> This makes pick_revisions() a little shorter and easier to read
> straight through.

Ah, yes: you've asked about this earlier.  Sounds sane; let's read
ahead and see if anything jumps out.

> diff --git a/builtin/revert.c b/builtin/revert.c
> index 1ea525c1..9f6c85c1 100644
> --- a/builtin/revert.c
> +++ b/builtin/revert.c
> @@ -1038,6 +1038,21 @@ static int pick_commits(struct commit_list *to=
do_list, struct replay_opts *opts)
> [...]
> +static int sequencer_continue(struct replay_opts *opts)
> +{
> + =C2=A0 =C2=A0 =C2=A0 struct commit_list *todo_list =3D NULL;
> [...]

> =C2=A0static int pick_revisions(struct replay_opts *opts)
> =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct commit_list *todo_list =3D NULL;
> [...]

This is the only detailed that jumped out- you're filling up two
different commit_list structures, depending on whether we're
performing a fresh operation or continuing an existing one.  Okay.

Thanks.

p.s- Sorry about the delay; just returned from a short vacation.

-- Ram
