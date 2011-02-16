From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2] Introduce CHERRY_PICK_HEAD
Date: Wed, 16 Feb 2011 17:02:50 -0600
Message-ID: <20110216230250.GF2615@elie>
References: <1297850903-65038-2-git-send-email-jaysoffian@gmail.com>
 <1297876835-70613-1-git-send-email-jaysoffian@gmail.com>
 <20110216214236.GC2615@elie>
 <AANLkTimBExej1mF=4UuTszcSoKy_xnj7bB3BaT5ze2vH@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 17 00:03:07 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PpqOn-0006Uv-Es
	for gcvg-git-2@lo.gmane.org; Thu, 17 Feb 2011 00:03:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753260Ab1BPXDA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 16 Feb 2011 18:03:00 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:51824 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751005Ab1BPXC7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 Feb 2011 18:02:59 -0500
Received: by qwa26 with SMTP id 26so1816420qwa.19
        for <git@vger.kernel.org>; Wed, 16 Feb 2011 15:02:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=qzE5Jb6qL7K9EuUUdbB4HHwzbDkxLSibJUhNRFg+7K0=;
        b=hmuT0C1UJgn2yi4VLalfSPw6BR0Hu//S70hUZd3NK9llETZu0FzP/jRxH1HpccjZ2N
         pYZG6ASWHWCEOWEIrhPj9OBE4bJSvmIgL63dbBvaXqY9ZXWKaEIa2CQL7Zl929B5znio
         FfqXFrl0PLYZFDRCGiE52ojd8FtZgBm0R7YXE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=WOAZdZUBKHpULLaLGqcJq7ehrH48DzFRe2NHLOeKZbjqHTghJRgMc/fYFC8tnTV4DN
         9lbOXquD38pCMgm7X11jAr6gtXwP0oZYvUjZds5hHHg2I1dRG0yOJ5cBQyCtyTSxmhnQ
         95874yK7MdV2sj9X4eJCtZ15UxQOPiIlxfM1M=
Received: by 10.224.19.198 with SMTP id c6mr1550221qab.197.1297897378165;
        Wed, 16 Feb 2011 15:02:58 -0800 (PST)
Received: from elie ([69.209.51.217])
        by mx.google.com with ESMTPS id g28sm207235qck.37.2011.02.16.15.02.55
        (version=SSLv3 cipher=OTHER);
        Wed, 16 Feb 2011 15:02:57 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <AANLkTimBExej1mF=4UuTszcSoKy_xnj7bB3BaT5ze2vH@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167018>

Jay Soffian wrote:
> On Wed, Feb 16, 2011 at 4:42 PM, Jonathan Nieder <jrnieder@gmail.com>=
 wrote:

>> Nit: GIT_CHERRY_PICK_HELP is not just for rebase --interactive but
>> for arbitrary porcelain that wants to take care of the commit itself
>> (see v1.5.4-rc0~106^2~1, revert/cherry-pick: Allow overriding the
>> help text by the calling Porcelain, 2007-11-28).
>
> What is the arbitrary porcelain you have in mind? :-)

git sequencer, for example.  Or any out-of-tree tool that is using
cherry-pick to move around commits and wants to know where they end
up.

>> The conservative thing to do is indeed to remove CHERRY_PICK_HEAD in
>> this case, I suppose. =C2=A0But I'd like to have the CHERRY_PICK_HEA=
D to
>> get the --amend safety when rebasing. =C2=A0I can send a separate pa=
tch
>> for it if you'd like.
>
> Please do, since I'm not really sure what you have in mind. If
> CHERRY_PICK_HEAD is left-behind, it interferes with the eventually
> commit done by rebase --continue.

Wait, does this mean that -c/-C/--amend/CHERRY_PICK_HEAD overrides
GIT_AUTHOR_NAME, GIT_AUTHOR_EMAIL, and GIT_AUTHOR_DATE?

*checks*

Yes, it does.  The behavior is carried over from v0.99~185
(git-commit-script: get commit message from an existing one,
2005-06-25), but imho it is wrong.

Does this seem worth fixing?
Jonathan
