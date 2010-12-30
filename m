From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH] unpack_trees(): skip trees that are the same in all input
Date: Thu, 30 Dec 2010 19:44:08 +0700
Message-ID: <AANLkTinWj7vjQcJVZ732HDj++F8PjUHhne8unoORsVB9@mail.gmail.com>
References: <7vr5d94fs4.fsf@alter.siamese.dyndns.org> <AANLkTinm=k_84Nh4YakbkdNNLO4-yeVxGF+p_rR5TFB=@mail.gmail.com>
 <7vd3oktmoo.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 30 13:44:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PYHsE-0003SQ-NV
	for gcvg-git-2@lo.gmane.org; Thu, 30 Dec 2010 13:44:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751890Ab0L3Mou convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 30 Dec 2010 07:44:50 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:53025 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750761Ab0L3Mot convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 30 Dec 2010 07:44:49 -0500
Received: by wyb28 with SMTP id 28so10932387wyb.19
        for <git@vger.kernel.org>; Thu, 30 Dec 2010 04:44:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=k5TZkRQY5t0ESjob/G2gjLM1mqanlJXdTZ+x7E8fYV8=;
        b=YM15jihabEnFc7Kr6U9nf3R/OfU9KeMZqJqG2wgf0uVdV8s+5gdJxvGwerJ/g1iwo2
         TLiFG9DaMOSKlSGAsmTogfGzQTBSQ8T0cCHzGwOVgT8qQCXQsoIR7AuxzZ64Lj1mvHFN
         0yhqXkry8u6eSQJWR59NQ/0m9wkgHc5s3f4x0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=lXG6l5+bcDZsSeM+nruX4XcIdUkeOb+cfE6zUNGt4mZbY1fqXEMQEh/LvbQ472vFlm
         NV9r2Pw2Uh2FiXn0ZtoetxoGm7kktbLdYAaZrquWPyvoynMF7fmWExrGjkDPLT9Nkie2
         3hD24TDC+Dv9IfrHNSk2HtKLSnj8gB/pBnCyY=
Received: by 10.216.59.143 with SMTP id s15mr99999wec.49.1293713088388; Thu,
 30 Dec 2010 04:44:48 -0800 (PST)
Received: by 10.216.63.14 with HTTP; Thu, 30 Dec 2010 04:44:08 -0800 (PST)
In-Reply-To: <7vd3oktmoo.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164358>

On Thu, Dec 30, 2010 at 2:15 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
> By the way, I think info->data->skip_sparse_checkout should be fixed =
by
> renaming it to info->data->sparse_checkout. =C2=A0The flag controls a=
 special
> case logic that should not be in effect unless explicitly asked, and
> forcing normal codepath to say "If skip_sparse_checkout is not false,=
 do
> this" in double-negative is unnice than "If sparse_checkout is in eff=
ect,
> please run this special case" when reading the code.

It's something to do with zero value being "feature set by default".
Unless explicitly said otherwise, sparse checkout code should be in
effect so that skip-checkout bit is preserved in index. No, double
negation is not nice. But I don't know how I can set
unpack_trees_options.sparse_checkout =3D 1 by default.
--=20
Duy
